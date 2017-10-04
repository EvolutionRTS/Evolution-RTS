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

---------------------------------------------------------------- QUEUES


local firstEngineerAmphibious = {
	Orb,
	Orb,
	Orb,
	"eshieldgen",
	"ehbotengineer",
	Orb,
	Orb,
	Turret,
	Turret,
	Turret,
	Turret,
	Orb,
	Orb,
	Scout,
	Scout,
	Scout,
	Scout,
	Scout,
	Orb,
	Orb,
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibbuggy",
	Orb,
	Orb,
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibriot",
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibriot",
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibbuggy",
	"eamphibriot",
	Orb,
	Box,
	"eamphibbuggy_up1",
	"eamphibbuggy_up1",
	"eamphibbuggy_up1",
	"eamphibriot",
	"eamphibbuggy_up1",
	"eamphibbuggy_up1",
	"eamphibbuggy_up1",
	"eamphibriot",
	"eamphibbuggy_up1",
	"eamphibbuggy_up1",
	"eamphibbuggy_up1",
	"eamphibriot",
	Orb,
	Orb,
	"eamphibbuggy_up1",
	"eamphibriot_up1",
	"eamphibbuggy_up1",
	"eamphibriot_up1",
	"eamphibneedle",
	"eamphibneedle",
	"eamphibneedle",
	Orb,
	Turret,
	Box,
	"eamphibbuggy_up2",
	"eamphibriot_up2",
	"eamphibbuggy_up2",
	"eamphibriot_up2",
	"eamphibneedle",
	"eamphibneedle",
	"eamphibneedle",
	"eamphibarty_up1",
	"eamphibmedtank",
	Orb,
	Orb,
	"eamphibmedtank",
	"eamphibriot_up2",
	"eamphibmedtank",
	"eamphibriot_up2",
	"eamphibneedle_up1",
	"eamphibneedle_up1",
	"eamphibneedle_up1",
	"eamphibarty_up1",
	"eamphibmedtank_up1",
	Orb,
	Box,
	"eamphibmedtank_up1",
	"eamphibriot_up3",
	"eamphibmedtank_up1",
	"eamphibriot_up3",
	"eamphibneedle_up2",
	"eamphibneedle_up2",
	"eamphibneedle_up2",
	"eamphibarty_up2",
	"eamphibmedtank_up2",
	Orb,
}

local firstEngineerHover = {
	Orb,
	Orb,
	Orb,
	"eshieldgen",
	"ehbotengineer",
	Orb,
	Orb,
	Turret,
	Turret,
	Turret,
	Turret,
	Orb,
	Orb,
	Scout,
	Scout,
	Scout,
	Scout,
	Scout,
	Orb,
	Orb,
	"elighttank3",
	"elighttank3",
	"elighttank3",
	"elighttank3",
	"elighttank3",
	"elighttank3",
	"elighttank3",
	"elighttank3",
	"elighttank3",
	"elighttank3",
	Orb,
	Orb,
	"elighttank3",
	"elighttank3",
	"elighttank3",
	"eriottank2",
	"elighttank3",
	"elighttank3",
	"elighttank3",
	"eriottank2",
	"elighttank3",
	"elighttank3",
	"elighttank3",
	"eriottank2",
	Orb,
	Box,
	"elighttank3_up1",
	"elighttank3_up1",
	"elighttank3_up1",
	"eriottank2",
	"elighttank3_up1",
	"elighttank3_up1",
	"elighttank3_up1",
	"eriottank2",
	"elighttank3_up1",
	"elighttank3_up1",
	"elighttank3_up1",
	"eriottank2",
	Orb,
	Orb,
	"elighttank3_up1",
	"eriottank2_up1",
	"elighttank3_up1",
	"eriottank2_up1",
	"elighttank3_up2",
	"elighttank3_up2",
	"elighttank3_up2",
	Orb,
	Turret,
	Box,
	"elighttank3_up2",
	"eriottank2_up2",
	"elighttank3_up2",
	"eriottank2_up2",
	"elighttank3_up2",
	"elighttank3_up2",
	"elighttank3_up2",
	"eartytank_up1",
	"eheavytank3",
	Orb,
	Orb,
	"eheavytank3",
	"eriottank2_up2",
	"eheavytank3",
	"eriottank2_up2",
	"elighttank3_up3",
	"elighttank3_up3",
	"elighttank3_up3",
	"eartytank_up1",
	"eheavytank3_up1",
	Orb,
	Box,
	"eheavytank3_up1",
	"eriottank2_up3",
	"eheavytank3_up1",
	"eriottank2_up3",
	"elighttank3_up3",
	"elighttank3_up3",
	"elighttank3_up3",
	"eartytank_up2",
	"eheavytank3_up2",
	Orb,
}

