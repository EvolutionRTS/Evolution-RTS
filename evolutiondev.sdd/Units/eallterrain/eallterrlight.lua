-- UNITDEF -- EALLTERRLIGHT --
--------------------------------------------------------------------------------

local unitName = "eallterrlight"

--------------------------------------------------------------------------------

local unitDef = {

--mobileunit 
  transportbyenemy   = false;

--**


  acceleration       = 1,
  brakeRate          = 1,
  buildCostEnergy    = 0,
  buildCostMetal     = 22,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT NOTAIR RAID",
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
  
  description        = [[Raider
Light
50 Damage vs Light
25 Damage vs Armored/Building
  
Requires +2 Power
Uses +2 Supply]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_UNIT",
  firestandorders    = "1",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "allterrraider",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 200,
  maxVelocity        = 5.5,
  maxReverseVelocity = 2,
  turninplacespeedlimit = 5.5,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "ALLTERRTANK4",
  name               = "Recluse",
  noChaseCategory    = "VTOL",
  objectName         = "eallterrlight2.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "SMALL_UNIT",
  sightDistance      = 500,
  smoothAnim         = true,
  stealth			 = true,
  seismicSignature   = 4,
  seismicDistance    = 500,
  turnInPlace        = true,
  turnRate           = 1000,
  unitname           = "eallterrlight",
  upright			 = false,
  workerTime         = 0,
    sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:factorysparks",
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
      def                = "lighttankweapon",
      badTargetCategory  = "VTOL",
	  badTargetCategory  = "BUILDING ARMORED WALL",
    },
  },
   customParams = {
    needed_cover = 1,
	death_sounds = "generic",
    RequireTech = "2 Power",
	armortype   = "light",
	nofriendlyfire	= "1",
	supply_cost = 2,
	normalstex = "unittextures/lego2skin_explorernormal.dds", 
	 buckettex = "unittextures/lego2skin_explorerbucket.dds",
	factionname	= "outer_colonies",  
  },
}


--------------------------------------------------------------------------------
local weapon1Damage = 50

local weaponDefs = {
  lighttankweapon = {
    badTargetCategory = [[ARMORED BUILDING]],
    AreaOfEffect       = 1,
    avoidFeature       = false,
    avoidFriendly      = false,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.3,
    duration           = 0.1,
    energypershot      = weapon1Damage / 20,
    explosionGenerator = "custom:genericshellexplosion-small-blue",
    fallOffRate        = 1,
    fireStarter        = 50,
	impulseFactor      = 0,
	interceptedByShieldType = 4,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    range              = 350,
    reloadtime         = 0.5,
    WeaponType         = "LaserCannon",
    rgbColor           = "0.5 0.8 1",
    rgbColor2          = "1 1 1",
    soundTrigger       = true,
    soundstart         = "heavycannonGD.wav",
    texture1           = "shot",
    texture2           = "empty",
    thickness          = 6,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 2000,
	customparams = {
	  damagetype		= "eallterrlight",  
	  
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
