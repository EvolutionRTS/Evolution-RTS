-- UNITDEF -- EAIRPLANT --
--------------------------------------------------------------------------------

local unitName = "eairplant"

--------------------------------------------------------------------------------

local unitDef = {
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
  description        = "Produces Units",
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
  unitnumber         = "83",
  workerTime         = 2,
  yardMap            = "cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc cccccccccccccccccc",
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "towerdecal2.png",
  BuildingGroundDecalSizeX = 19,
  BuildingGroundDecalSizeY = 19,
  BuildingGroundDecalDecaySpeed = 0.9,
  sfxtypes = {
    explosiongenerators = {
      "custom:nanoflame",
      "custom:nano",
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
	twokhotkey = 'v',
	armortype   = "building", 
	normaltex = "unittextures/eairplantnormal.png", 
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
