-- UNITDEF -- EAMPHIBENGINEER --
--------------------------------------------------------------------------------

local unitName = "eamphibengineer"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.24,
  buildCostEnergy    = 0,
  buildCostMetal     = 35,
  buildDistance      = 800,
  builder            = true,
  buildTime          = 5,
  CanAttack			 = false,
  CanAssist			 = true,
  canBeAssisted      = true,
  CanCapture         = false,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canreclamate       = "1",
  canstop            = "1",
  category           = "LIGHT AMPHIB SUPPORT",
  description        = [[Engineer
Light]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "CONSTRUCTOR",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "engineer",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  levelground        = true,
  maxDamage          = 600,
  maxSlope           = 28,
  maxVelocity        = 4,
  maxReverseVelocity = 1,
  maxWaterDepth      = 5000,
  metalmake          = 0,
  metalStorage       = 0,
  movementClass      = "TANK4",
  moveState			 = "2",
  name               = "The Developer",
  objectName         = "eamphibengineer2.s3o",
  script	         = "eamphibengineer2.cob",
  radarDistance      = 0,
  radarDistanceJam   = 20,
  repairable		 = false,
 selfDestructAs     = "CONSTRUCTOR",
  showNanoSpray      = "0",
  side               = "ARM",
  sightDistance      = 500,
  SonarDistance      = 500,
  smoothAnim         = true,
  stealth            = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 4,
  turnRate           = 1000,
--  turnrate           = 1020,
  unitname           = "eamphibengineer",
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
      "custom:nanoorb",
      "custom:dirt",
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
    "emaker", --new
    "esolar2", --new
    "egeothermal", --new
    "efusion2", --new
    "estorage", --new
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
	"emine",
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
    needed_cover = 1,
  	death_sounds = "soldier",
    dronespawner = "1",
	armortype   = "light",
	normaltex = "unittextures/lego2skin_explorernormal.dds", 
  },
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
