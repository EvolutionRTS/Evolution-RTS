--[[
Task Queues!
]]--

math.randomseed( os.time() )
math.random(); math.random(); math.random()

local function AirOrLand()
	local r = math.random(0,3)
	if r == 0 then
			return "eairplant"
		elseif r == 1 then
			return "ebasefactory"
		elseif r == 2 then
			return "eamphibfac"
		else 
			return "eminifac"
	end
end

local function StartFactory()
	local r = math.random(0,3)
	if r == 0 then
			return "eairplant"
		elseif r == 1 then
			return "ebasefactory"
		elseif r == 2 then
			return "eamphibfac"
		else 
			return "eminifac"
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
   "eengineer5",
}

local firstEngineer = {
	--{action = "wait", frames = 30}
   AirOrLand,
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "emediumgen",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "estorage",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "estorage",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "estorage",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "estorage",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "emediumgen",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "efusion2",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "efusion2",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "efusion2",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "efusion2",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
--   "ecruisesilo",
}

local engineers = {
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "emediumgen",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "estorage",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "estorage",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "estorage",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   AirOrLand,
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "estorage",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "emediumgen",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "efusion2",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "efusion2",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "efusion2",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
   "efusion2",
   { action = "moverelative", position = {x = math.random(-750, 750), y = math.random(-750, 750), z = math.random(-750, 750)} },
--   "ecruisesilo",
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
   "eairengineer",
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
   "eamphibengineer",
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
   "eallterrengineer",
}

local function engineerlist(beh)
   if ai.engineerfirst == true then
      return engineers
   else
      ai.engineerfirst = true
      return firstEngineer
   end
end

taskqueues = {
   ecommanderai = engineerlist,
   ebasefactory = factory,
   eengineer5 = engineerlist,
   eallterrengineer = engineerlist,
   eamphibengineer = engineerlist,
   eairengineer = engineerlist,
   eairplant = airplant,
   eamphibfac = amphibfactory,
   eminifac = allterrfactory,
}