local firstEngineerSpider = {
	Orb,
	Orb,
	Orb,
	"eshieldgen",
	"ehbotengineer",
	Orb,
	Orb,
	Turret,
	Turret,
	Turret,
	Turret,
	Orb,
	Orb,
	Scout,
	Scout,
	Scout,
	Scout,
	Scout,
	Orb,
	Orb,
	"eallterrlight",
	"eallterrlight",
	"eallterrlight",
	"eallterrlight",
	"eallterrlight",
	"eallterrlight",
	"eallterrlight",
	"eallterrlight",
	"eallterrlight",
	"eallterrlight",
	Orb,
	Orb,
	"eallterrlight",
	"eallterrlight",
	"eallterrlight",
	"eallterrriot",
	"eallterrlight",
	"eallterrlight",
	"eallterrlight",
	"eallterrriot",
	"eallterrlight",
	"eallterrlight",
	"eallterrlight",
	"eallterrriot",
	Orb,
	Box,
	"eallterrlight_up1",
	"eallterrlight_up1",
	"eallterrlight_up1",
	"eallterrriot",
	"eallterrlight_up1",
	"eallterrlight_up1",
	"eallterrlight_up1",
	"eallterrriot",
	"eallterrlight_up1",
	"eallterrlight_up1",
	"eallterrlight_up1",
	"eallterrriot",
	Orb,
	Orb,
	"eallterrlight_up1",
	"eallterrriot_up1",
	"eallterrlight_up1",
	"eallterrriot_up1",
	"eallterrmed",
	"eallterrmed",
	"eallterrmed",
	Orb,
	Turret,
	Box,
	"eallterrlight_up2",
	"eallterrriot_up2",
	"eallterrlight_up2",
	"eallterrriot_up2",
	"eallterrmed",
	"eallterrmed",
	"eallterrmed",
	"eallterrassault_up1",
	"eallterrheavy",
	Orb,
	Orb,
	"eallterrheavy",
	"eallterrriot_up2",
	"eallterrheavy",
	"eallterrriot_up2",
	"eallterrmed_up1",
	"eallterrmed_up1",
	"eallterrmed_up1",
	"eallterrassault_up1",
	"eallterrheavy_up1",
	Orb,
	Box,
	"eallterrheavy_up1",
	"eallterrriot_up3",
	"eallterrheavy_up1",
	"eallterrriot_up3",
	"eallterrmed_up2",
	"eallterrmed_up2",
	"eallterrmed_up2",
	"eallterrassault_up2",
	"eallterrheavy_up2",
	Orb,
}

