function gadget:GetInfo()
	return {
		name		= "BA Chicken Spawner",
		desc		= "Spawns burrows and chickens",
		author	= "TheFatController, quantum",
		date		= "16 November, 2008",
		license	 = "GNU GPL, v2 or later",
		layer	 = 0,
		enabled	 = true 
	}
end

if (gadgetHandler:IsSyncedCode()) then
-- BEGIN SYNCED
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
-- Speed-ups
--

	local GetUnitNeutral		= Spring.GetUnitNeutral
	local GetTeamList			= Spring.GetTeamList
	local GetTeamLuaAI			= Spring.GetTeamLuaAI
	local GetGaiaTeamID			= Spring.GetGaiaTeamID
	local SetGameRulesParam		= Spring.SetGameRulesParam
	local GetGameRulesParam		= Spring.GetGameRulesParam
	local GetTeamUnitsCounts	= Spring.GetTeamUnitsCounts
	local GetTeamUnitCount	 	= Spring.GetTeamUnitCount
	local GetGameSpeed		 	= Spring.GetGameSpeed
	local GetGameFrame		 	= Spring.GetGameFrame
	local GetPlayerList			= Spring.GetPlayerList
	local GetPlayerInfo			= Spring.GetPlayerInfo
	local GetGameSeconds		= Spring.GetGameSeconds
	local DestroyUnit			= Spring.DestroyUnit
	local GetTeamUnits		 	= Spring.GetTeamUnits
	local GetUnitsInCylinder	= Spring.GetUnitsInCylinder
	local GetUnitNearestEnemy	= Spring.GetUnitNearestEnemy
	local GetUnitPosition		= Spring.GetUnitPosition
	local GiveOrderToUnit		= Spring.GiveOrderToUnit
	local TestBuildOrder		= Spring.TestBuildOrder
	local GetGroundBlocked	 	= Spring.GetGroundBlocked
	local CreateUnit			= Spring.CreateUnit
	local SetUnitBlocking		= Spring.SetUnitBlocking
	local GetGroundHeight		= Spring.GetGroundHeight
	local GetUnitTeam			= Spring.GetUnitTeam
	local GetUnitHealth			= Spring.GetUnitHealth
	local GetUnitCommands		= Spring.GetUnitCommands
	local SetUnitExperience		= Spring.SetUnitExperience
	local GetUnitDefID		 	= Spring.GetUnitDefID
	local SetUnitHealth			= Spring.SetUnitHealth
	local GetUnitIsDead			= Spring.GetUnitIsDead
	local GetCommandQueue		= Spring.GetCommandQueue
	local spGetLocalTeamID		= Spring.GetLocalTeamID
	
	local mRandom			= math.random
	local math				= math
	local Game				= Game
	local table				= table
	local ipairs			= ipairs
	local pairs				= pairs

	local MAPSIZEX = Game.mapSizeX
	local MAPSIZEZ = Game.mapSizeZ

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	local queenLifePercent		= 100
	local maxTries				= 100
	local currentWave			= 1
	local targetCache			= 1
	local minBurrows			= 1
	local timeOfLastSpawn		= 0
	local timeOfLastFakeSpawn	= 0
	local highTeam				= 0
	local timeOfLastWave		= 0
	local expMod				= 0
	local burrowTarget			= 0
	local qDamage				= 0
	local lastTeamID			= 0
	local targetCacheCount		= 0
	local nextSquadSize			= 0
	local chickenCount			= 0
	local t						= 0
	local timeCounter			= 0
	local queenAnger			= 0
	local bonusPoints			= 0
	local burrowSpawnProgress	= 0
	local queenMaxHP			= 0
	local chickenDebtCount		= 0
	local firstSpawn			= true
	local showScoresOnce		= true
	local gameOver				= false
	local qMove					= false
	local warningMessage		= false
	local computerTeams			= {}
	local humanTeams			= {}
	local disabledUnits			= {}
	local spawnQueue			= {}
	local idleOrderQueue		= {}
	local stunList				= {}
	local endScores				= {}
	local queenResistance		= {}
	local queenID
	local chickenTeamID
	local luaAI
	local lsx1,lsz1,lsx2,lsz2
	local turrets				= {}
	local chickenBirths			= {}
	local failChickens			= {}
	local chickenTargets		= {}
	local burrows				= {}		
	local AIfaction				

	-- local EMP_GOO = {}
	-- EMP_GOO[WeaponDefNames['chickenr1_goolauncher'].id] = WeaponDefNames['chickenr1_goolauncher'].damages[1]
	-- EMP_GOO[WeaponDefNames['weaver_death'].id] = WeaponDefNames['weaver_death'].damages[1]
	-- local LOBBER = UnitDefNames["chickenr1"].id
	-- local JUNO = WeaponDefNames["juno_pulse"].id
	-- local KROW_ID = UnitDefNames["corcrw"].id
	-- local KROW_LASER = "krow_laser_index"
	
	local spawnerConfig = include("gamedata/configs/survival_settings.lua")
		
	local SMALL_UNIT		= UnitDefNames[spawnerConfig.smallUnit].id
	local MEDIUM_UNIT		= UnitDefNames[spawnerConfig.mediumUnit].id
	local LARGE_UNIT		= UnitDefNames[spawnerConfig.largeUnit].id
	local REFERENCE_UNIT	= UnitDefNames[spawnerConfig.referenceUnit].id
	
	local modes 			= spawnerConfig.modes

	for i, v in ipairs(modes) do -- make it bi-directional
		modes[v] = i
	end
	
	local teams = GetTeamList()
	local highestLevel = 0


	for _, teamID in ipairs(teams) do
		local faction
		Spring.Echo("-------------Survival Debug Messages---------------- ")		
		Spring.Echo("TEAM ",Spring.GetAIInfo(teamID))
		Spring.Echo("TEAM ",Spring.GetTeamInfo(teamID))
		Spring.Echo("---------------------------------------------------- ")

		if(GetTeamLuaAI(teamID) ~= "") then -- we found a lua ai, lets get his team!
			_, _, _, _, hooffaction = Spring.GetTeamInfo(teamID)	 
			AIfaction = hooffaction
				 Spring.Echo("AI FACTION: ")
				 Spring.Echo(hooffaction)
				 Spring.Echo(GetTeamLuaAI(teamID))
		end
			
		local teamLuaAI = GetTeamLuaAI(teamID)
		if (teamLuaAI and teamLuaAI ~= "") then
			local _,_,_,_,_,_,CustomTeamOptions=Spring.GetTeamInfo(teamID)
			if (not CustomTeamOptions) or (not CustomTeamOptions["aioverride"]) then
				luaAI = teamLuaAI
				if (modes[teamLuaAI] > highestLevel) then
					highestLevel = modes[teamLuaAI]
				end
				chickenTeamID = teamID
				computerTeams[teamID] = true
			else
				humanTeams[teamID]		= true -- chickens lua bots overriden also count as "humanTeams"
			end
		elseif teamID~=GetGaiaTeamID() then
			humanTeams[teamID]		= true -- bots not chickens also count as "humanTeams"
		end
	end

	luaAI = modes[highestLevel]

	Spring.Echo("Spring.GetModOptions()",#Spring.GetModOptions())
	Spring.Echo(chickenTeamID, "chickenTeamID","Spring.GetModOptions()",Spring.GetModOptions(),
	"materialstorage", Spring.GetModOptions()["materialstorage"],
	"StartMetal", Spring.GetModOptions()["startmetal"])

	local gaiaTeamID	 = GetGaiaTeamID()
	if not chickenTeamID then
		if	Spring.GetModOptions()["materialstorage"] == nil and 
			Spring.GetModOptions()["startmetal"] == nil then
			chickenTeamID = gaiaTeamID
			warningMessage = true
		else -- no chickens, lets go!
			return;
		end
	else
		computerTeams[gaiaTeamID] = nil
	end

	humanTeams[gaiaTeamID]		= nil

	local gameMode		=	Spring.GetModOptions().comm
	local placerMode	=	false
	
	if spawnerConfig.badModes[gameMode] then
		return false
	end

	Spring.Echo(chickenTeamID,	Spring.GetModOptions()["materialstorage"] == nil and 
								Spring.GetModOptions()["startmetal"] == nil)
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	--
	-- Utility
	--
	local function SetToList(set)
		local list = {}
		for k in pairs(set) do
		table.insert(list, k)
		end
		return list
	end

	local function SetCount(set)
		local count = 0
		for k in pairs(set) do
		count = count + 1
		end
		return count
	end

	function comma_value(amount)
		local formatted = amount
		while true do	
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
		end
		return formatted
	end

	local function getSqrDistance(x1,z1,x2,z2)
		local dx,dz = x1-x2,z1-z2
		return (dx*dx)+(dz*dz)
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	--
	-- Difficulty
	--	
	if AIfaction == '' or AIfaction == nil then
		local sidedata = VFS.Include("gamedata/sidedata.lua")
		--default to first faction in list
		AIfaction = string.lower(sidedata[1].name)
	end	

	Spring.Echo(AIfaction, " AIfaction")
	VFS.Include("gamedata/configs/" .. AIfaction .. "_spawn_defs.lua")
	
		-- Spring.Echo("bonusTurret")
		-- Spring.Echo(bonusTurret)

	local function SetGlobals(difficulty)
		--Spring.Echo(difficulty)
		for key, value in pairs(gadget.difficulties[difficulty]) do
			gadget[key] = value
		end
		gadget.difficulties = nil
	end

	SetGlobals(luaAI or defaultDifficulty) -- set difficulty

	local expIncrement = ((SetCount(humanTeams) * expStep) / queenTime)
	if expStep < 0 then expIncrement = ((expStep * -1) / queenTime) end
	local nextWave = ((queenTime / 8) / 60)
	local gracePenalty = math.max(math.floor(((gracePeriod - 220) / burrowSpawnRate) + 0.5), 0)
	chickensPerPlayer = (chickensPerPlayer * SetCount(humanTeams))
	maxBurrows = maxBurrows + math.floor(SetCount(humanTeams) * 1.334) 
	queenTime = (queenTime + gracePeriod)
	chickenDebtCount = math.ceil((math.max((gracePeriod - 220),0) / 3)) 

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	--
	-- Game Rules
	--
	local UPDATE = 30

	local unitCounts = {}

	local chickenDefTypes = {}
	for unitName in pairs(chickenTypes) do
		chickenDefTypes[UnitDefNames[unitName].id] = unitName
		unitCounts[string.sub(unitName,1,-2)] = {count = 0, lastCount = 0}
	end

	local defendersDefs = {}
	for unitName in pairs(defenders) do 
		defendersDefs[UnitDefNames[unitName].id] = unitName
	end

	local function SetupUnit(unitName)
		SetGameRulesParam(unitName.."Count", 0)
		SetGameRulesParam(unitName.."Kills", 0)
	end

	SetGameRulesParam("queenTime",		queenTime)
	SetGameRulesParam("queenLife",		queenLifePercent)
	SetGameRulesParam("queenAnger",		 queenAnger)
	SetGameRulesParam("gracePeriod",		gracePeriod)

	for unitName in pairs(chickenTypes) do
		SetupUnit(string.sub(unitName,1,-2))
	end

	for unitName in pairs(defenders) do
		SetupUnit(string.sub(unitName,1,-2))
	end

	SetupUnit(burrowName)

		
	local difficulty = modes[luaAI] or 3
	SetGameRulesParam("difficulty", difficulty)

	local function UpdateUnitCount()
		local teamUnitCounts = GetTeamUnitsCounts(chickenTeamID)
		local total = 0
		
		for shortName in pairs(unitCounts) do
		unitCounts[shortName].count = 0
		end
		
		for unitDefID, number in pairs(teamUnitCounts) do
			if UnitDefs[unitDefID] then
				local shortName = string.sub(UnitDefs[unitDefID].name,1,-2)
				if unitCounts[shortName] then
					unitCounts[shortName].count = unitCounts[shortName].count + number
				end
			end
		end
		
		for shortName, counts in pairs(unitCounts) do
			if (counts.count ~= counts.lastCount) then
				SetGameRulesParam(shortName.."Count", counts.count)
				counts.lastCount = counts.count
			end
			total = total + counts.count
		end
		
		return total
	end



	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	--
	-- Clean up
	--

	local function KillOldChicken()
		for unitID, birthDate in pairs(chickenBirths) do
			local age = (t - birthDate)
			if (age > maxAge) then
				if (unitID ~= queenID) then 
				DestroyUnit(unitID)
				chickenCount = chickenCount - 1
				chickenDebtCount = chickenDebtCount + 1
				end
			end
		end
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	--
	-- Game End Stuff
	--

	local function KillAllChicken()
		local chickenUnits = GetTeamUnits(chickenTeamID)
		for _, unitID in pairs(chickenUnits) do
			if disabledUnits[unitID] then
				DestroyUnit(unitID, false, true)
			else
				DestroyUnit(unitID, true)
			end
		end
	end

	local function KillAllComputerUnits()
		for teamID in pairs(computerTeams) do
			local teamUnits = GetTeamUnits(teamID)
			for _, unitID in pairs(teamUnits) do
				if disabledUnits[unitID] then
					DestroyUnit(unitID, false, true)
				else
					DestroyUnit(unitID, true)
				end
			end
		end
	end

	local function CalculateScores()
		local totalDamage = 0
		local teamScores = {}
		local totalScore = bonusPoints
		for teamID in pairs(humanTeams) do
			local foo = Spring.GetTeamStatsHistory(teamID,0,t)
			teamScores[teamID] = foo[#foo].damageDealt
			totalDamage = totalDamage + teamScores[teamID]
			local teamUnits = GetTeamUnits(teamID)
			for _, unitID in pairs(teamUnits) do
			local defID = GetUnitDefID(unitID)
				if defID then
					totalScore = totalScore + UnitDefs[defID].metalCost
					totalScore = totalScore + (UnitDefs[defID].energyCost / 50)
				end
			end
		end
		for teamID in pairs(humanTeams) do
			teamScores[teamID] = (teamScores[teamID] / totalDamage)
			teamScores[teamID] = math.ceil((totalScore * teamScores[teamID]))
			if (teamID > highTeam) then 
				highTeam = teamID 
			end
		end
		highTeam = (highTeam + 1)
		return teamScores
	end

	local function DisplayScores(scoreList)
		Spring.Echo("			 ")
		Spring.Echo("Team Scores")
		Spring.Echo("-----------")
		for i = 0,highTeam,1 do
			if scoreList[i] then
				local teamID = i
				local teamScore = scoreList[i]
				local playerList = Spring.GetPlayerList(teamID, false)
				if playerList[1] then
					Spring.SendMessage("Team" .. teamID .. " (<PLAYER" .. playerList[1] .. ">) - " .. comma_value(teamScore) .. " Points")
				else
					Spring.Echo("Team" .. teamID .. " (AI) - " .. comma_value(teamScore) .. " Points")
				end
			end
		end
	end


	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	--
	-- Spawn Dynamics
	--

	local function addChickenTarget(chickenID, targetID)
		if (not targetID) or (GetUnitTeam(targetID) == chickenTeamID) or (GetUnitTeam(chickenID) ~= chickenTeamID) then 
			return 
		end
		--debug--Spring.Echo(t .. " addChickenTarget " .. chickenID .. "," .. targetID)
		if chickenTargets[chickenID] and chickenTargets[chickenTargets[chickenID]] then
			chickenTargets[chickenTargets[chickenID]][chickenID] = nil
		end
		if (chickenTargets[targetID] == nil) then
			chickenTargets[targetID] = {}
			chickenTargets[targetID][chickenID] = targetID
			chickenTargets[chickenID] = targetID
		else
			chickenTargets[targetID][chickenID] = targetID
			chickenTargets[chickenID] = targetID
		end
	end

	local function AttackNearestEnemy(unitID, unitDefID, unitTeam)
		local targetID = GetUnitNearestEnemy(unitID)
		if (targetID) and (not GetUnitIsDead(targetID)) and (not GetUnitNeutral(targetID)) then
		--debug--Spring.Echo(t .. " AttackNearestEnemy " .. unitID .. " -> " .. targetID)
		local defID = GetUnitDefID(targetID)
		if UnitDefs[defID] and (UnitDefs[defID].speed > 75) then
			return false
		end
		local x,y,z = GetUnitPosition(targetID)
		idleOrderQueue[unitID] = {cmd = CMD.FIGHT, params = {x,y,z}, opts = {}}
		addChickenTarget(unitID, targetID)
		return true
		else
		return false
		end
	end

	local function ChooseTarget()
		local humanTeamList = SetToList(humanTeams)
		if (#humanTeamList == 0) then
			return {mRandom(1,MAPSIZEX-1),0,mRandom(1,MAPSIZEZ-1)}
		end
		local isDead 
		
		if targetCache then
			isDead = GetUnitIsDead(targetCache)
		else -- targetcache is nil, so dead!
			isDead = true
		end
		
		if (targetCacheCount >= nextSquadSize) or isDead then
			local tries = 0
			repeat
				local teamID = humanTeamList[mRandom(#humanTeamList)]
				if (teamID == lastTeamID) then
					teamID = humanTeamList[mRandom(#humanTeamList)] 
				end
				lastTeamID = teamID
				local units = GetTeamUnits(teamID)
				if units[2] then
					targetCache = units[mRandom(1,#units)]
				else
					targetCache = units[1]
				end
				local slowunit = true
				if tries < 5 then
					if targetCache then
						local defID = GetUnitDefID(targetCache)
						if UnitDefs[defID] and (UnitDefs[defID].speed > 75) then
							slowunit = false
						end
					end
				end		
				tries = (tries + 1)
			until targetCache and((not GetUnitIsDead(targetCache)) and (not GetUnitNeutral(targetCache)) and slowunit) or (tries > maxTries)
				targetCacheCount = 0
				nextSquadSize = 6 + mRandom(0,4)
		else
			targetCacheCount = targetCacheCount + 1
		end	
		--debug--Spring.Echo(t .. " ChooseTarget " .. targetCache)
		if targetCache then
			--Spring.Echo(GetUnitPosition(targetCache))
			return {GetUnitPosition(targetCache)}	
		else
			return {100,100,100}
		end
	end

	local function getChickenSpawnLoc(burrowID, size)
		local x, y, z
		local bx, by, bz	= GetUnitPosition(burrowID)
		if (not bx or not bz) then
		return false
		end
		
		local tries		 = 0
		local s			 = spawnSquare
			
		repeat
		x = mRandom(bx - s, bx + s)
		z = mRandom(bz - s, bz + s)
		s = s + spawnSquareIncrement
		tries = tries + 1
		if (x >= MAPSIZEX) then x = (MAPSIZEX - mRandom(1,40)) elseif (x <= 0) then x = mRandom(1,40) end
		if (z >= MAPSIZEZ) then z = (MAPSIZEZ - mRandom(1,40)) elseif (z <= 0) then z = mRandom(1,40) end
		until ((TestBuildOrder(size, x, by, z, 1) == 2) and (not GetGroundBlocked(x, z))) or (tries > maxTries)
				 
		y = GetGroundHeight(x,z)
		return x, y, z
		 
	end


	local function SpawnTurret(burrowID, turret)

		if (mRandom() > defenderChance) or (not turret) or (burrows[burrowID] >= maxTurrets) then
		return
		end
		
		local x, y, z
		local bx, by, bz	= GetUnitPosition(burrowID)
		local tries		 = 0
		local s			 = spawnSquare

		repeat
		x = mRandom(bx - s, bx + s)
		z = mRandom(bz - s, bz + s)
		s = s + spawnSquareIncrement
		tries = tries + 1
		if (x >= MAPSIZEX) then x = (MAPSIZEX - mRandom(1,40)) elseif (x <= 0) then x = mRandom(1,40) end
		if (z >= MAPSIZEZ) then z = (MAPSIZEZ - mRandom(1,40)) elseif (z <= 0) then z = mRandom(1,40) end
		until (not GetGroundBlocked(x, z) or tries > maxTries)
		
		y = GetGroundHeight(x,z)
		local unitID = CreateUnit(turret, x, y, z, "n", chickenTeamID)
		idleOrderQueue[unitID] = {cmd = CMD.GUARD, params ={burrowID}, opts = {}}
		SetUnitBlocking(unitID, false)
		turrets[unitID] = {burrowID, t}
		burrows[burrowID] = burrows[burrowID] + 1
		 
	end


	local function SpawnBurrow(number)
		
		if (queenID) then
		return
		end

		local unitDefID = UnitDefNames[burrowName].id
		
		for i=1, (number or 1) do
		local x, z
		local tries = 0
		repeat
		if (burrowSpawnType == "initialbox") then 
			x = mRandom(lsx1, lsx2)
			z = mRandom(lsz1, lsz2)
		elseif ((burrowSpawnType == "alwaysbox") and (tries < (maxTries / 2))) then
			x = mRandom(lsx1, lsx2)
			z = mRandom(lsz1, lsz2)
		else
			x = mRandom(spawnSquare, MAPSIZEX - spawnSquare)
			z = mRandom(spawnSquare, MAPSIZEZ - spawnSquare)
		end
		
		local y = GetGroundHeight(x, z)
		tries = tries + 1
		local blocking = TestBuildOrder(REFERENCE_UNIT, x, y, z, 1)
		if (blocking == 2) and (burrowSpawnType == "avoid") then
			local proximity = GetUnitsInCylinder(x, z, minBaseDistance)
			local vicinity = GetUnitsInCylinder(x, z, maxBaseDistance)
			local humanUnitsInVicinity = false
			local humanUnitsInProximity = false
			for i=1,#vicinity,1 do
			if (GetUnitTeam(vicinity[i]) ~= chickenTeamID) then
				humanUnitsInVicinity = true
				break
			end
			end

			for i=1,#proximity,1 do
			if (GetUnitTeam(proximity[i]) ~= chickenTeamID) then
				humanUnitsInProximity = true
				break
			end
			end

			if (humanUnitsInProximity or not humanUnitsInVicinity) then
			blocking = 1
			end
		end
		until (blocking == 2 or tries > maxTries)

		local unitID = CreateUnit(burrowName, x, 0, z, "n", chickenTeamID)
		burrows[unitID] = 0
		SetUnitBlocking(unitID, false)
		end
		
	end

	local function updateQueenLife()
		if not queenID then return end
		local curH, maxH = GetUnitHealth(queenID)
		local lifeCheck = math.ceil(((curH/maxH)*100)-0.5)
		if queenLifePercent ~= lifeCheck then
		queenLifePercent = lifeCheck
		SetGameRulesParam("queenLife",		queenLifePercent)
		end
	end

	local function stunUnit(unitID, seconds)
		seconds = (seconds * 30)
		if stunList[unitID] then 
			seconds = math.max(stunList[unitID], seconds) 
		end
		stunList[unitID] = seconds
		SetUnitHealth(unitID, {paralyze=99999999})
	end

	local function SpawnQueen()
		
		local x, y, z
		local tries = 0
		
		repeat
		x = mRandom(1, (MAPSIZEX-1))
		z = mRandom(1, (MAPSIZEZ-1))
		y = GetGroundHeight(x, z)
		tries = tries + 1
		local blocking = TestBuildOrder(LARGE_UNIT, x, y, z, 1)
		
		local proximity = GetUnitsInCylinder(x, z, minBaseDistance)
		local vicinity = GetUnitsInCylinder(x, z, maxBaseDistance)
		local humanUnitsInVicinity = false
		local humanUnitsInProximity = false
		
		for i=1,#vicinity,1 do
			if (GetUnitTeam(vicinity[i]) ~= chickenTeamID) then
				humanUnitsInVicinity = true
				break
			end
		end

		for i=1,#proximity,1 do
			if (GetUnitTeam(proximity[i]) ~= chickenTeamID) then
				humanUnitsInProximity = true
				break
			end
		end

		if (humanUnitsInProximity or not humanUnitsInVicinity) then
			blocking = 1
		end
		
		until (blocking == 2 or tries > maxTries)
		
		return CreateUnit(queenName, x, y, z, "n", chickenTeamID)
	 
	end


	local function Wave()
		--debug--Spring.Echo(t .. "Wave()")
		
		if gameOver then 
			return 
		end
		
		currentWave = math.min(math.ceil((((t-gracePeriod+queenAnger) / 60) / nextWave)), 8)
		if currentWave > #waves then 
			currentWave = #waves 
		end
		if queenID then
			if queenSpawnMult > 0 then
				for i = 1,queenSpawnMult,1 do
					local squad = waves[9][mRandom(1,#waves[9])]
					for i,sString in pairs(squad) do
						local nEnd,_	 = string.find(sString, " ")
						local unitNumber = string.sub(sString,1,(nEnd-1))
						local chickenName	= string.sub(sString,(nEnd+1))
						for i = 1,unitNumber,1 do
							table.insert(spawnQueue, {burrow = queenID, unitName = chickenName, team = chickenTeamID})
						end
					end
				end
			end
		currentWave = 10
		end
		
		local cCount = 0
		for burrowID in pairs(burrows) do
		if (t > (queenTime * 0.33)) then SpawnTurret(burrowID, bonusTurret) end
			local squad = waves[currentWave][mRandom(1,#waves[currentWave])]
			for i,sString in pairs(squad) do
				local skipSpawn = false
				if (cCount > chickensPerPlayer) and (mRandom() > spawnChance) then 
					skipSpawn = true 
				end
				if skipSpawn and (chickenDebtCount > 0) and (mRandom() > 0.5) then
					chickenDebtCount = (chickenDebtCount - 1)
					skipSpawn = false
				end
				if not skipSpawn then
					local nEnd,_	 = string.find(sString, " ")
					local unitNumber = string.sub(sString,1,(nEnd-1))
					local chickenName	= string.sub(sString,(nEnd+1))
					for i = 1,unitNumber,1 do
						table.insert(spawnQueue, {burrow = burrowID, unitName = chickenName, team = chickenTeamID})
					end
					cCount = cCount + unitNumber
				end
			end
		end
		return cCount
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	--
	-- Get rid of the AI
	--

	local function DisableUnit(unitID)
		Spring.MoveCtrl.Enable(unitID)
		Spring.MoveCtrl.SetPosition(unitID, MAPSIZEX/2, 99999, MAPSIZEZ/2)
		Spring.SetUnitStealth(unitID, true)
		Spring.SetUnitNoDraw(unitID, true)
		Spring.SetUnitNoSelect(unitID, true)
		Spring.SetUnitNoMinimap(unitID, true)
		Spring.SetUnitCloak(unitID, true)
		SetUnitBlocking(unitID, false)
		SetUnitHealth(unitID, {paralyze=99999999})
		disabledUnits[unitID] = true
	end

	local function DisableComputerUnits()
		for teamID in pairs(computerTeams) do
			local teamUnits = GetTeamUnits(teamID)
			for _, unitID in ipairs(teamUnits) do
				DisableUnit(unitID)
			end
		end
	end


	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	--
	-- Call-ins
	--

	function gadget:UnitMoveFailed(unitID, unitDefID, unitTeam)
		if gameOver then 
			return 
		end
		if (unitTeam ~= chickenTeamID) or (unitID == queenID) or idleOrderQueue[unitID] then 
			return
		end
		local px,py,pz = GetUnitPosition(unitID)
		if failChickens[unitID] then
			if (getSqrDistance(failChickens[unitID].x,failChickens[unitID].z,px,pz) < 5000) then
				failChickens[unitID].count = failChickens[unitID].count + 1
				if (failChickens[unitID].count > 3) then
					DestroyUnit(unitID, false, true)
					chickenDebtCount = chickenDebtCount + 1
					chickenCount = chickenCount - 1
					return
				end
			else
				failChickens[unitID].x = px
				failChickens[unitID].z = pz
			end
		else
			failChickens[unitID] = { x = px, z = pz, count = 1 }
		end
		if (mRandom(1,2) == 1) then
			px = px + mRandom(50,100) 
		else 
			px = px - mRandom(50,100) 
		end
		if (mRandom(1,2) == 1) then 
			pz = pz + mRandom(50,100) 
		else 
			pz = pz - mRandom(50,100) 
		end
		idleOrderQueue[unitID] = {cmd = CMD.MOVE, params = {px,py,pz}, opts = {}}
	end

	function gadget:UnitIdle(unitID, unitDefID, unitTeam)
		if gameOver then 
			return 
		end
		if (unitTeam == chickenTeamID) and (chickenDefTypes[unitDefID] or (unitID == queenID)) then
		--debug--Spring.Echo(t .. " unitIdle " .. unitID)
			if not AttackNearestEnemy(unitID, unitDefID, unitTeam) then
				idleOrderQueue[unitID] = {cmd = CMD.FIGHT, params = ChooseTarget(), opts = {}}
				if targetCache then
					if GetUnitNeutral(targetCache) then
						idleOrderQueue[unitID] = {cmd = CMD.ATTACK, params = {targetCache}, opts = {}}
					end
					addChickenTarget(unitID, targetCache)
				end
			end
		end 
	end

	function gadget:UnitCreated(unitID, unitDefID, unitTeam)
		if chickenTargets[unitID] then
			chickenTargets[unitID] = nil
		end
	end

	function gadget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, 
								weaponID, attackerID, attackerDefID, attackerTeam)
									
		-- if EMP_GOO[weaponID] and (unitTeam ~= chickenTeamID) and (lobberEMPTime > 0) then
		-- stunUnit(unitID, ((damage / EMP_GOO[weaponID]) * lobberEMPTime))
		-- end
		 
		if chickenBirths[attackerID] then 
			chickenBirths[attackerID] = t 
		end
		if failChickens[attackerID] then 
			failChickens[attackerID] = nil 
		end
		if failChickens[unitID] then 
			failChickens[unitID] = nil 
		end
		
		-- if (unitDefID == LOBBER) then
		-- local nSpawn = false
		-- if ((GetUnitHealth(unitID) < 2475) and (damage < (2000 + mRandom(1,500)))) then nSpawn = true end
		if ((weaponID == JUNO) and (mRandom(1,2) == 1)) then 
			nSpawn = true
		end
		
		if (unitID == queenID) then
			if paralyzer then
				SetUnitHealth(unitID, {paralyze=0})
				return
			end
			if (weaponID == -1) and (damage > 25000) then
				local qHealth = GetUnitHealth(unitID)
				SetUnitHealth(unitID, (qHealth + damage - 25000))
				damage = 25000
			end
			if attackerDefID then
				if not queenResistance[weaponID] then 
					queenResistance[weaponID] = {}
					queenResistance[weaponID].damage = damage
					queenResistance[weaponID].notify = 0
				end
				local resistPercent = (math.min(queenResistance[weaponID].damage/queenMaxHP, 0.75) + 0.2)
				if resistPercent > 0.35 then
					if queenResistance[weaponID].notify == 0 then
						local weaponName
						weaponName = WeaponDefs[weaponID].description
						Spring.Echo("Battleship is becoming resistant to " .. UnitDefs[attackerDefID].humanName .. "'s attacks (" .. weaponName .. ")")
						queenResistance[weaponID].notify = 1
					end
					local qHealth = GetUnitHealth(unitID)
					SetUnitHealth(unitID, (qHealth + (damage * resistPercent)))
					damage = damage - (damage * resistPercent)
				end
				queenResistance[weaponID].damage = queenResistance[weaponID].damage + damage
			end
			qDamage = (qDamage + damage)
			if (qDamage > (queenMaxHP/10)) then
				if qMove then
					idleOrderQueue[queenID] = {cmd = CMD.STOP, params = {}, opts = {}}
					qMove = false
					qDamage = 0 - mRandom(1,25000)
				else
					local cC = ChooseTarget()
					local xQ, _, zQ = GetUnitPosition(queenID)
					if cC then
						local angle = math.atan2((cC[1]-xQ), (cC[3]-zQ))
						local dist = math.sqrt(((cC[1]-xQ)*(cC[1]-xQ))+((cC[3]-zQ)*(cC[3]-zQ))) * 0.75
						if (dist > 800) and (dist < 3000) then
							GiveOrderToUnit(queenID, CMD.MOVE, {(xQ + (math.sin(angle) * dist)), cC[2], (zQ + (math.cos(angle) * dist))}, {})
							GiveOrderToUnit(queenID, CMD.FIGHT, cC, {"shift"})
						if targetCache then addChickenTarget(queenID, targetCache) end
							qDamage = (0 - mRandom(1,25000))
							Wave()
							qMove = true
						else
							idleOrderQueue[queenID] = {cmd = CMD.STOP, params = {}, opts = {}}
							qDamage = 0
							Wave()
						end
					else
						idleOrderQueue[queenID] = {cmd = CMD.STOP, params = {}, opts = {}}
						qDamage = 0
					end
				end
			end
		end
	end

	function gadget:GameStart()
		Spring.Echo("GameStart() chickenTeamID",chickenTeamID)
		if warningMessage then 
			Spring.Echo("Warning: No Survival bot team available, adding a Survival bot")
			Spring.Echo("(Assigning Survival bot Team to Gaia)")
			Spring.SendCommands("endgraph 0") -- it's an ugly broken hack, but the only one I found
		end
		DisableComputerUnits()
		if (burrowSpawnType == "initialbox") or (burrowSpawnType == "alwaysbox") then
			local _,_,_,_,_,luaAllyID = Spring.GetTeamInfo(chickenTeamID)
			if luaAllyID then
				lsx1,lsz1,lsx2,lsz2 = Spring.GetAllyTeamStartBox(luaAllyID)
				if (not lsx1) or (not lsz1) or (not lsx2) or (not lsz2) then
					burrowSpawnType = "avoid"
					Spring.Echo("No Survival mode start box available, Burrow Placement set to 'Avoid Players'")
				elseif (lsx1 == 0) and (lsz1 == 0) and (lsx2 == Game.mapSizeX) and (lsz2 == Game.mapSizeX) then
					burrowSpawnType = "avoid"
					Spring.Echo("No Survival mode start box available, Burrow Placement set to 'Avoid Players'")
				end
			end
		end
	end
	 
	function gadget:GameFrame(n)
			
		if gameOver then return end
		
		if (chickenCount < maxChicken) then
		local i,defs = next(spawnQueue)
		if i and defs then
			local x, y, z = getChickenSpawnLoc(defs.burrow, SMALL_UNIT)
			if x and y and z then
				local myUnit = defs.unitName
				if (chickenSwitches[difficulty] and chickenSwitches[difficulty][defs.unitName])then
					myUnit = chickenSwitches[difficulty][defs.unitName]
				end			
				local unitID = CreateUnit(myUnit, x,y,z, "n", defs.team)
				if unitID then
					 SetUnitExperience(unitID, expMod)
					 idleOrderQueue[unitID] = {cmd = CMD.FIGHT, params = ChooseTarget(), opts = {}}
					 if targetCache then
						 if GetUnitNeutral(targetCache) then
							 idleOrderQueue[unitID] = {cmd = CMD.ATTACK, params = {targetCache}, opts = {}}
						 end
							addChickenTarget(unitID, targetCache)
						 end
						 chickenBirths[unitID] = t
						 chickenCount = chickenCount + 1
					end
				end
				spawnQueue[i] = nil
			end
		end
		
		for unitID in pairs(stunList) do
			stunList[unitID] = (stunList[unitID] - 1)
			if (stunList[unitID] <= 0) then 
				SetUnitHealth(unitID, {paralyze=0})
				stunList[unitID] = nil
			end
		end	
		
		if (n >= timeCounter) then
		timeCounter = (n + UPDATE)
			
		t = GetGameSeconds()
		KillOldChicken()
		
		if (t < gracePeriod) then return end
		
		expMod = (expMod + expIncrement)
		
		if next(idleOrderQueue) then
			local processOrderQueue = {}
			for unitID,order in pairs(idleOrderQueue) do
				if GetUnitDefID(unitID) then 
					processOrderQueue[unitID] = order
				end
			end
			idleOrderQueue = {}
			for unitID,order in pairs(processOrderQueue) do
				GiveOrderToUnit(unitID, order.cmd, order.params, order.opts)
				GiveOrderToUnit(unitID, CMD.MOVE_STATE, { mRandom(0,2) }, {})
			end
		end
			 
		if (t >= (queenTime - queenAnger)) then
			if (not queenID) and (not gameOver) then
				queenID = SpawnQueen()
				idleOrderQueue[queenID] = {cmd = CMD.STOP, params = {}, opts = {}}
				_G.chickenEventArgs = {type="queen"}
				SendToUnsynced("ChickenEvent")
				_G.chickenEventArgs = nil
				_,queenMaxHP = GetUnitHealth(queenID)
				SetUnitExperience(queenID, (expMod*1.5))
				chickenSpawnRate = (chickenSpawnRate * 0.75)	 
			end
			updateQueenLife()
		end
			
		local quicken = 0
		local burrowCount = SetCount(burrows)
		 
		if (burrowTarget > 0) and (burrowTarget ~= burrowCount) then
			quicken = (burrowSpawnRate * (1 - (burrowCount / burrowTarget)))
		end
			
		local burrowSpawnTime = (burrowSpawnRate - quicken)
				 
		if (burrowSpawnRate < (t - timeOfLastFakeSpawn) and burrowCount < maxBurrows) then
			if firstSpawn then	
				minBurrows = SetCount(humanTeams)
				local hteamID = next(humanTeams)
				local ranCount = GetTeamUnitCount(hteamID)
				for i = 1,ranCount,1 do
					mRandom()
				end
				burrowTarget = math.min(math.ceil(minBurrows * 1.5) + gracePenalty, 40)
			else
				burrowTarget = burrowTarget + 1
			end
			timeOfLastFakeSpawn = t
		end
		
		if (burrowCount < minBurrows) or (burrowSpawnTime <	(t - timeOfLastSpawn) and burrowCount < maxBurrows) then 
			if firstSpawn then
				for i = 1,math.min(math.ceil((SetCount(humanTeams) * 1.5)) + gracePenalty, 40),1 do
					SpawnBurrow()
				end
				timeOfLastWave = (t - (chickenSpawnRate - 6))
				firstSpawn = false
				if (burrowSpawnType == "initialbox") then 
					burrowSpawnType = "avoid" 
				end
			else
				SpawnBurrow()
			end
			if (burrowCount >= minBurrows) then 
				timeOfLastSpawn = t 
			end
			_G.chickenEventArgs = {type="burrowSpawn"}
			SendToUnsynced("ChickenEvent")
			_G.chickenEventArgs = nil
			SetGameRulesParam("roostCount", SetCount(burrows))
		end
		
		if (burrowCount > 0) and (chickenSpawnRate < (t - timeOfLastWave)) then
			local cCount = Wave()
			if cCount and cCount > 0 and (not queenID) then
				_G.chickenEventArgs = {type="wave", number=cCount, tech=currentWave}
				SendToUnsynced("ChickenEvent")
				_G.chickenEventArgs = nil
			end
			timeOfLastWave = t
		end
		chickenCount = UpdateUnitCount()
		end 
	end

	function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
		--debug--Spring.Echo(t .. " UnitDestroyed " .. unitID)
		if gameOver then 
			return 
		end
		 
		if chickenBirths[unitID] then
			chickenBirths[unitID] = nil 
		end
	
		if turrets[unitID] then 
			turrets[unitID] = nil
		end

		if idleOrderQueue[unitID] then 
			idleOrderQueue[unitID] = nil 
		end
		
		if failChickens[unitID] then 
			failChickens[unitID] = nil 
		end

		if chickenTargets[unitID] then
			if (unitTeam ~= chickenTeamID) then
				--debug--Spring.Echo(t .. " chickenTargets " .. unitID)
				for chickenID in pairs(chickenTargets[unitID]) do
					--debug--Spring.Echo(t .. " stopChicken " .. chickenID)
					if GetUnitDefID(chickenID) then 
						idleOrderQueue[chickenID] = {cmd = CMD.STOP, params = {}, opts = {}}	 
					end
				end
			elseif chickenTargets[chickenTargets[unitID]] then
				chickenTargets[chickenTargets[unitID]][unitID] = nil
			end
			chickenTargets[unitID] = nil
		end
		
		if (unitID == targetCache) then
			targetCache = nil
			targetCacheCount = math.huge
		end
		
		if (unitTeam == chickenTeamID) and chickenDefTypes[unitDefID] then
			local name = UnitDefs[unitDefID].name
			if unitDefID ~= burrowDef then 
				name = string.sub(name,1,-2) 
			end
			local kills = GetGameRulesParam(name.."Kills")
			SetGameRulesParam(name.."Kills", kills + 1)
			chickenCount = chickenCount - 1
		end
		
		if (unitID == queenID) then
			queenID = nil
			gameOver = true
			endScores = CalculateScores()
			endScores.type = "scores"
			_G.chickenEventArgs = endScores
			SendToUnsynced("ChickenEvent")
			_G.chickenEventArgs = nil
			KillAllComputerUnits()
			KillAllChicken()
		end
		
		if (unitDefID == burrowDef) and (not gameOver) then
		
		local kills = GetGameRulesParam(burrowName.."Kills")
		SetGameRulesParam(burrowName.."Kills", kills + 1)
		
		burrows[unitID] = nil
		if (addQueenAnger == 1) then
			queenAnger = (queenAnger + angerBonus)
			expMod = (expMod + (expIncrement * angerBonus))
			SetGameRulesParam("queenAnger", queenAnger)
			bonusPoints = (bonusPoints + 2500)	
		end
			
		for i,defs in pairs(spawnQueue) do
			if (defs.burrow == unitID) then
			spawnQueue[i] = nil
			end
		end
		
		SetGameRulesParam("roostCount", SetCount(burrows))
		end
		
	end

	function gadget:TeamDied(teamID)
		if humanTeams[teamID] then
			if (minBurrows > 1) then
				minBurrows = (minBurrows - 1) 
			end
		end
		humanTeams[teamID] = nil
		computerTeams[teamID] = nil
		if gameOver and showScoresOnce then 
			DisplayScores(endScores)
			showScoresOnce = false
		end
	end

	function gadget:UnitTaken(unitID, unitDefID, oldTeam, newTeam)
		if (oldTeam == chickenTeamID) then
			DestroyUnit(unitID, true)
		end
	end

	function gadget:AllowUnitTransfer(unitID, unitDefID, oldTeam, newTeam, capture)
		if (newTeam == chickenTeamID) then
			return false
		else
			return true
		end
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
else
	-- END SYNCED
	-- BEGIN UNSYNCED
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	local Script = Script
	local SYNCED = SYNCED

	function WrapToLuaUI()
		if (Script.LuaUI('ChickenEvent')) then
		local chickenEventArgs = {}
		for k, v in spairs(SYNCED.chickenEventArgs) do
			chickenEventArgs[k] = v
		end
		Script.LuaUI.ChickenEvent(chickenEventArgs)
		end
	end

	function gadget:Initialize()
			gadgetHandler:AddSyncAction('ChickenEvent', WrapToLuaUI)
	end

end
