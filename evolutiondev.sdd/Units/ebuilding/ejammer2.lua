-- UNITDEF -- EJAMMER2 --
--------------------------------------------------------------------------------

local unitName = "ejammer2"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  activateWhenBuilt  = true,
  buildAngle         = 16384,
  buildCostEnergy    = 0,
  buildCostMetal     = 50,
  builder            = false,
  buildTime          = 10,
  category           = "NOTAIR",
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
  maxDamage          = 140,
  maxSlope           = 60,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "Radar (J)ammer Tower",
  objectName         = "ejammer2.s3o",
  onoffable          = true,
  radarDistanceJam   = 500,
  selfDestructAs     = "SMALL_BUILDING",
  side               = "CORE",
  sightDistance      = 0,
  smoothAnim         = true,
  sonarDistance      = 0,
  unitname           = "ejammer2",
  workerTime         = 0,
  yardMap            = "oooo",
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdradar",
    },
  },
  customParams = {
	twokhotkey = 'j',
	armortype   = "building", 
	normaltex = "unittextures/ejammer2normal.png", 
	helptext = [[Radar Jammer

Will jam radar in a +500 Radius

+500 Radar distance Jamming]],
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=6,
	buildingGroundDecalSizeY=6,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[ejammer2_aoplane.dds]],
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
