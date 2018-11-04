--[[
Task Queues!
]]--

math.randomseed( os.time() )
math.random(); math.random(); math.random()

--------------------------------------------- Functions for AI
local aiDebug = Spring.GetModOptions().aidebug
local spGetTeamUnitsSorted = Spring.GetTeamUnitsSorted
local spGetUnitDefID = Spring.GetUnitDefID
local spGetTeamResources = Spring.GetTeamResources
local spGetTeamUnitDefCount = Spring.GetTeamUnitDefCount
local spGetTeamInfo = Spring.GetTeamInfo
local spGetTeamStartPosition = Spring.GetTeamStartPosition
local spGetAllyTeamStartBox = Spring.GetAllyTeamStartBox
local liftersqueued = 0
local skip = {action = "nexttask"}
--Spring.GetGameSeconds() -- checking gametime

if aiDebug == nil then
	aiDebug = "enabled"
end

---------------------------------------------------------------- LIFTER QUEUES
 
 --function MoveToStartLocation( taskqueuebehaviour )
	
	--local startxmin, startzmin, startxmax, startzmax = spGetAllyTeamStartBox(ai.allyId)
	--local px = math.random(startxmin, startxmax)
	--local pz = math.random(startzmin, startzmax)
	--local py = 0
	
	--Spring.Echo([[AI startxmin ]] .. startxmin .. [[ ]])
	--Spring.Echo([[AI startzmin ]] .. startzmin .. [[ ]])
	--Spring.Echo([[AI startxmax ]] .. startxmax .. [[ ]])
	--Spring.Echo([[AI startzmax ]] .. startzmax .. [[ ]])
	
	--local spawnposx, _, spawnposz = spGetTeamStartPosition(ai.id)
	--local sx = spawnposx
	--local sz = spawnposz
	
	--Spring.Echo([[AI spawnx ]] .. sx .. [[ ]])
	--Spring.Echo([[AI spawnz ]] .. sz .. [[ ]])
	
	--mx = sx - px
	--mz = sz - pz
	--my = 0

	--local x = px
	--local z = pz
	--local y = py
	
	--Spring.Echo([[AI startlocationx ]] .. mx .. [[ ]])
	--Spring.Echo([[AI startlocationz ]] .. mz .. [[ ]])
	
	--Spring.Echo([[AI ID ]] .. ai.id .. [[ ]])
	--Spring.Echo([[AI allyID ]] .. ai.allyId .. [[ ]])
	--return action = "move", position = {x = px, y = py, z = pz},
--end

function BuildMex()
	local mc, ms, mp, mi, me = Spring.GetTeamResources(ai.id, "metal")
	local aimexamount = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.emetalextractor.id)
	if mc >= ms - ms*0.10 or Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elifterai.id) < 5 then
		if Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elifterai.id)*240 < Spring.GetGameSeconds() then
			return "elifterai"
		else
			return "eorb"
		end
	else
		return "emetalextractor"
	end
