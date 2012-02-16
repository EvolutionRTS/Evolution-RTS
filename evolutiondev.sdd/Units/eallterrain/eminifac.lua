-- UNITDEF -- EMINIFAC --
--------------------------------------------------------------------------------

local unitName = "eminifac"

--------------------------------------------------------------------------------

local unitDef = {

  activatewhenbuilt  = false,
  buildAngle         = 1024,
  buildCostEnergy    = 0,
  buildCostMetal     = 40,
  builder            = true,
  buildTime          = 10,
  canBeAssisted      = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR",
  corpse             = "ammobox",
  
-- Cloaking

	cancloak		 = true,
	cloakCost		 = 20,
	minCloakDistance = 250,
	decloakOnFire	 = true,
	decloakSpherical = true,
	initCloaked		 = false,
	
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
  stealth			 = true,
  seismicSignature   = 1,
  TEDClass           = "PLANT",
  unitname           = "eminifac",
  workerTime         = 2,
  yardMap            = "ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ooooooooooooooooooooo ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc ccccccccccccccccccccc",
--  usePieceCollisionVolumes = true,
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "towerdecal2.png",
  BuildingGroundDecalSizeX = 23,
  BuildingGroundDecalSizeY = 23,
  BuildingGroundDecalDecaySpeed = 0.9,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

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
  	death_sounds = "generic",
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
