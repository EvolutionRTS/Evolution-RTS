-- UNITDEF -- EJAMMER2 --
--------------------------------------------------------------------------------

local unitName = "ejammer2"

--------------------------------------------------------------------------------

local unitDef = {
  activateWhenBuilt  = true,
  buildAngle         = 16384,
  buildCostEnergy    = 0,
  buildCostMetal     = 10,
  builder            = false,
  buildTime          = 5,
  category           = "BUILDING NOTAIR",
  corpse             = "ammobox",
  description        = "Radar Jamming Tower",
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_BUILDING",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "radarjam",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 280,
  maxSlope           = 60,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "Radar Jammer Tower",
  objectName         = "ejammer2.s3o",
  onoffable          = true,
  radarDistanceJam   = 500,
  repairable		 = false,
  selfDestructAs     = "SMALL_BUILDING",
  side               = "CORE",
  sightDistance      = 500,
  smoothAnim         = true,
  sonarDistance      = 0,
  unitname           = "ejammer2",
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
    needed_cover = 3,
	death_sounds = "generic",
	armortype   = "building",
	normaltex = "unittextures/ejammer2normal.png", 
	helptext = [[Radar Jammer

Will jam radar in a +500 Radius

+500 Radar distance Jamming]],
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
