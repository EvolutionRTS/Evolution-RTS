-- UNITDEF -- EAIRPLANT --
--------------------------------------------------------------------------------

local unitName = "eairplant"

--------------------------------------------------------------------------------

local unitDef = {

  activatewhenbuilt  = false,
  buildCostEnergy    = 0,
  buildCostMetal     = 60,
  builder            = true,
  buildTime          = 2.5,
  canBeAssisted      = true,
  canPatrol          = true,
  canReclaim		 = false,
  canstop            = "1",
  category           = "BUILDING NOTAIR",
  corpse             = "ammobox",
  description        = [[Produces Units
  
  Provides powergrid]],
  energyStorage      = 0,
  energyUse          = 0,
  energyMake         = 0,
  explodeAs          = "MEXPOP2",
  footprintX         = 18,
  footprintZ         = 18,
  iconType           = "factory",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 5000,
  maxSlope           = 60,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  metalMake          = 0,
  mobilestandorders  = "1",
  name               = "Aircraft Plant (V)",
  objectName         = "eairplant.s3o",
  radarDistance      = 0,
  selfDestructAs     = "LARGE_BUILDING",
  showNanoSpray      = "0",
  sightDistance      = 388,
  smoothAnim         = true,
  TEDClass           = "PLANT",
  unitname           = "eairplant",
--  unitRestricted	 = 1,
  unitnumber         = "83",
  workerTime         = 1,
  yardMap            = "cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc",
  usePieceCollisionVolumes = true,
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "towerdecal2.png",
  BuildingGroundDecalSizeX = 19,
  BuildingGroundDecalSizeY = 19,
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
  zbuffer            = "1",
  buildoptions = {
    "eairengineer",
    "escout", --new
    "egunship2", --new
    "efighter", --new
    "ebomber", --new
    "etransport", --new

  },
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdfactoryselect",
    },
  },
   customParams = {
   	death_sounds = "generic",
	twokhotkey = 'v',
	armortype   = "building", 
	normaltex = "unittextures/eairplantnormal.png", 
--	ProvideTech = "1 Powergrid",
--    ProvideTechRange = "1500",
--	groundtexselectimg = ":nc:bitmaps/power/powergrid.png",
--	groundtexselectxsize = 1500, -- optional
--    groundtexselectzsize = 1500, -- optional
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=19,
	buildingGroundDecalSizeY=19,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[eairplant_aoplane.dds]],
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
