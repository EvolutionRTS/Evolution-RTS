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

local aiStartUnits = {
	["ecommander"] = {
		"ecommanderbattleai",
		"ecommanderbuildai",
		"ecommandercloakai",
		"ecommanderfactoryai",
		"ecommandershieldai",
		"ecommanderhealerai",
	},
	["zarm"] = {
		"zarm",
	},
	["xcommander"] = {
		"xcommander",
	},
}

local factionDefComms = {
	[0] = "ecommander",
	[1] = "zarm",
	[2] = "xcommander",
}

local validStartComm = {
	[UnitDefNames["ecommander"].id] = true,
	[UnitDefNames["zarm"].id] = true,
	[UnitDefNames["xcommander"].id] = true,
}

local ACCESS_LEVEL = {
    -- pick one of the two below choose whether enemies can see faction choice
	private = true,
    -- public = true,
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local modOptions = Spring.GetModOptions()

function IsTeamAI(teamID)
	_, _, _, isAiTeam=Spring.GetTeamInfo(teamID)
	return isAiTeam
end

local function GetStartUnit(teamID)
	local reqStartUnit = Spring.GetTeamRulesParam(teamID, "startUnit")
	if reqStartUnit then
		return UnitDefs[reqStartUnit].name
	end

	-- get the team startup info
	local side = select(5, Spring.GetTeamInfo(teamID))
	local startUnit

	if IsTeamAI(teamID) then
		Spring.Echo ("Enemy is an AI so it gets an AI Specific Overseer!")
		--local factionrandom = math.random(0,1)
		math.random(); math.random(); math.random()
		local sidedata = factionDefComms[math.random(0,1)]
		if sidedata == nil then
			Spring.Echo("[Game Spawn] AI Faction: nil")
		else
			Spring.Echo("[Game Spawn] AI Faction: " .. sidedata)
		end

		local aiCommData = aiStartUnits[sidedata] or {}
		local aiCommIndex = math.random(1, #aiCommData)
		startUnit = aiCommData[aiCommIndex]
	else
		-- If a side isn't selected, flip a coin
		if (side == "") then
			local factionIndex = math.random(0, 1)
			startUnit = factionDefComms[factionIndex]
		else
			startUnit = Spring.GetSideData(side)
		end
	end

	return startUnit
end

local function SpawnStartUnit(teamID)
	local startUnit = GetStartUnit(teamID)

	if (startUnit and startUnit ~= "") then
	
		if startUnit == "ecommander" then
			playerFaction = "ateran"
		elseif startUnit == "zarm" then
			playerFaction = "zaal"
		elseif startUnit == "xcommander" then
			playerFaction = "pattern"
		elseif startUnit == nil then
			playerFaction = "Script is Fucked"
		else
			playerFaction = startUnit
			Spring.Echo("[Game Spawn] If you're seeing this message that means that the code which sets the player's faction is absolutely fucked somewhere. On the next line I will echo the playerFaction variable. If it says anything other than the factions listed above, at least it will provide a clue.")
			Spring.Echo(playerFaction)
		end
		
		
		Spring.Echo("[Game Spawn] My starting faction is " .. playerFaction)
		Spring.SetTeamRulesParam(teamID, "faction", playerFaction)
	
		-- spawn the specified start unit
		local x,y,z = Spring.GetTeamStartPosition(teamID)
		if IsTeamAI(teamID) then
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
		if startUnit == "zarm" then
			id1=Spring.CreateUnit("ztumor", x+100, y+200, z, facing, teamID)
			id1=Spring.CreateUnit("ztumor", x-100, y-200, z, facing, teamID)
			--Spring.GiveOrderToUnit(id1,CMD.GUARD,{unitID}, {"shift"})
		end
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

function gadget:RecvLuaMsg(msg, playerID)
	if msg:find("\138") ~= 1 then
		return
	end

	local requestedCommDefID = tonumber(msg:sub(2) or "-1")
	if not validStartComm[requestedCommDefID] then
		return
	end

	local teamID = select(4, Spring.GetPlayerInfo(playerID, false))
	--Spring.Echo("Setting start unit for team", teamID, " to ", requestedCommDefID)
	Spring.SetTeamRulesParam(teamID, "startUnit", requestedCommDefID, ACCESS_LEVEL)
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