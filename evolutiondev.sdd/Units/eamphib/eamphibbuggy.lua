-- UNITDEF -- EAMPHIBBUGGY --
--------------------------------------------------------------------------------

local unitName = "eamphibbuggy"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "missiletrailsmall",
  pieceTrailCEGRange = 1,
--End tags entered from Notepad++
  acceleration       = 0.18,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 8,
  builder            = false,
  buildTime          = 7,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "AMPHIB RAID",
  corpse             = "ammobox",
  description        = [[Scout/Raider - Damagetype: Piercing :: Armortype: Light
	• Switches to torpedos when underwater

Requires +1 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_UNIT",
  footprintX         = 2,
  footprintZ         = 2,
  iconType           = "amphib",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 80,
  maxSlope           = 28,
  maxVelocity        = 6.0,
  maxReverseVelocity = 2,
  maxWaterDepth      = 5000,
  metalStorage       = 0,
  movementClass      = "TANK2",
  name               = "Snake (B)",
  noChaseCategory    = "VTOL",
  objectName         = "eamphibbuggy.s3o",
  radarDistance      = 0,
  selfDestructAs     = "SMALL_UNIT",
  sightDistance      = 1000,
  SonarDistance        = 500,
  stealth			 = true,
  sonarStealth		 = false,
  smoothAnim         = true,
  seismicDistance    = 1000,
  turnInPlace        = false,
  turnRate           = 475,
  unitname           = "eamphibbuggy",
  workerTime         = 0,

    sfxtypes = {
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
      def                = "lightlaser",
    },
	[2]  = {
      def                = "TORP",
    },
  },
   customParams = {
	twokhotkey = 'b',
    RequireTech = "1 Power",
	armortype   = "lightarmor",
	normaltex = "unittextures/eamphibbuggynormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
    lightlaser = {
    accuracy           = 200,
    areaOfEffect       = 8,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.2,
    duration           = 0.1,
    energypershot      = 1.5,
    explosionGenerator = "custom:burn",
	energypershot      = 1.2,
    fallOffRate        = 1,
    fireStarter        = 50,
	interceptedByShieldType = 4,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    range              = 350,
    reloadtime         = 0.1,
    WeaponType         = "LaserCannon",
    rgbColor           = "0.5 0 0",
    rgbColor2          = "0.8 0.8 0.8",
    soundTrigger       = true,
    soundstart         = "18383_inferno_knokart.wav",
    texture1           = "plasmaball",
    texture2           = "empty",
    thickness          = 2,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 1000,
	customparams = {
	  damagetype		= "beam",  
    }, 
    damage = {
      default           = 12,
    },
  },
  
  TORP = {
	rendertype		= 1,
	lineofsight		= 1,
	turret			= 1,
    model              = "torpedo.s3o",
    energypershot      = 3,
	propeller		= 1,
	range			= 400,
	reloadtime		= 1,
	weapontimer		= 3,
	weaponvelocity	= 500,
	startvelocity	= 25,
	weaponacceleration	= 25,
	areaofeffect	= 16,
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
	  damagetype		= "beam",  
    }, 
    damage = {
      default            = 30,
    },
  },  
}
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
