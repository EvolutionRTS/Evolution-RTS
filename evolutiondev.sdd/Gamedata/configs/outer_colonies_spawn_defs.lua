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
  eamphibaa		= true,
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

addWave(1,{"1 eaatank"})
addWave(1,{"1 elighttank3"})
addWave(1,{"1 eamphibbuggy"})
addWave(1,{"1 eallterrlight"})

addWave(2,{"2 elighttank3"})
addWave(2,{"1 eheavytank3"})
addWave(2,{"1 amphibmedtank"})
addWave(2,{"2 eaatank"})

addWave(3,{"2 elighttank3"})
addWave(3,{"1 eheavytank3"})
addWave(3,{"1 emissiletank"})
addWave(3,{"2 eaatank"})

addWave(4,{"2 elighttank3"})
addWave(4,{"1 eheavytank3"})
addWave(4,{"1 emissiletank"})
addWave(4,{"2 eamphibaa"})
addWave(4,{"2 ebomb"})
addWave(4,{"2 eaatank"})

addWave(5,{"2 elighttank3"})
addWave(5,{"2 eamphibmedtank"})
addWave(5,{"2 eaatank"})

addWave(6,{"2 elighttank3"})
addWave(6,{"1 eriottank2"})
addWave(6,{"1 eheavytank3"})
addWave(6,{"1 eallterrheavy"})
addWave(6,{"1 eartytank"})
addWave(6,{"2 eaatank"})

addWave(7,{"2 egunship2"})
addWave(7,{"1 ebomber"})

addWave(8,{"2 eallterrlight"})
addWave(8,{"1 eriottank2"})
addWave(8,{"1 eheavytank3"})
addWave(8,{"1 eamphibmedtank"})
addWave(8,{"2 eamphibrock"})
addWave(6,{"3 eartytank"})
addWave(6,{"3 eallterrassault"})
addWave(6,{"3 eamphibarty"})
addWave(8,{"2 eamphibaa"})
addWave(8,{"1 ebomber"})

addWave(9,{"3 elighttank3"})
addWave(9,{"3 eamphibbuggy"})
addWave(9,{"3 eallterrlight"})

addWave(10,{"5 egunship2"})
addWave(10,{"5 ebomber"})
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
    chickensPerPlayer = 12,
    spawnChance      = 0.5,
  },


  ['Survival Spawner: Very Hard'] = {
    chickenSpawnRate = 15,
    burrowSpawnRate  = 20,
    queenSpawnMult   = 3,
    angerBonus       = 30,
    expStep 		 = 0.4,
    lobberEMPTime    = 7.5,
    chickenTypes     = Copy(chickenTypes),
    defenders        = Copy(defenders),
    chickensPerPlayer = 24,
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

