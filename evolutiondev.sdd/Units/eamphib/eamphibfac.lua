-- UNITDEF -- EAMPHIBFAC --
--------------------------------------------------------------------------------

local unitName = "eamphibfac"

--------------------------------------------------------------------------------

local unitDef = {

  activatewhenbuilt  = false,
  buildAngle         = 1024,
  buildCostEnergy    = 0,
  buildCostMetal     = 80,
  builder            = true,
  buildTime          = 5,
  canBeAssisted      = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "BUILDING NOTAIR AMPHIB",
   collisionVolumeOffsets = "0 20 0",
   collisionVolumeScales  = "238 92 128",
   collisionVolumeTest    = 1,
   collisionVolumeType    = "box",
  corpse             = "ammobox",
  description        = [[Produces Units
  
  Provides powergrid]],
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
  unitRestricted	 = 1,
  workerTime         = 1,
  yardMap            = "oooooooooooooooo oooooooooooooooo oooooooooooooooo oooooooooooooooo oooooooooooooooo oooooooooooooooo oooooooooooooooo oooooooooooooooo yyyyyyyyyyyyyyyy yyyyyyyyyyyyyyyy yyyyyyyyyyyyyyyy yyyyyyyyyyyyyyyy yyyyyyyyyyyyyyyy yyyyyyyyyyyyyyyy yyyyyyyyyyyyyyyy yyyyyyyyyyyyyyyy",
--  usePieceCollisionVolumes = true,
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "amphibfactdecal.png",
  BuildingGroundDecalSizeX = 17,
  BuildingGroundDecalSizeY = 17,
  BuildingGroundDecalDecaySpeed = 0.9,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:nanoflame",
      "custom:nano",
	  "custom:blacksmoke",
    },
  },
  buildoptions = {
    "eamphibengineer", --new
    "eamphibbuggy", --new
	"eamphibriot", --new
    "eamphibmedtank", --new
    "eamphibrock", --new
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
	ProvideTech = "1 Powergrid",
    ProvideTechRange = "1500",
	groundtexselectimg = ":nc:bitmaps/power/powergrid.png",
	groundtexselectxsize = 1500, -- optional
    groundtexselectzsize = 1500, -- optional
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