end
 
 
 function RandomLift( tqb, ai, unit )
	--Locals
	local mc, ms, mp, mi, me = Spring.GetTeamResources(ai.id, "metal")
	local ec, es = Spring.GetTeamResources(ai.id, "energy")
	local su = Spring.GetTeamRulesParam(ai.id, "supplyUsed")
	local sm = Spring.GetTeamRulesParam(ai.id, "supplyMax")
	local unitcount = Spring.GetTeamUnitCount(ai.id)
	
	--DEBUG LOG
	if aiDebug == "enabled" then
		Spring.Echo([[Shard Debug Log]])
		Spring.Echo([[--Units:]])
		Spring.Echo([[AI have ]] .. unitcount .. [[ units!]])
		Spring.Echo([[--Resources:]])
		Spring.Echo([[AI is using ]] .. su ..[[/]] .. sm .. [[ supply!]])
		Spring.Echo([[AI have ]] .. math.ceil(mc) ..[[/]] .. ms .. [[ metal and ]] .. math.ceil(ec) .. [[/]] .. es .. [[ energy!]])
		Spring.Echo([[AI Metal Income is ]] .. mi.. [[ / -]] .. me )
		Spring.Echo(GG.TechCheck("endbringer", ai.id) )
	else
	end
	--Spring.SendMessageToPlayer(0, "Hello World!")
	------- Tech 0 - Very Early Game
	
	if ec <= 50 and GG.TechCheck("tech1", ai.id) == true then
		if GG.TechCheck("tech3", ai.id) == true then
			return "efusion2"
		elseif GG.TechCheck("tech2", ai.id) == true then
			return "egeothermal"
		else
			return "esolar2"
		end
	elseif (mc >= ms - ms*0.10 or Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elifterai.id) < 5) and Spring.GetGameSeconds() < 300 then
		if Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elifterai.id)*240 < Spring.GetGameSeconds() then
			return "elifterai"
		else
			return "eorb"
		end
	elseif es < Spring.GetGameSeconds()*0.5 then
		return "estorage"
	elseif su >= sm-40 and sm ~= 400 then
		return "estorage"
	
	elseif GG.TechCheck("tech1", ai.id) == false and Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.etech1.id) == 0 then
		return "etech1"
		
	else
		if GG.TechCheck("tech1", ai.id) == false and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then 
			local r = math.random(0,1)
			if r == 0 then
				return "emine"
			else
				return "eturretlightai"
			end
		
		------- Reached Tech 1
		elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then 
			if ec <= 50 then
				return "esolar2"
			else
				local r = math.random(0,2)
				local aar = math.random(0,5)
				if aar > 0 then
					if r == 0 then
						return "emine"
					elseif r == 1 then
						return "eradar2"
					elseif r == 2 then
						return "eturretlightai"
					end
				else
					return "elaserbattery"
				end
			end
		
		------- Reached Tech 2 MK 2
		elseif GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == false then 
			if ec <= 50 then
				return "egeothermal"
			else
				local r2 = math.random(0,20)
				local aar = math.random(0,5)
				if r2 > 0 and aar > 0 then
					local r = math.random(0,4)
					if r == 0 then
						return "emine"
					elseif r == 1 then
						return "eradar2"
					elseif r == 2 then
						return "eturretlightai"
					elseif r == 3 then
						return "eturretheavyai"
					elseif r == 4 then
						return "ejammerai"
					end
				elseif r2 == 0 then
					local r = math.random(0,1)
					if r == 0 then
						return "eshieldgen"
					else
						return "ekmar"
					end
				else
					return "elaserbattery"
				end
			end
			
		------- Reached Tech 3 MK 3
		elseif GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true and Spring.GetGameSeconds() <= 1500 then 
			if ec <= 50 then
				return "efusion2"
			else
				local r2 = math.random(0,10)
				local aar = math.random(0,5)
				if r2 > 0 and aar > 0 then
					local r = math.random(0,4)
					if r == 0 then
						return "emine"
					elseif r == 1 then
						return "eradar2"
					elseif r == 2 then
						return "eturretlightai"
					elseif r == 3 then
						return "eturretheavyai"
					elseif r == 4 then
						return "ejammerai"
					end
				elseif r2 == 0 then
					local r = math.random(0,3)
					if r == 0 then
						return "eshieldgen"	
					elseif r == 1 then
						return "eartyturret_up3"
					elseif r == 2 then
						return "esiloai"
					elseif r == 3 then
						return "ekmar"
					end
				else
					return "elaserbattery"
				end
			end
		
		------- Reached MK 4
		elseif GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true and Spring.GetGameSeconds() > 1500 then
			if ec <= 50 then
				return "efusion2"
			else
				local r2 = math.random(0,5)
				local aar = math.random(0,10)
				if r2 > 0 and aar > 0 then
					local r = math.random(0,4)
					if r == 0 then	
						return "emine"
					elseif r == 1 then
						return "eradar2"
					elseif r == 2 then
						return "eturretlightai_up3"
					elseif r == 3 then
						return "eturretheavyai_up3"
					elseif r == 4 then
						return "ejammerai"
					end
				elseif r2 == 0 then
					local r = math.random(0,3)
					if r == 0 then
						return "eshieldgen"	
					elseif r == 1 then
						return "eartyturret_up3"
					elseif r == 2 then
						return "esiloai"
					elseif r == 3 then
						return "ekmar"
					end
				else
					return "elaserbattery"
				end
			end
		end
	end
end

