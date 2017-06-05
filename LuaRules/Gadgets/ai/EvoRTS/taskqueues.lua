--[[
Task Queues!
]]--

math.randomseed( os.time() )
math.random(); math.random(); math.random()

local function AirOrLand()
	local r = math.random(0,4)
	if r == 0 then
			return "eairplant"
		elseif r == 1 then
			return "ebasefactory"
		elseif r == 2 then
			return "eamphibfac"
		elseif r == 3 then
			return "eminifac"
		else
			return "ehbotfac"
	end
end

local function StartFactory()
	local r = math.random(0,2)
	if r == 0 then
			return "eminifac"
		elseif r == 1 then
			return "ebasefactory"
		else
			return "eamphibfac"
	end
end

local function Raid()
	local r = math.random(0,3)
	if r == 0 then
			return "eallterrlight"
		elseif r == 1 then
			return "eamphibbuggy"
		elseif r == 2 then
			return "ehbotpeewee"
		else
			return "elighttank3"
	end
end

local function EMP()
	local r = math.random(0,3)
	if r == 0 then
			return "eallterrriot"
		elseif r == 1 then
			return "eamphibriot"
		elseif r == 2 then
			return "eriottank2"
		else
			return "eamphibneedle"
	end
end

local function Arty()
	local r = math.random(0,3)
	if r == 0 then
			return "eallterrassault"
		elseif r == 1 then
			return "ehbotthud"
		elseif r == 2 then
			return "eartytank"
		else
			return "eamphibarty"
	end
end

local function Armor()
	local r = math.random(0,3)
	if r == 0 then
			return "eamphibmedtank"
		elseif r == 1 then
			return "eallterrmed"
		elseif r == 2 then
			return "eallterrheavy"
		else
			return "eheavytank3"
	end
end

local function Support()
	local r = math.random(0,4)
	if r == 0 then
			return "emissiletank"
		elseif r == 1 then
			return "ehbotsniper"
		elseif r == 2 then
			return "eamphibrock"
		elseif r == 3 then
			return "ehbotrocko"
		else
			return "eallterrshield"
	end
end

local function End()
	local r = math.random(0,2)
	if r == 0 then
			return "eallterranarchid"
		elseif r == 1 then
			return "eamphibleveler"
		else
			return "elacerator"
	end
end

local function Air()
	local r = math.random(0,2)
	if r == 0 then
			return "ebomber"
		elseif r == 1 then
			return "efighter"
		else
			return "egunship2"
	end
end

local factory = {
   "elighttank3",
   "elighttank3",
   "elighttank3",
   "elighttank3",
   "elighttank3",
   "eriottank2",
   "eriottank2",
   "eheavytank3",
   "eheavytank3",
   "eheavytank3",
   "eheavytank3",
   "eheavytank3",
   "emissiletank",
   "emissiletank",
   "emissiletank",
   "emissiletank",
   "emissiletank",
   "emissiletank",
   "emissiletank",
   "eartytank",
   "eartytank",
--   "eengineer5",
}

local firstEngineer = {
   { action = "wait", frames = 3000},
   "eorbai",
   "escout",
   "escout",
   "escout",
   "escout",
   "escout",
   "eorbai",
   "escout",
   "escout",
   "escout",
   "escout",
   "escout",
   "escout",
   "escout",
   "escout",
   "eorbai",
   Raid,
   Raid,
   Raid,
   Raid,
   "eorbai",
   Raid,
   Raid,
   Raid,
   Raid,
   "eorbai",
   "eorbai",
   "escout",
   Raid,
   Raid,
   Raid,
   "ebox",
   "eorbai",
   Raid,
   Raid,
   Raid,
   Raid,
   Raid,
   "ebox",
}

--local orbs = {
	--{ action = "moverelative", position = {x = math.random(-200, 200), y = math.random(-200, 200), z = math.random(-200, 200)} },
	--{ action = "moverelative", position = {x = math.random(-200, 200), y = math.random(-200, 200), z = math.random(-200, 200)} },
	--{ action = "moverelative", position = {x = math.random(-200, 200), y = math.random(-200, 200), z = math.random(-200, 200)} },
	--{ action = "moverelative", position = {x = math.random(-200, 200), y = math.random(-200, 200), z = math.random(-200, 200)} },
--}

local engineers = {
	"eorbai",
	Arty,
    Arty,
    Arty,
	"eorbai",
    Arty,
    Arty,
	Arty,
	Arty,
	"ebox",
	Arty,
	Arty,
	Arty,
	Arty,
	"eorbai",
	Arty,
	Arty,
	Arty,
    "eorbai",
	Air,
	Air,
	Air,
	Air,
    Air,
	Air,
	"eorbai",
	Air,
	Air,
	"eorbai",
	Armor,
    Armor,
    Armor,
	"eorbai",
    Armor,
    Armor,
	Armor,
	Armor,
	"ebox",
	Armor,
	Armor,
	Armor,
	Armor,
	"eorbai",
	Armor,
	Armor,
	Armor,
    "eorbai",
	Support,
	Support,
	Support,
	Support,
    Support,
	Support,
	"eorbai",
	Support,
	Support,
	"eorbai",
	Armor,
    Support,
    Arty,
	"eorbai",
    Armor,
    Armor,
	Support,
	Armor,
	"ebox",
	Armor,
	Arty,
	Armor,
	Armor,
	"eorbai",
	Armor,
	Support,
	Armor,
    "eorbai",
	End,
	End,
	End,
	End,
    End,
	End,
	"eorbai",
	End,
	End,
}

local airplant = {
   "egunship2",
   "egunship2",
   "egunship2",
   "egunship2",
   "efighter",
   "efighter",
   "ebomber",
   "ebomber",
   "egunship2",
   "egunship2",
   "egunship2",
   "egunship2",
   "efighter",
   "efighter",
   "ebomber",
   "ebomber",
--   "eairengineer",
}

local amphibfactory = {
   "eamphibbuggy",
   "eamphibbuggy",
   "eamphibbuggy",
   "eamphibbuggy",
   "eamphibbuggy",
   "eamphibriot",
   "eamphibriot",
   "eamphibneedle",
   "eamphibneedle",
   "eamphibneedle",
   "eamphibneedle",
   "eamphibmedtank",
   "eamphibmedtank",
   "eamphibmedtank",
   "eamphibrock",
   "eamphibrock",
   "eamphibrock",
   "eamphibrock",
   "eamphibrock",
   "eamphibrock",
   "eamphibarty",
   "eamphibarty",
--   "eamphibengineer",
}

local allterrfactory = {
   "eallterrlight",
   "eallterrlight",
   "eallterrlight",
   "eallterrlight",
   "eallterrlight",
   "eallterrriot",
   "eallterrriot",
   "eallterrmed",
   "eallterrmed",
   "eallterrmed",
   "eallterrmed",
   "eallterrheavy",
   "eallterrheavy",
   "eallterrheavy",
   "eallterrheavy",
   "eallterrheavy",
   "eallterrheavy",
   "eallterrassault",
--   "eallterrengineer",
}

local function engineerlist(beh)
   if ai.engineerfirst == true then
      return engineers
   else
      ai.engineerfirst = true
      return firstEngineer
   end
end

--local function orblist(brr)
    --return orbs
--end

taskqueues = {
   ecommanderbattleai = engineerlist,
   ebasefactory = factory,
   eengineer5 = engineerlist,
   eallterrengineer = engineerlist,
   eamphibengineer = engineerlist,
   eairengineer = engineerlist,
   eairplant = airplant,
   eamphibfac = amphibfactory,
   eminifac = allterrfactory,
   --eorb = orblist,
}
