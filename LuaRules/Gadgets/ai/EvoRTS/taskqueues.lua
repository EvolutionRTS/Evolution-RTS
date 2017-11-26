--[[
Task Queues!
]]--

math.randomseed( os.time() )
math.random(); math.random(); math.random()

--------------------------------------------- Functions for AI
local aiDifficulty = Spring.GetModOptions().aidifficulty
local aiUnits = Spring.GetModOptions().aiunits
local aiNukes = Spring.GetModOptions().ainukes
local shardChicken = Spring.GetModOptions().shardchicken
spGetTeamUnitsSorted = Spring.GetTeamUnitsSorted
spGetUnitDefID = Spring.GetUnitDefID
spGetTeamResources = Spring.GetTeamResources
spGetTeamUnitDefCount = Spring.GetTeamUnitDefCount
--Spring.GetGameSeconds() -- checking gametime

if shardChicken == nil then
	shardChicken = "disabled"
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

if shardChicken == "disabled" then

function RandomT3()
	if Spring.GetGameSeconds() >= 900 then
		local r = math.random(0,5)
			if 	   r == 0 and storedenergy >= 750 then
				--Spring.Echo([[WARNING! ShardAI is now building an Nuke Silo!!!]])
				return "esiloai"
			elseif r >= 1 and storedenergy >= 750 then
				--Spring.Echo([[WARNING! ShardAI is now building an Long Range Artillery!!!]])
				return "elobberai"
			end
	else
		return "escout_up3"
	end
end

function RandomFac()
	--Spring.Echo("[Shard] AI Difficulty is set to " .. aiDifficulty)
	--Spring.Echo("[Shard] Current gamesecond is " .. Spring.GetGameSeconds())
	--Spring.Echo("[Shard] Units are " .. aiUnits)
	if aiDifficulty == "easy" then
		if Spring.GetGameSeconds() >= 600 then
			if aiUnits == "enabled" then
			local r = math.random(0,4)
				if r == 0 then
					return "eairfacai_up0"
				elseif r == 1 then
					return "eallterrfacai_up0"
				elseif r == 2 then
					return "eamphifacai_up0"
				elseif r == 3 then
					return "ehbotfacai_up0"
				elseif r == 4 then
					return "ehoverfacai_up0"
				end
			elseif aiUnits == "disabled" then
					return "elifterai"
			end
		else
					return "eturretlightai"
		end
	elseif aiDifficulty == "hard" then
		if Spring.GetGameSeconds() >= 300 then
			if aiUnits == "enabled" then
			local r = math.random(0,4)
				if r == 0 then
					return "eairfacai_up0"
				elseif r == 1 then
					return "eallterrfacai_up0"
				elseif r == 2 then
					return "eamphifacai_up0"
				elseif r == 3 then
					return "ehbotfacai_up0"
				elseif r == 4 then
					return "ehoverfacai_up0"
				end
			elseif aiUnits == "disabled" then
					return "elifterai"
			end
		else
					return "eturretlightai"
		end
	end
