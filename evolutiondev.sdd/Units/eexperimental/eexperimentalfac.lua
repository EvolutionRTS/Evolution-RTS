-- UNITDEF -- EEXPERIMENTALFAC --
--------------------------------------------------------------------------------

local unitName = "eexperimentalfac"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  activatewhenbuilt  = false,
  buildAngle         = 1024,
  buildCostEnergy    = 0,
  buildCostMetal     = 200,
  builder            = true,
  buildTime          = 10,
  canBeAssisted      = true,
  canMove            = false,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR",
  corpse             = "ammobox",
  description        = "Produces Destroyer Class Units",
  energyStorage      = 0,
  energyUse          = 0,
  energyMake         = 0,
  explodeAs          = "MEXPOP2",
  footprintX         = 34,
  footprintZ         = 34,
  iconType           = "factory",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 10000,
  maxSlope           = 25,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  metalMake          = 0,
  name               = "(D)estroyer Class Factory",
  objectName         = "eexperimentalfac.s3o",
  radarDistance      = 0,
  selfDestructAs     = "LARGE_BUILDING",
  showNanoSpray      = "0",
  side               = "CORE",
  sightDistance      = 388,
  smoothAnim         = true,
  TEDClass           = "PLANT",
  unitname           = "eexperimentalfac",
  workerTime         = 2,
  yardMap            = "ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo",
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "experimentalfacgroundplate.png",
  BuildingGroundDecalSizeX = 34,
  BuildingGroundDecalSizeY = 34,
  BuildingGroundDecalDecaySpeed = 0.9,
  sfxtypes = {
    explosiongenerators = {
      "custom:nanohuge",
    },
  },
  buildoptions = {
    "eextankdestroyer", --new
    "eexkrabgroth", --new
    "eexnukearty" --new
  },
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdfactoryselect",
    },
  },
  customParams = {
  	death_sounds = "nuke",
	twokhotkey = 'd',
	armortype   = "building", 
	normaltex = "unittextures/lego2skin_explorernormal.png", 
  },
}



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
