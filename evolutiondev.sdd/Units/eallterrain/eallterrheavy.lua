-- UNITDEF -- EALLTERRHEAVY --
--------------------------------------------------------------------------------

local unitName = "eallterrheavy"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 1,
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
  category           = "ARMORED NOTAIR SKIRMISHER",
  corpse             = "ammobox",
  
-- Cloaking

	cancloak		 = true,
	cloakCost		 = 2,
	cloakCostMoving	 = 2,
	minCloakDistance = 70,
	decloakOnFire	 = true,
	decloakSpherical = true,
	initCloaked		 = false,
	
-- End Cloaking
  
  description        =[[Armored Tank Destroyer
Armored
100 Damage vs Light/Armored
60 Damage vs Buildings
  
Requires +6 Power
Uses +6 Supply]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "HUGE_UNIT",
  firestandorders    = "1",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "allterr",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 600,
  maxVelocity        = 2.8,
  turninplacespeedlimit = 2.8,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "ALLTERRTANK4",
  name               = "Sledge",
  noChaseCategory    = "VTOL",
  objectName         = "eallterrheavy2.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "HUGE_UNIT",
  shootme            = "1",
  sightDistance      = 750,
  smoothAnim         = true,
  stealth			 = true,
  seismicSignature   = 4,
  turnInPlace        = true,
  turnRate           = 2500,
  unitname           = "eallterrheavy",
  unitnumber         = "110",
  upright            = false,
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:gdhcannon",
      "custom:dirtsmall",
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
      def                = "heavytankweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
	  badTargetCategory  = "BUILDING WALL",
    },
  },
   customParams = {
    needed_cover = 3,
   	death_sounds = "soldier",
    RequireTech = "6 Power",
	armortype   = "armored",
	supply_cost = 6,
	normaltex = "unittextures/lego2skin_explorernormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  heavytankweapon = {
    badTargetCategory = [[BUILDING]],
    AreaOfEffect       = 1,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.5,
--	cegTag             = "mediumcannonweapon3",
    duration           = 0.2,
    energypershot      = 6,
    explosionGenerator = "custom:MEDMECHPOP",
    fallOffRate        = 1,
    fireStarter        = 50,
	impulseFactor      = 0,
	interceptedByShieldType = 4,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    range              = 700,
    reloadtime         = 1,
    WeaponType         = "LaserCannon",
    rgbColor           = "0 1 0",
    rgbColor2          = "1 1 1",
    soundTrigger       = true,
    soundstart         = "allterrheavyshot.wav",
    soundHit           = "mediumcannonhit.wav",
    texture1           = "shot",
    texture2           = "empty",
    thickness          = 9,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 800,
	customparams = {
	  damagetype		= "eallterrheavy",  
    }, 
    damage = {
      default           = 100,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------

