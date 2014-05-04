-- UNITDEF -- EMISSILETANK --
--------------------------------------------------------------------------------

local unitName = "emissiletank"

--------------------------------------------------------------------------------

local unitDef = {

--mobileunit 
  transportbyenemy   = false;

--**


  acceleration       = 1,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 32,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT NOTAIR SUPPORT",
  corpse             = "ammobox",
  description        = [[Missile Support Tank
Light
100 Damage vs Light/Armored
50 Damage vs Building

Requires +7 Power
Uses +7 Supply]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "tankdestroyer",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 320,
  maxSlope           = 26,
  maxVelocity        = 2.5,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK4",
  name               = "Droplet",
  objectName         = "emissiletank2.s3o",
  script			 = "emissiletank2.cob",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  side               = "ARM",
  sightDistance      = 850,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 2.6,
  turnRate           = 1000,
--  turnrate           = 300,
  unitname           = "emissiletank",
  upright            = true,
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
      def                = "missletankweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
	  badTargetCategory  = "BUILDING LIGHT",
    },
	[2]  = {
      def                = "missletankweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
	  badTargetCategory  = "BUILDING LIGHT WALL",
    },
  },
  customParams = {
	canareaattack="1",
    needed_cover = 3,
  	death_sounds = "generic",
    RequireTech = "7 Power",
	armortype   = "light",
	nofriendlyfire	= "1",
	supply_cost = 7,
	normalstex = "unittextures/lego2skin_explorernormal.dds", 
	 buckettex = "unittextures/lego2skin_explorerbucket.dds",
	factionname	= "outer_colonies",  
	helptext	= [[The Droplet is a medium range missile artillery battery. It does the most damage to armored units. It's damage is lower than a light tank destroyer, but it's large area of effect makes up for anything it lacks in damage.]],
  },
}


--------------------------------------------------------------------------------
local weapon1Damage = 150

local weaponDefs = {
  missletankweapon = {
	  badTargetCategory = [[LIGHT BUILDING]],
    AreaOfEffect       = 100,
    avoidFriendly      = false,
    avoidFeature       = false,
	collideFriendly    = false,
    collideFeature     = false,
    cegTag             = "missiletrail",
    craterBoost        = 0,
    craterMult         = 0,
    explosionGenerator = "custom:genericshellexplosion-medium-red",
	energypershot      = weapon1Damage / 20,
    fireStarter        = 100,
    flightTime         = 10,
    guidance           = true,
    id                 = 124,
    impulseBoost       = 0,
    impulseFactor      = 0,
    interceptedByShieldType = 4,
    lineOfSight        = true,
    model              = "missilesmallvlaunch.s3o",
    name               = "Rocket",
    range              = 850,
    reloadtime         = 3,
    weaponType		   = "MissileLauncher",
    selfprop           = true,
    smokedelay         = "0.1",
    smokeTrail         = false,
    soundHit           = "explode_large.wav",
    soundStart         = "missile_launch1.wav",
    startsmoke         = "0",
    tracks             = true,
    turnrate           = 30000,
    vlaunch            = true,
    weaponAcceleration = 400,
    weaponTimer        = 1,
    weaponType         = "StarburstLauncher",
    weaponVelocity     = 1800,
	customparams = {
	  damagetype		= "emissiletank",  
	  
	  --Upgrades--
	  upgradeClass		= "groundweapons",
    },      
    damage = {
      default           = weapon1Damage,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
