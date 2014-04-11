---------------------------------------------------------------------------------
--------------------------------------------------------------------------------
maxChicken           = tonumber(Spring.GetModOptions().mo_maxchicken) or 25
maxBurrows           = 10
gracePeriod          = 300  -- no chicken spawn in this period, seconds
queenTime            = (Spring.GetModOptions().mo_queentime or 40) * 60 -- time at which the queen appears, seconds
addQueenAnger        = tonumber(Spring.GetModOptions().mo_queenanger) or 1
burrowSpawnType      = Spring.GetModOptions().mo_chickenstart or "avoid"
spawnSquare          = 500       -- size of the chicken spawn square centered on the burrow
spawnSquareIncrement = 4         -- square size increase for each unit spawned
burrowName           = "burrow"   -- burrow unit name
maxAge               = 120      -- chicken die at this age, seconds
queenName 		     = Spring.GetModOptions().mo_queendifficulty or "queen"
burrowDef            = UnitDefNames[burrowName].id
defenderChance       = 0.5       -- probability of spawning a single turret
maxTurrets           = 6   		 -- Max Turrets per burrow
queenSpawnMult       = 1         -- how many times bigger is a queen hatch than a normal burrow hatch
burrowSpawnRate      = 20
chickenSpawnRate     = 30
minBaseDistance      = 1000      
maxBaseDistance      = 7200
chickensPerPlayer    = 1
spawnChance          = 0.5
bonusTurret          = "eaaturret" -- Turret that gets spawned when a burrow dies
angerBonus           = 204
expStep 			 = 0.0625
lobberEMPTime        = 4
waves         = {}

chickenSwitches	= {}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local function Copy(original)
  local copy = {} 
  for k, v in pairs(original) do
    if (type(v) == "table") then
      copy[k] = Copy(v)
    else
      copy[k] = v
    end
  end
  return copy
end

local function addWave(wave, unitList)
 if not waves[wave] then waves[wave] = {} end
 table.insert(waves[wave], unitList)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local chickenTypes = {
  elighttank3	=  true,
  eriottank2	=  true,
  eheavytank3	=  true,
  emissiletank	=  true,
  eaatank		=  true,
  eartytank		=  true,
  efatso2		=  true,
  ebomb			=  true,
  eallterrassault	=  true,
  eallterrheavy	=  true,
  eallterrlight	=  true,
  eallterrmed	=  true,
  eallterrriot	=  true,
  eallterrshield	=  true,
  ebomber		=  true,
  edrone		=  true,
  efighter		=  true,
  egunship2		=  true,
  eamphibarty	=  true,
  eamphibbuggy	=  true,
  eamphibmedtank	=  true,
  eamphibriot	=  true,
  eamphibrock	=  true,
  eexkrabgroth	=  true,
  eextankdestroyer = true,
  
}

chickenSwitches	= {
	[1] = {
		ebomber	=  "edrone",	
		egunship2	=  "edrone",	
		efighter	=  "edrone",	
		eamphibarty	=  "elighttank3",	
		ebomb	=  "elighttank3",
		efatso2	=  "elighttank3",
	},
	
	[2] = {
		ebomber		=  "edrone",
		egunship2	=  "edrone",	
		ebomb		=  "elighttank3",		
	},
	
	[3] = {
		ebomber	=  "edrone",
	},
	
	[4] = {
		edrone	=  "efighter",
	},
	
	[5] = {
		edrone	=  "efighter",
	},
}

local defenders = { 
  elightturret2 = true,
  eheavyturret2 = true,
  eaaturret		= true,
  ekmar			= true,
}

addWave(1,{"10 eaatank"})
addWave(1,{"3 elighttank3"})
addWave(1,{"3 eallterrlight"})
addWave(1,{"3 eamphibbuggy"})
addWave(1,{"3 elighttank3"})
addWave(1,{"3 elighttank3"})
addWave(1,{"3 elighttank3", "2 eriottank2"})
addWave(1,{"3 eamphibbuggy", "2 eamphibmedtank"})