function RandomOverseer( tqb, ai, unit )
	--Locals
	local mc, ms, mp, mi, me = Spring.GetTeamResources(ai.id, "metal")
	local ec, es = Spring.GetTeamResources(ai.id, "energy")
	local su = Spring.GetTeamRulesParam(ai.id, "supplyUsed")
	local sm = Spring.GetTeamRulesParam(ai.id, "supplyMax")
	local unitcount = Spring.GetTeamUnitCount(ai.id)
	
	--DEBUG LOG
	if aiDebug == "enabled" then
		Spring.Echo([[Shard Debug Log]])
		Spring.Echo([[--Units:]])
		Spring.Echo([[AI have ]] .. unitcount .. [[ units!]])
		Spring.Echo([[--Resources:]])
		Spring.Echo([[AI is using ]] .. su ..[[/]] .. sm .. [[ supply!]])
		Spring.Echo([[AI have ]] .. math.ceil(mc) ..[[/]] .. ms .. [[ metal and ]] .. math.ceil(ec) .. [[/]] .. es .. [[ energy!]])
	else
	end
	
	
	
	------- Tech 0 - Very Early Game
	if ec <= 50 and GG.TechCheck("tech1", ai.id) == true then
		if GG.TechCheck("tech3", ai.id) == true then
			return "efusion2"
		elseif GG.TechCheck("tech2", ai.id) == true then
			return "egeothermal"
		else
			return "esolar2"
		end
	elseif mc >= ms - ms*0.20 then
		if Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elifterai.id)*240 < Spring.GetGameSeconds() then
			return "elifterai"
		else
			return "eorb"
		end
	elseif GG.TechCheck("tech1", ai.id) == false and Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.etech1.id) == 0 then
		return "etech1"
		
	elseif es < Spring.GetGameSeconds()*0.5 then
		return "estorage"
	else
		if Spring.GetGameSeconds() <= 90 then 
			local r = math.random(0,1)
			if mc <= 10 or mi*2 <= me then
				return "emetalextractor"
			elseif r == 0 then
				return "emine"
			else
				return "eturretlightai"
			end
		
		------- Reached Tech 1
		elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then 
			if ec <= 50 then
				return "esolar2"
			else
				local r = math.random(0,2)
				local aar = math.random(0,10)
				if aar > 0 then
					if r == 0 then
						return "emine"
					elseif r == 1 then
						return "eradar2"
					elseif r == 2 then
						return "eturretlightai"
					end
				else
					return "elaserbattery"
				end
			end
		
		------- Reached Tech 2 MK 2
		elseif GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == false then 
			if ec <= 50 then
				return "egeothermal"
			else
				local r2 = math.random(0,20)
				local aar = math.random(0,10)
				if r2 > 0 and aar > 0 then
					local r = math.random(0,4)
					if r == 0 then
						return "emine"
					elseif r == 1 then
						return "eradar2"
					elseif r == 2 then
						return "eturretlightai"
					elseif r == 3 then
						return "eturretheavyai"
					elseif r == 4 then
						return "ejammerai"
					end
				elseif r2 == 0 then
					local r = math.random(0,1)
					if r == 0 then
						return "eshieldgen"
					else
						return "ekmar"
					end
				else
					return "elaserbattery"
				end
			end
			
		------- Reached Tech 3 MK 3
		elseif GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true and Spring.GetGameSeconds() <= 1500 then 
			if ec <= 50 then
				return "efusion2"
			else
				local r2 = math.random(0,15)
				local aar = math.random(0,10)
				if r2 > 0 and aar > 0 then
					local r = math.random(0,4)
					if r == 0 then
						return "emine"
					elseif r == 1 then
						return "eradar2"
					elseif r == 2 then
						return "eturretlightai_up3"
					elseif r == 3 then
						return "eturretheavyai_up3"
					elseif r == 4 then
						return "ejammerai"
					end
				elseif r2 == 0 then
					local r = math.random(0,3)
					if r == 0 then
						return "eshieldgen"	
					elseif r == 1 then
						return "eartyturret_up3"
					elseif r == 2 then
						return "esiloai"
					elseif r == 3 then
						return "ekmar"
					end
				else
					return "elaserbattery"
				end
			end
		
		------- Reached MK 4
		elseif GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true and Spring.GetGameSeconds() > 1500 then
			if ec <= 50 then
				return "efusion2"
			else
				local r2 = math.random(0,5)
				local aar = math.random(0,10)
				if r2 > 0 and aar > 0 then
					local r = math.random(0,4)
					if r == 0 then
						return "emine"
					elseif r == 1 then
						return "eradar2"
					elseif r == 2 then
						return "eturretlightai_up3"
					elseif r == 3 then
						return "eturretheavyai_up3"
					elseif r == 4 then
						return "ejammerai"
					end
				elseif r2 == 0 then
					local r = math.random(0,3)
					if r == 0 then
						return "eshieldgen"	
					elseif r == 1 then
						return "eartyturret_up3"
					elseif r == 2 then
						return "esiloai"
					elseif r == 3 then
						return "ekmar"
					end
				else
					return "elaserbattery"
				end
			end
		end
	end
