-- UNITDEF -- EMETALEXTRACTOR --
--------------------------------------------------------------------------------

local unitName = "emetalextractor"

--------------------------------------------------------------------------------

local unitDef = {

  activateWhenBuilt  = true,
  buildAngle         = 2048,
  buildCostEnergy    = 0,
  buildCostMetal     = 20,
  builder            = false,
  buildTime          = 5,
  canAttack			 = false,
  category           = "BUILDING NOTAIR ECO",
  corpse             = "ammobox",
  description        = "Extracts Metal",
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_BUILDING",
  extractsMetal      = 0.0000001,
  makesMetal         = 0,
  footprintX         = 7,
  footprintZ         = 7,
  iconType           = "eco",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 500,
  maxSlope           = 60,
  maxWaterDepth      = 25,
  metalStorage       = 0,
  metalMake          = 0,
  name               = "Metal Extractor",
  objectName         = "emetalextractor2.s3o",
  onoffable          = true,
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "SMALL_BUILDING",
  selfDestructCountdown = 1,
  side               = "CORE",
  sightDistance      = 367,
  smoothAnim         = true,
  unitname           = "emetalextractor",
  workerTime         = 0,
  yardMap            = "ooooooo ooooooo ooooooo ooooooo ooooooo ooooooo ooooooo",
    sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
	  "custom:blacksmoke",
	  "custom:fusionreactionmex",
	  "custom:skyhatelaser",
    },
  },
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdmex",
    },
  },
  weapons = {
  },
  customParams = {
	iseco = 1,
    needed_cover = 3,
    death_sounds = "generic",
	armortype   = "building",
	normaltex = "unittextures/lego2skin_explorernormal.png",
	helptext = [[Metal Extractor

Extracts metal from exposed resource points on the map. Provides +1 metal income

+1 Metal]],
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=10,
	buildingGroundDecalSizeY=10,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[emetalextractor_aoplane.dds]],
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
