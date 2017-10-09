--[[
Task Queues!
]]--

math.randomseed( os.time() )
math.random(); math.random(); math.random()

--------------------------------------------- Functions for AI

shardChicken = Spring.GetModOptions().shardchicken

if shardChicken == nil then
	shardChicken = "disabled"
end

if shardChicken == "disabled" then

local function Orb()
	return "eorbai"
end

local function Box()
	return "ebox"
end

local function Scout()
	return "escout_up3"
end

local function Turret()
	return "eaiturret"
end

local function RandomT3()
   local r = math.random(0,2)
		if r == 0 then
			return "eantinukeai"
		elseif r == 1 then
			return "esiloai"
		elseif r == 2 then
			return "elobberai"
		end
	end

local function RandomFac()
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
	end

---------------------------------------------------------------- QUEUES


local idlelist = {
	{ action = "wait", frames = 3000},
}

local overseerlistfirst = {
	"elifterai",
	RandomFac,
}

local overseerlist = {
	"elifterai",
	RandomFac,
	RandomT3,
}

local lifterlist = {
	"elifterai",
	"egeothermal",
	"emetalextractor",
	"emine",
	"eturretlightai",
	"emetalextractor",
	"eturretlightai",
	"esolar2",
	"efusion2",
	"estorage",
	"estorage",
	"ekmar",
	"ejammer2",
	"eturretheavyai",	
}

---------------------------------------------FACTORY QUEUES
------------------------AIR FACTORY
------------UPGRADE 0
local eairfacaiup0 = {
	"ebomber2",
	"efighter",
	"egunship2",
	"ebomber2",
	"efighter",
	"egunship2",
	"ebomber2",
	"efighter",
	"egunship2",
	"ebomber2",
	"efighter",
	"egunship2",
	"eairfacai_up1"
}
------------UPGRADE 1
local eairfacaiup1 = {
	"ebomber2_up1",
	"efighter_up1",
	"egunship2_up1",
	"ebomber2_up1",
	"efighter_up1",
	"egunship2_up1",
	"ebomber2_up1",
	"efighter_up1",
	"egunship2_up1",
	"ebomber2_up1",
	"efighter_up1",
	"egunship2_up1",
	"eairfacai_up2",
}
------------UPGRADE 2
local eairfacaiup2 = {
	"ebomber2_up2",
	"efighter_up2",
	"egunship2_up2",
	"ebomber2_up2",
	"efighter_up2",
	"egunship2_up2",
	"ebomber2_up2",
	"efighter_up2",
	"egunship2_up2",
	"ebomber2_up2",
	"efighter_up2",
	"egunship2_up2",
	"eairfacai_up3",
}
------------UPGRADE 3
local eairfacaiup3 = {
	"ebomber2_up3",
	"efighter_up3",
	"egunship2_up3",
	"ebomber2_up3",
	"efighter_up3",
	"egunship2_up3",
	"ebomber2_up3",
	"efighter_up3",
	"egunship2_up3",
	"ebomber2_up3",
	"efighter_up3",
	"egunship2_up3",
}