end
---------------------------------------------------------------- LIFTER QUEUES

 function RandomLift()
	--Spring.Echo([[AI is using ]] .. Spring.GetTeamRulesParam(thisAI.id, "supplyUsed") .. [[ supply]])
	local mc, ms = Spring.GetTeamResources(ai.id, "metal")
	local ec, es = Spring.GetTeamResources(ai.id, "energy")

	if mc >= 490 then
		return "elifterai"
	elseif mc <= 10 then
		return "emetalextractor"
	elseif ec <= 50 then
		local r = math.random(0,5)
			if r == 0 then
				return "efusion2"
			else
				return "esolar2"
			end
	else
	local r = math.random(0,13)
		if r <= 3 then
			return "emine"
		elseif r == 4 then
			return "eturretlightai"
		elseif r == 5 then
			return "ekmar"
		elseif r == 6 then
			return "estorage"
		elseif r == 7 then
			return "ejammer2"
		elseif r == 8 then
			return "eturretheavyai"
		elseif r == 9 then
			return "eorbai"
		elseif r == 10 then
			return "ebox"
		elseif r == 11 then
			return "escout_up3"
		elseif r == 12 then
			if Spring.GetGameSeconds() >= 900 then
				local r = math.random(0,5)
					if 	   r == 0 and es >= 750 then
						--Spring.Echo([[WARNING! ShardAI is now building an Nuke Silo!!!]])
						return "esiloai"
					elseif r >= 1 and es >= 400 then
						--Spring.Echo([[WARNING! ShardAI is now building an Long Range Artillery!!!]])
						return "elobberai"
					end
			else
				return "escout_up3"
			end
		elseif r == 13 then
		--Spring.Echo("[Shard] AI Difficulty is set to " .. aiDifficulty)
		--Spring.Echo("[Shard] Current gamesecond is " .. Spring.GetGameSeconds())
		--Spring.Echo("[Shard] Units are " .. aiUnits)
			if aiDifficulty == "easy" then
				if Spring.GetGameSeconds() >= 900 then
					if aiUnits == "enabled" then
					local r = math.random(0,4)
						if r == 0 then
							return "eairfacai_up0"
						elseif r == 1 then
							return "eallterrfacai_up0"
						elseif r == 2 then
							return "eamphifacai_up0"
						elseif r == 3 then
							return "ehbotfacai_up0"
						elseif r == 4 then
							return "ehoverfacai_up0"
						end
						elseif aiUnits == "disabled" then
							return "elifterai"
						end
				else
						return "eturretlightai"
				end
			elseif aiDifficulty == "hard" then
				if Spring.GetGameSeconds() >= 600 then
					if aiUnits == "enabled" then
					local r = math.random(0,4)
						if r == 0 then
							return "eairfacai_up0"
						elseif r == 1 then
							return "eallterrfacai_up0"
						elseif r == 2 then
							return "eamphifacai_up0"
						elseif r == 3 then
							return "ehbotfacai_up0"
						elseif r == 4 then
							return "ehoverfacai_up0"
						end
				elseif aiUnits == "disabled" then
							return "elifterai"
					end
				else
						return "eturretlightai"
				end
			end
		end
end
end

function RandomOverseer()

	local mc, ms = Spring.GetTeamResources(ai.id, "metal")
	local ec, es = Spring.GetTeamResources(ai.id, "energy")

	if mc >= 490 then
		return "elifterai"
	elseif ec <= 50 then
		local r = math.random(0,5)
			if r == 0 then
				return "efusion2"
			else
				return "esolar2"
			end
	else
	local r = math.random(0,17)
		if r <= 3 then
			return "emine"
		elseif r > 3 and r <= 6 then
			return "ekmar"
		elseif r > 6 and r <= 9 then
			return "eturretlightai"
		elseif r > 9 and r <= 12 then
			return "eturretheavyai"
		elseif r == 13 then
			return "eshieldgen"
		elseif r == 14 then
			if Spring.GetGameSeconds() >= 900 then
				local r = math.random(0,5)
					if 	   r == 0 and es >= 750 then
						--Spring.Echo([[WARNING! ShardAI is now building an Nuke Silo!!!]])
						return "esiloai"
					elseif r >= 1 and es >= 400 then
						--Spring.Echo([[WARNING! ShardAI is now building an Long Range Artillery!!!]])
						return "elobberai"
					end
			else
				return "escout_up3"
			end
		elseif r == 15 then
			return "ejammer2"
		elseif r == 16 then
			return "estorage"
		elseif r == 17 then
			return "escout_up3"
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
	}


local overseerorders = {
	RandomOverseer,
}

local lifterlist = {
	RandomLift,
}

---------------------------------------------FACTORY QUEUES
------------------------AIR FACTORY
------------UPGRADE 0
local eairfacaiup0 = {
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"ebomber",
	"elifterai",
	"eairfacai_up1"
}
------------UPGRADE 1
local eairfacaiup1 = {
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"ebomber_up1",
	"elifterai",
	"eairfacai_up2",
}
------------UPGRADE 2
local eairfacaiup2 = {
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"ebomber_up2",
	"elifterai",
	"eairfacai_up3",
}
------------UPGRADE 3
local eairfacaiup3 = {
	"ebomber_up3",
}

------------------------ALL TERRAIN FACTORY
------------UPGRADE 0
local eallterrfacaiup0 = {
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"eallterrassault",
	"elifterai",
	"eallterrfacai_up1",
}
------------UPGRADE 1
local eallterrfacaiup1 = {
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"eallterrassault_up1",
	"elifterai",
	"eallterrfacai_up2",
}
------------UPGRADE 2
local eallterrfacaiup2 = {
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"eallterrassault_up2",
	"elifterai",
	"eallterrfacai_up3",
}
------------UPGRADE 3
local eallterrfacaiup3 = {
	"eallterrassault_up3",
}