end

	
------------------------------------------------------------------------------------------------------------NEW STUFF

local UDC = Spring.GetTeamUnitDefCount
local UDN = UnitDefNames
----------------------------------------------------------------------

local unitoptions = {}
local skip = {action = "nexttask"}
local assistaround = { action = "fightrelative", position = {x = 0, y = 0, z = 0} }
local patrolaround = { action = "patrolrelative", position = {x = 1, y = 0, z = 1} }
local ezMorph = {action = "ezmorph"}

--------------------------------------------------------------------------------------------
--------------------------------------- Main Functions -------------------------------------
--------------------------------------------------------------------------------------------

---- UNIT COUNTS ---

function GetFacs(tqb,ai,unit)
	local list = {
	UDN.eairplant.id, UDN.eairplant_up1.id, UDN.eairplant_up2.id, UDN.eairplant_up3.id, 
	UDN.eminifac.id, UDN.eminifac_up1.id, UDN.eminifac_up2.id, UDN.eminifac_up3.id, 
	UDN.eamphibfac.id, UDN.eamphibfac_up1.id, UDN.eamphibfac_up2.id, UDN.eamphibfac_up3.id, 
	UDN.ehbotfac.id, UDN.ehbotfac_up1.id, UDN.ehbotfac_up2.id, UDN.ehbotfac_up3.id, 
	UDN.ebasefactory.id, UDN.ebasefactory_up1.id, UDN.ebasefactory_up2.id, UDN.ebasefactory_up3.id, 
	}
	local units = Spring.GetTeamUnitsByDefs(ai.id, list)
	return #units
end

function GetPlannedFacs(tqb, ai, unit)
	local list = {
	UDN.eairplant.id, UDN.eairplant_up1.id, UDN.eairplant_up2.id, UDN.eairplant_up3.id, 
	UDN.eminifac.id, UDN.eminifac_up1.id, UDN.eminifac_up2.id, UDN.eminifac_up3.id, 
	UDN.eamphibfac.id, UDN.eamphibfac_up1.id, UDN.eamphibfac_up2.id, UDN.eamphibfac_up3.id, 
	UDN.ehbotfac.id, UDN.ehbotfac_up1.id, UDN.ehbotfac_up2.id, UDN.ehbotfac_up3.id, 
	UDN.ebasefactory.id, UDN.ebasefactory_up1.id, UDN.ebasefactory_up2.id, UDN.ebasefactory_up3.id, 
	}
	local total = 0
	for ct, unitDefID in pairs(list) do
		local planned = ai.newplacementhandler:GetExistingPlansByUnitDefID(unitDefID)
		for planID, plan in pairs(planned) do
			total = total + 1
		end
	end
	return total
end

function GetPlannedAndUnfinishedFacs(tqb,ai,unit)
	local list = {
	UDN.eairplant.id, UDN.eairplant_up1.id, UDN.eairplant_up2.id, UDN.eairplant_up3.id, 
	UDN.eminifac.id, UDN.eminifac_up1.id, UDN.eminifac_up2.id, UDN.eminifac_up3.id, 
	UDN.eamphibfac.id, UDN.eamphibfac_up1.id, UDN.eamphibfac_up2.id, UDN.eamphibfac_up3.id, 
	UDN.ehbotfac.id, UDN.ehbotfac_up1.id, UDN.ehbotfac_up2.id, UDN.ehbotfac_up3.id, 
	UDN.ebasefactory.id, UDN.ebasefactory_up1.id, UDN.ebasefactory_up2.id, UDN.ebasefactory_up3.id, 
	}
	local count = 0
	for ct, unitDefID in pairs(list) do
		count = count + UUDC(UnitDefs[unitDefID].name, ai.id)
	end
	count = count + GetPlannedFacs(tqb, ai, unit)
	return count
end

