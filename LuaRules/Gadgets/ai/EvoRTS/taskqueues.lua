--[[
Task Queues!
]]--

math.randomseed( os.time() )
math.random(); math.random(); math.random()

--------------------------------------------- Functions for AI
local aiDifficulty = Spring.GetModOptions().aidifficulty
local aiUnits = Spring.GetModOptions().aiunits
local aiNukes = Spring.GetModOptions().ainukes
local aiDebug = Spring.GetModOptions().aidebug
spGetTeamUnitsSorted = Spring.GetTeamUnitsSorted
spGetUnitDefID = Spring.GetUnitDefID
spGetTeamResources = Spring.GetTeamResources
spGetTeamUnitDefCount = Spring.GetTeamUnitDefCount
--Spring.GetGameSeconds() -- checking gametime

if aiDebug == nil then
	aiDebug = "enabled"
end

if aiUnits == nil then
	aiUnits = "enabled"
end

if aiUnits == nil then
	aiUnits = "enabled"
end

if aiNukes == nil then
	aiNukes = "enabled"
end

if aiDifficulty == nil then
	aiDifficulty = "easy"
end

local Tech1 = "etech1"
local Tech2 = "etech2"
local Tech3 = "etech3"
---------------------------------------------------------------- LIFTER QUEUES

 function RandomLift()
	--Locals
	local mc, ms = Spring.GetTeamResources(ai.id, "metal")
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
	if mc >= 490 then
		r = math.random(0,5)
		if r >= 1 then
			return "elifterai"
		else
			return "eunitfactoryai"
		end
	elseif mc <= 10 then
		return "emetalextractor"
	elseif es < Spring.GetGameSeconds()*0.5 then
		return "estorage"
	else
		if Spring.GetGameSeconds() <= 300 then 
			if ec <= 50 then
				return "esolar2"
			else
				return "emine"
			end
		
		------- Reached Tech 1
		elseif Spring.GetGameSeconds() > 300 and Spring.GetGameSeconds() <= 600 then 
			if ec <= 50 then
				return "esolar2"
			else
				local r = math.random(0,4)
				if r == 0 then
					return "emine"
				elseif r == 1 then
					return "eradar2"
				elseif r == 2 then
					return "eturretlightai"
				elseif r == 3 then
					return "eorbai"
				elseif r == 4 then
					return "ebox"
				end
			end
		
		------- Reached Tech 2 MK 2
		elseif Spring.GetGameSeconds() > 600 and Spring.GetGameSeconds() <= 1000 then 
			if ec <= 50 then
				return "efusion2"
			else
				local r = math.random(0,8)
				if r == 0 then
					return "emine"
				elseif r == 1 then
					return "eradar2"
				elseif r == 2 then
					return "eturretlightai"
				elseif r == 3 then
					return "eorbai"
				elseif r == 4 then
					return "ebox"
				elseif r == 5 then
					return "eturretheavyai"
				elseif r == 6 then
					return "ejammer2"
				elseif r == 7 then
					return "ekmar"
				elseif r == 8 then
					return "eshieldgen"	
				end
			end
			
		------- Reached Tech 3 MK 3
		elseif Spring.GetGameSeconds() > 1000 and Spring.GetGameSeconds() <= 1300 then 
			if ec <= 50 then
				return "efusion2"
			else
				local r = math.random(0,10)
				if r == 0 then
					return "emine"
				elseif r == 1 then
					return "eradar2"
				elseif r == 2 then
					return "eturretlightai"
				elseif r == 3 then
					return "eorbai"
				elseif r == 4 then
					return "ebox"
				elseif r == 5 then
					return "eturretheavyai"
				elseif r == 6 then
					return "ejammer2"
				elseif r == 7 then
					return "ekmar"
				elseif r == 8 then
					return "eshieldgen"	
				elseif r == 9 then
					return "elobberai"
				elseif r == 10 then
					return "esiloai"
				end
			end
		
		------- Reached MK 4
		elseif Spring.GetGameSeconds() > 1300 then
			if ec <= 50 then
				return "efusion2"
			else
				local r = math.random(0,10)
				if r == 0 then
					return "emine"
				elseif r == 1 then
					return "eradar2"
				elseif r == 2 then
					return "eturretlightai_up3"
				elseif r == 3 then
					return "eorbai"
				elseif r == 4 then
					return "ebox"
				elseif r == 5 then
					return "eturretheavyai_up3"
				elseif r == 6 then
					return "ejammer2"
				elseif r == 7 then
					return "ekmar"
				elseif r == 8 then
					return "eshieldgen"	
				elseif r == 9 then
					return "elobberai"
				elseif r == 10 then
					return "esiloai"
				end
			end
	
		end
	end
