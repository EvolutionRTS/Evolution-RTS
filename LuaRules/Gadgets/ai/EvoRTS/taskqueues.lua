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
local liftersqueued = 0
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

local WaitRNG = math.random(0,500)
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
	if mc >= ms - ms*0.10 then
		if Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elifterai.id)*60 < Spring.GetGameSeconds() then
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
	else
		if aimexamount * 15 <= Spring.GetGameSeconds()  then
			return "emetalextractor"
		else
			return "ebomb"
		end
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
	
	if ec <= 50 and GG.TechCheck("tech1", ai.id) == true then
		if GG.TechCheck("tech3", ai.id) == true then
			return "efusion2"
		elseif GG.TechCheck("tech2", ai.id) == true then
			return "egeothermal"
		else
			return "esolar2"
		end
	elseif mc >= ms - ms*0.10 then
		if Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elifterai.id)*60 < Spring.GetGameSeconds() then
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
	
	elseif GG.TechCheck("tech1", ai.id) == false and Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.etech1.id) then
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
	if ec <= 50 and GG.TechCheck("tech1", ai.id) == true then
		if GG.TechCheck("tech3", ai.id) == true then
			return "efusion2"
		elseif GG.TechCheck("tech2", ai.id) == true then
			return "egeothermal"
		else
			return "esolar2"
		end
	elseif mc >= ms - ms*0.20 then
		if Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elifterai.id)*60 < Spring.GetGameSeconds() then
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
	elseif GG.TechCheck("tech1", ai.id) == false and Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.etech1.id) then
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

	if Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elifterai.id) < 4 then
		return "elifterai"
	elseif su <= sm-20 and GG.TechCheck("tech1", ai.id) == true then
				
			if GG.TechCheck("tech2", ai.id) == false and GG.TechCheck("tech3", ai.id) == false then ------- Reached Tech 1
			
			local r = math.random(0,12)
				if r == 0 then
					return "eallterrlight"
				elseif r == 1 then
					return "eallterrassault"
				elseif r == 2 then
					return "elighttank3"
				elseif r == 3 then
					return "eartytank"
				elseif r == 4 then
					return "escoutdrone"
				elseif r == 5 then
					return "eamphibarty"
				elseif r == 6 then
					return "eamphibriot"
				elseif r == 7 then
					return "eamphibbuggy"
				elseif r == 8 then
					return "ehbotpeewee"
				elseif r == 9 then
					return "eriottank2"
				elseif r == 10 then
					return "eamphibneedle"
				elseif r == 11 then
					return "eallterrriot"
				elseif r == 12 then
					return "ehbotthud"
				end
			
			elseif GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == false then ------- Reached Tech 2 MK 2

			local r = math.random(0,9)
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
					return "ebomber_up1"
				elseif r == 6 then
					return "efighter_up1"
				elseif r == 7 then
					return "eamphibrock_up1"
				elseif r == 8 then
					return "emissiletank_up1"
				elseif r == 9 then
					return "eamphibmedtank_up1"
				end	

			elseif GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true and Spring.GetGameSeconds() <= 1300 then ------- Reached Tech 3 MK 3
					local r = math.random(0,10)
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
						return "ebomber_up2"
					elseif r == 6 then
						return "efighter_up2"
					elseif r == 7 then
						return "eairemp_up2"
					elseif r == 8 then
						return "eamphibrock_up2"
					elseif r == 9 then
						return "emissiletank_up2"
					elseif r == 10 then
						return "eamphibmedtank_up2"
					end
			elseif GG.TechCheck("tech2", ai.id) == true and GG.TechCheck("tech3", ai.id) == true and Spring.GetGameSeconds() > 1300 then ------- Reached MK 4
				
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
						return "eairemp_up3"
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
							if Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elifterai.id)*60 < Spring.GetGameSeconds() then
								return "elifterai"
							else
								return "eorb_up3"
							end
						end
					end
				end	
		else
				if es < Spring.GetGameSeconds()*0.5 then
					return "estorage"
				elseif mc >= ms - ms*0.20 then
					if Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.elifterai.id)*60 < Spring.GetGameSeconds() then
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
				elseif Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.emine.id) > Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eturretlightai.id) + Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eturretlightai_up3.id) and GG.TechCheck("tech1", ai.id) then
					if Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eturretlightai.id) + Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eturretlightai_up3.id) > Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eturretheavyai.id) + Spring.GetTeamUnitDefCount(ai.id, UnitDefNames.eturretheavyai_up3.id) and GG.TechCheck("tech2", ai.id) then
						if GG.TechCheck("tech3", ai.id) then
							return "eturretheavyai_up3"
						else
							return "eturretheavyai"
						end
					else
						if GG.TechCheck("tech3", ai.id) then
							return "eturretlightai_up3"
						else
							return "eturretlightai"
						end
					end
				else
					local r = math.random(0,5)
					if r == 0 then
						return "emine"
					elseif r == 1 then
						return "escoutdrone"
					else
						return "ebomb"
					end
				end
		end
	end
---Factories:


	
---------------------------------------------------------------- QUEUES



local idlelist = {
	{ action = "wait", frames = 3000},
}

local assistqueue = {
	{ action = "patrolrelative", position = {x = 100, y = 0, z = 100} },
}

local overseerlistfirst = {
	"emetalextractor",
	"emetalextractor",
	"emetalextractor",
	"escoutdrone",
	"elifterai",
	"eturretlightai",
	"escoutdrone",
	"elifterai",
	"eturretlightai",
	"escoutdrone",
	"elifterai",
	"eturretlightai",
	"escoutdrone",
}
	
local overseerorders = {
	RandomOverseer,
	RandomOverseer,
	RandomOverseer,
	RandomOverseer,
	"emine",
	"elifterai",
}

local lifterlist = {
	RandomLift,
	BuildMex,
	RandomUnit,
	RandomUnit,
	RandomUnit,
	"emine",
	BuildMex,
	
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

local function lifterqueue()
	if liftersqueued > 1 then
		liftersqueued = liftersqueued - 0.02
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
	eunitfactoryai = unitsqueue,
	eorb = assistqueue,
	eorb_up1 = assistqueue,
	eorb_up2 = assistqueue,
	eorb_up3 = assistqueue,
}
----------------------------------------------------------