function AllFacs(tqb, ai, unit)
	return GetFacs(tqb,ai,unit) + GetPlannedFacs(tqb, ai, unit)
end


function GetType(tqb,ai,unit,list)
	local units = Spring.GetTeamUnitsByDefs(ai.id, list)
	return #units
end

function GetPlannedType(tqb, ai, unit,list)
	local total = 0
	for ct, unitDefID in pairs(list) do
		local planned = ai.newplacementhandler:GetExistingPlansByUnitDefID(unitDefID)
		for planID, plan in pairs(planned) do
			total = total + 1
		end
	end
	return total
end

function GetPlannedAndUnfinishedType(tqb,ai,unit,list)
	local count = 0
	for ct, unitDefID in pairs(list) do
		count = count + UUDC(UnitDefs[unitDefID].name, ai.id)
	end
	count = count + GetPlannedType(tqb, ai, unit,list)
	return count
end

function AllType(tqb, ai, unit, list)
	return GetType(tqb,ai,unit,list) + GetPlannedType(tqb, ai, unit, list)
end


function UUDC(unitName, teamID) -- Unfinished UnitDef Count
	local count = 0
	if UnitDefNames[unitName] then
		local tableUnits = Spring.GetTeamUnitsByDefs(teamID, UnitDefNames[unitName].id)
		for k, v in pairs(tableUnits) do
			local _,_,_,_,bp = Spring.GetUnitHealth(v)
			if bp < 1 then
				count = count + 1
			end
		end
	end
	return count
end

