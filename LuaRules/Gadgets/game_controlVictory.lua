function gadget:GetInfo()
	return {
		name = "Control Victory",
		desc = "Enables a victory through capture and hold",
		author = "KDR_11k (David Becker)",
		date = "2008-03-22",
		license = "Public Domain",
		layer = 1,
		enabled = true
	}
end

local nonCapturingUnits = {
	"eairengineer",
	"efighter",
	--"escout",
	"egunship2",
	"etransport",
	"edrone",
	"ebomber",
}

--local pointMarker = FeatureDefNames.xelnotgawatchtower.id -- Feature marking a point- This doesn't do anything atm

	
local captureRadius = tonumber(Spring.GetModOptions().captureradius) or 500 -- Radius around a point in which to capture it
local captureTime = tonumber(Spring.GetModOptions().capturetime) or 30 -- Time to capture a point
local captureBonus = tonumber(Spring.GetModOptions().capturebonus) or.5 -- speedup from adding more units
local decapSpeed = tonumber(Spring.GetModOptions().decapspeed) or 3 -- speed multiplier for neutralizing an enemy point
local moveSpeed =.5

local startTime = tonumber(Spring.GetModOptions().starttime) or 0 -- The time when capturing can start

local dominationScoreTime = tonumber(Spring.GetModOptions().dominationscoretime) or 30 -- Time needed holding all points to score in multi domination

Spring.Echo("Control Victory Scoring Mode: " .. (Spring.GetModOptions().scoremode or "Control Victory Scoring Mode Is Not Set!"))
-- if Spring.GetModOptions().scoremode == "disabled" then return false end

local limitScore = tonumber(Spring.GetModOptions().limitscore) or 3500

local allyTeamColorSets={}

local scoreModes = {
	disabled = 0, -- none (duh)
	countdown = 1, -- A point decreases all opponents' scores, zero means defeat
	tugowar = 2, -- A point steals enemy score, zero means defeat
	multidomination = 3, -- Holding all points will grant 100 score, first to reach the score limit wins
}
local scoreMode = scoreModes[Spring.GetModOptions().scoremode or "countdown"]

local _, _, _, _, _, gaia = Spring.GetTeamInfo(Spring.GetGaiaTeamID())
local mapx, mapz = Game.mapSizeX, Game.mapSizeZ

if (gadgetHandler:IsSyncedCode()) then

	-- SYNCED

	local points = {}
	local score = {}

	local dom = {
		dominator = nil,
		dominationTime = nil,
	}

	local function Loser(team)
		if team == gaia then
			return
		end
		for _, u in ipairs(Spring.GetAllUnits()) do
			if team == Spring.GetUnitAllyTeam(u) then
				Spring.DestroyUnit(u)
			end
		end
	end

	local function Winner(team)
		for _, a in ipairs(Spring.GetAllyTeamList()) do
			if a ~= team and a ~= gaia then
				Loser(a)
			end
		end
	end
	

	function gadget:Initialize()
		for _, a in ipairs(Spring.GetAllyTeamList()) do
			if scoreMode ~= 3 then
				score[a] = limitScore
			else
				score[a] = 0
			end
		end
		score[gaia] = 0
		local configfile, _ = string.gsub(Game.mapName, ".smf$", ".lua")
		configfile = "LuaRules/Configs/ControlPoints/cv_" .. configfile .. ".lua"
		Spring.Echo(configfile .. " -This is the name of the control victory configfile-")
		if VFS.FileExists(configfile) then
			local config = VFS.Include(configfile)
			points = config.points
			for _, p in pairs(points) do
				p.capture = 0
			end
			moveSpeed = 0
		else
			Spring.Echo("No Control Victory Config File Found")
