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
local spGetTeamUnitsSorted = Spring.GetTeamUnitsSorted
local spGetUnitDefID = Spring.GetUnitDefID
local spGetTeamResources = Spring.GetTeamResources
local spGetTeamUnitDefCount = Spring.GetTeamUnitDefCount
local spGetTeamInfo = Spring.GetTeamInfo
local spGetTeamStartPosition = Spring.GetTeamStartPosition
local spGetAllyTeamStartBox = Spring.GetAllyTeamStartBox
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


---------------------------------------------------------------- LIFTER QUEUES
 
 function MoveToStartLocation()
		
	Spring.Echo([[AI ID ]] .. ai.id .. [[ ]])
	Spring.Echo([[AI allyID ]] .. ai.allyId .. [[ ]])
	
	if spGetAllyTeamStartBox(ai.allyId) ~= 0 then
		local startxmin, startzmin, startxmax, startzmax = spGetAllyTeamStartBox(ai.allyId)
		Spring.Echo([[AI startxmin ]] .. startxmin .. [[ ]])
		Spring.Echo([[AI startzmin ]] .. startzmin .. [[ ]])
		Spring.Echo([[AI startxmax ]] .. startxmax .. [[ ]])
		Spring.Echo([[AI startzmax ]] .. startzmax .. [[ ]])
		return { action = "move", position = {x = math.random(startxmin, startxmax), y = math.random(-200, 200), z = math.random(startzmin, startzmax)} }
	else
		return { action = "wait", frames = 1}
	end
end

 
 function BuildMex()
	local mc, ms, mp, mi, me = Spring.GetTeamResources(ai.id, "metal")
	if mc <= ms*0.5 then
		return "emetalextractor"
	else
		return { action = "wait", frames = 150}
	end
end
 
 
 function RandomLift()
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
	if mc >= ms - ms*0.20 then
		local r = math.random(0,3)
		if r <= 1 then
			return "eunitfactoryai"
		elseif r == 2 then
			return "elifterai"
		else
			if GG.TechCheck("tech1", ai.id) == false and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then
				return "eorb"
			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then
				return "eorb_up1"
			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == false then
				return "eorb_up2"
			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true then
				return "eorb_up3"
			end
		end
	elseif es < Spring.GetGameSeconds()*0.5 then
		return "estorage"
	elseif su >= sm-20 and sm ~= 400 then
		return "estorage"
	
	elseif GG.TechCheck("tech1", ai.id) == false and GG.TechCheck("tech0ai", ai.id) == true then
		return "etech1ai"
	elseif GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech1ai", ai.id) == true and GG.TechCheck("tech0ai", ai.id) == false then
		return "etech2ai"
	elseif GG.TechCheck("tech3", ai.id) == false and GG.TechCheck("tech2ai", ai.id) == true and GG.TechCheck("tech0ai", ai.id) == false and GG.TechCheck("tech1ai", ai.id) == false then
		return "etech3ai"
		
	else
		if GG.TechCheck("tech1", ai.id) == false and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then 
			if ec <= 50 then
				return "esolar2"
			else
				return "emine"
			end
		
		------- Reached Tech 1
		elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then 
			if ec <= 50 then
				return "esolar2"
			else
				local r = math.random(0,2)
				if r == 0 then
					return "emine"
				elseif r == 1 then
					return "eradar2"
				elseif r == 2 then
					return "eturretlightai"
				end
			end
		
		------- Reached Tech 2 MK 2
		elseif GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == false then 
			if ec <= 50 then
				return "efusion2"
			else
				local r = math.random(0,5)
				local r2 = math.random(0,30)
				if r2 ~= 0 then
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
					elseif r == 5 then
						return "ekmar"
					end
				else
					return "eshieldgen"
				end
			end
			
		------- Reached Tech 3 MK 3
		elseif GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true and Spring.GetGameSeconds() <= 1500 then 
			if ec <= 50 then
				return "efusion2"
			else
				local r2 = math.random(0,15)
				if r2 ~= 0 then
					local r = math.random(0,5)
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
					elseif r == 5 then
						return "ekmar"
					end
				elseif r2 == 0 then
					local r = math.random(0,2)
					if r == 0 then
						return "eshieldgen"	
					elseif r == 1 then
						return "elobberai"
					elseif r == 2 then
						return "esiloai"
					end
				end
			end
		
		------- Reached MK 4
		elseif GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true and Spring.GetGameSeconds() > 1500 then
			if ec <= 50 then
				return "efusion2"
			else
				local r2 = math.random(0,5)
				if r2 ~= 0 then
					local r = math.random(0,5)
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
					elseif r == 5 then
						return "ekmar"
					end
				elseif r2 == 0 then
					local r = math.random(0,2)
					if r == 0 then
						return "eshieldgen"	
					elseif r == 1 then
						return "elobberai"
					elseif r == 2 then
						return "esiloai"
					end
				end
			end
	
		end
	end
end