local firstEngineerHBot = {
	Orb,
	Orb,
	Orb,
	"eshieldgen",
	"ehbotengineer",
	Orb,
	Orb,
	Turret,
	Turret,
	Turret,
	Turret,
	Orb,
	Orb,
	Scout,
	Scout,
	Scout,
	Scout,
	Scout,
	Orb,
	Orb,
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	Orb,
	Orb,
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	"ehbotpeewee",
	Orb,
	Box,
	"ehbotpeewee_up1",
	"ehbotpeewee_up1",
	"ehbotpeewee_up1",
	"ehbotpeewee",
	"ehbotpeewee_up1",
	"ehbotpeewee_up1",
	"ehbotpeewee_up1",
	"ehbotpeewee",
	"ehbotpeewee_up1",
	"ehbotpeewee_up1",
	"ehbotpeewee_up1",
	"ehbotpeewee",
	Orb,
	Orb,
	"ehbotpeewee_up1",
	"ehbotpeewee_up1",
	"ehbotpeewee_up1",
	"ehbotpeewee_up1",
	"ehbotthud",
	"ehbotthud",
	"ehbotthud",
	Orb,
	Turret,
	Box,
	"ehbotpeewee_up2",
	"ehbotpeewee_up2",
	"ehbotpeewee_up2",
	"ehbotpeewee_up2",
	"ehbotthud",
	"ehbotthud",
	"ehbotthud",
	"ehbotrocko_up1",
	"ehbotsniper",
	Orb,
	Orb,
	"ehbotsniper",
	"ehbotpeewee_up2",
	"ehbotsniper",
	"ehbotpeewee_up2",
	"ehbotthud_up1",
	"ehbotthud_up1",
	"ehbotthud_up1",
	"ehbotrocko_up1",
	"ehbotsniper_up1",
	Orb,
	Box,
	"ehbotsniper_up1",
	"ehbotpeewee_up3",
	"ehbotsniper_up1",
	"ehbotpeewee_up3",
	"ehbotthud_up2",
	"ehbotthud_up2",
	"ehbotthud_up2",
	"ehbotrocko_up2",
	"ehbotsniper_up2",
	Orb,
}

local firstEngineerAir = {
	Orb,
	Orb,
	Orb,
	"eshieldgen",
	"ehbotengineer",
	Orb,
	Orb,
	Turret,
	Turret,
	Turret,
	Turret,
	Orb,
	Orb,
	Scout,
	Scout,
	Scout,
	Scout,
	Scout,
	Orb,
	Orb,
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	Orb,
	Orb,
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	"efighter",
	Orb,
	Box,
	"efighter_up1",
	"efighter_up1",
	"efighter_up1",
	"efighter",
	"efighter_up1",
	"efighter_up1",
	"efighter_up1",
	"efighter",
	"efighter_up1",
	"efighter_up1",
	"efighter_up1",
	"efighter",
	Orb,
	Orb,
	"efighter_up1",
	"efighter_up1",
	"efighter_up1",
	"efighter_up1",
	"efighter",
	"efighter",
	"efighter",
	Orb,
	Turret,
	Box,
	"efighter_up2",
	"efighter_up2",
	"efighter_up2",
	"efighter_up2",
	"efighter",
	"efighter",
	"efighter",
	"egunship2_up1",
	"egunship2",
	Orb,
	Orb,
	"egunship2",
	"efighter_up2",
	"egunship2",
	"efighter_up2",
	"efighter_up1",
	"efighter_up1",
	"efighter_up1",
	"egunship2_up1",
	"egunship2_up1",
	Orb,
	Box,
	"egunship2_up1",
	"efighter_up3",
	"egunship2_up1",
	"efighter_up3",
	"efighter_up2",
	"efighter_up2",
	"efighter_up2",
	"egunship2_up2",
	"egunship2_up2",
	Orb,
}

local engineersAmphibious = {
	"ehbotengineer",
	Orb,
	Orb,
	Turret,
	Orb,
	Box,
	"eamphibmedtank_up3",
	"eamphibriot_up3",
	"eamphibmedtank_up3",
	"eamphibriot_up3",
	"eamphibneedle_up3",
	"eamphibneedle_up3",
	"eamphibneedle_up3",
	"eamphibarty_up3",
	"eamphibmedtank_up3",
	Orb,
	Orb,
	Box,
	"eamphibmedtank_up3",
	"eamphibriot_up3",
	"eamphibmedtank_up3",
	"eamphibriot_up3",
	"eamphibneedle_up3",
	"eamphibneedle_up3",
	"eamphibneedle_up3",
	"eamphibarty_up3",
	"eamphibmedtank_up3",
	Orb,
	Orb,
	Orb,
	Orb,
	Orb,
	"eamphibleveler_up3",
	Orb,
	Box,
}

