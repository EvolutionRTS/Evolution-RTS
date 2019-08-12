--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    game_spawn.lua
--  brief:   spawns start unit and sets storage levels
--  author:  Tobi Vollebregt
--
--  Copyright (C) 2010.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
	return {
		name      = "Spawn",
		desc      = "spawns start unit and sets storage levels",
		author    = "Tobi Vollebregt",
		date      = "January, 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- synced only
if (not gadgetHandler:IsSyncedCode()) then
	return false
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local modOptions = Spring.GetModOptions()
 
function IsTeamAI(teamID)
	teamID,leader,isDead,isAiTeam=Spring.GetTeamInfo(teamID)
	return isAiTeam
end
 
local function GetStartUnit(teamID)
        -- get the team startup info
        local side = select(5, Spring.GetTeamInfo(teamID))
        local startUnit
       
        boolIsAI= IsTeamAI(teamID)
       
		if boolIsAI==true then
			Spring.Echo ("Enemy is an AI so it gets an AI Specific Overseer!")
			local sidedata = Spring.GetSideData(side)
			Spring.Echo("faction: " .. sidedata)
			math.random(); math.random(); math.random()
			local i = math.random(1,6)
			local factioncheck = math.random(0,1)
			--if factioncheck == 0 then
			if sidedata == "ecommander" then
				if i == 1 then
					startUnit = "ecommanderbattleai"
				elseif i == 2 then
					startUnit = "ecommanderbuildai"
				elseif i == 3 then
					startUnit = "ecommandercloakai"
				elseif i == 4 then
					startUnit = "ecommanderfactoryai"
				elseif i == 5 then
					startUnit = "ecommandershieldai"
				else
					startUnit = "ecommanderhealerai"
				end
			elseif sidedata == "zarm" then
			--elseif factioncheck == 1 then
				startUnit = "zarm"
			else
				if factioncheck == 0 then
					if i == 1 then
						startUnit = "ecommanderbattleai"
					elseif i == 2 then
						startUnit = "ecommanderbuildai"
					elseif i == 3 then
						startUnit = "ecommandercloakai"
					elseif i == 4 then
						startUnit = "ecommanderfactoryai"
					elseif i == 5 then
						startUnit = "ecommandershieldai"
					else
						startUnit = "ecommanderhealerai"
					end
				else
					startUnit = "zarm"
				end
			end
			return startUnit
		end
       
		-- If a side isn't selected, flip a coin
        if (side == "") then
            local coinflip = math.random(0,1)
			if coinflip == 0 then
				startUnit = "ecommander"
			elseif coinflip == 1 then
				startUnit = "zarm"
			end
        else
			startUnit = Spring.GetSideData(side)
		end
        return startUnit
end

local function SpawnStartUnit(teamID)
	local startUnit = GetStartUnit(teamID)
	if (startUnit and startUnit ~= "") then
		-- spawn the specified start unit
		local x,y,z = Spring.GetTeamStartPosition(teamID)
		if boolIsAI==true then
			local _,_,_,_,_,allyID = Spring.GetTeamInfo(teamID)
			local startBoxXmin, startBoxZmin, startBoxXmax, startBoxZmax = Spring.GetAllyTeamStartBox(allyID)
			local mx = Game.mapSizeX
			local mz = Game.mapSizeZ
			if not (startBoxXmin == 0 and startBoxZmin == 0 and startBoxXmax == mx and startBoxZmax == mz) then
				math.random(); math.random(); math.random()
				x = math.random(startBoxXmin, startBoxXmax)
				z = math.random(startBoxZmin, startBoxZmax)
			end
		end
		-- snap to 16x16 grid
		x, z = 16*math.floor((x+8)/16), 16*math.floor((z+8)/16)
		y = Spring.GetGroundHeight(x, z)
		-- facing toward map center
		local facing=math.abs(Game.mapSizeX/2 - x) > math.abs(Game.mapSizeZ/2 - z)
			and ((x>Game.mapSizeX/2) and "west" or "east")
			or ((z>Game.mapSizeZ/2) and "north" or "south")
		local unitID = Spring.CreateUnit(startUnit, x, y, z, facing, teamID)
-- Fun times		
--		if startUnit == "ecommanderai" then
--			id1=Spring.CreateUnit("eorb", x+100, y+200, z, facing, teamID)
--			Spring.GiveOrderToUnit(id1,CMD.GUARD,{unitID}, {"shift"})
--		end
	end

	-- set start resources, either from mod options or custom team keys
	local teamOptions = select(8, Spring.GetTeamInfo(teamID))
	local m = teamOptions.startmetal  or modOptions.startmetal  or 100
	local e = teamOptions.startenergy or modOptions.startenergy or 100

	-- using SetTeamResource to get rid of any existing resource without affecting stats
	-- using AddTeamResource to add starting resource and counting it as income
	if (m and tonumber(m) ~= 0) then
		-- remove the pre-existing storage
		--   must be done after the start unit is spawned,
		--   otherwise the starting resources are lost!
		Spring.SetTeamResource(teamID, "ms", tonumber(m)) --Use tonumber(m) to have it match the startmetal amounts
		Spring.SetTeamResource(teamID, "m", 0)
		Spring.AddTeamResource(teamID, "m", tonumber(m))
	end
	if (e and tonumber(e) ~= 0) then
		-- remove the pre-existing storage
		--   must be done after the start unit is spawned,
		--   otherwise the starting resources are lost!
		Spring.SetTeamResource(teamID, "es", tonumber(e)) --Use tonumber(e) to have it match the startenergy amounts
		Spring.SetTeamResource(teamID, "e", 0)
		Spring.AddTeamResource(teamID, "e", tonumber(e))
	end
end


function gadget:GameStart()
	-- only activate if engine didn't already spawn units (compatibility)
	if (#Spring.GetAllUnits() > 0) then
		return
	end

	-- spawn start units
	local gaiaTeamID = Spring.GetGaiaTeamID()
	local teams = Spring.GetTeamList()
	for i = 1,#teams do
		local teamID = teams[i]
		-- don't spawn a start unit for the Gaia team
		if (teamID ~= gaiaTeamID) then
			SpawnStartUnit(teamID)
		end
	end
end