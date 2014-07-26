-- UNITDEF -- EAMPHIBROCK --
--------------------------------------------------------------------------------

local unitName = "eamphibrock"

--------------------------------------------------------------------------------

local unitDef = {

--mobileunit 
  transportbyenemy   = false;

--**


  acceleration       = 1,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 34,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT AMPHIB SUPPORT",
  corpse             = "ammobox",
  description        = [[Missile support tank
Light
200 Damage vs Armored
100 Damage vs Light/Building

Requires +5 Power
Uses +5 Supply]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "mediumExplosionGeneric",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "tankdestroyer",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 320,
  maxSlope           = 28,
  maxVelocity        = 3.4,
  maxReverseVelocity = 1,
  maxWaterDepth      = 5000,
  metalStorage       = 0,
  movementClass      = "TANK4",
  name               = "Spitter",
  noChaseCategory    = "VTOL",
  objectName         = "eamphibrock4.s3o",
  script			 = "eamphibrock4.cob",
  onlytargetcategory2 = "VTOL",
  onlytargetcategory3 = "VTOL",
  onlytargetcategory4 = "VTOL",
  onlytargetcategory5 = "VTOL",
  onlytargetcategory6 = "VTOL",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "mediumExplosionGeneric",
  side               = "CORE",
  sightDistance      = 650,
  SonarDistance      = 650,
  stealth			 = true,
  seismicSignature   = 2,
  sonarStealth		 = false,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 3.4,
  turnInPlace        = true,
  turnRate           = 5000,
--  turnrate           = 430,
  unitname           = "eamphibrock",
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:dirt",
	  "custom:blacksmoke",
	  "custom:jethtrail",
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
      def                = "antiarmorrockets",
      onlyTargetCategory = "NOTAIR AMPHIB",
	  badTargetCategory  = "BUILDING LIGHT WALL",
    },
    [2]  = {
      def                = "antiarmorrocketssalvo",
      onlyTargetCategory = "NOTAIR AMPHIB",
	  badTargetCategory  = "BUILDING LIGHT WALL",
    },
  },
   customParams = {
	canareaattack="1",
    needed_cover = 2,
   	death_sounds = "generic",
    RequireTech = "5 Power",
	armortype   = "light",
	nofriendlyfire	= "1",
	supply_cost = 5,
	normalstex = "unittextures/lego2skin_explorernormal.dds", 
	 buckettex = "unittextures/lego2skin_explorerbucket.dds",
	factionname	= "outer_colonies",   
  },
}


--------------------------------------------------------------------------------
local weapon1Damage = 200
local weapon2Damage = 200
local weapon2Burst = 5

local weaponDefs = {

  antiarmorrockets = {
    AreaOfEffect       = 1,
	avoidFriendly      = false,
    avoidFeature       = false,
	collideFriendly    = false,
    collideFeature     = false,
    cegTag             = "missiletrailsmall",
    explosionGenerator = "custom:genericshellexplosion-medium-red",
	energypershot      = weapon1Damage / 20,
    fireStarter        = 70,
    tracks             = true,
	impulseFactor      = 0,
    interceptedByShieldType = 4,
    model              = "missilesmalllauncher.s3o",
    name               = "Rockets",
    range              = 700,
    reloadtime         = 1,
    weaponType		   = "MissileLauncher",
    smokeTrail         = false,
    soundStart         = "rocket1.wav",
    soundHit           = "explode5.wav",
    startVelocity      = 250,
    tolerance          = 8000,
    turnrate           = 2500,
	predictBoost	   = 0.5,
    turret             = true,
    weaponAcceleration = 50,
    flightTime         = 5,
	trajectoryHeight   = 1.5,
    weaponVelocity     = 500,
	customparams = {
	  damagetype		= "eamphibrock",  

	  --Upgrades--
	  upgradeClass		= "groundweapons",
    },     
    damage = {
      default           = weapon1Damage,
    },
  },
  
  antiarmorrocketssalvo = {
    AreaOfEffect       = 1,
	avoidFriendly      = false,
    avoidFeature       = false,
	collideFriendly    = false,
    collideFeature     = false,
	burst			   = weapon2Burst,
	burstrate		   = 0.1,
    cegTag             = "missiletrailsmall",
    explosionGenerator = "custom:genericshellexplosion-medium-red",
	energypershot      = weapon2Damage / 20 * weapon2Burst,
    fireStarter        = 70,
    tracks             = true,
	impulseFactor      = 0,
    interceptedByShieldType = 4,
    model              = "missilesmalllauncher.s3o",
    name               = "Rockets",
    range              = 700,
    reloadtime         = 5,
    weaponType		   = "MissileLauncher",
    smokeTrail         = false,
    soundStart         = "rocket1.wav",
    soundHit           = "explode5.wav",
    startVelocity      = 250,
    tolerance          = 8000,
    turnrate           = 10000,
	predictBoost	   = 0.5,
    turret             = true,
    weaponAcceleration = 50,
    flightTime         = 5,
	trajectoryHeight   = 1.5,
	sprayangle		   = 10000,
    weaponVelocity     = 500,
	customparams = {
	  damagetype		= "eamphibrock",  
	  
	  --Upgrades--
	  upgradeClass		= "groundweapons",
    },     
    damage = {
      default           = weapon2Damage,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