function RandomOverseer()
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
	if mc >= ms - ms*0.20 then
		local r = math.random(0,3)
		if r <= 1 then
			return "eunitfactoryai"
		elseif r == 2 then
			return "elifterai"
		else
			if GG.TechCheck("tech1", ai.id) == false and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then
				return "eorb"
			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then
				return "eorb_up1"
			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == false then
				return "eorb_up2"
			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true then
				return "eorb_up3"
			end
		end
	elseif GG.TechCheck("tech1", ai.id) == false and GG.TechCheck("tech0ai", ai.id) == true and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then
		return "etech1ai"
	elseif GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech1ai", ai.id) == true and GG.TechCheck("tech0ai", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then
		return "etech2ai"
	elseif GG.TechCheck("tech3", ai.id) == false and GG.TechCheck("tech2ai", ai.id) == true and GG.TechCheck("tech0ai", ai.id) == false and GG.TechCheck("tech1ai", ai.id) == false and GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true then
		return "etech3ai"
	
	elseif es < Spring.GetGameSeconds()*0.5 then
		return "estorage"
	else
		if Spring.GetGameSeconds() <= 200 then 
			if mc <= 10 or mi*2 <= me then
				return "emetalextractor"
			elseif ec <= 50 then
				return "esolar2"
			else
				return "emine"
			end
		
		------- Reached Tech 1
		elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then 
			if ec <= 50 then
				return "esolar2"
			else
				local r = math.random(0,2)
				if r == 0 then
					return "emine"
				elseif r == 1 then
					return "eradar2"
				elseif r == 2 then
					return "eturretlightai"
				end
			end
		
		------- Reached Tech 2 MK 2
		elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == false then 
			if ec <= 50 then
				return "efusion2"
			else
				local r = math.random(0,5)
				local r2 = math.random(0,50)
				if r2 ~= 0 then
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
					elseif r == 5 then
						return "ekmar"
					end
				else
					return "eshieldgen"
				end
			end
			
		------- Reached Tech 3 MK 3
		elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true and Spring.GetGameSeconds() <= 1500 then 
			if ec <= 50 then
				return "efusion2"
			else
				local r2 = math.random(0,40)
				if r2 ~= 0 then
					local r = math.random(0,5)
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
					elseif r == 5 then
						return "ekmar"
					end
				elseif r2 == 0 then
					local r = math.random(0,2)
					if r == 0 then
						return "eshieldgen"	
					elseif r == 1 then
						return "elobberai"
					elseif r == 2 then
						return "esiloai"
					end
				end
			end
		------- Reached MK 4
		elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true and Spring.GetGameSeconds() > 1500 then
			if ec <= 50 then
				return "efusion2"
			else
				local r2 = math.random(0,30)
				if r2 ~= 0 then
					local r = math.random(0,5)
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
					elseif r == 5 then
						return "ekmar"
					end
				elseif r2 == 0 then
					local r = math.random(0,2)
					if r == 0 then
						return "eshieldgen"	
					elseif r == 1 then
						return "elobberai"
					elseif r == 2 then
						return "esiloai"
					end
				end
			end
		end
	end
end

function RandomUnit()
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

	if mc >= ms - ms*0.20 then
		local r = math.random(0,3)
		if r <= 1 then
			return "eunitfactoryai"
		elseif r == 2 then
			return "elifterai"
		else
			if GG.TechCheck("tech1", ai.id) == false and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then
				return "eorb"
			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then
				return "eorb_up1"
			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == false then
				return "eorb_up2"
			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true then
				return "eorb_up3"
			end
		end
	elseif su <= sm-20 then
			if GG.TechCheck("tech1", ai.id) == false and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then ------- Tech 0 - Very Early Game
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
			
			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then ------- Reached Tech 1
			
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
			
			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == false then ------- Reached Tech 2 MK 2

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

			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true and Spring.GetGameSeconds() <= 1300 then ------- Reached Tech 3 MK 3
				
			
				local r2 = math.random(0,50)
				if r2 ~= 0 then	
					local r = math.random(0,8)
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
					end
				elseif r2 == 0 then
						if GG.TechCheck("endbringer", ai.id) == true then
						local r = math.random(0,4)
							if r == 0 then
								return "eamphibleveler_up2"
							elseif r == 1 then
								return "eallterranarchid_up2"
							elseif r == 2 then
								return "elacerator_up2"
							elseif r == 3 then
								return "ekrow_up2"
							elseif r == 4 then
								return "ehbotkarganneth_up2"
							end
						else
							return "escout_up3"
						end
					end	
				
			elseif GG.TechCheck("tech1", ai.id) == true and GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true and Spring.GetGameSeconds() > 1300 then ------- Reached MK 4
				
				local r2 = math.random(0,50)
				if r2 ~= 0 then
					local r = math.random(0,8)
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
					end
				elseif r2 == 0 then
					if GG.TechCheck("endbringer", ai.id) == true then
						local r = math.random(0,4)
							if r == 0 then
								return "eamphibleveler_up3"
							elseif r == 1 then
								return "eallterranarchid_up3"
							elseif r == 2 then
								return "elacerator_up3"
							elseif r == 3 then
								return "ekrow_up3"
							elseif r == 4 then
								return "ehbotkarganneth_up3"
							end
						else
							return "escout_up3"
						end
					end
				end	
		else
			return "escout_up3"
		end
	end
---------------------------------------------------------------- QUEUES


local idlelist = {
	{ action = "wait", frames = 3000},
}

local overseerlistfirst = {
	MoveToStartLocation,
	"emetalextractor",
	"emine",
	"elifterai",
	"emine",
	"esolar2",
	"emine",
	"eunitfactoryai",
	"emine",
	"elifterai",
	"emine",
	"elifterai",
	"emine",
	"elifterai",
	"emine",
	"esolar2",
	"emine",
	"esolar2",
	"emine",
	"eunitfactoryai",
	"emine",
}
	
local overseerorders = {
	RandomOverseer,
	RandomOverseer,
	RandomOverseer,
	RandomOverseer,
	"emine",
}

local lifterlist = {
	BuildMex,
	RandomLift,
	"emine",
}

local unitsqueue = {
	RandomUnit,
	RandomUnit,
	RandomUnit,
	RandomUnit,
	RandomUnit,
	RandomUnit,
	RandomUnit,
	RandomUnit,
	"emine",
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