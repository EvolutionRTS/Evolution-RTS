-- UNITDEF -- EBOMBER --
--------------------------------------------------------------------------------

local unitName = "ebomber"

--------------------------------------------------------------------------------

local unitDef = {

--mobileunit 
  transportbyenemy   = false;

--**


  acceleration       = 0.2,
  airStrafe          = true,
  BadTargetCategory  = "VTOL",
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 40,
  builder            = false,
  buildTime          = 2.5,
  canAttack          = true,
  canFly             = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = true,
  category           = "ARMORED VTOL",
  collide            = true,
  corpse             = "ammobox",
  cruiseAlt          = 350,
  description        = [[Bomber
Armored
1000 Damage vs Buildings
250 Damage vs Light/Armored
  
Requires +10 Power
Uses +10 Supply

Must be forcefired on the target]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  footprintX         = 7,
  footprintZ         = 7,
--  fireState			 = 0,
  floater            = true,
  hoverAttack        = true,
  iconType           = "assault",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  loopbackattack     = false,
  maxAcc             = 0.18,
  maxDamage          = 540,
  maxSlope           = 10,
  maxVelocity        = 11,
  verticalSpeed		 = 15,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "Cardinal",
  noChaseCategory    = "VTOL",
  objectName         = "ebomber2.s3o",
  script			 = "ebomber2.cob",
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 900,
  smoothAnim         = true,
  stealth            = false,
  turnRate           = 400,
  unitname           = "ebomber",
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:jethtrail",
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
      def                = "SBOMB",
      noChaseCategory    = "VTOL",
	  onlyTargetCategory = "BUILDING",
    },
  },
   customParams = {
--    needed_cover = 2,
	death_sounds = "generic",
	nofriendlyfire = "1",
    RequireTech = "10 Power",
	armortype   = "armored",
	nofriendlyfire	= "1",
	supply_cost = 10,
	normalstex = "unittextures/lego2skin_explorernormal.dds", 
	 buckettex = "unittextures/lego2skin_explorerbucket.dds",
	factionname	= "outer_colonies",   
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  SBOMB = {
    AreaOfEffect       = 500,
    avoidFriendly      = false,
    avoidFeature       = false,
	collideFriendly    = false,
    collideFeature     = false,
    cegTag             = "missiletrailgunship",
	commandfire		   = "true",
    explosionGenerator = "custom:genericshellexplosion-large-red",
	energypershot      = 50,
	edgeEffectiveness  = 0.1,
    fireStarter        = 70,
    guidance           = false,
    id                 = 136,
    impulseBoost       = 0,
    impulseFactor      = 0,
    interceptedByShieldType = 4,
    lineOfSight        = true,
    metalpershot       = 0,
    model              = "missile.s3o",
    name               = "Rockets",
    range              = 900,
    reloadtime         = 30,
    weaponType		   = "MissileLauncher",  -- This causes the missile trail to go off kilter
--	rendertype		   = 1,
    selfprop           = true,
    smokedelay         = ".1",
    smokeTrail         = false,
    soundHit           = "unitexplodebig.wav",
	soundHitVolume	   = 10,
    soundStart         = "bomberlaunch.wav",
	soundStartVolume   = 10,
    startsmoke         = "0",
    startVelocity      = 500,
    tolerance          = 8000,
    turnRate           = 10000,
    tracks             = false,
	turret			   = false,
    weaponAcceleration = 10,
    flightTime         = 10,
    weaponVelocity     = 800,
	customparams = {
	  damagetype		= "ebomber",  
	  nofriendlyfire	= 1,
    },
    damage = {
      default           = 1000,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