------------------------AMPHIBIOUS FACTORY
------------UPGRADE 0
local eamphifacaiup0 = {
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"eamphibarty",
	"elifterai",
	"eamphifacai_up1",
}
------------UPGRADE 1
local eamphifacaiup1 = {
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"eamphibarty_up1",
	"elifterai",
	"eamphifacai_up2",
}
------------UPGRADE 2
local eamphifacaiup2 = {
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"eamphibarty_up2",
	"elifterai",
	"eamphifacai_up3",
}
------------UPGRADE 3
local eamphifacaiup3 = {
	"eamphibarty_up3",
}

------------------------HBOT FACTORY
------------UPGRADE 0
local ehbotfacaiup0 = {
	"ehbotsniper",
	"ehbotrocko",
	"ehbotsniper",
	"ehbotrocko",
	"ehbotsniper",
	"ehbotrocko",
	"ehbotsniper",
	"ehbotrocko",
	"ehbotsniper",
	"ehbotrocko",
	"ehbotsniper",
	"ehbotrocko",
	"ehbotsniper",
	"ehbotrocko",
	"elifterai",
	"ehbotfacai_up1",
}
------------UPGRADE 1
local ehbotfacaiup1 = {
	"ehbotsniper_up1",
	"ehbotrocko_up1",
	"ehbotsniper_up1",
	"ehbotrocko_up1",
	"ehbotsniper_up1",
	"ehbotrocko_up1",
	"ehbotsniper_up1",
	"ehbotrocko_up1",
	"ehbotsniper_up1",
	"ehbotrocko_up1",
	"ehbotsniper_up1",
	"ehbotrocko_up1",
	"ehbotsniper_up1",
	"ehbotrocko_up1",
	"elifterai",
	"ehbotfacai_up2",
}
------------UPGRADE 2
local ehbotfacaiup2 = {
	"ehbotsniper_up2",
	"ehbotrocko_up2",
	"ehbotsniper_up2",
	"ehbotrocko_up2",
	"ehbotsniper_up2",
	"ehbotrocko_up2",
	"ehbotsniper_up2",
	"ehbotrocko_up2",
	"ehbotsniper_up2",
	"ehbotrocko_up2",
	"ehbotsniper_up2",
	"ehbotrocko_up2",
	"ehbotsniper_up2",
	"ehbotrocko_up2",
	"elifterai",
	"ehbotfacai_up3",
}
------------UPGRADE 3
local ehbotfacaiup3 = {
	"ehbotsniper_up3",
	"ehbotrocko_up3",
}

------------------------HOVER FACTORY
------------UPGRADE 0
local ehoverfacaiup0 = {
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"eartytank",
	"elifterai",
	"ehoverfacai_up1",
}
------------UPGRADE 1
local ehoverfacaiup1 = {
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"eartytank_up1",
	"elifterai",
	"ehoverfacai_up2",
}
------------UPGRADE 2
local ehoverfacaiup2 = {
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"eartytank_up2",
	"elifterai",
	"ehoverfacai_up3",
}
------------UPGRADE 3
local ehoverfacaiup3 = {
	"eartytank_up3",
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
    ---builders
	ecommanderbattleai = overseerqueue,
    elifterai = lifterlist,
	---factories
	eairfacai_up0 = eairfacaiup0,
	eairfacai_up1 = eairfacaiup1,
	eairfacai_up2 = eairfacaiup2,
	eairfacai_up3 = eairfacaiup3,
	---
	eallterrfacai_up0 = eallterrfacaiup0,
	eallterrfacai_up1 = eallterrfacaiup1,
	eallterrfacai_up2 = eallterrfacaiup2,
	eallterrfacai_up3 = eallterrfacaiup3,
	---
	eamphifacai_up0 = eamphifacaiup0,
	eamphifacai_up1 = eamphifacaiup1,
	eamphifacai_up2 = eamphifacaiup2,
	eamphifacai_up3 = eamphifacaiup3,
	---
	ehbotfacai_up0 = ehbotfacaiup0,
	ehbotfacai_up1 = ehbotfacaiup1,
	ehbotfacai_up2 = ehbotfacaiup2,
	ehbotfacai_up3 = ehbotfacaiup3,
	---
	ehoverfacai_up0 = ehoverfacaiup0,
	ehoverfacai_up1 = ehoverfacaiup1,
	ehoverfacai_up2 = ehoverfacaiup2,
	ehoverfacai_up3 = ehoverfacaiup3,
	---
}
----------------------------------------------------------

