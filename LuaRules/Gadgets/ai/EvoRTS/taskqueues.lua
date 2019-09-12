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
local MaximumSupply = tonumber(Spring.GetModOptions().supplycap)
if MaximumSupply == nil then
	MaximumSupply = 400
end
--Spring.GetGameSeconds() -- checking gametime

local UDC = Spring.GetTeamUnitDefCount
local UDN = UnitDefNames
----------------------------------------------------------------------

local unitoptions = {}
local options = {}
local skip = {action = "nexttask"}
local assistaround = { action = "fightrelative", position = {x = 0, y = 0, z = 0} }
local patrolaround = { action = "patrolrelative", position = {x = 1, y = 0, z = 1} }
local ezMorph = {action = "ezmorph"}

--------------------------------------------------------------------------------------------
--------------------------------------- Main Functions -------------------------------------
--------------------------------------------------------------------------------------------

---- UNIT COUNTS ---

function GetArtileryUnits(tqb,ai,unit)
	local list = {
	UDN.eartytank.id, UDN.eartytank_up1.id, UDN.eartytank_up2.id, UDN.eartytank_up3.id, 
	UDN.eartytank_saturation.id, UDN.eartytank_saturation_up1.id, UDN.eartytank_saturation_up2.id, UDN.eartytank_saturation_up3.id, 
	UDN.eamphibarty.id, UDN.eamphibarty_up1.id, UDN.eamphibarty_up2.id, UDN.eamphibarty_up3.id, 
	UDN.eallterrassault.id, UDN.eallterrassault_up1.id, UDN.eallterrassault_up2.id, UDN.eallterrassault_up3.id, 
	}
	local units = Spring.GetTeamUnitsByDefs(ai.id, list)
	return #units
end

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

function MoveToRandomStartBoxLocation(tqb, ai, unit)
	local _,_,_,_,_,MyAllyTeam = Spring.GetTeamInfo(ai.id)
	local startxmin, startzmin, startxmax, startzmax = spGetAllyTeamStartBox(MyAllyTeam)
	local mx = Game.mapSizeX
	local mz = Game.mapSizeZ
	if startxmax == mx and startzmax == mz and startxmin == 0 and startzmin == 0 then
		return skip
	else
		px = math.random(startxmin, startxmax)
		pz = math.random(startzmin, startzmax)
		py = Spring.GetGroundHeight(px, pz)
	end
	if py <= 0 then
		return skip
	end
	return {action = "move", position = {x = px, y = py, z = pz}}
end

---- FIND BEST ---
function FindBest(unitoptions,ai)
	if unitoptions and unitoptions[1] then
		local effect = {}
		local randomization = 1
		local randomunit = {}
		for n, unitName in pairs(unitoptions) do
			local cost = UnitDefs[UnitDefNames[unitName].id].energyCost + UnitDefs[UnitDefNames[unitName].id].metalCost
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
--------------------------------------STRUCTURES

function BuildTechFacility(tqb, ai, unit)
	--Spring.Echo([[Build Tech Facility]])
	local GetLifters = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.ehbotengineer.id) + 1
	local rLifter = math.random(0, GetLifters*2)
	if GetLifters < 4 or rLifter == 0 then
		return "ehbotengineer"
	elseif not GG.TechCheck("tech1", ai.id) and Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.etech1.id) == 0 then
		return "etech1"
	else
		return skip
	end
end

function BuildFactory(tqb, ai, unit)
	--Spring.Echo([[Build Factory]])
	local count = GetFacs(tqb,ai,unit)
	local mc, ms, mp, mi, me = Spring.GetTeamResources(ai.id, "metal")
	local GetLifters = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.ehbotengineer.id) + 1
	local rLifter = math.random(0, GetLifters*2)
	if GetLifters < 4 or rLifter == 0 then
		return "ehbotengineer"
	elseif count < Spring.GetGameSeconds()*0.00332 then
		if count > 0 and Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eairplant.id) + Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eairplant_up1.id) + Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eairplant_up2.id) + Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eairplant_up3.id) < 1 then
			return "eairplant"
		elseif GG.TechCheck("tech2", ai.id) then 
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

function BuildMex(tqb, ai, unit)
	--Spring.Echo([[Build Mex]])
	local GetLifters = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.ehbotengineer.id) + 1
	local rLifter = math.random(0, GetLifters*2)
	if GetLifters < 4 or rLifter == 0 then
		return "ehbotengineer"
	else
		return "emetalextractor"
	end