addWave(2,{"3 edrone", "2 egunship2", "2 ebomber"})
addWave(2,{"7 elighttank3"})
addWave(2,{"5 eheavytank3"})
addWave(2,{"4 eamphibbuggy", "2 eamphibmedtank", "3 eamphibrock"})
addWave(2,{"3 eallterrmed"})
addWave(2,{"4 eallterrlight", "2 eallterrriot"})
addWave(2,{"4 eheavytank3", "6 eheavytank3"})
addWave(2,{"5 eamphibmedtank", "3 eamphibarty"})
addWave(2,{"4 eallterrheavy", "3 eallterrassault"})

addWave(3,{"5 emissiletank", "4 efatso2"})
addWave(3,{"3 edrone", "3 egunship2", "3 ebomber"})
addWave(3,{"8 eaatank", "5 elighttank3"})
addWave(3,{"5 eheavytank3"})
addWave(3,{"4 eamphibbuggy", "4 eamphibmedtank", "4 eamphibrock"})
addWave(3,{"8 eallterrmed"})
addWave(3,{"4 eallterrlight", "3 eallterrriot"})
addWave(3,{"4 eheavytank3", "6 eheavytank3"})
addWave(3,{"5 eamphibmedtank", "3 eamphibarty"})
addWave(3,{"4 eallterrheavy", "3 eallterrassault"})

addWave(4,{"5 ebomb"})
addWave(4,{"5 ebomb"})
addWave(4,{"5 ebomb"})
addWave(4,{"5 ebomb"})
addWave(4,{"5 ebomb"})
addWave(4,{"5 ebomb"})
addWave(4,{"5 ebomb"})
addWave(4,{"5 ebomb"})
addWave(4,{"5 ebomb"})
addWave(4,{"5 ebomb"})
addWave(4,{"5 ebomb"})

addWave(5,{"7 elighttank3"})
addWave(5,{"6 eartytank"})
addWave(5,{"8 efatso2", "8 eallterrassault"})
addWave(5,{"5 emissiletank", "8 eheavytank3", "5 eheavytank3"})
addWave(5,{"10 eallterrheavy", "12 eallterrriot", "15 eallterrlight"})
addWave(5,{"5 ebomb"})
addWave(5,{"15 elighttank3"})
addWave(5,{"10 eartytank"})
addWave(5,{"7 efatso2", "10 eallterrassault"})
addWave(5,{"5 emissiletank", "8 eheavytank3", "5 eheavytank3"})
addWave(5,{"10 eallterrheavy", "12 eallterrriot", "12 eallterrlight"})
addWave(5,{"1 eextankdestroyer"})

