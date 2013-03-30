-- UNITDEF -- EAMPHIBRIOT--
--------------------------------------------------------------------------------

local unitName = "eamphibriot"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 23,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
--  canDgun			 = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT AMPHIB RIOT",
  corpse             = "ammobox",
  description        = [[Anti-Swarm Tank
Light, 200% Damage vs Light
• Paralyzes enemy units
• Projectile can hit multiple units

Requires +5 Power]],
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
  maxDamage          = 340,
  maxSlope           = 28,
  maxVelocity        = 3.7,
  maxReverseVelocity = 1,
  maxWaterDepth      = 5000,
  metalStorage       = 0,
  movementClass      = "TANK3",
  name               = "(D)icer",
  noChaseCategory    = "VTOL",
  objectName         = "eamphibriot.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "MEDIUM_UNIT",
  side               = "CORE",
  sightDistance      = 500,
  SonarDistance      = 500,
  stealth			 = true,
  sonarStealth		 = false,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 3.7,
  turnRate           = 1000,
--  turnrate           = 430,
  unitname           = "eamphibriot",
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
      def                = "riottankempweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
--[[
    [2]  = {
      def                = "TORP",
    },
]]--
  },
   customParams = {
    needed_cover = 2,
   	death_sounds = "soldier",
	twokhotkey = 'd',
    RequireTech = "4 Power",
	armortype   = "light",
	nofriendlyfire	= "1",
	normaltex = "unittextures/eamphibriotnormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  riottankweapon = {
    badTargetCategory = [[ARMORED BUILDING]],
	accuracy		   = 0,
    AreaOfEffect       = 25,
	avoidFeature       = false,
    avoidFriendly      = false,
    ballistic          = true,
    cegTag             = "riotweapon",
    collideFriendly    = false,
    explosionGenerator = "custom:PLASMA_Expl",
	energypershot      = 4.5,
    id                 = 172,
    impulseFactor      = 50,
    name               = "Light Cannon",
    range              = 500,
    reloadtime         = 0.25,
    weaponType		   = "Cannon",
--    soundHit           = "mediumcannonhit.wav",
    soundStart         = "riottankshot.wav",
    tolerance          = 2000,
    turret             = true,
    weaponVelocity     = 1000,
	customparams = {
	  damagetype		= "riot",  
    },   
    damage = {
      default           = 25,
    },
  },
  
  TORP = {
    badTargetCategory = [[ARMORED BUILDING]],
    cegtag			= "torpedotrailsmall",
	weaponType		   = "TorpedoLauncher",
	lineofsight		= 1,
	turret			= 1,
    model              = "torpedo.s3o",
    energypershot      = 2.25,
	propeller		= 1,
	range			= 500,
	reloadtime		= 0.5,
	weapontimer		= 10,
	weaponvelocity	= 500,
	startvelocity	= 250,
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
	  damagetype		= "riot",  
    }, 
    damage = {
      default            = 38,
    },
  }, 
  
  riottankempweapon = {
    badTargetCategory = [[ARMORED BUILDING]],
    AreaOfEffect       = 100,
    avoidFeature       = false,
    avoidFriendly      = false,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.6,
--	cegTag             = "mediumcannonweapon3",
    duration           = 0.05,
    energypershot      = 10,
    explosionGenerator = "custom:fusionfx",
    fallOffRate        = 1,
    fireStarter        = 100,
	impulseFactor      = 0,
    lineOfSight        = true,
    minintensity       = 1,
    name               = "Laser",
	noexplode		   = true,
	paralyzer		   = true,
	paralyzetime	   = 2.5,
    range              = 500,
    reloadtime         = 1,
    WeaponType         = "LaserCannon",
    rgbColor           = "0 0.2 1",
    rgbColor2          = "1 1 1",
    soundTrigger       = true,
    soundstart         = "fnubeamfire.wav",
    soundHit           = "phasegun1hit.wav",
    texture1           = "wave",
    texture2           = "empty",
    thickness          = 40,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 1000,
	customparams = {
	  damagetype		= "riot",  
	  nofriendlyfire	= 1,
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