--[[      local angle = math.random() * math.pi * 2
      points = {}
      for i=1,3 do
         local angle = angle + i * math.pi * 2/3
         points[i] = {
            x=mapx/2 + mapx * .4 * math.sin(angle),
            y=0,
            z=mapz/2 + mapz * .4 * math.cos(angle),
            velx=moveSpeed * 10 * -1 * math.cos(angle),
            velz=moveSpeed * 10 * math.sin(angle),
            owner=nil,
            aggressor=nil,
            capture=0,
         }
      end ]]--
		end
		_G.points = points
		_G.score = score
		_G.dom = dom
	end

	function gadget:GameFrame(f)
		-- This causes the points to move around, windows screensaver style :-)
--[[   for _,p in pairs(points) do
    if p.velx then
         p.velx = p.velx / moveSpeed + .03 * (0.5 - math.random())
         p.velz = p.velz / moveSpeed + .03 * (0.5 - math.random())
         local vel = (p.velx^2 + p.velz^2)^0.5
         local velmult = math.max(1 - .1^(math.max(1, math.min(3, math.log(vel / moveSpeed)))), (vel * 1^.01)^.99 / vel) * moveSpeed
         p.velx = p.velx * velmult
         p.velz = p.velz * velmult
         if p.x + p.velx < captureRadius or p.x + p.velx > mapx - captureRadius then p.velx = -1 * p.velx end
         if p.z + p.velz < captureRadius or p.z + p.velz > mapz - captureRadius then p.velz = -1 * p.velz end
         p.x = p.x + p.velx
         p.x = p.x + p.velx
         p.z = p.z + p.velz
         p.z = p.z + p.velz
      end
   end ]]--

		if f % 30 <.1 and f / 1800 > startTime then
			local owned = {}
			for _, allyTeamID in ipairs(Spring.GetAllyTeamList()) do
				owned[allyTeamID] = 0
			end
			for _, capturePoint in pairs(points) do
				local aggressor = nil
				local owner = capturePoint.owner
				local count = 0
				for _, u in ipairs(Spring.GetUnitsInCylinder(capturePoint.x, capturePoint.z, captureRadius)) do
					local validUnit = true
					for _, i in ipairs (nonCapturingUnits) do
						if UnitDefs[Spring.GetUnitDefID(u)].name == i then
							validUnit = false
						end
					end
					if validUnit then
						local unitOwner = Spring.GetUnitAllyTeam(u)
						--Spring.Echo(unitOwner)
						if owner then
							if owner == unitOwner then
								count = 0
								break
							else
								count = count + 1
							end
						else
							if aggressor then
								if aggressor == unitOwner then
									count = count + 1
								else
									aggressor = nil
									break
								end
							else
								aggressor = unitOwner
								count = count + 1
							end
						end
					end
				end
				if owner and count > 0 then
					capturePoint.aggressor = nil
					capturePoint.capture = capturePoint.capture + (1 + captureBonus * (count - 1)) * decapSpeed
				elseif aggressor then
					--Spring.Echo("capturePoint.aggressor", capturePoint.aggressor)
					if capturePoint.aggressor == aggressor then
						capturePoint.capture = capturePoint.capture + 1 + captureBonus * (count - 1)
					else
						capturePoint.aggressor = aggressor
						capturePoint.capture = 1 + captureBonus * (count - 1)
					end
				end
				if capturePoint.capture > captureTime then
					capturePoint.owner = capturePoint.aggressor
					capturePoint.capture = 0
				end
				if capturePoint.owner then
					--Spring.Echo(capturePoint.owner)
					owned[capturePoint.owner] = owned[capturePoint.owner] + 1
				end
			end
			if scoreMode == 1 then -- Countdown
				for owner, count in pairs(owned) do
					for _, allyTeamID in ipairs(Spring.GetAllyTeamList()) do
						if allyTeamID ~= owner and score[allyTeamID] > 0 then
							score[allyTeamID] = score[allyTeamID] - count
						end
					end
				end
				for allyTeamID, teamScore in pairs(score) do
					-- Spring.Echo("Team "..allyTeamID..": "..teamScores)
					if teamScore <= 0 then
						Loser(allyTeamID)
					end
				end
			elseif scoreMode == 2 then -- Tug o'War
				for owner, count in pairs(owned) do
					for _, a in ipairs(Spring.GetAllyTeamList()) do
						if a ~= owner and score[a] > 0 then
							score[a] = score[a] - count
							score[owner] = score[owner] + count
						end
					end
				end
				for allyTeamID, teamScore in pairs(score) do
					--Spring.Echo("Team "..allyTeamID..": "..teamScore)
					if teamScore <= 0 then
						Loser(allyTeamID)
					end
				end
			elseif scoreMode == 3 then -- Multi Domination
				local prevDominator = dom.dominator
				dom.dominator = nil
				for owner, count in pairs(owned) do
					if count == #points then
						dom.dominator = owner
						if prevDominator ~= owner or not dom.dominationTime then
							dom.dominationTime = f + 30 * dominationScoreTime
						end
						break
					end
				end
				if dom.dominator then
					if dom.dominationTime <= f then
						for _, capturePoint in pairs(points) do
							capturePoint.owner = nil
							capturePoint.capture = 0
						end
						score[dom.dominator] = score[dom.dominator] + 1000
						if score[dom.dominator] >= limitScore then
							Winner(dom.dominator)
						end
					end
				end
			end
		end
	end

	function gadget:AllowUnitCreation(unit, builder, team, x, y, z) -- TODO: fix for comshare
		if moveSpeed == 0 then
			for _, p in pairs(points) do
				if x and math.sqrt((x - p.x) * (x - p.x) + (z - p.z) * (z - p.z)) < captureRadius then
					Spring.SendMessageToPlayer(team, "Cannot build units in a control point")
					return false
				end
			end
		end
		return true
	end

