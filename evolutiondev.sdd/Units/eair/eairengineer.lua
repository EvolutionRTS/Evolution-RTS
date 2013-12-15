-- UNITDEF -- EAIRENGINEER --
--------------------------------------------------------------------------------

local unitName = "eairengineer"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 0.2,
  airStrafe          = true,
  brakeRate          = 7,
  buildCostEnergy    = 0,
  buildCostMetal     = 40,
  buildTime          = 2.5,
  builder            = true,
  buildDistance      = 800,
  canAttack          = false,
  CanAssist			 = true,
  canBeAssisted      = true,
  CanCapture         = false,
  canDropFlare       = true,
  canFly             = true,
  canGuard           = true,
  canLoopbackAttack  = true,
  canMove            = true,
  canPatrol          = true,
  canreclamate       = true,
  canstop            = true,
  category           = "LIGHT VTOL",
  collide            = true,
--Collision Volumes... Because the engine devs are silly.
	collisionVolumeScales = [[35 35 35]],
--End Collision volumes
  corpse             = "ammobox",
  cruiseAlt          = 300,
  description        = "Airborne Engineer :: Armortype: Light",
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  flareDelay         = 0.1,
  flareDropVector    = "0 0 -1",
  flareefficieny     = "0.3",
  flareReload        = 3,
  floater            = true,
  footprintX         = 4,
  footprintZ         = 4,
  hoverAttack        = true,
  iconType           = "engineer",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxBank 			 = 5,
  maxDamage          = 600,
  maxSlope           = 90,
  maxVelocity        = 14,
  verticalSpeed		 = 15,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  moverate1          = "8",
  moveState			 = "2",
  name               = "The Originator",
  objectName         = "eairengineer.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  showNanoSpray      = false,
  sightDistance      = 800,
  smoothAnim         = true,
  turnRate           = 920,
  unitname           = "eairengineer",
  unitnumber         = "148",
  workerTime         = 1,
  capturespeed       = 1,
  TerraformSpeed     = 100000,
  ReclaimSpeed       = 1000,
  repairspeed        = 0.15625,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:jethtrail",
      "custom:nanoorb",
	  "custom:blacksmoke",
    },
  },
  buildoptions = {
    "eminifac", --new
    "ebasefactory", --new
    "eamphibfac",
    "eairplant",
	"eexperimentalfac",
    "emetalextractor", --new
    "euwmetalextractor", --new
    "emaker", --new
    "esolar2", --new
    "euwsolar2", --new
    "egeothermal", --new
    "efusion2", --new
    "euwfusion2", --new
    "estorage", --new
    "euwstorage", --new
    "eradar2", --new
    "ejammer2", --new
    "ekmar",
    "elightturret2", --new
    "eheavyturret2", --new
    "eaaturret",
	"euwturret",
    "elrpc",
    "eshieldgen",
    "esilo",
	"eorb",
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
--    airdronespawner = "1",
	armortype   = "light",
	normaltex = "unittextures/con_legonormal.png", 
  },
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
