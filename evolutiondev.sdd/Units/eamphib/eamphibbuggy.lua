-- UNITDEF -- EAMPHIBBUGGY --
--------------------------------------------------------------------------------

local unitName = "eamphibbuggy"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 18,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT AMPHIB RAID",
  corpse             = "ammobox",
  description        = [[Scout/Raider
Light, 200% Damage vs Light
	• Can fire while underwater

Requires +1 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_UNIT",
  footprintX         = 2,
  footprintZ         = 2,
  iconType           = "amphib",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 160,
  maxSlope           = 28,
  maxVelocity        = 6.0,
  maxReverseVelocity = 2,
  maxWaterDepth      = 5000,
  metalStorage       = 0,
  movementClass      = "TANK2",
  name               = "Snake (B)",
  noChaseCategory    = "VTOL",
  objectName         = "eamphibbuggy.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "SMALL_UNIT",
  sightDistance      = 1000,
  SonarDistance        = 1000,
  stealth			 = true,
  sonarStealth		 = false,
  smoothAnim         = true,
  seismicDistance    = 1000,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 6.0,
  turnRate           = 1000,
--  turnrate           = 475,
  unitname           = "eamphibbuggy",
  workerTime         = 0,

    sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:factorysparks",
      "custom:dirt",
	  "custom:blacksmoke",
    },
  },
  sounds = {
    underattack        = "unitsunderattack1",
    ok = {
      "ack",
    },
    select = {
      "unitselect",
    },
  },
  weapons = {
    [1]  = {
      def                = "lightbeamlaser",
	  badTargetCategory  = "ARMORED BUILDING",
    },
--[[	
	[2]  = {
      def                = "TORP",
    },
]]--
  },
   customParams = {
    needed_cover = 1,
   	death_sounds = "soldier",
	twokhotkey = 'b',
    RequireTech = "1 Power",
	armortype   = "light",
	normaltex = "unittextures/eamphibbuggynormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
    lightlaser = {
	badTargetCategory = [[ARMORED BUILDING VTOL]],
    accuracy           = 200,
    AreaOfEffect       = 8,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.2,
    duration           = 0.1,
    energypershot      = 0.6,
    explosionGenerator = "custom:burn",
	energypershot      = 1.2,
    fallOffRate        = 1,
    fireStarter        = 50,
	interceptedByShieldType = 4,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    range              = 300,
    reloadtime         = 0.1,
    WeaponType         = "LaserCannon",
    rgbColor           = "0.5 0 0",
    rgbColor2          = "0.8 0.8 0.8",
    soundTrigger       = true,
    soundstart         = "18383_inferno_knokart.wav",
    texture1           = "plasmaball",
    texture2           = "empty",
    thickness          = 2,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 1000,
	customparams = {
	  damagetype		= "raiderlight",  
    }, 
    damage = {
      default           = 12,
    },
  },
  
  lightbeamlaser = {
	badTargetCategory = [[ARMORED BUILDING VTOL]],
	TargetMoveError	   = 0.3,
    AreaOfEffect       = 0,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.2,
    beamlaser          = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.2,
    duration           = 0.2,
    explosionGenerator = "custom:burn",
	energypershot      = 1.6,
    fallOffRate        = 1,
    fireStarter        = 50,
	interceptedByShieldType = 4,
    lineOfSight        = true,
	laserflaresize 	   = 5,
	largebeamlaser	   = true,
    minintensity       = 1,
    name               = "Laser",
    range              = 300,
    reloadtime         = 0.2,
    WeaponType         = "BeamLaser",
    rgbColor           = "0.5 0 0",
    rgbColor2          = "0.8 0.8 0.8",
    soundTrigger       = true,
    soundstart         = "amphibbuggytankshothit.wav",
--	soundHit		   = "amphibbuggytankshothit.wav",
	scrollspeed		   = 5,
    texture1           = "lightning",
    texture2           = "laserend",
    thickness          = 5,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 1000,
	waterweapon		   = true,
	customparams = {
	  damagetype		= "raiderlight",  
    }, 
    damage = {
      default           = 16, -- multiply * 1.2 for correct dps output
    },
  },
  
  TORP = {
	cegtag			= "torpedotrailsmall",
	weaponType		   = "TorpedoLauncher",
	lineofsight		= 1,
	turret			= 1,
    model              = "torpedo.s3o",
    energypershot      = 2,
	propeller		= 1,
	range			= 400,
	reloadtime		= 1,
	weapontimer		= 3,
	weaponvelocity	= 500,
	startvelocity	= 125,
	weaponacceleration	= 100,
	AreaOfEffect	= 16,
    soundHit           = "subhit.wav",
    soundStart         = "torpedolaunch.wav",
    explosionGenerator = "custom:torpedoexplosion",
	selfprop		= 1,
	waterweapon		= 1,
	burnblow		= 1,
	predictboost	= 0,
	impulsefactor	= 0,
	cratermult		= 0,
	craterboost		= 0,
	noselfdamage	= 1,
	avoidfriendly	= 0,
	collidefriendly	= 0,
	customparams = {
		death_sounds = "generic",
	  damagetype		= "raiderlight",  
    }, 
    damage = {
      default            = 40,
    },
  },  
}
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