elseif shardChicken == "enabled" then

----------------------------------------------------------
local chickenbuilderstart = {
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo1", 		-- Kamikaze Bomb MK1
"chicken1d", 			-- Swarm MK1
"chicken1c", 			-- Swarm MK2
"chicken1b", 			-- Swarm MK3
"chicken1", 			-- Swarm MK4
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenw1d",			-- Air Spiker MK1
"chickenw1",			-- Air Spiker MK2
"chickenw1c",			-- Air Spiker MK2
"chickenw1b",			-- Air Spiker MK3
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenw1d",			-- Air Spiker MK1
"chickenw1",			-- Air Spiker MK2
"chickenw1c",			-- Air Spiker MK2
"chickenw1b",			-- Air Spiker MK3
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenw1d",			-- Air Spiker MK1
"chickenw1",			-- Air Spiker MK2
"chickenw1c",			-- Air Spiker MK2
"chickenw1b",			-- Air Spiker MK3
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenw1d",			-- Air Spiker MK1
"chickenw1",			-- Air Spiker MK2
"chickenw1c",			-- Air Spiker MK2
"chickenw1b",			-- Air Spiker MK3
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenw1d",			-- Air Spiker MK1
"chickenw1",			-- Air Spiker MK2
"chickenw1c",			-- Air Spiker MK2
"chickenw1b",			-- Air Spiker MK3
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken_dodo2", 		-- Kamikaze Bomb MK2
"chicken1z", 			-- Swarm MK5
"chicken1y", 			-- Swarm MK6
"chicken1x", 			-- Swarm MK7
"chickena1",			-- Tank MK1
"chickena1b",			-- Tank MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickena1c",			-- Tank MK1
"chickenc3b",			-- Spider MK1
"chickenc3",			-- Spider MK2
"chickenc3c",			-- Spider MK3
"chickenh4",			-- Fast Swarm
"chickens1",			-- Spiker MK1
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenw1d",			-- Air Spiker MK1
"chickenw1",			-- Air Spiker MK2
"chickenw1c",			-- Air Spiker MK2
"chickenw1b",			-- Air Spiker MK3
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken2", 			-- Swarm MK8
"chicken2b", 			-- Swarm MK9
"chickena2b",			-- Tank MK2
"chickena2",			-- Tank MK3
"chickenh3",			-- Tank MK4
"chickenh2",			-- Tank MK5
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenc1",			-- Spider MK4
"chickenc2",			-- Spider MK5
"chickenp1",			-- Flamer
"chickenr1",			-- Artilery MK1
"chickenr2",			-- Artilery MK2
"chickens2",			-- Spiker MK2
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenw1d",			-- Air Spiker MK1
"chickenw1",			-- Air Spiker MK2
"chickenw1c",			-- Air Spiker MK2
"chickenw1b",			-- Air Spiker MK3
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken2", 			-- Swarm MK8
"chicken2b", 			-- Swarm MK9
"chickena2b",			-- Tank MK2
"chickena2",			-- Tank MK3
"chickenh3",			-- Tank MK4
"chickenh2",			-- Tank MK5
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenc1",			-- Spider MK4
"chickenc2",			-- Spider MK5
"chickenp1",			-- Flamer
"chickenr1",			-- Artilery MK1
"chickenr2",			-- Artilery MK2
"chickens2",			-- Spiker MK2
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken2", 			-- Swarm MK8
"chicken2b", 			-- Swarm MK9
"chickena2b",			-- Tank MK2
"chickena2",			-- Tank MK3
"chickenh3",			-- Tank MK4
"chickenh2",			-- Tank MK5
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenc1",			-- Spider MK4
"chickenc2",			-- Spider MK5
"chickenp1",			-- Flamer
"chickenr1",			-- Artilery MK1
"chickenr2",			-- Artilery MK2
"chickens2",			-- Spiker MK2
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken2", 			-- Swarm MK8
"chicken2b", 			-- Swarm MK9
"chickena2b",			-- Tank MK2
"chickena2",			-- Tank MK3
"chickenh3",			-- Tank MK4
"chickenh2",			-- Tank MK5
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenc1",			-- Spider MK4
"chickenc2",			-- Spider MK5
"chickenp1",			-- Flamer
"chickenr1",			-- Artilery MK1
"chickenr2",			-- Artilery MK2
"chickens2",			-- Spiker MK2
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenw1d",			-- Air Spiker MK1
"chickenw1",			-- Air Spiker MK2
"chickenw1c",			-- Air Spiker MK2
"chickenw1b",			-- Air Spiker MK3
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken2", 			-- Swarm MK8
"chicken2b", 			-- Swarm MK9
"chickena2b",			-- Tank MK2
"chickena2",			-- Tank MK3
"chickenh3",			-- Tank MK4
"chickenh2",			-- Tank MK5
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenc1",			-- Spider MK4
"chickenc2",			-- Spider MK5
"chickenp1",			-- Flamer
"chickenr1",			-- Artilery MK1
"chickenr2",			-- Artilery MK2
"chickens2",			-- Spiker MK2
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken2", 			-- Swarm MK8
"chicken2b", 			-- Swarm MK9
"chickena2b",			-- Tank MK2
"chickena2",			-- Tank MK3
"chickenh3",			-- Tank MK4
"chickenh2",			-- Tank MK5
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenc1",			-- Spider MK4
"chickenc2",			-- Spider MK5
"chickenp1",			-- Flamer
"chickenr1",			-- Artilery MK1
"chickenr2",			-- Artilery MK2
"chickens2",			-- Spiker MK2
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken2", 			-- Swarm MK8
"chicken2b", 			-- Swarm MK9
"chickena2b",			-- Tank MK2
"chickena2",			-- Tank MK3
"chickenh3",			-- Tank MK4
"chickenh2",			-- Tank MK5
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenc1",			-- Spider MK4
"chickenc2",			-- Spider MK5
"chickenp1",			-- Flamer
"chickenr1",			-- Artilery MK1
"chickenr2",			-- Artilery MK2
"chickens2",			-- Spiker MK2
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenw1d",			-- Air Spiker MK1
"chickenw1",			-- Air Spiker MK2
"chickenw1c",			-- Air Spiker MK2
"chickenw1b",			-- Air Spiker MK3
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
}

