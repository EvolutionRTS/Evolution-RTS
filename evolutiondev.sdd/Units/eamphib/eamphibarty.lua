-- UNITDEF -- EAMPHIBARTY --
--------------------------------------------------------------------------------

local unitName = "eamphibarty"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 80,
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
  description        = [["Laser Support Artillery
Light, 200% Damage vs Buildings
	• Switches to torpedos when underwater

Requires + 10 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "amphib",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 800,
  maxSlope           = 28,
  maxVelocity        = 3.0,
  maxReverseVelocity = 1,
  minWaterDepth      = 28,
  metalStorage       = 0,
  movementClass      = "TANK4",
  name               = "Splitter (A)",
  objectName         = "eamphibarty.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  sightDistance      = 1175,
  SonarDistance      = 1175,
  stealth			 = true,
  sonarStealth		 = false,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 3.0,
  turnRate           = 1000,
--  turnrate           = 300,
  unitname           = "eamphibarty",
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
      def                = "assimilatorbeamweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
	[2]  = {
      def                = "TORP",
    },
  },
   customParams = {
    needed_cover = 3,
   	death_sounds = "soldier",
	twokhotkey = 'a',
    RequireTech = "10 Power",
	armortype   = "light",
	normaltex = "unittextures/eamphibartynormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  assimilatorweapon = {
    badTargetCategory = [[ARMORED LIGHT]],
    AreaOfEffect       = 8,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    color              = 144,
    color2             = 217,
    coreThickness      = 0.5,
    duration           = 0.4,
    explosionGenerator = "custom:burn",
	energypershot      = 7.5,
    fallOffRate        = 0.1,
    fireStarter        = 50,
	interceptedByShieldType = 4,
    largeBeamLaser     = true,
    lineOfSight        = true,
    name               = "Laser",
    range              = 1175,
    reloadtime         = 9,
    WeaponType         = "LaserCannon",
    soundHit           = "18403_inferno_xplosm2.wav",
    soundStart         = "laserbeam02.wav",
    soundTrigger       = true,
    sweep              = "1",
    sweepfire          = true,
    texture1           = "plasmaball",
    texture2           = "empty",
    thickness          = 5,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 1500,
	customparams = {
	  damagetype		= "antibuilding",  
    }, 
    damage = {
      default           = 150,
    },
  },
  
  assimilatorbeamweapon = {
    badTargetCategory = [[ARMORED LIGHT]],
    AreaOfEffect       = 8,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 1.8,
    collideFeature     = false,
    collideFriendly    = false,
    color              = 144,
    color2             = 217,
    coreThickness      = 0.5,
    duration           = 0.4,
    explosionGenerator = "custom:burn",
	energypershot      = 7.5,
    fallOffRate        = 0.1,
    fireStarter        = 50,
	interceptedByShieldType = 4,
    largeBeamLaser     = true,
	laserflaresize 	   = 5,
    lineOfSight        = true,
	minintensity       = 1,
    name               = "Laser",
    range              = 1175,
    reloadtime         = 9,
    WeaponType         = "BeamLaser",
    soundHit           = "amphibartyshothit.wav",
    soundStart         = "laserbeam02.wav",
    soundTrigger       = true,
    texture1           = "lightning",
    texture2           = "laserend",
    thickness          = 20,
    tolerance          = 500,
    turret             = true,
    weaponVelocity     = 1500,
	customparams = {
	  damagetype		= "antibuilding",  
    }, 
    damage = {
      default           = 150,
    },
  },
  
  TORP = {
	cegtag			= "torpedotrailsmall",
	weaponType		   = "TorpedoLauncher",
	lineofsight		= 1,
	turret			= 1,
    model              = "torpedo.s3o",
    energypershot      = 7.5,
	propeller		= 1,
	range			= 1175,
	reloadtime		= 9,
	weapontimer		= 25,
	weaponvelocity	= 1500,
	startvelocity	= 500,
	weaponacceleration	= 100,
	AreaOfEffect	= 8,
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
	  damagetype		= "antibuilding",  
    }, 
    damage = {
      default            = 150,
    },
  },  
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
