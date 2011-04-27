-- UNITDEF -- ERADAR2 --
--------------------------------------------------------------------------------

local unitName = "eradar2"

--------------------------------------------------------------------------------

local unitDef = {
  activateWhenBuilt  = true,
  buildAngle         = 16384,
  buildCostEnergy    = 0,
  buildCostMetal     = 30,
  builder            = false,
  buildTime          = 5,
  category           = "NOTAIR",
  corpse             = "ammobox",
  description        = "Radar Tower - High LOS",
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_BUILDING",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "radar",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 100,
  maxSlope           = 60,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "(R)adar Tower",
  objectName         = "eradar2.s3o",
  onoffable          = true,
  radarDistance      = 3500,
  selfDestructAs     = "SMALL_BUILDING",
  side               = "CORE",
  sightDistance      = 1500,
  smoothAnim         = true,
  sonarDistance      = 0,
  seismicDistance    = 3500,
  unitname           = "eradar2",
  workerTime         = 0,
  yardMap            = "oooo",
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdradar",
    },
  },
  customParams = {
	twokhotkey = 'r',
	armortype   = "building", 
	normaltex = "unittextures/eradar2normal.png", 
	helptext = [[Radar Tower

Provides long range radar and line of sight

+3500 Radar Range

+1500 Line of Sight]],
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=6,
	buildingGroundDecalSizeY=6,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[eradar2_aoplane.dds]],
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