local chickenbuilderend = {
"chicken2", 			-- Swarm MK8
"chicken2b", 			-- Swarm MK9
"chickena2b",			-- Tank MK2
"chickena2",			-- Tank MK3
"chickenh3",			-- Tank MK4
"chickenh2",			-- Tank MK5
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenc1",			-- Spider MK4
"chickenc2",			-- Spider MK5
"chickenp1",			-- Flamer
"chickenr1",			-- Artilery MK1
"chickenr2",			-- Artilery MK2
"chickens2",			-- Spiker MK2
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken2", 			-- Swarm MK8
"chicken2b", 			-- Swarm MK9
"chickena2b",			-- Tank MK2
"chickena2",			-- Tank MK3
"chickenh3",			-- Tank MK4
"chickenh2",			-- Tank MK5
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenc1",			-- Spider MK4
"chickenc2",			-- Spider MK5
"chickenp1",			-- Flamer
"chickenr1",			-- Artilery MK1
"chickenr2",			-- Artilery MK2
"chickens2",			-- Spiker MK2
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chicken2", 			-- Swarm MK8
"chicken2b", 			-- Swarm MK9
"chickena2b",			-- Tank MK2
"chickena2",			-- Tank MK3
"chickenh3",			-- Tank MK4
"chickenh2",			-- Tank MK5
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenc1",			-- Spider MK4
"chickenc2",			-- Spider MK5
"chickenp1",			-- Flamer
"chickenr1",			-- Artilery MK1
"chickenr2",			-- Artilery MK2
"chickens2",			-- Spiker MK2
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
"chickenf1",			-- Bomber MK1
"chickenf1b",			-- Bomber MK2
"chickens3",			-- Assault Spiker
"chickenw2",			-- Fighter
"chickeneco", 			-- Power Source
"chickeneco", 			-- Power Source
}

local idlelist = {
  { action = "wait", frames = 3000},
}

local function engineerlist(beh)
		if ai.engineerfirst == true then
			return chickenbuilderend
			else
			ai.engineerfirst = true
			return chickenbuilderstart
			end
	end
	taskqueues = {
   ecommanderbattleai = engineerlist,
   --ebasefactory = factory,
   --eengineer5 = engineerlist,
   eallterrengineer = engineerlist,
   --eamphibengineer = engineerlist,
   --eairengineer = engineerlist,
   --eairplant = airplant,
   --eamphibfac = amphibfactory,
   --eminifac = allterrfactory,
   --eorb = orblist,
	}
end

