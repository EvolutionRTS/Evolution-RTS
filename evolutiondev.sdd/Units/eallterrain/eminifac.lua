-- UNITDEF -- EMINIFAC --
--------------------------------------------------------------------------------

local unitName = "eminifac"

--------------------------------------------------------------------------------

local unitDef = {
  buildAngle         = 1024,
  buildCostEnergy    = 0,
  buildCostMetal     = 40,
  builder            = true,
  buildTime          = 10,
  canBeAssisted      = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR",
  corpse             = "ammobox",
  
-- Cloaking

	cancloak		 = true,
	cloakCost		 = 20,
	decloakDistance	 = 400,
	decloakOnFire	 = true,
	decloakSpherical = true,
	startCloaked	 = false,
	
-- End Cloaking
  
  description        = "Produces Units",
  energyStorage      = 0,
  energyUse          = 0,
  energyMake         = 0,
  explodeAs          = "MEXPOP2",
  footprintX         = 21,
  footprintZ         = 21,
  iconType           = "factory",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 2000,
  maxSlope           = 60,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  metalMake          = 0,
  name               = "All-Terrain Factory (X)",
  objectName         = "eminifac.s3o",
  radarDistance      = 0,
  selfDestructAs     = "LARGE_BUILDING",
  showNanoSpray      = "0",
  sightDistance      = 388,
  smoothAnim         = true,
  TEDClass           = "PLANT",
  unitname           = "eminifac",
  workerTime         = 2,
  yardMap            = "ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc",
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "towerdecal2.png",
  BuildingGroundDecalSizeX = 23,
  BuildingGroundDecalSizeY = 23,
  BuildingGroundDecalDecaySpeed = 0.9,
  sfxtypes = {
    explosiongenerators = {
      "custom:nanoflame",
      "custom:nano",
    },
  },
  buildoptions = {
    "eallterrengineer", --new
    "eallterrlight",
    "eallterrmed",
    "eallterrriot",
    "eallterrheavy",
	"eallterrassault",
	"eallterrshield",
  },
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdfactoryselect",
    },
  },
  customParams = {
	twokhotkey = 'x',
	armortype   = "building", 
	normaltex = "unittextures/eminifacnormal.png", 
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=23,
	buildingGroundDecalSizeY=23,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[eminifac_aoplane.dds]],
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
