-- UNITDEF -- BURROW --
--------------------------------------------------------------------------------

local unitName = "burrow"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  activateWhenBuilt  = true,
  buildAngle         = 2500,
  buildCostEnergy    = 0,
  buildCostMetal     = 500,
  builder            = false,
  buildTime          = 10,
  canAttack			 = false,
  category           = "NOTAIR ECO BUILDING",
  corpse             = "ammobox",
  description        = "Produces Unlimited Energy and Metal",
  energyMake         = 998,
  energyStorage      = 900,
  energyUse          = 0,
  explodeAs          = "FUSIONPOP",
  footprintX         = 8,
  footprintZ         = 8,
  iconType           = "energy",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 2500,
  maxSlope           = 60,
  maxWaterDepth      = 5000,
  metalmake	         = 998,
  metalStorage       = 900,
  name               = "Plot Device",
  objectName         = "efusion2.s3o",
  radarDistance      = 1000,
  reclaimable		 = false,
  selfDestructAs     = "FUSIONPOP",
  side               = "ARM",
  sightDistance      = 1000,
  smoothAnim         = true,
  unitname           = "burrow",
  workerTime         = 0,

  sfxtypes = {
    explosiongenerators = {
	  "custom:blacksmoke",
	  "custom:fusionreactionburrow",
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
    ProvideTech = "50 Power",
	armortype   = "building",
	normaltex = "unittextures/lego2skin_explorernormal.dds", 
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