end

function BuildEnergy(tqb, ai, unit)
	--Spring.Echo([[Build Energy]])
	local ec, es, ep, ei, ee = Spring.GetTeamResources(ai.id, "energy")
	local GetLifters = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.ehbotengineer.id) + 1
	local rLifter = math.random(0, GetLifters*2)
	if GetLifters < 4 or rLifter == 0 then
		return "ehbotengineer"
	else
		local r = math.random(0,20)
		if ei <= ee or r == 0 then
			if GG.TechCheck("tech3", ai.id) then
				return "efusion2"
			elseif GG.TechCheck("tech2", ai.id) then
				return "egeothermal"
			elseif GG.TechCheck("tech1", ai.id) then
				return "esolar2"
			else
				return skip
			end
		else
			return skip
		end
	end
end

function BuildSupply(tqb, ai, unit)
	--Spring.Echo([[Build Supply]])
	local mc, ms, mp, mi, me = Spring.GetTeamResources(ai.id, "metal")
	local ec, es, ep, ei, ee = Spring.GetTeamResources(ai.id, "energy")
	local su = Spring.GetTeamRulesParam(ai.id, "supplyUsed")
	local sm = Spring.GetTeamRulesParam(ai.id, "supplyMax")
	local GetLifters = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.ehbotengineer.id) + 1
	local rLifter = math.random(0, GetLifters*2)
	if GetLifters < 4 or rLifter == 0 then
		return "ehbotengineer"
	elseif su < sm - 20 and sm ~= MaximumSupply then
		return "estorage"
	elseif ms < Spring.GetGameSeconds() and ms < 1000 then
		return "estorage"
	else
		return skip
	end
end

function BuildTurret(tqb, ai, unit)
	--Spring.Echo([[Build Turret]])
	local GetLifters = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.ehbotengineer.id) + 1
	local rLifter = math.random(0, GetLifters*2)
	local r = math.random(0,1)
	if GetLifters < 4 or rLifter == 0 then
			return "ehbotengineer"
	elseif r == 0 then
		local LT = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elightturret2.id)
		local AAT = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elaserbattery.id)
		if GG.TechCheck("tech2", ai.id) then 
			local HT = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eheavyturret2.id)
			if AAT*5 < LT and AAT*5 < HT then
				return "elaserbattery"
			elseif HT < LT then
				return "eheavyturret2"
			else
				return "elightturret2"
			end
		elseif AAT*10 < LT and GG.TechCheck("tech1", ai.id) then
			return "elaserbattery"
		else
			return "elightturret2"
		end
	else
		return skip
	end
end
 
function BuildEngineers(tqb, ai, unit)
	--Spring.Echo([[Build Engineers]])
	local mc, ms, mp, mi, me = Spring.GetTeamResources(ai.id, "metal")
	local ec, es, ep, ei, ee = Spring.GetTeamResources(ai.id, "energy")
	local GetLifters = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.ehbotengineer.id) + 1
	local rLifter = math.random(0, GetLifters*2)
	if GetLifters < 4 or rLifter == 0 then
		return "ehbotengineer"
	else
		local GetORBs = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eorb.id) + Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eorb_up1.id) + Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eorb_up2.id) + Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eorb_up3.id) + 1
		local rORB = math.random(0, GetORBs)
		if rORB == 0 then
			return "eorb"
		else 
			return skip
		end
	end
end

