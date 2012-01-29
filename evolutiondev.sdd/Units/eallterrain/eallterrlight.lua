-- UNITDEF -- EALLTERRLIGHT --
--------------------------------------------------------------------------------

local unitName = "eallterrlight"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 0.18,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 10,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR RAID",
  corpse             = "ammobox",
  
-- Cloaking

	cancloak		 = true,
	cloakCost		 = 2,
	decloakDistance	 = 100,
	decloakOnFire	 = true,
	decloakSpherical = true,
	startCloaked	 = false,
	
-- End Cloaking
  
  description        = [[Raider - Damagetype: Explosive :: Armortype: Light

Requires +2 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_UNIT",
  firestandorders    = "1",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "allterr",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 100,
  maxVelocity        = 5.5,
  maxReverseVelocity = 2,
  turninplacespeedlimit = 5.5,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "ALLTERRTANK4",
  name               = "(R)ecluse",
  noChaseCategory    = "VTOL",
  objectName         = "eallterrlight2.s3o",
  radarDistance      = 0,
  selfDestructAs     = "SMALL_UNIT",
  sightDistance      = 800,
  smoothAnim         = true,
  stealth			 = true,
  seismicSignature   = 4,
  seismicDistance    = 800,
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
    },
    [2]  = {
      def                = "lighttankweapon2",
      badTargetCategory  = "VTOL",
    },
  },
   customParams = {
    needed_cover = 1,
	death_sounds = "soldier",
	twokhotkey = 'r',
    RequireTech = "2 Power",
	armortype   = "lightarmor",
	normaltex = "unittextures/lego2skin_explorernormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  lighttankweapon = {
    areaOfEffect       = 50,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.3,
    duration           = 0.1,
    energypershot      = 2.2,
    explosionGenerator = "custom:burn",
    fallOffRate        = 1,
    fireStarter        = 50,
	impulseFactor      = 0,
	interceptedByShieldType = 4,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    range              = 350,
    reloadtime         = 1,
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
    weaponVelocity     = 1000,
	customparams = {
	  damagetype		= "beam",  
    }, 
    damage = {
      default           = 30,
    },
  },
  lighttankweapon2 = {
    areaOfEffect       = 50,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.3,
    duration           = 0.1,
    energypershot      = 2.2,
    explosionGenerator = "custom:burn",
    fallOffRate        = 1,
    fireStarter        = 50,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    range              = 350,
    reloadtime         = 1,
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
    weaponVelocity     = 1000,
	customparams = {
	  damagetype		= "beam",  
    }, 
    damage = {
      default           = 30,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
