-- UNITDEF -- EAMPHIBFAC --
--------------------------------------------------------------------------------

local unitName = "eamphibfac"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  activatewhenbuilt  = false,
  buildAngle         = 1024,
  buildCostEnergy    = 0,
  buildCostMetal     = 40,
  builder            = true,
  buildTime          = 10,
  canBeAssisted      = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR AMPHIB",
  corpse             = "ammobox",
  description        = "Produces Units",
  energyStorage      = 0,
  energyUse          = 0,
  energyMake         = 0,
  explodeAs          = "MEXPOP2",
  footprintX         = 16,
  footprintZ         = 16,
  iconType           = "factory",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 5000,
  maxSlope           = 25,
  maxWaterDepth      = 5000,
  metalStorage       = 0,
  metalMake          = 0,
  name               = "Amphibious Tank Factory (C)",
  objectName         = "eamphibfac.s3o",
  radarDistance      = 0,
  selfDestructAs     = "LARGE_BUILDING",
  showNanoSpray      = "0",
  side               = "CORE",
  sightDistance      = 388,
  SonarDistance      = 175,
  smoothAnim         = true,
  TEDClass           = "PLANT",
  unitname           = "eamphibfac",
  workerTime         = 2,
  yardMap            = "oooooooooooooooo oooooooooooooooo oooooooooooooooo oooooooooooooooo oooooooooooooooo oooooooooooooooo oooooooooooooooo oooooooooooooooo cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc cccccccccccccccc",
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "amphibfactdecal.png",
  BuildingGroundDecalSizeX = 17,
  BuildingGroundDecalSizeY = 17,
  BuildingGroundDecalDecaySpeed = 0.9,
  sfxtypes = {
    explosiongenerators = {
      "custom:nanoflame",
      "custom:nano",
    },
  },
  buildoptions = {
    "eamphibengineer", --new
    "eamphibbuggy", --new
    "eamphibmedtank", --new
    "eamphibrock", --new
    "eamphibriot", --new
    "eamphibarty", --new
  },
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdfactoryselect",
    },
  },
  customParams = {
  	death_sounds = "generic",
	twokhotkey = 'c',
	armortype   = "building", 
	normaltex = "unittextures/eamphibfacnormal.png", 
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=17,
	buildingGroundDecalSizeY=17,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[eamphibfac_aoplane.dds]],
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
