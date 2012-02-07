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
  buildTime          = 8,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "AMPHIB SKIRMISHER",
  corpse             = "ammobox",
  description        = [[Skirmish Tank - Damagetype: Medium :: Armortype: Light
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
  maxDamage          = 280,
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
  selfDestructAs     = "MEDIUM_UNIT",
  side               = "CORE",
  sightDistance      = 500,
  SonarDistance      = 350,
  stealth			 = true,
  sonarStealth		 = false,
  smoothAnim         = true,
  turnInPlace        = false,
  turnInPlaceSpeedLimit = 4.5,
  turnRate           = 430,
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
	armortype   = "lightarmor",
	normaltex = "unittextures/eamphibmedtanknormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
    medtanklaser = {
    areaOfEffect       = 8,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.5,
    duration           = 0.2,
    energypershot      = 10,
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
	  damagetype		= "medium",  
    }, 
    damage = {
      default           = 100,
    },
  },
  TORP = {
	rendertype		= 1,
	lineofsight		= 1,
	turret			= 1,
    model              = "torpedo.s3o",
    energypershot      = 10,
	propeller		= 1,
	range			= 550,
	reloadtime		= 1,
	weapontimer		= 4,
	weaponvelocity	= 1000,
	startvelocity	= 25,
	weaponacceleration	= 25,
	areaofeffect	= 8,
    soundHit           = "subhit.wav",
    soundStart         = "torpedolaunch.wav",
    explosionGenerator = "custom:dodaibomb",
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
	  damagetype		= "medium",  
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
