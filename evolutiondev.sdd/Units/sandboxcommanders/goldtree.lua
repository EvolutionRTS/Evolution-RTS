-- UNITDEF -- WHITEBASE --
--------------------------------------------------------------------------------

local unitName = "goldtree"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  acceleration       = 20,
  activateWhenBuilt  = true,
  airStrafe          = false,
  airHoverFactor     = 0,
  bmcode             = "1",
  brakeRate          = 10,
  buildCostEnergy    = 100000,
  buildCostMetal     = 100000,
  buildDistance      = 2000,
  builder            = true,
  buildTime          = 200000,
  canFly             = true,
  canGuard           = true,
  canAssist 		 = false,
  canMove            = true,
  canPatrol          = true,
  canreclamate       = "1",
  canRepair          = false,
  canstop            = "1",
  category           = "AIR CTRL_C COMMANDER",
  collide            = true,
  commander          = true,
  cruiseAlt          = 600,
  defaultmissiontype = "VTOL_standby",
  description        = "Command Unit",
  energyMake         = 50,
  energyStorage      = 20000,
  explodeAs          = "COMM_EXPLOSION",
  firestandorders    = "1",
  footprintX         = 5,
  footprintZ         = 5,
  mygravity          = 0,
  collisionVolumeTest = 1;
  healtime           = "27",
  iconType           = "commf",
  idleAutoHeal       = 1000000,
  maneuverleashlength = "500",
  mass               = 2000,
  maxDamage          = 40000,
  maxVelocity        = 30,
  metalMake          = 5,
  metalStorage       = 20000,
  minAirBasePower    = 99999,
  minCloakDistance   = 500.54833984375,
  minCollisionSpeed  = 15,
  mobilestandorders  = "1",
  name               = "feature placer",
  notargetcategory1  = "AIR",
  objectName         = "units/goldtree.s3o",
  power              = 20,
  pushResistant      = true,
  radarDistance      = 1977.902762220000,
  reclaimable        = false,
  selfDestructAs     = "COMM_EXPLOSION",
  shootme            = "1",
  showNanoSpray      = true,
  side               = "renpou",
  sightDistance      = 1350.00,
  smoothAnim         = true,
  standingfireorder  = "2",
  standingmoveorder  = "1",
  steeringmode       = "0",
  TEDClass           = "KBOT",
  threed             = "1",
  turnRate           = 1000,
  unitname           = "goldtree",
  unitnumber         = "401",
  upright            = false,
  version            = "1",
  workerTime         = 3000,
  zbuffer            = "1",
  buildoptions = {
  },
  customparams = {
    factionname		   = "neutral",  
	featureplacer	   = true,
    deltamaterials     = "0.1",
    power              = 50,
  },
  sfxtypes = {
    explosiongenerators = {
      "custom:sparklegreen",
      "custom:RED_EXPLOSION",
      "custom:BIGBOMB_EXPLOSION",
      "custom:COMM_EXPLOSION",
    },
  },
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