------------------------ALL TERRAIN FACTORY
------------UPGRADE 0
local eallterrfacaiup0 = {
	"eallterrlight",
	"eallterrriot",
	"eallterrassault",
	"eallterrmed",
	"eallterrheavy",
	"eallterrlight",
	"eallterrriot",
	"eallterrassault",
	"eallterrmed",
	"eallterrheavy",
	"eallterrlight",
	"eallterrriot",
	"eallterrassault",
	"eallterrmed",
	"eallterrheavy",
	"eallterrfacai_up1",
}
------------UPGRADE 1
local eallterrfacaiup1 = {
	"eallterrlight_up1",
	"eallterrriot_up1",
	"eallterrassault_up1",
	"eallterrmed_up1",
	"eallterrheavy_up1",
	"eallterrlight_up1",
	"eallterrriot_up1",
	"eallterrassault_up1",
	"eallterrmed_up1",
	"eallterrheavy_up1",
	"eallterrlight_up1",
	"eallterrriot_up1",
	"eallterrassault_up1",
	"eallterrmed_up1",
	"eallterrheavy_up1",
	"eallterrfacai_up2",
}
------------UPGRADE 2
local eallterrfacaiup2 = {
	"eallterrlight_up2",
	"eallterrriot_up2",
	"eallterrassault_up2",
	"eallterrmed_up2",
	"eallterrheavy_up2",
	"eallterrlight_up2",
	"eallterrriot_up2",
	"eallterrassault_up2",
	"eallterrmed_up2",
	"eallterrheavy_up2",
	"eallterrlight_up2",
	"eallterrriot_up2",
	"eallterrassault_up2",
	"eallterrmed_up2",
	"eallterrheavy_up2",
	"eallterrfacai_up3",
}
------------UPGRADE 3
local eallterrfacaiup3 = {
	"eallterrlight_up3",
	"eallterrriot_up3",
	"eallterrassault_up3",
	"eallterrmed_up3",
	"eallterrheavy_up3",
	"eallterrlight_up3",
	"eallterrriot_up3",
	"eallterrassault_up3",
	"eallterrmed_up3",
	"eallterrheavy_up3",
	"eallterrlight_up3",
	"eallterrriot_up3",
	"eallterrassault_up3",
	"eallterrmed_up3",
	"eallterrheavy_up3",
}

------------------------AMPHIBIOUS FACTORY
------------UPGRADE 0
local eamphifacaiup0 = {
	"eamphibbuggy",
	"eamphibriot",
	"eamphibneedle",
	"eamphibarty",
	"eamphibmedtank",
	"eamphibrock",
	"eamphibbuggy",
	"eamphibriot",
	"eamphibneedle",
	"eamphibarty",
	"eamphibmedtank",
	"eamphibrock",
	"eamphibbuggy",
	"eamphibriot",
	"eamphibneedle",
	"eamphibarty",
	"eamphibmedtank",
	"eamphibrock",
	"eamphifacai_up1",
}
------------UPGRADE 1
local eamphifacaiup1 = {
	"eamphibbuggy_up1",
	"eamphibriot_up1",
	"eamphibneedle_up1",
	"eamphibarty_up1",
	"eamphibmedtank_up1",
	"eamphibrock_up1",
	"eamphibbuggy_up1",
	"eamphibriot_up1",
	"eamphibneedle_up1",
	"eamphibarty_up1",
	"eamphibmedtank_up1",
	"eamphibrock_up1",
	"eamphibbuggy_up1",
	"eamphibriot_up1",
	"eamphibneedle_up1",
	"eamphibarty_up1",
	"eamphibmedtank_up1",
	"eamphibrock_up1",
	"eamphifacai_up2",
}
------------UPGRADE 2
local eamphifacaiup2 = {
	"eamphibbuggy_up2",
	"eamphibriot_up2",
	"eamphibneedle_up2",
	"eamphibarty_up2",
	"eamphibmedtank_up2",
	"eamphibrock_up2",
	"eamphibbuggy_up2",
	"eamphibriot_up2",
	"eamphibneedle_up2",
	"eamphibarty_up2",
	"eamphibmedtank_up2",
	"eamphibrock_up2",
	"eamphibbuggy_up2",
	"eamphibriot_up2",
	"eamphibneedle_up2",
	"eamphibarty_up2",
	"eamphibmedtank_up2",
	"eamphibrock_up2",
	"eamphifacai_up3",
}
------------UPGRADE 3
local eamphifacaiup3 = {
	"eamphibbuggy_up3",
	"eamphibriot_up3",
	"eamphibneedle_up3",
	"eamphibarty_up3",
	"eamphibmedtank_up3",
	"eamphibrock_up3",
	"eamphibbuggy_up3",
	"eamphibriot_up3",
	"eamphibneedle_up3",
	"eamphibarty_up3",
	"eamphibmedtank_up3",
	"eamphibrock_up3",
	"eamphibbuggy_up3",
	"eamphibriot_up3",
	"eamphibneedle_up3",
	"eamphibarty_up3",
	"eamphibmedtank_up3",
	"eamphibrock_up3",
}

