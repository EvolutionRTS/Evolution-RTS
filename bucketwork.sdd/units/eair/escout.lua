-- UNITDEF -- ESCOUT --
--------------------------------------------------------------------------------

local unitName = "escout"

--------------------------------------------------------------------------------

local unitDef = {

--mobileunit 
  transportbyenemy   = false;

--**


  acceleration       = 0.5,
  airStrafe          = true,
  brakeRate          = 0.5,
  buildCostEnergy    = 0,
  buildCostMetal     = 15,
  builder            = false,
  buildTime          = 2.5,
  canFly             = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT VTOL",
  collide            = false,
  corpse             = "ammobox",
  cruiseAlt          = 180,
  description        = "",
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_UNIT",
  footprintX         = 4,
  footprintZ         = 4,
  hoverAttack        = true,
  floater            = true,
  iconType           = "air",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxAcc             = 0.5,
  maxDamage          = 320,
  maxSlope           = 10,
  maxVelocity        = 20,
  verticalSpeed		 = 15,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "AirScout",
  objectName         = "escout2.s3o",
  script			 = "escout2.cob",
  radarDistance      = 1500,
  SonarDistance      = 1000,
  repairable		 = false,
 selfDestructAs     = "SMALL_UNIT",
  side               = "ARM",
  sightDistance      = 750,
  smoothAnim         = true,
  turnRate           = 800,
  unitname           = "escout",
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
   customParams = {
--    needed_cover = 1,
	death_sounds = "generic",
    RequireTech = "4 Power",
	armortype   = "light",
	supply_cost = 4,
	normalstex = "unittextures/lego2skin_explorernormal.dds", 
	 buckettex = "unittextures/lego2skin_explorerbucket.dds",
	factionname	= "outer_colonies",  
  },
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
