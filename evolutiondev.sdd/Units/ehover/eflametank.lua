-- UNITDEF -- EFLAMETANK --
--------------------------------------------------------------------------------

local unitName = "eflametank"

--------------------------------------------------------------------------------

local unitDef = {

--mobileunit 
  transportbyenemy   = false;

--**


  acceleration       = 1,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 25,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT NOTAIR RAID",
  corpse             = "ammobox",
  description        = [[Flamethrower Raider
Light
200 Damage/s vs Buildings
100 Damage/s vs Light/Armored

Energy Drain: 12.5/s

Requires +3 Power
Uses +3 Supply]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "mediumExplosionGenericRed",
  footprintX         = 3,
  footprintZ         = 3,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 400,
  maxSlope           = 26,
  maxVelocity        = 5,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK3",
  name               = "Firestorm",
  noChaseCategory    = "VTOL",
  objectName         = "eflametank.s3o",
  onlytargetcategory2 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "mediumExplosionGenericRed",
  side               = "CORE",
  sightDistance      = 750,
  seismicDistance    = 500,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 5,
  turnRate           = 1000,
--  turnrate           = 950,
  unitname           = "eflametank",
  upright            = true,
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:dirt",
       "custom:flamethrowerrange500",
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
      def                = "lightlaser",
      onlyTargetCategory = "NOTAIR AMPHIB",
	  badTargetCategory  = "ARMORED LIGHT WALL",
    },
  },
  customParams = {
    needed_cover = 2,
  	death_sounds = "generic",
    RequireTech = "3 Power",
	armortype   = "light",
	nofriendlyfire	= "1",
	supply_cost = 3,
	normalstex = "unittextures/eflametanknormal.png", 
	helptext	=	[[]],
  },
}


--------------------------------------------------------------------------------
local weapon1Damage = 25

local weaponDefs = {
    lightlaser = {
	badTargetCategory = [[LIGHT]],
    accuracy           = 0,
    AreaOfEffect       = 1,
    avoidFeature       = false,
    avoidFriendly      = false,
    collideFeature     = false,
    collideFriendly    = false,
    explosionGenerator = "custom:burnblack",
    coreThickness      = 0,
    duration           = 1,
    energypershot      = weapon1Damage / 20,
    fallOffRate        = 1,
    fireStarter        = 50,
	interceptedByShieldType = 4,
    soundstart         = "flamethrower1.wav",
    lineOfSight        = true,
    minintensity       = 1,
    impulseFactor      = 0,
    name               = "Something with Flames",
    range              = 500,
    reloadtime         = 0.1,
    WeaponType         = [[LaserCannon]],
    rgbColor           = "0 0 0",
    rgbColor2          = "0 0 0",
    thickness          = 0,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 400,
	customparams = {
	  damagetype		= "eflametank",  
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