------------------------HBOT FACTORY
------------UPGRADE 0
local ehbotfacaiup0 = {
	"ehbotpeewee",
	"ehbotthud",
	"ehbotsniper",
	"ehbotrocko",
	"ehbotpeewee",
	"ehbotthud",
	"ehbotsniper",
	"ehbotrocko",
	"ehbotpeewee",
	"ehbotthud",
	"ehbotsniper",
	"ehbotrocko",
	"ehbotfacai_up1",
}
------------UPGRADE 1
local ehbotfacaiup1 = {
	"ehbotpeewee_up1",
	"ehbotthud_up1",
	"ehbotsniper_up1",
	"ehbotrocko_up1",
	"ehbotpeewee_up1",
	"ehbotthud_up1",
	"ehbotsniper_up1",
	"ehbotrocko_up1",
	"ehbotpeewee_up1",
	"ehbotthud_up1",
	"ehbotsniper_up1",
	"ehbotrocko_up1",
	"ehbotfacai_up2",
}
------------UPGRADE 2
local ehbotfacaiup2 = {
	"ehbotpeewee_up2",
	"ehbotthud_up2",
	"ehbotsniper_up2",
	"ehbotrocko_up2",
	"ehbotpeewee_up2",
	"ehbotthud_up2",
	"ehbotsniper_up2",
	"ehbotrocko_up2",
	"ehbotpeewee_up2",
	"ehbotthud_up2",
	"ehbotsniper_up2",
	"ehbotrocko_up2",
	"ehbotfacai_up3",
}
------------UPGRADE 3
local ehbotfacaiup3 = {
	"ehbotpeewee_up3",
	"ehbotthud_up3",
	"ehbotsniper_up3",
	"ehbotrocko_up3",
	"ehbotpeewee_up3",
	"ehbotthud_up3",
	"ehbotsniper_up3",
	"ehbotrocko_up3",
	"ehbotpeewee_up3",
	"ehbotthud_up3",
	"ehbotsniper_up3",
	"ehbotrocko_up3",
}

------------------------HOVER FACTORY
------------UPGRADE 0
local ehoverfacaiup0 = {
	"elighttank3",
	"eriottank2",
	"eartytank",
	"eheavytank3",
	"emissiletank",
	"elighttank3",
	"eriottank2",
	"eartytank",
	"eheavytank3",
	"emissiletank",
	"elighttank3",
	"eriottank2",
	"eartytank",
	"eheavytank3",
	"emissiletank",
	"ehoverfacai_up1",
}
------------UPGRADE 1
local ehoverfacaiup1 = {
	"elighttank3_up1",
	"eriottank2_up1",
	"eartytank_up1",
	"eheavytank3_up1",
	"emissiletank_up1",
	"elighttank3_up1",
	"eriottank2_up1",
	"eartytank_up1",
	"eheavytank3_up1",
	"emissiletank_up1",
	"elighttank3_up1",
	"eriottank2_up1",
	"eartytank_up1",
	"eheavytank3_up1",
	"emissiletank_up1",
	"ehoverfacai_up2",
}
------------UPGRADE 2
local ehoverfacaiup2 = {
	"elighttank3_up2",
	"eriottank2_up2",
	"eartytank_up2",
	"eheavytank3_up2",
	"emissiletank_up2",
	"elighttank3_up2",
	"eriottank2_up2",
	"eartytank_up2",
	"eheavytank3_up2",
	"emissiletank_up2",
	"elighttank3_up2",
	"eriottank2_up2",
	"eartytank_up2",
	"eheavytank3_up2",
	"emissiletank_up2",
	"ehoverfacai_up3",
}
------------UPGRADE 3
local ehoverfacaiup3 = {
	"elighttank3_up3",
	"eriottank2_up3",
	"eartytank_up3",
	"eheavytank3_up3",
	"emissiletank_up3",
	"elighttank3_up3",
	"eriottank2_up3",
	"eartytank_up3",
	"eheavytank3_up3",
	"emissiletank_up3",
	"elighttank3_up3",
	"eriottank2_up3",
	"eartytank_up3",
	"eheavytank3_up3",
	"emissiletank_up3",
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
		return overseerlist
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
"eaiturret",
"eaiturret",
"eaiturret",
"eaiturret",
"eaiturret",
"eaiturret",
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
"eaiturret",
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
"eaiturret",			
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
   eaiturret = idlelist,
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

