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
   "eengineer5",
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
   "eengineer5",
   "emissiletank",
   "emissiletank",
   "emissiletank",
   "emissiletank",
   "emissiletank",
   "emissiletank",
   "emissiletank",
   "eartytank",
   "eartytank",
}

local firstEngineer = {
   AirOrLand,
   "eorb",
   "emediumgen",
   "emediumgen",
   "elightturret2",
   "eorb",
   "emediumgen",
   "eheavyturret2",
   "eorb",
   "emediumgen",
   "efusion2",
   "emediumgen",
   "eheavyturret2",
--   "ecruisesilo",
}

local engineers = {
   "emediumgen",
   "emediumgen",
   "elightturret2",
   AirOrLand,
   "eorb",
   "emediumgen",
   "emediumgen",
   "efusion2",
   "eheavyturret2",
--   "ecruisesilo",
}

local airplant = {
   "eairengineer",
   "egunship2",
   "egunship2",
   "egunship2",
   "egunship2",
   "efighter",
   "efighter",
   "ebomber",
   "ebomber",
}

local amphibfactory = {
   "eamphibengineer",
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
	"eamphibengineer",
   "eamphibrock",
   "eamphibrock",
   "eamphibrock",
   "eamphibrock",
   "eamphibrock",
   "eamphibrock",
   "eamphibarty",
   "eamphibarty",
}

local allterrfactory = {
   "eallterrengineer",
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
   "eallterrengineer",
   "eallterrheavy",
   "eallterrheavy",
   "eallterrheavy",
   "eallterrheavy",
   "eallterrheavy",
   "eallterrheavy",
   "eallterrassault",
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