end

function RandomOverseer()
	--Locals
	local mc, ms = Spring.GetTeamResources(ai.id, "metal")
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
	if mc >= 490 then
		r = math.random(0,5)
		if r >= 1 then
			return "elifterai"
		else
			return "eunitfactoryai"
		end
	elseif es < Spring.GetGameSeconds()*0.5 then
		return "estorage"
	else
		if Spring.GetGameSeconds() <= 200 then 
			elseif mc <= 10 then
				return "emetalextractor"
			if ec <= 50 then
				return "esolar2"
			else
				return "emine"
			end
		
		------- Reached Tech 1
		elseif Spring.GetGameSeconds() > 200 and Spring.GetGameSeconds() <= 500 then 
			if ec <= 50 then
				return "esolar2"
			else
				local r = math.random(0,4)
				if r == 0 then
					return "emine"
				elseif r == 1 then
					return "eradar2"
				elseif r == 2 then
					return "eturretlightai"
				elseif r == 3 then
					return "eorbai"
				elseif r == 4 then
					return "ebox"
				end
			end
		
		------- Reached Tech 2 MK 2
		elseif Spring.GetGameSeconds() > 500 and Spring.GetGameSeconds() <= 1000 then 
			if ec <= 50 then
				return "efusion2"
			else
				local r = math.random(0,8)
				if r == 0 then
					return "emine"
				elseif r == 1 then
					return "eradar2"
				elseif r == 2 then
					return "eturretlightai"
				elseif r == 3 then
					return "eorbai"
				elseif r == 4 then
					return "ebox"
				elseif r == 5 then
					return "eturretheavyai"
				elseif r == 6 then
					return "ejammer2"
				elseif r == 7 then
					return "ekmar"
				elseif r == 8 then
					return "eshieldgen"	
				end
			end
			
		------- Reached Tech 3 MK 3
		elseif Spring.GetGameSeconds() > 1000 and Spring.GetGameSeconds() <= 1300 then 
			if ec <= 50 then
				return "efusion2"
			else
				local r = math.random(0,10)
				if r == 0 then
					return "emine"
				elseif r == 1 then
					return "eradar2"
				elseif r == 2 then
					return "eturretlightai"
				elseif r == 3 then
					return "eorbai"
				elseif r == 4 then
					return "ebox"
				elseif r == 5 then
					return "eturretheavyai"
				elseif r == 6 then
					return "ejammer2"
				elseif r == 7 then
					return "ekmar"
				elseif r == 8 then
					return "eshieldgen"	
				elseif r == 9 then
					return "elobberai"
				elseif r == 10 then
					return "esiloai"
				end
			end
		
		------- Reached MK 4
		elseif Spring.GetGameSeconds() > 1300 then
			if ec <= 50 then
				return "efusion2"
			else
				local r = math.random(0,10)
				if r == 0 then
					return "emine"
				elseif r == 1 then
					return "eradar2"
				elseif r == 2 then
					return "eturretlightai_up3"
				elseif r == 3 then
					return "eorbai"
				elseif r == 4 then
					return "ebox"
				elseif r == 5 then
					return "eturretheavyai_up3"
				elseif r == 6 then
					return "ejammer2"
				elseif r == 7 then
					return "ekmar"
				elseif r == 8 then
					return "eshieldgen"	
				elseif r == 9 then
					return "elobberai"
				elseif r == 10 then
					return "esiloai"
				end
			end
	
		end
	end
end

