-- UNITDEF -- EBARRICADE --
--------------------------------------------------------------------------------

local unitName = "ebarricade"

--------------------------------------------------------------------------------

local unitDef = {
  activateWhenBuilt  = true,
  buildAngle         = 4096,
  buildCostEnergy    = 0,
  buildCostMetal     = 5,
  builder            = false,
  buildTime          = 1,
  canAttack          = false,
  canstop            = "1",
  category           = "BUILDING NOTAIR WALL",
   collisionVolumeOffsets = "0 0 0",
   collisionVolumeScales  = "48 72 48",
   collisionVolumeTest    = 1,
   collisionVolumeType    = "box",
  damageModifier     = 0.2,
  description        = "Organic Barricade - Regenerates Health :: Armortype: Armored Building",
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "ESTOR_BUILDING",
  footprintX         = 3,
  footprintZ         = 3,
  autoHeal           = 20,
  iconType           = "barricade",
  idleTime           = 0,
  maxDamage          = 1000,
  maxSlope           = 60,
  maxWaterDepth      = 0,
  mass				 = 1000,
  metalStorage       = 0,
  name               = "Thorn",
  objectName         = "ebarricade.s3o",
  repairable		 = false,
  selfDestructAs     = "ESTOR_BUILDING",
  selfDestructCountdown = 0,
  side               = "ARM",
  sightDistance      = 0,
  smoothAnim         = true,
  TEDClass           = "FORT",
  unitname           = "ebarricade",
  workerTime         = 0,
  yardMap            = "ooo ooo ooo",
  
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
      "turretselect",
    },
  },
  customParams = {
    needed_cover = 1,
	death_sounds = "generic",
	armortype   = "building",
	normalstex = "unittextures/ebarricadenormal.png", 
	helptext = [[Organic Barricade

Regenerates Hitpoints as it takes damage. Provides cover for your units or structures.

+20 Hitpoints regenerated per second]],
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=5,
	buildingGroundDecalSizeY=5,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[ebarricade_aoplane.dds]],
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
