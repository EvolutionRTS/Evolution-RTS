-- UNITDEF -- EBASEFACTORY --
--------------------------------------------------------------------------------

local unitName = "ebasefactory"

--------------------------------------------------------------------------------

local unitDef = {

  activatewhenbuilt  = false,
  buildAngle         = 1024,
  buildCostEnergy    = 0,
  buildCostMetal     = 60,
  builder            = true,
  buildTime          = 5,
  canAttack			 = false,
  canBeAssisted      = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canReclaim		 = false,
  canstop            = true,
  category           = "BUILDING NOTAIR",
   collisionVolumeOffsets = "0 40 0",
   collisionVolumeScales  = "128 112 188",
   collisionVolumeTest    = 1,
   collisionVolumeType    = "box",
  corpse             = "ammobox",
  description        = [[Produces Units]],
  energyStorage      = 0,
  energyUse          = 0,
  energyMake         = 0,
  explodeAs          = "MEXPOP2",
  footprintX         = 20,
  footprintZ         = 20,
  iconType           = "factory",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 1500,
  maxSlope           = 25,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  metalMake          = 0,
  name               = "Hovertank Factory",
  objectName         = "ebasefactory.s3o",
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "LARGE_BUILDING",
  showNanoSpray      = "0",
  side               = "CORE",
  sightDistance      = 388,
  smoothAnim         = true,
  TEDClass           = "PLANT",
  unitname           = "ebasefactory",
--  unitRestricted	 = 1,
  workerTime         = 1,
  yardMap            = "ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ooooooyyyyyyyyyyyyyy ",
--  usePieceCollisionVolumes = true,
--  modelCenterOffset	 = {108, 10, 0},
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:nanoorb",
      "custom:nano",
	  "custom:blacksmoke",
	  "custom:fusionreactionhoverfac",
	  "custom:skyhatelaser",
    },
  },
  buildoptions = {
    "eengineer5", --new
    "elighttank3", --new
--    "eflametank", --new
    "eriottank2", --new
--    "emediumtank3", --new
    "eheavytank3", --new
	"emissiletank", --new
    "eaatank",
--	"efatso2", --new
    "eartytank", --new
    "ebomb",
  },
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdfactoryselect",
    },
  },
  weapons = {
  },
  customParams = {
  	death_sounds = "generic",
	armortype   = "building", 
--	RequireTech = "12 Power",
	normalstex = "unittextures/ebasefactorynormal.png", 
--	ProvideTech = "1 Powergrid",
--    ProvideTechRange = "1500",
--	groundtexselectimg = ":nc:bitmaps/power/powergrid.png",
--	groundtexselectxsize = 1500, -- optional
--    groundtexselectzsize = 1500, -- optional
	helptext = [[The hovertank factory is the most robust of all the technology avenues in Evolution RTS. Unlike their amphibious and all-terrain counterparts, the Hover Factory does not possess any innate traits, but the larger selection of units makes up for the lack of innate abilities.]],
  },
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "factorygroundplate.dds",
  BuildingGroundDecalSizeX = 22,
  BuildingGroundDecalSizeY = 22,
  BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