function BuildSupport(tqb, ai, unit)
	--Spring.Echo([[Build Support]])
	local GetLifters = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.ehbotengineer.id) + 1
	local rLifter = math.random(0, GetLifters*2)
	if GetLifters < 4 or rLifter == 0 then
		return "ehbotengineer"
	else
		if GG.TechCheck("tech3", ai.id) then
			local r = math.random(0,20)
			if r == 0 then
				local unitoptions = {"emine", "escoutdrone", "eradar2", "ebox", "ejammer2", "eshieldgen", "ekmar", "esilo", "eartyturret",}
				return unitoptions[math.random(1,#unitoptions)]
			else
				local unitoptions = {"emine", "escoutdrone", "eradar2", "ebox", "ejammer2",}
				return unitoptions[math.random(1,#unitoptions)]
			end
		elseif GG.TechCheck("tech2", ai.id) then
			local r = math.random(0,30)
			if r == 0 then
				local unitoptions = {"emine", "escoutdrone", "eradar2", "ebox", "ejammer2", "eshieldgen", "ekmar",}
				return unitoptions[math.random(1,#unitoptions)]
			else
				local unitoptions = {"emine", "escoutdrone", "eradar2", "ebox", "ejammer2",}
				return unitoptions[math.random(1,#unitoptions)]
			end
		elseif GG.TechCheck("tech1", ai.id) then
			local unitoptions = {"emine", "escoutdrone", "eradar2", "ebox",}
			return unitoptions[math.random(1,#unitoptions)]
		else
			local unitoptions = {"emine", "escoutdrone",}
			return unitoptions[math.random(1,#unitoptions)]
		end
	end
end	

--------------------------------------------UNITS
---Air
function BuildAirUP0(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local unitoptions = {"efighter", "egunship2", "ebomber", "eairemp",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"efighter", "egunship2", "ebomber",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildAirUP1(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local unitoptions = {"efighter_up1", "egunship2_up1", "ebomber_up1", "eairemp_up1",}
		return FindBest(unitoptions, ai)
	elseif GG.TechCheck("tech2", ai.id) then
		local unitoptions = {"efighter_up1", "egunship2_up1", "ebomber_up1",}
		return FindBest(unitoptions, ai)
	else
		return skip
	end
end

function BuildAirUP2(tqb, ai, unit)
	if GG.TechCheck("tech3", ai.id) then
		local unitoptions = {"efighter_up2", "egunship2_up2", "ebomber_up2", "eairemp_up2",}
		return FindBest(unitoptions, ai)
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
	local ArtyCount = GetArtileryUnits(tqb,ai,unit)
	
	if GG.TechCheck("tech2", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eallterrassault", "eallterrheavy", "eallterrlight", "eallterrmed", "eallterrriot", "eallterrshield",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eallterrheavy", "eallterrlight", "eallterrmed", "eallterrriot", "eallterrshield",}
			return FindBest(unitoptions, ai)
		end
	elseif GG.TechCheck("tech1", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eallterrassault", "eallterrlight", "eallterrriot", "eallterrshield",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eallterrlight", "eallterrriot", "eallterrshield",}
			return FindBest(unitoptions, ai)
		end
	else
		return skip
	end
end

function BuildAllTerUP1(tqb, ai, unit)
	local ArtyCount = GetArtileryUnits(tqb,ai,unit)
	if GG.TechCheck("tech2", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eallterrassault_up1", "eallterrheavy_up1", "eallterrlight_up1", "eallterrmed_up1", "eallterrriot_up1", "eallterrshield_up1",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eallterrheavy_up1", "eallterrlight_up1", "eallterrmed_up1", "eallterrriot_up1", "eallterrshield_up1",}
			return FindBest(unitoptions, ai)
		end
	elseif GG.TechCheck("tech1", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eallterrassault_up1", "eallterrlight_up1", "eallterrriot_up1", "eallterrshield_up1",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eallterrlight_up1", "eallterrriot_up1", "eallterrshield_up1",}
			return FindBest(unitoptions, ai)
		end
	else
		return skip
	end
end

function BuildAllTerUP2(tqb, ai, unit)
	local ArtyCount = GetArtileryUnits(tqb,ai,unit)
	if GG.TechCheck("tech2", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eallterrassault_up2", "eallterrheavy_up2", "eallterrlight_up2", "eallterrmed_up2", "eallterrriot_up2", "eallterrshield_up2",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eallterrheavy_up2", "eallterrlight_up2", "eallterrmed_up2", "eallterrriot_up2", "eallterrshield_up2",}
			return FindBest(unitoptions, ai)
		end
	elseif GG.TechCheck("tech1", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eallterrassault_up2", "eallterrlight_up2", "eallterrriot_up2", "eallterrshield_up2",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eallterrlight_up2", "eallterrriot_up2", "eallterrshield_up2",}
			return FindBest(unitoptions, ai)
		end
	else
		return skip
	end
end

function BuildAllTerUP3(tqb, ai, unit)
	local ArtyCount = GetArtileryUnits(tqb,ai,unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "eallterranarchid_up3"
			else
				local rArty = math.random(0, ArtyCount + 1)
				if rArty == 0 then
					local unitoptions = {"eallterrassault_up3", "eallterrheavy_up3", "eallterrlight_up3", "eallterrmed_up3", "eallterrriot_up3", "eallterrshield_up3",}
					return FindBest(unitoptions, ai)
				else
					local unitoptions = {"eallterrheavy_up3", "eallterrlight_up3", "eallterrmed_up3", "eallterrriot_up3", "eallterrshield_up3",}
					return FindBest(unitoptions, ai)
				end
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eallterrassault_up3", "eallterrheavy_up3", "eallterrlight_up3", "eallterrmed_up3", "eallterrriot_up3", "eallterrshield_up3",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eallterrheavy_up3", "eallterrlight_up3", "eallterrmed_up3", "eallterrriot_up3", "eallterrshield_up3",}
			return FindBest(unitoptions, ai)
		end
	elseif GG.TechCheck("tech1", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eallterrassault_up3", "eallterrlight_up3", "eallterrriot_up3", "eallterrshield_up3",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eallterrlight_up3", "eallterrriot_up3", "eallterrshield_up3",}
			return FindBest(unitoptions, ai)
		end
	else
		return skip
	end
end

----Amphib

function BuildAmphibUP0(tqb, ai, unit)
	local ArtyCount = GetArtileryUnits(tqb,ai,unit)
	if GG.TechCheck("tech2", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eamphibarty", "eamphibbuggy", "eamphibmedtank", "eamphibneedle", "eamphibrock",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eamphibbuggy", "eamphibmedtank", "eamphibneedle", "eamphibrock",}
			return FindBest(unitoptions, ai)
		end
	elseif GG.TechCheck("tech1", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eamphibarty", "eamphibbuggy", "eamphibneedle",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eamphibbuggy", "eamphibneedle",}
			return FindBest(unitoptions, ai)
		end
	else
		return skip
	end
end

function BuildAmphibUP1(tqb, ai, unit)
	local ArtyCount = GetArtileryUnits(tqb,ai,unit)
	if GG.TechCheck("tech2", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eamphibarty_up1", "eamphibbuggy_up1", "eamphibmedtank_up1", "eamphibneedle_up1", "eamphibrock_up1",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eamphibbuggy_up1", "eamphibmedtank_up1", "eamphibneedle_up1", "eamphibrock_up1",}
			return FindBest(unitoptions, ai)
		end
	elseif GG.TechCheck("tech1", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eamphibarty_up1", "eamphibbuggy_up1", "eamphibneedle_up1",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eamphibbuggy_up1", "eamphibneedle_up1",}
			return FindBest(unitoptions, ai)
		end
	else
		return skip
	end
end

function BuildAmphibUP2(tqb, ai, unit)
	local ArtyCount = GetArtileryUnits(tqb,ai,unit)
	if GG.TechCheck("tech2", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eamphibarty_up2", "eamphibbuggy_up2", "eamphibmedtank_up2", "eamphibneedle_up2", "eamphibrock_up2",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eamphibbuggy_up2", "eamphibmedtank_up2", "eamphibneedle_up2", "eamphibrock_up2",}
			return FindBest(unitoptions, ai)
		end
	elseif GG.TechCheck("tech1", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eamphibarty_up2", "eamphibbuggy_up2", "eamphibneedle_up2",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eamphibbuggy_up2", "eamphibneedle_up2",}
			return FindBest(unitoptions, ai)
		end
	else
		return skip
	end
end

function BuildAmphibUP3(tqb, ai, unit)
	local ArtyCount = GetArtileryUnits(tqb,ai,unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "eamphibleveler_up3"
			else
				local rArty = math.random(0, ArtyCount + 1)
				if rArty == 0 then
					local unitoptions = {"eamphibarty_up3", "eamphibbuggy_up3", "eamphibmedtank_up3", "eamphibneedle_up3", "eamphibrock_up3",}
					return FindBest(unitoptions, ai)
				else
					local unitoptions = {"eamphibbuggy_up3", "eamphibmedtank_up3", "eamphibneedle_up3", "eamphibrock_up3",}
					return FindBest(unitoptions, ai)
				end
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eamphibarty_up3", "eamphibbuggy_up3", "eamphibmedtank_up3", "eamphibneedle_up3", "eamphibrock_up3",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eamphibbuggy_up3", "eamphibmedtank_up3", "eamphibneedle_up3", "eamphibrock_up3",}
			return FindBest(unitoptions, ai)
		end
	elseif GG.TechCheck("tech1", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eamphibarty_up3", "eamphibbuggy_up3", "eamphibneedle_up3",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eamphibbuggy_up3", "eamphibneedle_up3",}
			return FindBest(unitoptions, ai)
		end
	else
		return skip
	end
end

----Hbot

function BuildHbotUP0(tqb, ai, unit)
	if GG.TechCheck("tech2", ai.id) then
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
	if GG.TechCheck("tech2", ai.id) then
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
	if GG.TechCheck("tech2", ai.id) then
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
	local ArtyCount = GetArtileryUnits(tqb,ai,unit)
	if GG.TechCheck("tech2", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eartytank", "eheavytank3", "elighttank3", "emissiletank", "eriottank2",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eheavytank3", "elighttank3", "emissiletank", "eriottank2",}
			return FindBest(unitoptions, ai)
		end
	elseif GG.TechCheck("tech1", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eartytank", "elighttank3", "eriottank2",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"elighttank3", "eriottank2",}
			return FindBest(unitoptions, ai)
		end
	else
		return skip
	end
end

function BuildHoverUP1(tqb, ai, unit)
	local ArtyCount = GetArtileryUnits(tqb,ai,unit)
	if GG.TechCheck("tech2", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eartytank_up1", "eheavytank3_up1", "elighttank3_up1", "emissiletank_up1", "eriottank2_up1",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eheavytank3_up1", "elighttank3_up1", "emissiletank_up1", "eriottank2_up1",}
			return FindBest(unitoptions, ai)
		end
	elseif GG.TechCheck("tech1", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eartytank_up1", "elighttank3_up1", "eriottank2_up1",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"elighttank3_up1", "eriottank2_up1",}
			return FindBest(unitoptions, ai)
		end
	else
		return skip
	end
end

function BuildHoverUP2(tqb, ai, unit)
	local ArtyCount = GetArtileryUnits(tqb,ai,unit)
	if GG.TechCheck("tech2", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eartytank_up2", "eheavytank3_up2", "elighttank3_up2", "emissiletank_up2", "eriottank2_up2",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eheavytank3_up2", "elighttank3_up2", "emissiletank_up2", "eriottank2_up2",}
			return FindBest(unitoptions, ai)
		end
	elseif GG.TechCheck("tech1", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eartytank_up2", "elighttank3_up2", "eriottank2_up2",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"elighttank3_up2", "eriottank2_up2",}
			return FindBest(unitoptions, ai)
		end
	else
		return skip
	end
end

function BuildHoverUP3(tqb, ai, unit)
	local ArtyCount = GetArtileryUnits(tqb,ai,unit)
	if GG.TechCheck("tech3", ai.id) then
		local r = math.random(0,100)
			if r == 0 then
				return "elacerator_up3"
			else
				local rArty = math.random(0, ArtyCount + 1)
				if rArty == 0 then
					local unitoptions = {"eartytank_up3", "eheavytank3_up3", "elighttank3_up3", "emissiletank_up3", "eriottank2_up3",}
					return FindBest(unitoptions, ai)
				else
					local unitoptions = {"eheavytank3_up3", "elighttank3_up3", "emissiletank_up3", "eriottank2_up3",}
					return FindBest(unitoptions, ai)
				end
			end
	elseif GG.TechCheck("tech2", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eartytank_up3", "eheavytank3_up3", "elighttank3_up3", "emissiletank_up3", "eriottank2_up3",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"eheavytank3_up3", "elighttank3_up3", "emissiletank_up3", "eriottank2_up3",}
			return FindBest(unitoptions, ai)
		end
	elseif GG.TechCheck("tech1", ai.id) then
		local rArty = math.random(0, ArtyCount + 1)
		if rArty == 0 then
			local unitoptions = {"eartytank_up3", "elighttank3_up3", "eriottank2_up3",}
			return FindBest(unitoptions, ai)
		else
			local unitoptions = {"elighttank3_up3", "eriottank2_up3",}
			return FindBest(unitoptions, ai)
		end
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
	BuildEngineers,
	BuildTurret,
	BuildEngineers,
	BuildEngineers,
	BuildEngineers,
	BuildEngineers,
	BuildEngineers,
	BuildTurret,
}
	
local overseerorders = {
	BuildFactory,
	BuildTechFacility,
	BuildEnergy,
	BuildTurret,
	MoveToRandomStartBoxLocation,
}

local lifterlist = {
	BuildFactory,
	BuildMex,
	BuildTurret,
	MoveToRandomStartBoxLocation,
	BuildFactory,
	BuildEnergy,
	BuildSupply,
	BuildTurret,
	BuildEngineers,
	BuildSupport,
	BuildMex,
	BuildTurret,
	BuildEnergy,
	BuildSupply,
	BuildEngineers,
	BuildSupport,
}

local lifterareamex = {
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	"emetalextractor",
	BuildTurret,
	MoveToRandomStartBoxLocation,
}

-----------------------------------------------------

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
		liftersqueued = liftersqueued - 0.30
		return lifterlist
	else
		liftersqueued = liftersqueued + 1
		return lifterareamex
	end
end

------------------------------------------------- ZAAAAAAAAAAAAAALS
function GetZaalSpawners(tqb,ai,unit)
	local list = {
	UDN.zhatch.id, UDN.zhatch_up1.id, UDN.zhatch_up2.id
	}
	local units = Spring.GetTeamUnitsByDefs(ai.id, list)
	return #units
end

local function ZaalMorph(tqb, ai, unit)
	return ezMorph
end


local function ZaalUnitLists(tqb, ai, unit)
	local r = math.random(0,10)
	local r2 = math.random(0,3)
	local scouts = Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.zairscout.id)
	
	if scouts < r2 then
		return "zairscout"
	end
	
	if GG.TechCheck("tech3", ai.id) then
		if r <= 3 then
			return "zlightswarm"
		elseif r <= 6 then
			local options = {"zlightswarm", "zmedswarm", "zairtoairfighter", "zpyro",}
			return FindBest(options, ai)
		elseif r <= 9 then
			local options = {"zlightswarm", "zmedswarm", "zairtoairfighter", "zpyro", "zairbomber", "zskirmisher",}
			return FindBest(options, ai)
		else
			local options = {"zlightswarm", "zmedswarm", "zairtoairfighter", "zpyro","zairbomber", "zairtogroundfighter", "zarty", "zassault", "zkamikaze", "zskirmisher", "zqueen",}
			return FindBest(options, ai)
		end
	
	elseif GG.TechCheck("tech2", ai.id) then
		
		if r <= 6 then
			return "zlightswarm"
		elseif r <= 9 then
			local options = {"zlightswarm", "zmedswarm", "zairtoairfighter", "zpyro",}
			return FindBest(options, ai)
		else
			local options = {"zlightswarm", "zmedswarm", "zairtoairfighter", "zpyro", "zairbomber", "zskirmisher",}
			return FindBest(options, ai)
		end
		
	elseif GG.TechCheck("tech1", ai.id) then
		
		if r <= 9 then
			return "zlightswarm"
		else
			local options = {"zlightswarm", "zpyro", "zmedswarm",}
			return FindBest(options, ai)
		end
		
	end
end


-- local function ZaalEZMorphIfEnergyIsOK(tqb, ai, unit)
	-- local ec, es, ep, ei, ee = Spring.GetTeamResources(ai.id, "energy")
	-- if ec >= es*0.5 then
		-- return ezMorph
	-- else
		-- return skip
	-- end
-- end


local function ZaalBuild(tqb, ai, unit)
	--local SpawnerCount = GetZaalSpawners(tqb,ai,unit)
	--local r = math.random(0,SpawnerCount + 1)
	local ec, es, ep, ei, ee = Spring.GetTeamResources(ai.id, "energy")
	local su = Spring.GetTeamRulesParam(ai.id, "supplyUsed") or 0
	local sm = Spring.GetTeamRulesParam(ai.id, "supplyMax") or 0
	if ec <= es*0.5 and GG.TechCheck("tech1", ai.id) then
		return "zespire1"
	elseif su > sm - 20 and sm ~= MaximumSupply then
		return "ztiberium"
	else
		return "zhatch"
	end
end


local ZaalHive1 = {
	ZaalUnitLists,
	ZaalMorph,
}

local ZaalHive2 = {
	ZaalUnitLists,
	ZaalMorph,
}

local ZaalHive3 = {
	ZaalUnitLists,
}

local ZaalArm = {
	ZaalBuild,
}

local ZaalEspire = {
	ZaalMorph,
}
	


taskqueues = {
    --builders
	ecommanderbattleai = overseerqueue,
	ecommanderbuildai = overseerqueue,
	ecommandercloakai = overseerqueue,
	ecommanderfactoryai = overseerqueue,
	ecommanderhealerai = overseerqueue,
	ecommandershieldai = overseerqueue,
    ehbotengineer = lifterqueue,
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
	zarm = ZaalArm,
	zhatch_up2 = ZaalHive3,
	zhatch = ZaalHive1,
	zhatch_up1 = ZaalHive2,
	zespire1 = ZaalEspire,
	zespire4 = ZaalEspire,
}
----------------------------------------------------------