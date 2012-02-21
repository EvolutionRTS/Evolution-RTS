-- UNITDEF -- ETRANSPORT --
--------------------------------------------------------------------------------

local unitName = "etransport"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 0.2,
  brakeRate          = 5,
  buildCostEnergy    = 0,
  buildCostMetal     = 10,
  builder            = false,
  buildTime          = 5,
  canAttack          = false,
  canFly             = true,
  canGuard           = false,
  canMove            = true,
  canload            = true,
  canPatrol          = false,
  canstop            = "1",
  category           = "VTOL",
  collide            = false,
--Collision Volumes... Because the engine devs are idiots.
	collisionVolumeScales = [[35 35 35]],
--End Collision volumes
  corpse             = "ammobox",
  cruiseAlt          = 400,
  description        = [[Fast Armored Transport - Armortype: Heavy

Requires +2 Power]],
  energyMake         = 0,
  energyUse          = 0,
  explodeAs          = "HUGE_UNIT",
  fallSpeed          = 1000,
  footprintX         = 4,
  footprintZ         = 4,
  holdSteady         = true,
--  hoverAttack        = true,
  icontype           = "air",
  maxAcc             = 0.3,
  maxDamage          = 180,
  maxSlope           = 60,
  maxVelocity        = 18,
  verticalSpeed		 = 15,
  name               = "Charter (x)",
  objectName         = "etransport.s3o",
  releaseHeld        = true,
  selfDestructAs     = "HUGE_UNIT",
  side               = "GD",
  sightDistance      = 250,
  smoothAnim         = true,
  transportCapacity  = 1,
  transportMass      = 10000,
  transportSize      = 6,
--  transportUnloadMethod = 1,
  turnRate           = 900,
  unitname           = "etransport",
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:jethtrail",
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
--    needed_cover = 2,
	death_sounds = "soldier",
	twokhotkey = 'x',
    RequireTech = "2 Power",
	armortype   = "heavyarmor",
	normaltex = "unittextures/etransport2normal.png", 
  },
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