else -- UNSYNCED

	local Text = gl.Text
	local Color = gl.Color
	local DrawGroundCircle = gl.DrawGroundCircle
	local PushMatrix = gl.PushMatrix
	local PopMatrix = gl.PopMatrix
	local Translate = gl.Translate
	local Scale = gl.Scale
	local Rotate = gl.Rotate
	local Rect = gl.Rect
	local Billboard = gl.Billboard
	local playerListEntry = {}
	
	-----------------------------------------------------------------------------------------
	-- creates initial player listing 
	-----------------------------------------------------------------------------------------
	local function CreatePlayerList()
		local playerEntries = {}
		for allyTeamID, teamScore in spairs(SYNCED.score) do
			-- note to self, allyTeamID +1 = ally team number	
			--if allyTeamID ~= gaia then					
			--does this allyteam have a table? if not, make one
			if playerEntries[allyTeamID] == nil then 
				playerEntries[allyTeamID] = {}
				--	Spring.Echo("creating allyTeamID table")
			end
		
			for _,teamId in pairs(Spring.GetTeamList(allyTeamID))do	
				local playerList = Spring.GetPlayerList(teamId)	
				-- does this team have an entry? if not, make one!
				if playerEntries[allyTeamID][teamId] == nil then 
					playerEntries[allyTeamID][teamId] = {}	
				--	Spring.Echo("creating team table")
				end
				local r, g, b 			= Spring.GetTeamColor(teamId)
				local playerTeamColor	= string.char("255",r*255,g*255,b*255)
				for k,v in pairs(playerList)do
					-- does this player have an entry? if not, make one!
					if playerEntries[allyTeamID][teamId][v] == nil then 
						playerEntries[allyTeamID][teamId][v] = {}	
					--	Spring.Echo("creating player table")
					end
					
				--	if Spring.Echo(playerEntries[allyTeamID][teamId][v]) then
					--	Spring.Echo("waffles")
					--end
					playerEntries[allyTeamID][teamId][v]["name"] = Spring.GetPlayerInfo(v)
					playerEntries[allyTeamID][teamId][v]["color"] = playerTeamColor
				end -- end playerId
			end -- end teamId
		end -- allyTeamID		
		return playerEntries
	end	

	function gadget:Initialize()
		playerListEntry = CreatePlayerList(playerEntries)
	end
	
	-- draws ground circles
	local function DrawPoints()
		local teamAllyTeamID = Spring.GetLocalAllyTeamID()
		for _, capturePoint in spairs(SYNCED.points) do
				
				local r, g, b = 1, 1, 1
				if capturePoint.owner and capturePoint.owner ~= Spring.GetGaiaTeamID() then
					r, g, b = Spring.GetTeamColor(capturePoint.owner) 
				end
				Color(r, g, b, 1)
				--Spring.Echo("draw points", capturePoint.owner, r, g, b)
				local y = Spring.GetGroundHeight(capturePoint.x, capturePoint.z)

				DrawGroundCircle(capturePoint.x, capturePoint.y, capturePoint.z, captureRadius, 30)
				if capturePoint.capture > 0 then
					PushMatrix()
					Translate(capturePoint.x, y + 100, capturePoint.z)
					Billboard()
					Color(0, 0, 0, 1)
					Rect(-26, 6, 26, -6)
					Color(1, 1, 0, 1)
					Rect(-25, 5, -25 + 50 * (capturePoint.capture / captureTime), -5)
					PopMatrix()
				end
		end
		Color(1, 1, 1, 1)
	end

	function gadget:DrawWorld()
		gl.DepthTest(GL.LEQUAL)
		gl.PolygonOffset(-10, -10)
		DrawPoints()
		gl.DepthTest(false)
		gl.PolygonOffset(false)
	end

	function gadget:DrawInMiniMap(mmx, mmy)
		PushMatrix()
		gl.LoadIdentity()
		Translate(0, 1, 0)
		Scale(1 / Game.mapSizeX, 1 / Game.mapSizeZ, 1)
		Rotate(90, 1, 0, 0)
		DrawPoints()
		PopMatrix()
	end

	function gadget:DrawScreen(vsx, vsy)
		local frame = Spring.GetGameFrame()
		if frame / 1800 > startTime then
			local n = 1
			local dominator 		= SYNCED.dom.dominator
			local dominationTime 	= SYNCED.dom.dominationTime
			local white				= string.char("255","255","255","255")	
					
			-- for all the scores with a team.
			for allyTeamID, teamScore in spairs(SYNCED.score) do
				--Spring.Echo("at allied team ID", allyTeamID)
				-- note to self, allyTeamID +1 = ally team number	
				
					for _,teamId in pairs(Spring.GetTeamList(allyTeamID))do	
						--Spring.Echo("\tat team ID", teamId)
						-- gaia player doesn't count
						if teamId ~= gaia then					
							
							local playerList 		= Spring.GetPlayerList(teamId)	
							local r, g, b 			= Spring.GetTeamColor(teamId)
							local playerTeamColor	= string.char("255",r*255,g*255,b*255)
							--Spring.Echo("\t\t\tplayerList", #playerList)
							for _,playerId in pairs(playerList)do
								--Spring.Echo("\t\t\t\tnot player")
								--Spring.Echo("allied team ID", allyTeamID, "\t", "team ID", teamId, Spring.GetPlayerInfo(playerId))
								Text(playerTeamColor .. Spring.GetPlayerInfo(playerId) .. "'s Team (" .. allyTeamID.. ")" .. white, vsx - 280, vsy * .58 - 38 * playerId+10, 16, "lo")
								Text(white .. "Score: " .. teamScore, vsx - 250, vsy * .5625 - 38 * playerId+10, 16, "lo")
							end -- end playerId
						end -- not gaia
					end -- end teamId

			end

			if dominator and dominationTime > Spring.GetGameFrame() then
			--	Text( playerListEntry[dominator]["color"] .. "<" .. playerListEntry[dominator] .. "> will score a --Domination in " .. 
			--		math.floor((dominationTime - Spring.GetGameFrame()) / 30) .. 
			--		" seconds!", vsx *.5, vsy *.7, 24, "oc")
			end
		else
			Text("Capturing points begins in:", vsx - 280, vsy *.58, 18, "lo")
			local timeleft = startTime * 60 - frame / 30
			timeleft = timeleft - timeleft % 1
			Text(timeleft .. " seconds", vsx - 280, vsy *.58 - 25, 18, "lo")
		end
	end

end