---- FIND BEST ---
function FindBest(unitoptions,ai)
	if unitoptions and unitoptions[1] then
		local effect = {}
		local randomization = 1
		local randomunit = {}
		for n, unitName in pairs(unitoptions) do
			local cost = UnitDefs[UnitDefNames[unitName].id].energyCost / 60 + UnitDefs[UnitDefNames[unitName].id].metalCost
			local avgkilled_cost = GG.AiHelpers.UnitInfo(ai.id, UnitDefNames[unitName].id) and GG.AiHelpers.UnitInfo(ai.id, UnitDefNames[unitName].id).avgkilled_cost or 200 --start at 200 so that costly units aren't made from the start
			effect[unitName] = math.max(math.floor((avgkilled_cost/cost)^4*10),1)
			for i = randomization, randomization + effect[unitName] do
				randomunit[i] = unitName
			end
			randomization = randomization + effect[unitName]
		end
		if randomization < 1 then
			return skip
		end
		return randomunit[math.random(1,randomization)]	
	else
		return unitoptions[math.random(1,#unitoptions)]
	end
end
---------------

---------------------------------------------------------------- BUILD FUNCTIONS

function BuildTechFacility(tqb, ai, unit)
	if not GG.TechCheck("tech1", ai.id) and Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.etech1.id) == 0 then
		return "etech1"
	else
		return skip
	end
end

function BuildFactory(tqb, ai, unit)
	local count = GetFacs(tqb,ai,unit)
	local mc, ms, mp, mi, me = Spring.GetTeamResources(ai.id, "metal")
	if count < Spring.GetGameSeconds()*0.00332 then
		if GG.TechCheck("tech2", ai.id) then 
			local unitoptions = {"eairplant", "eminifac", "eamphibfac", "ehbotfac", "ebasefactory",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eminifac", "eamphibfac", "ehbotfac", "ebasefactory",}
			return FindBest(unitoptions, ai)
		end
	else
		return skip
	end
end

---Air
function BuildAirUP0(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "ekrow"
			else
				local unitoptions = {"efighter", "egunship2", "ebomber", "eairemp",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"efighter", "egunship2", "ebomber",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildAirUP1(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "ekrow_up1"
			else
				local unitoptions = {"efighter_up1", "egunship2_up1", "ebomber_up1", "eairemp_up1",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"efighter_up1", "egunship2_up1", "ebomber_up1",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildAirUP2(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "ekrow_up2"
			else
				local unitoptions = {"efighter_up2", "egunship2_up2", "ebomber_up2", "eairemp_up2",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"efighter_up2", "egunship2_up2", "ebomber_up2",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildAirUP3(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "ekrow_up3"
			else
				local unitoptions = {"efighter_up3", "egunship2_up3", "ebomber_up3", "eairemp_up3",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"efighter_up3", "egunship2_up3", "ebomber_up3",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

----AllTer

function BuildAllTerUP0(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "eallterranarchid"
			else
				local unitoptions = {"eallterrassault", "eallterrheavy", "eallterrlight", "eallterrmed", "eallterrriot", "eallterrshield",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"eallterrassault", "eallterrheavy", "eallterrlight", "eallterrmed", "eallterrriot", "eallterrshield",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"eallterrassault", "eallterrlight", "eallterrriot", "eallterrshield",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildAllTerUP1(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "eallterranarchid_up1"
			else
				local unitoptions = {"eallterrassault_up1", "eallterrheavy_up1", "eallterrlight_up1", "eallterrmed_up1", "eallterrriot_up1", "eallterrshield_up1",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"eallterrassault_up1", "eallterrheavy_up1", "eallterrlight_up1", "eallterrmed_up1", "eallterrriot_up1", "eallterrshield_up1",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"eallterrassault_up1", "eallterrlight_up1", "eallterrriot_up1", "eallterrshield_up1",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildAllTerUP2(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "eallterranarchid_up2"
			else
				local unitoptions = {"eallterrassault_up2", "eallterrheavy_up2", "eallterrlight_up2", "eallterrmed_up2", "eallterrriot_up2", "eallterrshield_up2",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"eallterrassault_up2", "eallterrheavy_up2", "eallterrlight_up2", "eallterrmed_up2", "eallterrriot_up2", "eallterrshield_up2",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"eallterrassault_up2", "eallterrlight_up2", "eallterrriot_up2", "eallterrshield_up2",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildAllTerUP3(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "eallterranarchid_up3"
			else
				local unitoptions = {"eallterrassault_up3", "eallterrheavy_up3", "eallterrlight_up3", "eallterrmed_up3", "eallterrriot_up3", "eallterrshield_up3",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"eallterrassault_up3", "eallterrheavy_up3", "eallterrlight_up3", "eallterrmed_up3", "eallterrriot_up3", "eallterrshield_up3",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"eallterrassault_up3", "eallterrlight_up3", "eallterrriot_up3", "eallterrshield_up3",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

----Amphib

function BuildAmphibUP0(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "eamphibleveler"
			else
				local unitoptions = {"eamphibarty", "eamphibbuggy", "eamphibmedtank", "eamphibneedle", "eamphibrock",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"eamphibarty", "eamphibbuggy", "eamphibmedtank", "eamphibneedle", "eamphibrock",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"eamphibarty", "eamphibbuggy", "eamphibneedle",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildAmphibUP1(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "eamphibleveler_up1"
			else
				local unitoptions = {"eamphibarty_up1", "eamphibbuggy_up1", "eamphibmedtank_up1", "eamphibneedle_up1", "eamphibrock_up1",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"eamphibarty_up1", "eamphibbuggy_up1", "eamphibmedtank_up1", "eamphibneedle_up1", "eamphibrock_up1",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"eamphibarty_up1", "eamphibbuggy_up1", "eamphibneedle_up1",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildAmphibUP2(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "eamphibleveler_up2"
			else
				local unitoptions = {"eamphibarty_up2", "eamphibbuggy_up2", "eamphibmedtank_up2", "eamphibneedle_up2", "eamphibrock_up2",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"eamphibarty_up2", "eamphibbuggy_up2", "eamphibmedtank_up2", "eamphibneedle_up2", "eamphibrock_up2",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"eamphibarty_up2", "eamphibbuggy_up2", "eamphibneedle_up2",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildAmphibUP3(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "eamphibleveler_up3"
			else
				local unitoptions = {"eamphibarty_up3", "eamphibbuggy_up3", "eamphibmedtank_up3", "eamphibneedle_up3", "eamphibrock_up3",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"eamphibarty_up3", "eamphibbuggy_up3", "eamphibmedtank_up3", "eamphibneedle_up3", "eamphibrock_up3",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"eamphibarty_up3", "eamphibbuggy_up3", "eamphibneedle_up3",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

----Hbot

function BuildHbotUP0(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "ehbotkarganneth"
			else
				local unitoptions = {"ehbotpeewee", "ehbotrocko", "ehbotsniper", "ehbotthud",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"ehbotpeewee", "ehbotrocko", "ehbotsniper", "ehbotthud",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"ehbotpeewee", "ehbotthud",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildHbotUP1(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "ehbotkarganneth_up1"
			else
				local unitoptions = {"ehbotpeewee_up1", "ehbotrocko_up1", "ehbotsniper_up1", "ehbotthud_up1",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"ehbotpeewee_up1", "ehbotrocko_up1", "ehbotsniper_up1", "ehbotthud_up1",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"ehbotpeewee_up1", "ehbotthud_up1",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildHbotUP2(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "ehbotkarganneth_up2"
			else
				local unitoptions = {"ehbotpeewee_up2", "ehbotrocko_up2", "ehbotsniper_up2", "ehbotthud_up2",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"ehbotpeewee_up2", "ehbotrocko_up2", "ehbotsniper_up2", "ehbotthud_up2",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"ehbotpeewee_up2", "ehbotthud_up2",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildHbotUP3(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "ehbotkarganneth_up3"
			else
				local unitoptions = {"ehbotpeewee_up3", "ehbotrocko_up3", "ehbotsniper_up3", "ehbotthud_up3",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"ehbotpeewee_up3", "ehbotrocko_up3", "ehbotsniper_up3", "ehbotthud_up3",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"ehbotpeewee_up3", "ehbotthud_up3",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

----Hover

function BuildHoverUP0(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "elacerator"
			else
				local unitoptions = {"eartytank", "eheavytank3", "elighttank3", "emissiletank", "eriottank2",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"eartytank", "eheavytank3", "elighttank3", "emissiletank", "eriottank2",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"eartytank", "elighttank3", "eriottank2",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildHoverUP1(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "elacerator_up1"
			else
				local unitoptions = {"eartytank_up1", "eheavytank3_up1", "elighttank3_up1", "emissiletank_up1", "eriottank2_up1",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"eartytank_up1", "eheavytank3_up1", "elighttank3_up1", "emissiletank_up1", "eriottank2_up1",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"eartytank_up1", "elighttank3_up1", "eriottank2_up1",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildHoverUP2(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "elacerator_up2"
			else
				local unitoptions = {"eartytank_up2", "eheavytank3_up2", "elighttank3_up2", "emissiletank_up2", "eriottank2_up2",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"eartytank_up2", "eheavytank3_up2", "elighttank3_up2", "emissiletank_up2", "eriottank2_up2",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"eartytank_up2", "elighttank3_up2", "eriottank2_up2",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildHoverUP3(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "elacerator_up3"
			else
				local unitoptions = {"eartytank_up3", "eheavytank3_up3", "elighttank3_up3", "emissiletank_up3", "eriottank2_up3",}
				return FindBest(unitoptions, ai)
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"eartytank_up3", "eheavytank3_up3", "elighttank3_up3", "emissiletank_up3", "eriottank2_up3",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech1", ai.id) then
		local unitoptions = {"eartytank_up3", "elighttank3_up3", "eriottank2_up3",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

---------------------------------------------------------------- QUEUES
---Air
local AirFactoryQueueUP0 = {
	ezMorph,
	BuildAirUP0,
}

local AirFactoryQueueUP1 = {
	ezMorph,
	BuildAirUP1,
}

local AirFactoryQueueUP2 = {
	ezMorph,
	BuildAirUP2,
}

local AirFactoryQueueUP3 = {
	ezMorph,
	BuildAirUP3,
}

---AllTer
local AllTerFactoryQueueUP0 = {
	ezMorph,
	BuildAllTerUP0,
}

local AllTerFactoryQueueUP1 = {
	ezMorph,
	BuildAllTerUP1,
}

local AllTerFactoryQueueUP2 = {
	ezMorph,
	BuildAllTerUP2,
}

local AllTerFactoryQueueUP3 = {
	ezMorph,
	BuildAllTerUP3,
}

---Amphib
local AmphibFactoryQueueUP0 = {
	ezMorph,
	BuildAmphibUP0,
}

local AmphibFactoryQueueUP1 = {
	ezMorph,
	BuildAmphibUP1,
}

local AmphibFactoryQueueUP2 = {
	ezMorph,
	BuildAmphibUP2,
}

local AmphibFactoryQueueUP3 = {
	ezMorph,
	BuildAmphibUP3,
}

---Hbot
local HbotFactoryQueueUP0 = {
	ezMorph,
	BuildHbotUP0,
}

local HbotFactoryQueueUP1 = {
	ezMorph,
	BuildHbotUP1,
}

local HbotFactoryQueueUP2 = {
	ezMorph,
	BuildHbotUP2,
}

local HbotFactoryQueueUP3 = {
	ezMorph,
	BuildHbotUP3,
}

---Hover
local HoverFactoryQueueUP0 = {
	ezMorph,
	BuildHoverUP0,
}

local HoverFactoryQueueUP1 = {
	ezMorph,
	BuildHoverUP1,
}

local HoverFactoryQueueUP2 = {
	ezMorph,
	BuildHoverUP2,
}

local HoverFactoryQueueUP3 = {
	ezMorph,
	BuildHoverUP3,
}

local overseerlistfirst = {
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"elifterai",
	"elifterai",
	"elifterai",
	"elifterai",
	BuildTechFacility,
	BuildFactory,
	"estorage",
	"estorage",
	"elifterai",
	"elifterai",
	"eturretlightai",
	"eturretlightai",
	"eturretlightai",
}
	
local overseerorders = {
	--RandomOverseer,
	--RandomOverseer,
	--RandomOverseer,
	--RandomOverseer,
	BuildTechFacility,
	"elifterai",
	"eorb",
	"elifterai",
	"eorb",
	"escoutdrone",
	"escoutdrone",
	"elifterai",
	"eorb",
	"escoutdrone",
	"escoutdrone",
	"elifterai",
	"eorb",
	"ebox",
}

local lifterlist = {
	"estorage",
	BuildFactory,
	RandomLift,
	BuildMex,
	RandomLift,
	BuildMex,
	RandomLift,
	BuildMex,
	RandomLift,
	BuildMex,
	RandomLift,
	BuildMex,
	"elifterai",
	"eorb",
	"estorage",
	"escoutdrone",
}

local lifterareamex = {
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
}
-----------------------------------------------------
--local factory = {
--}

--local airplant = {
--}

--local amphibfactory = {
--}

--local allterrfactory = {
--

--local orbs = {
	--{ action = "moverelative", position = {x = math.random(-200, 200), y = math.random(-200, 200), z = math.random(-200, 200)} },
	--{ action = "moverelative", position = {x = math.random(-200, 200), y = math.random(-200, 200), z = math.random(-200, 200)} },
	--{ action = "moverelative", position = {x = math.random(-200, 200), y = math.random(-200, 200), z = math.random(-200, 200)} },
	--{ action = "moverelative", position = {x = math.random(-200, 200), y = math.random(-200, 200), z = math.random(-200, 200)} },
--}


local function overseerqueue()
	if ai.engineerfirst == true then
		return overseerorders
	else
		ai.engineerfirst = true
		return overseerlistfirst
	end
end

local function lifterqueue()
	if liftersqueued > 2 then
		liftersqueued = liftersqueued - 0.10
		return lifterlist
	else
		liftersqueued = liftersqueued + 1
		return lifterareamex
	end
end

taskqueues = {
    --builders
	ecommanderbattleai = overseerqueue,
    elifterai = lifterqueue,
	eairplant = AirFactoryQueueUP0, 
	eairplant_up1 = AirFactoryQueueUP1, 
	eairplant_up2 = AirFactoryQueueUP2, 
	eairplant_up3 = AirFactoryQueueUP3, 
	eminifac = AllTerFactoryQueueUP0, 
	eminifac_up1 = AllTerFactoryQueueUP1, 
	eminifac_up2 = AllTerFactoryQueueUP2, 
	eminifac_up3 = AllTerFactoryQueueUP3, 
	eamphibfac = AmphibFactoryQueueUP0, 
	eamphibfac_up1 = AmphibFactoryQueueUP1, 
	eamphibfac_up2 = AmphibFactoryQueueUP2, 
	eamphibfac_up3 = AmphibFactoryQueueUP3, 
	ehbotfac = HbotFactoryQueueUP0, 
	ehbotfac_up1 = HbotFactoryQueueUP1, 
	ehbotfac_up2 = HbotFactoryQueueUP2, 
	ehbotfac_up3 = HbotFactoryQueueUP3, 
	ebasefactory = HoverFactoryQueueUP0, 
	ebasefactory_up1 = HoverFactoryQueueUP1, 
	ebasefactory_up2 = HoverFactoryQueueUP2, 
	ebasefactory_up3 = HoverFactoryQueueUP3, 
}
----------------------------------------------------------