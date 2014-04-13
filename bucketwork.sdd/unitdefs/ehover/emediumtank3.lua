-- UNITDEF -- EMEDIUMTANK3 --
--------------------------------------------------------------------------------

local unitName = "emediumtank3"

--------------------------------------------------------------------------------

local unitDef = {

--mobileunit 
  transportbyenemy   = false;

--**


  acceleration       = 1,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 27,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT NOTAIR SKIRMISHER",
  corpse             = "ammobox",
  description        = "",
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "MEDIUM_UNIT",
  footprintX         = 3,
  footprintZ         = 3,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 450,
  maxSlope           = 26,
  maxVelocity        = 4.0,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK3",
  name               = "Bruiser",
  noChaseCategory    = "VTOL",
  objectName         = "emediumtank3.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "MEDIUM_UNIT",
  side               = "CORE",
  sightDistance      = 600,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 4,
  turnRate           = 1000,
--  turnrate           = 430,
  unitname           = "emediumtank3",
  upright            = true,
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:gdhcannon",
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
      def                = "mediumtankcannon",
      onlyTargetCategory = "NOTAIR AMPHIB",
	  badTargetCategory  = "BUILDING LIGHT WALL",
    },
  },
  customParams = {
    needed_cover = 2,
  	death_sounds = "generic",
    RequireTech = "4 Power",
	armortype   = "light",
	nofriendlyfire	= "1",
	supply_cost = 4,
	normalstex = "unittextures/emediumtank3normal.png", 
	helptext	= [[The brusier is a lightly armored tank destroyer, excellent versus raiders and other light units. Pair with light raiders and heavy tank destroyers for best results.
	
	It's description is a bit deceptive if you read it incorrectly. In truth, it decimates armored units. It is moderately effective vs light units and buildings.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  mediumtankcannon = {
	  badTargetCategory = [[BUILDING]],
    AreaOfEffect       = 1,
    avoidFriendly      = false,
    avoidFeature       = false,
	collideFriendly    = false,
    collideFeature     = false,
    ballistic          = true,
    cegTag             = "bruisercannon",
    explosionGenerator = "custom:genericshellexplosion-small",
	energypershot      = 10,
    id                 = 51,
    interceptedByShieldType = 4,
	impulseFactor      = 0,
    name               = "Light Cannon",
    range              = 600,
    reloadtime         = 1.0,
    weaponType		   = "Cannon",
    soundHit           = "mediumcannonhit.wav",
    soundStart         = "bruisercannon.wav",
    startsmoke         = "1",
    turret             = true,
    weaponVelocity     = 400,
	customparams = {
	  damagetype		= "emediumtank3",  
    },      
    damage = {
      default           = 200,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
