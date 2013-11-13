-- UNITDEF -- EALLTERRASSAULT --
--------------------------------------------------------------------------------

local unitName = "eallterrassault"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 1,
  buildCostEnergy    = 0,
  buildCostMetal     = 38,
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
  
  description        =[[Armored Dedicated Anti-Base Tank
Armored
400 Damage vs Buildings
50 Damage vs Light/Armored

This unit can only fire at buildings!

Requires +10 Power
Uses +10 Supply]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "HUGE_UNIT",
  firestandorders    = "1",
  footprintX         = 6,
  footprintZ         = 6,
  iconType           = "allterr",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 1300,
  maxVelocity        = 2.5,
  maxReverseVelocity = 1,
  turninplacespeedlimit = 2.5,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "ALLTERRTANK6",
  name               = "Anvil",
  noChaseCategory    = "VTOL",
  objectName         = "eallterrassault.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "HUGE_UNIT",
  shootme            = "1",
  sightDistance      = 800,
  smoothAnim         = true,
  stealth			 = true,
  seismicSignature   = 6,
  turnInPlace        = true,
  turnRate           = 1000,
  unitname           = "eallterrassault",
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
      def                = "assaulttankcannon",
      onlyTargetCategory = "BUILDING",
    },
  },
   customParams = {
    needed_cover = 4,
   	death_sounds = "soldier",
    RequireTech = "10 Power",
	armortype   = "armored",
	supply_cost = 10,
	normaltex = "unittextures/lego2skin_explorernormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  assaulttankcannon = {
    badTargetCategory = [[ARMORED LIGHT]],
    AreaOfEffect       = 50,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.6,
--	cegTag             = "mediumcannonweapon3",
    duration           = 0.4,
    energypershot      = 20,
    explosionGenerator = "custom:burn",
    fallOffRate        = 1,
    fireStarter        = 100,
	impulseFactor      = 0,
	interceptedByShieldType = 4,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    range              = 750,
    reloadtime         = 2.5,
    WeaponType         = "LaserCannon",
    rgbColor           = "0.5 0 1",
    rgbColor2          = "1 1 1",
    soundTrigger       = true,
    soundstart         = "allterrassaultshot.wav",
    soundHit           = "assaultshothit.wav",
    texture1           = "shot",
    texture2           = "empty",
    thickness          = 9,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 250,
	customparams = {
	  damagetype		= "eallterrassault",  
    }, 
    damage = {
      default           = 400,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------

