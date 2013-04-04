-- UNITDEF -- EFLAMETANK --
--------------------------------------------------------------------------------

local unitName = "eflametank"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 22,
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
100 Damage/s vs Buildings
25 Damage/s vs Light/Armored

Energy Drain: 10/s

Requires +2 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "PYRO_BLAST",
  footprintX         = 3,
  footprintZ         = 3,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 260,
  maxSlope           = 26,
  maxVelocity        = 5,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK3",
  name               = "(P)yromaniac",
  noChaseCategory    = "VTOL",
  objectName         = "eflametank.s3o",
  onlytargetcategory2 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "PYRO_BLAST",
  side               = "CORE",
  sightDistance      = 500,
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
	  badTargetCategory  = "ARMORED LIGHT",
    },
  },
  customParams = {
    needed_cover = 2,
  	death_sounds = "soldier",
	twokhotkey = 'p',
    RequireTech = "2 Power",
	armortype   = "light",
	normaltex = "unittextures/eflametanknormal.png", 
	helptext	=	[[The pyromaniac has a long range flamethrower that is deadly versus base structures and especially economy buildings. Very fast and agile, however, it has a short line of sight. For best results, couple with Kites raiders.
	
	Pyromaniacs don't do much damage to other units. They can be used to fend off raiders in a pinch, but avoid sending them into battle vs other mobile units. They are excellent vs buildings.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
    lightlaser = {
	badTargetCategory = [[LIGHT]],
    accuracy           = 200,
    AreaOfEffect       = 50,
    avoidFeature       = false,
    avoidFriendly      = false,
    collideFeature     = false,
    collideFriendly    = false,
    explosionGenerator = "custom:burnblack",
    coreThickness      = 0,
    duration           = 1,
    energypershot      = 1,
    fallOffRate        = 1,
    fireStarter        = 50,
	interceptedByShieldType = 4,
    soundstart         = "flamethrower1.wav",
    lineOfSight        = true,
    minintensity       = 0.1,
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
      default           = 10,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