addWave(6,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(6,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(6,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(6,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(6,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(6,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(6,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(6,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(6,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(6,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(6,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})

addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(7,{"4 ebomber", "4 egunship2", "3 efighter"})

addWave(8,{"10 edrone"})
addWave(8,{"10 edrone"})
addWave(8,{"10 edrone"})
addWave(8,{"10 edrone"})
addWave(8,{"10 edrone"})
addWave(8,{"10 edrone"})
addWave(8,{"10 edrone"})
addWave(8,{"10 edrone"})
addWave(8,{"10 edrone"})
addWave(8,{"10 edrone"})
addWave(8,{"10 edrone"})

addWave(9,{"10 elighttank3"})
addWave(9,{"10 elighttank3"})
addWave(9,{"10 elighttank3"})
addWave(9,{"10 elighttank3"})
addWave(9,{"10 elighttank3"})
addWave(9,{"10 elighttank3"})
addWave(9,{"10 elighttank3"})
addWave(9,{"10 elighttank3"})
addWave(9,{"10 elighttank3"})
addWave(9,{"10 elighttank3"})
addWave(9,{"10 elighttank3"})

addWave(10,{"5 ebomb"})
addWave(10,{"5 ebomb"})
addWave(10,{"5 ebomb"})
addWave(10,{"5 ebomb"})
addWave(10,{"5 ebomb"})
addWave(10,{"5 ebomb"})
addWave(10,{"5 ebomb"})
addWave(10,{"5 ebomb"})
addWave(10,{"5 ebomb"})
addWave(10,{"5 ebomb"})
addWave(10,{"5 ebomb"})
addWave(10,{"7 elighttank3"})
addWave(10,{"6 eartytank"})
addWave(10,{"8 efatso2", "8 eallterrassault"})
addWave(10,{"5 emissiletank", "8 eheavytank3", "5 eheavytank3"})
addWave(10,{"10 eallterrheavy", "12 eallterrriot", "15 eallterrlight"})
addWave(10,{"5 ebomb"})
addWave(10,{"15 elighttank3"})
addWave(10,{"10 eartytank"})
addWave(10,{"7 efatso2", "10 eallterrassault"})
addWave(10,{"5 emissiletank", "8 eheavytank3", "5 eheavytank3"})
addWave(10,{"10 eallterrheavy", "12 eallterrriot", "12 eallterrlight"})
addWave(10,{"1 eextankdestroyer"})
addWave(10,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(10,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(10,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(10,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(10,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(10,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(10,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(10,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(10,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(10,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(10,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(10,{"2 eexkrabgroth", "1 eextankdestroyer"})
addWave(10,{"2 eextankdestroyer", "1 eexkrabgroth"})
addWave(10,{"3 eexkrabgroth"})

addWave(11,{"50 eallterrheavy", "50 eallterrriot", "50 eallterrlight"})

addWave(12,{"5 ebomb"})
addWave(12,{"5 ebomb"})
addWave(12,{"5 ebomb"})
addWave(12,{"5 ebomb"})
addWave(12,{"5 ebomb"})
addWave(12,{"5 ebomb"})
addWave(12,{"5 ebomb"})
addWave(12,{"5 ebomb"})
addWave(12,{"5 ebomb"})
addWave(12,{"5 ebomb"})
addWave(12,{"5 ebomb"})
addWave(12,{"7 elighttank3"})
addWave(12,{"6 eartytank"})
addWave(12,{"8 efatso2", "8 eallterrassault"})
addWave(12,{"5 emissiletank", "8 eheavytank3", "5 eheavytank3"})
addWave(12,{"10 eallterrheavy", "12 eallterrriot", "15 eallterrlight"})
addWave(12,{"5 ebomb"})
addWave(12,{"15 elighttank3"})
addWave(12,{"10 eartytank"})
addWave(12,{"7 efatso2", "10 eallterrassault"})
addWave(12,{"5 emissiletank", "8 eheavytank3", "5 eheavytank3"})
addWave(12,{"10 eallterrheavy", "12 eallterrriot", "12 eallterrlight"})
addWave(12,{"1 eextankdestroyer"})
addWave(12,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(12,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(12,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(12,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(12,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(12,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(12,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(12,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(12,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(12,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(12,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})

addWave(13,{"5 ebomb"})
addWave(13,{"5 ebomb"})
addWave(13,{"5 ebomb"})
addWave(13,{"5 ebomb"})
addWave(13,{"5 ebomb"})
addWave(13,{"5 ebomb"})
addWave(13,{"5 ebomb"})
addWave(13,{"5 ebomb"})
addWave(13,{"5 ebomb"})
addWave(13,{"5 ebomb"})
addWave(13,{"5 ebomb"})
addWave(13,{"7 elighttank3"})
addWave(13,{"6 eartytank"})
addWave(13,{"8 efatso2", "8 eallterrassault"})
addWave(13,{"5 emissiletank", "8 eheavytank3", "5 eheavytank3"})
addWave(13,{"10 eallterrheavy", "12 eallterrriot", "15 eallterrlight"})
addWave(13,{"5 ebomb"})
addWave(13,{"15 elighttank3"})
addWave(13,{"10 eartytank"})
addWave(13,{"7 efatso2", "10 eallterrassault"})
addWave(13,{"5 emissiletank", "8 eheavytank3", "5 eheavytank3"})
addWave(13,{"10 eallterrheavy", "12 eallterrriot", "12 eallterrlight"})
addWave(13,{"1 eextankdestroyer"})
addWave(13,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(13,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(13,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(13,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(13,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(13,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(13,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(13,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(13,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(13,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(13,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})

addWave(14,{"5 ebomb"})
addWave(14,{"5 ebomb"})
addWave(14,{"5 ebomb"})
addWave(14,{"5 ebomb"})
addWave(14,{"5 ebomb"})
addWave(14,{"5 ebomb"})
addWave(14,{"5 ebomb"})
addWave(14,{"5 ebomb"})
addWave(14,{"5 ebomb"})
addWave(14,{"5 ebomb"})
addWave(14,{"5 ebomb"})
addWave(14,{"7 elighttank3"})
addWave(14,{"6 eartytank"})
addWave(14,{"8 efatso2", "8 eallterrassault"})
addWave(14,{"5 emissiletank", "8 eheavytank3", "5 eheavytank3"})
addWave(14,{"10 eallterrheavy", "12 eallterrriot", "15 eallterrlight"})
addWave(14,{"5 ebomb"})
addWave(14,{"15 elighttank3"})
addWave(14,{"10 eartytank"})
addWave(14,{"7 efatso2", "10 eallterrassault"})
addWave(14,{"5 emissiletank", "8 eheavytank3", "5 eheavytank3"})
addWave(14,{"10 eallterrheavy", "12 eallterrriot", "12 eallterrlight"})
addWave(14,{"1 eextankdestroyer"})
addWave(14,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(14,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(14,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(14,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(14,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(14,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(14,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(14,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(14,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(14,{"10 eallterrriot", "5 emissiletank", "3 efatso2", "5 eallterrheavy"})
addWave(14,{"10 elighttank3", "5 eallterrheavy", "4 eaatank"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"4 ebomber", "4 egunship2", "3 efighter"})
addWave(14,{"10 edrone"})
addWave(14,{"10 edrone"})
addWave(14,{"10 edrone"})
addWave(14,{"10 edrone"})
addWave(14,{"10 edrone"})
addWave(14,{"10 edrone"})
addWave(14,{"10 edrone"})
addWave(14,{"10 edrone"})
addWave(14,{"10 edrone"})
addWave(14,{"10 edrone"})
addWave(14,{"10 edrone"})
--------------------------------------------------------------------------------
difficulties = {
  ['Survival Spawner: Very Easy'] = {
    chickenSpawnRate = 130, 
    burrowSpawnRate  = 100,
    queenSpawnMult   = 0,
    angerBonus       = 20,
    expStep 		 = 0,
    lobberEMPTime    = 0,
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
    chickensPerPlayer = 1,
    spawnChance      = 0.25,
  },
  ['Survival Spawner: Easy'] = {
    chickenSpawnRate = 90, 
    burrowSpawnRate  = 50,
    queenSpawnMult   = 0.5,
    angerBonus       = 20,
    expStep 		 = 0.09375,
    lobberEMPTime    = 2.5,
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
    chickensPerPlayer = 2,
    spawnChance      = 0.33,
  },

  ['Survival Spawner: Normal'] = {
    chickenSpawnRate = 45,
    burrowSpawnRate  = 30,
    queenSpawnMult   = 1,
    angerBonus       = 25,
    expStep 		 = 0.125,
    lobberEMPTime    = 4,
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
    chickensPerPlayer = 4,
    spawnChance      = 0.4,
  },

  ['Survival Spawner: Hard'] = {
    chickenSpawnRate = 30,
    burrowSpawnRate  = 20,
    queenSpawnMult   = 2,
    angerBonus       = 30,
    expStep 		 = 0.25,
    lobberEMPTime    = 5,
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
    chickensPerPlayer = 8,
    spawnChance      = 0.5,
  },


  ['Survival Spawner: Very Hard'] = {
    chickenSpawnRate = 20,
    burrowSpawnRate  = 20,
    queenSpawnMult   = 3,
    angerBonus       = 30,
    expStep 		 = 0.4,
    lobberEMPTime    = 7.5,
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
    chickensPerPlayer = 16,
    spawnChance      = 0.6,
  },

  ['Survival Spawner: Custom'] = {
    chickenSpawnRate = tonumber(Spring.GetModOptions().mo_custom_chickenspawn),
    burrowSpawnRate  = tonumber(Spring.GetModOptions().mo_custom_burrowspawn),
    queenSpawnMult   = tonumber(Spring.GetModOptions().mo_custom_queenspawnmult),
    angerBonus       = tonumber(Spring.GetModOptions().mo_custom_angerbonus),
    expStep 		 = (tonumber(Spring.GetModOptions().mo_custom_expstep) or 0.6) * -1,
    lobberEMPTime    = tonumber(Spring.GetModOptions().mo_custom_lobberemp),
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
    chickensPerPlayer = tonumber(Spring.GetModOptions().mo_custom_minchicken),
    spawnChance      = (tonumber(Spring.GetModOptions().mo_custom_spawnchance) or 50) / 100,
  },
}

defaultDifficulty = 'Survival Spawner: Normal'
--------------------------------------------------------------------------------

