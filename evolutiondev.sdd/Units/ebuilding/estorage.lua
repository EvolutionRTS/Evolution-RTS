-- UNITDEF -- ESTORAGE --
--------------------------------------------------------------------------------

local unitName = "estorage"

--------------------------------------------------------------------------------

local unitDef = {
  activateWhenBuilt  = true,
  buildAngle         = 8196,
  buildCostEnergy    = 0,
  buildCostMetal     = 20,
  builder            = false,
  buildTime          = 5,
  canAttack			 = false,
  category           = "BUILDING NOTAIR ECO",
 
   collisionVolumeScales  = [[66 74 126]],
   collisionVolumeOffsets = [[0 10 0]],
   collisionVolumeTest    = 1,
   collisionVolumeType    = "box",
  
  corpse             = "ammobox",
  description        = "Resource Storage - Stores 50m/50e",
  energyStorage      = 50,
  energyUse          = 0,
  explodeAs          = "ESTOR_BUILDING",
  footprintX         = 4,
  footprintZ         = 8,
  idleAutoHeal       = .5,
  idleTime           = 2200,
  icontype           = "eco",
  maxDamage          = 1200,
  maxSlope           = 50,
  maxWaterDepth      = 5000,
  metalStorage       = 50,
  name               = "Storage",
  objectName         = "estorage2.s3o",
  script			 = "estorage2.cob",
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "ESTOR_BUILDING",
  side               = "CORE",
  sightDistance      = 367,
  smoothAnim         = true,
  unitname           = "estorage",
  workerTime         = 0,
  yardMap            = "yyooooyy yyooooyy yyooooyy yyooooyy yyooooyy yyooooyy yyooooyy yyooooyy ",
  
sfxtypes = {
	pieceExplosionGenerators = {
		"deathceg0",
		"deathceg1",
	},
	
	explosiongenerators = {
	  "custom:blacksmoke",
	  "custom:fusionreactionstoragenew",
	  "custom:skyhatelaser",
    },
},
  
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdenergy",
    },
  },
  weapons = {
  },
   customParams = {
	iseco = 1,
    needed_cover = 2,
	death_sounds = "generic",
	armortype   = "building", 
	normaltex = "unittextures/lego2skin_explorernormal.dds", 
	helptext = [[Storage Facility

Will increase your storage reserves by +50

+50 Metal Storage

+50 Energy Storage]],
  },
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "factorygroundplate.dds",
  BuildingGroundDecalSizeX = 10,
  BuildingGroundDecalSizeY = 10,
  BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