function RandomUnit()
	--Locals
	local mc, ms = Spring.GetTeamResources(ai.id, "metal")
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

	if mc >= 490 then
		r = math.random(0,5)
		if r >= 1 then
			return "elifterai"
		else
			return "eunitfactoryai"
		end
	else
		if su <= sm-20 then
			if Spring.GetGameSeconds() <= 300 then ------- Tech 0 - Very Early Game
			local r = math.random(0,9)
				if r == 0 then
					return "eallterrlight"
				elseif r == 1 then
					return "eallterrassault"
				elseif r == 2 then
					return "elighttank3"
				elseif r == 3 then
					return "eartytank"
				elseif r == 4 then
					return "efighter"
				elseif r == 5 then
					return "escout"
				elseif r == 6 then
					return "eamphibarty"
				elseif r == 7 then
					return "eamphibriot"
				elseif r == 8 then
					return "eamphibbuggy"
				elseif r == 9 then
					return "ehbotpeewee"
				end
			
			elseif Spring.GetGameSeconds() > 300 and Spring.GetGameSeconds() <= 600 then ------- Reached Tech 1
			
			local r = math.random(0,15)
				if r == 0 then
					return "eallterrlight"
				elseif r == 1 then
					return "eallterrassault"
				elseif r == 2 then
					return "elighttank3"
				elseif r == 3 then
					return "eartytank"
				elseif r == 4 then
					return "efighter"
				elseif r == 5 then
					return "escout"
				elseif r == 6 then
					return "eamphibarty"
				elseif r == 7 then
					return "eamphibriot"
				elseif r == 8 then
					return "eamphibbuggy"
				elseif r == 9 then
					return "ehbotpeewee"
				elseif r == 10 then
					return "ebomber"
				elseif r == 11 then
					return "eriottank2"
				elseif r == 12 then
					return "eamphibneedle"
				elseif r == 13 then
					return "eallterrshield"
				elseif r == 14 then
					return "eallterrriot"
				elseif r == 15 then
					return "ehbotthud"
				end
			
			elseif Spring.GetGameSeconds() > 600 and Spring.GetGameSeconds() <= 1000 then ------- Reached Tech 2 MK 2

			local r = math.random(0,8)
				if r == 0 then
					return "eheavytank3_up1"
				elseif r == 1 then
					return "ehbotrocko_up1"
				elseif r == 2 then
					return "eallterrmed_up1"
				elseif r == 3 then
					return "eallterrheavy_up1"
				elseif r == 4 then
					return "egunship2_up1"
				elseif r == 5 then
					return "escout_up1"
				elseif r == 6 then
					return "eamphibrock_up1"
				elseif r == 7 then
					return "emissiletank_up1"
				elseif r == 8 then
					return "eamphibmedtank_up1"
				end	

			elseif Spring.GetGameSeconds() > 1000 and Spring.GetGameSeconds() <= 1300 then ------- Reached Tech 3 MK 3
				
			local r = math.random(0,11)
				if r == 0 then
					return "eheavytank3_up2"
				elseif r == 1 then
					return "ehbotrocko_up2"
				elseif r == 2 then
					return "eallterrmed_up2"
				elseif r == 3 then
					return "eallterrheavy_up2"
				elseif r == 4 then
					return "egunship2_up2"
				elseif r == 5 then
					return "escout_up2"
				elseif r == 6 then
					return "eamphibrock_up2"
				elseif r == 7 then
					return "emissiletank_up2"
				elseif r == 8 then
					return "eamphibmedtank_up2"
				elseif r == 9 then
					return "eamphibleveler_up2"
				elseif r == 10 then
					return "eallterranarchid_up2"
				elseif r == 11 then
					return "elacerator_up2"
				end	

			elseif Spring.GetGameSeconds() > 1300 then ------- Reached MK 4
				
			local r = math.random(0,11)
				if r == 0 then
					return "eheavytank3_up3"
				elseif r == 1 then
					return "ehbotrocko_up3"
				elseif r == 2 then
					return "eallterrmed_up3"
				elseif r == 3 then
					return "eallterrheavy_up3"
				elseif r == 4 then
					return "egunship2_up3"
				elseif r == 5 then
					return "escout_up3"
				elseif r == 6 then
					return "eamphibrock_up3"
				elseif r == 7 then
					return "emissiletank_up3"
				elseif r == 8 then
					return "eamphibmedtank_up3"
				elseif r == 9 then
					return "eamphibleveler_up3"
				elseif r == 10 then
					return "eallterranarchid_up3"
				elseif r == 11 then
					return "elacerator_up3"
				end	
			end
		else
			return "eorbai"
		end
	end
end
---------------------------------------------------------------- QUEUES


local idlelist = {
	{ action = "wait", frames = 3000},
}

	local overseerlistfirst = {
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"elifterai",
	"eunitfactoryai",
	}


local overseerorders = {
	RandomOverseer,
}

local lifterlist = {
	RandomLift,
}

local unitsqueue = {
	RandomUnit,
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

taskqueues = {
    --builders
	ecommanderbattleai = overseerqueue,
    elifterai = lifterlist,
	eunitfactoryai = unitsqueue,
	
}
----------------------------------------------------------