local engineersHover = {
	"ehbotengineer",
	Orb,
	Orb,
	Turret,
	Orb,
	Box,
	"eheavytank3_up3",
	"eriottank2_up3",
	"eheavytank3_up3",
	"eriottank2_up3",
	"eheavytank3_up3",
	"eheavytank3_up3",
	"eheavytank3_up3",
	"eartytank_up3",
	"eheavytank3_up3",
	Orb,
	Orb,
	Box,
	"eheavytank3_up3",
	"eriottank2_up3",
	"eheavytank3_up3",
	"eriottank2_up3",
	"eheavytank3_up3",
	"eheavytank3_up3",
	"eheavytank3_up3",
	"eartytank_up3",
	"eheavytank3_up3",
	Orb,
	Orb,
	Orb,
	Orb,
	Orb,
	"elacerator_up3",
	Orb,
	Box,
}

local engineersSpider = {
	"ehbotengineer",
	Orb,
	Orb,
	Turret,
	Orb,
	Box,
	"eallterrheavy_up3",
	"eallterrriot_up3",
	"eallterrheavy_up3",
	"eallterrriot_up3",
	"eallterrmed_up3",
	"eallterrmed_up3",
	"eallterrmed_up3",
	"eallterrassault_up3",
	"eallterrheavy_up3",
	Orb,
	Orb,
	Box,
	"eallterrheavy_up3",
	"eallterrriot_up3",
	"eallterrheavy_up3",
	"eallterrriot_up3",
	"eallterrmed_up3",
	"eallterrmed_up3",
	"eallterrmed_up3",
	"eallterrassault_up3",
	"eallterrheavy_up3",
	Orb,
	Orb,
	Orb,
	Orb,
	Orb,
	"eallterranarchid_up3",
	Orb,
	Box,
}

local engineersHBot = {
	"ehbotengineer",
	Orb,
	Orb,
	Turret,
	Orb,
	Box,
	"ehbotsniper_up3",
	"ehbotpeewee_up3",
	"ehbotsniper_up3",
	"ehbotpeewee_up3",
	"ehbotthud_up3",
	"ehbotthud_up3",
	"ehbotthud_up3",
	"ehbotrocko_up3",
	"ehbotsniper_up3",
	Orb,
	Orb,
	Box,
	"ehbotsniper_up3",
	"ehbotpeewee_up3",
	"ehbotsniper_up3",
	"ehbotpeewee_up3",
	"ehbotthud_up3",
	"ehbotthud_up3",
	"ehbotthud_up3",
	"ehbotrocko_up3",
	"ehbotsniper_up3",
	Orb,
	Box,
}

local engineersAir = {
	"ehbotengineer",
	Orb,
	Orb,
	Turret,
	Orb,
	Box,
	"egunship2_up3",
	"efighter_up3",
	"egunship2_up3",
	"efighter_up3",
	"efighter_up3",
	"efighter_up3",
	"efighter_up3",
	"egunship2_up3",
	"egunship2_up3",
	Orb,
	Orb,
	Box,
	"egunship2_up3",
	"efighter_up3",
	"egunship2_up3",
	"efighter_up3",
	"efighter_up3",
	"efighter_up3",
	"efighter_up3",
	"egunship2_up3",
	"egunship2_up3",
	Orb,
	Box,
}

local idlelist = {
	{ action = "wait", frames = 3000},
}

local defender = {
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"emine",
	"ehbotengineer",
	"eshieldgen",
}
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


local function engineerlist(beh)
   local r = math.random(0,4)
		if r == 0 then
			if ai.engineerfirst == true then
			return engineersAmphibious
			else
			ai.engineerfirst = true
			return firstEngineerAmphibious
			end
		elseif r == 1 then
			if ai.engineerfirst == true then
			return engineersSpider
			else
			ai.engineerfirst = true
			return firstEngineerSpider
			end
		elseif r == 2 then
			if ai.engineerfirst == true then
			return engineersHover
			else
			ai.engineerfirst = true
			return firstEngineerHover
			end
		elseif r == 3 then
			if ai.engineerfirst == true then
			return engineersHBot
			else
			ai.engineerfirst = true
			return firstEngineerHBot
			end
		else
			if ai.engineerfirst == true then
			return engineersAir
			else
			ai.engineerfirst = true
			return firstEngineerAir
			end
		end
	end
	taskqueues = {
   ecommanderbattleai = engineerlist,
   eaiturret = idlelist,
   ehbotengineer = defender,
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


