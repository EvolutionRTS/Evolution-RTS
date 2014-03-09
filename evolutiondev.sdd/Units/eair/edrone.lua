-- UNITDEF -- EDRONE --
--------------------------------------------------------------------------------

local unitName = "edrone"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 0.5,
  airStrafe          = true,
  bankscale          = "1",
  brakeRate          = 0.5,
  buildCostEnergy    = 1,
  buildCostMetal     = 5,
  buildTime          = 2.5,
  canAttack          = true,
  canDropFlare       = false,
  canFly             = true,
  canGuard           = true,
  canLoopbackAttack  = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT VTOL",
  collide            = false,
--  corpse             = "ammobox",
  cruiseAlt          = 100,
  description        = [[Gunship Drone
Light
3 Damage vs Light/Armored/Building]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  flareDelay         = 0.1,
  flareDropVector    = "0 0 -1",
  flareefficieny     = "0.3",
  flareReload        = 3,
  footprintX         = 3,
  footprintZ         = 3,
  hoverAttack        = true,
  iconType           = "tankdestroyer",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 100,
  maxSlope           = 30,
  maxVelocity        = 30,
  verticalSpeed		 = 15,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  moverate1          = "8",
  name               = "MidKnight",
  objectName         = "edrone2.s3o",
  script			 = "edrone2.cob",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 300,
  smoothAnim         = true,
  stealth            = true,
  turnRate           = 920,
  unitname           = "edrone",
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:jetstrail",
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
      def                = "droneweapon",
      mainDir            = "0 0 1",
      maxAngleDif        = 45,
	  badTargetCategory  = "WALL",
    },
  },
  customParams = {
--    needed_cover = 1,
	armortype   = "light",
  	death_sounds = "generic",
	nofriendlyfire	= "1",
	normaltex = "unittextures/lego2skin_explorernormal.dds",  
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  droneweapon = {
    accuracy           = 500,
    AreaOfEffect       = 1,
    avoidFriendly      = false,
    avoidFeature       = false,
	collideFriendly    = false,
    collideFeature     = false,
    beamTime           = 0.2,
    beamWeapon         = true,
    coreThickness      = 0.5,
    craterBoost        = 0,
    craterMult         = 0,
    duration           = 0.05,
	energypershot      = 0.3,
    explosionGenerator = "custom:genericshellexplosion-sparks",
    fallOffRate        = 0.1,
    impulseFactor      = 0,
    interceptedByShieldType = 4,
    largeBeamLaser     = true,
    lineOfSight        = true,
    name               = "Light Laser",
    noSelfDamage       = true,
    range              = 800,
    reloadtime         = 1,
    WeaponType         = "LaserCannon",
    rgbColor           = "0.1 0.5 0.2",
    rgbColor2          = "0 1 0",
    selfprop           = true,
    soundHit           = "18393_inferno_reject.wav",
    soundStart         = "18389_inferno_medlas.wav",
    soundTrigger       = true,
    startVelocity      = 1000,
    targetMoveError    = 0,
    texture1           = "plasmaball",
    texture2           = "empty",
    texture3           = "empty",
    texture4           = "empty",
    thickness          = 5,
    turret             = true,
    weaponVelocity     = 1000,
	customparams = {
	  damagetype		= "edrone",  
    },    
    damage = {
      default            = 3,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
