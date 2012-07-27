-- UNITDEF -- EAMPHIBMEDTANK --
--------------------------------------------------------------------------------

local unitName = "eamphibmedtank"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 20,
  builder            = false,
  buildTime          = 7,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "ARMORED AMPHIB SKIRMISHER",
  corpse             = "ammobox",
  description        = [[Tank Destroyer
Armored, 50% Damage vs Buildings
	• Switches to torpedos when underwater

Requires +4 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "MEDIUM_UNIT",
  footprintX         = 3,
  footprintZ         = 3,
  iconType           = "amphib",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 560,
  maxSlope           = 28,
  maxVelocity        = 4.5,
  maxReverseVelocity = 1,
  maxWaterDepth      = 5000,
  metalStorage       = 0,
  movementClass      = "TANK3",
  name               = "(R)azor",
  noChaseCategory    = "VTOL",
  objectName         = "eamphibmedtank.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "MEDIUM_UNIT",
  side               = "CORE",
  sightDistance      = 550,
  SonarDistance      = 550,
  stealth			 = true,
  sonarStealth		 = false,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 4.5,
  turnRate           = 1000,
--  turnrate           = 430,
  unitname           = "eamphibmedtank",
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
      def                = "medtanklaser",
    },
	[2]  = {
      def                = "TORP",
    },
  },
   customParams = {
    needed_cover = 2,
   	death_sounds = "soldier",
	twokhotkey = 'r',
    RequireTech = "4 Power",
	armortype   = "armored",
	normaltex = "unittextures/eamphibmedtanknormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
    medtanklaser = {
	badTargetCategory = [[BUILDING]],
    AreaOfEffect       = 8,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.5,
    duration           = 0.2,
    energypershot      = 7.5,
    explosionGenerator = "custom:burn",
    fallOffRate        = 1,
    fireStarter        = 50,
    interceptedByShieldType = 4,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    range              = 550,
    reloadtime         = 1,
    WeaponType         = "LaserCannon",
    rgbColor           = "0 0.5 0",
    rgbColor2          = "0.8 0.8 0.8",
    soundTrigger       = true,
    soundstart         = "plasma.wav",
    texture1           = "plasmaball",
    texture2           = "empty",
    thickness          = 4,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 1000,
	customparams = {
	  damagetype		= "tankdestroyer",  
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
	range			= 550,
	reloadtime		= 1,
	weapontimer		= 4,
	weaponvelocity	= 1000,
	startvelocity	= 300,
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
	  damagetype		= "tankdestroyer",  
    }, 
    damage = {
      default            = 100,
    },
  }, 
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
