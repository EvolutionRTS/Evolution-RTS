-- UNITDEF -- ERADAR2 --
--------------------------------------------------------------------------------

local unitName = "eradar2"

--------------------------------------------------------------------------------

local unitDef = {
  activateWhenBuilt  = true,
  buildAngle         = 16384,
  buildCostEnergy    = 0,
  buildCostMetal     = 15,
  builder            = false,
  buildTime          = 5,
  category           = "BUILDING NOTAIR",
  corpse             = "ammobox",
  description        = "Radar Tower",
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_BUILDING",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "radar",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 200,
  maxSlope           = 60,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "Radar Tower",
  objectName         = "eradar2.s3o",
  onoffable          = true,
  radarDistance      = 1500,
  repairable		 = false,
  selfDestructAs     = "SMALL_BUILDING",
  side               = "CORE",
  sightDistance      = 500,
  smoothAnim         = true,
  sonarDistance      = 0,
  seismicDistance    = 750,
  unitname           = "eradar2",
  workerTime         = 0,
  yardMap            = "oooo oooo oooo oooo",
  
sfxtypes = {
	pieceExplosionGenerators = {
		"deathceg0",
		"deathceg1",
	},
	
	explosiongenerators = {
	  "custom:blacksmoke",
    },
},
  
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdradar",
    },
  },
  customParams = {
    needed_cover = 2,
	death_sounds = "generic",
	armortype   = "building",
	normaltex = "unittextures/eradar2normal.png", 
	helptext = [[]],
  },
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "factorygroundplate.dds",
  BuildingGroundDecalSizeX = 6,
  BuildingGroundDecalSizeY = 6,
  BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
