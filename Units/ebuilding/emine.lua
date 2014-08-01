-- UNITDEF -- EMINE --
--------------------------------------------------------------------------------

local unitName = "emine"

--------------------------------------------------------------------------------

local unitDef = {
  activateWhenBuilt  = true,
  blocking			 = true,
  buildAngle         = 1024,
  buildCostEnergy    = 0,
  buildCostMetal     = 5,
  builder            = false,
  buildTime          = 5,
  category           = "BUILDING NOTAIR",
  
-- Cloaking

	cancloak		 = true,
	cloakCost		 = 0,
	cloakCostMoving	 = 0,
	minCloakDistance = 0,
	decloakOnFire	 = true,
	decloakSpherical = true,
	initCloaked		 = true,
	
-- End Cloaking
  
  description        = [[Anti-Tank Land Mine
  Fires a projectile dealing 200 damage
  
  Costs 0.15 Energy Upkeep]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0.15,
  explodeAs          = "smallExplosionGenericWhite",
  footprintX         = 1,
  footprintZ         = 1,
  iconType           = "mine",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  levelground        = false,
  maxDamage          = 10,
  maxSlope           = 60,
  maxWaterDepth      = 5000,
  metalStorage       = 0,
  name               = "Land Mine",
  objectName         = "emine.s3o",
  script			 = "emine.cob",
  onoffable          = false,
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "smallExplosionGenericWhite",
  selfDestructCountdown = 0,
  side               = "CORE",
  sightDistance      = 200,
  smoothAnim         = true,
  sonarDistance      = 0,
  seismicDistance    = 0,
  stealth            = true,
  unitname           = "emine",
  workerTime         = 0,
  yardMap            = "o o o o",
  
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
  
  weapons = {
    [1]  = {
      def                = "emineboom",
	  onlyTargetCategory = "LIGHT ARMORED",
    },
  },
  
  customParams = {
    needed_cover = 1,
  	death_sounds = "generic",
	nofriendlyfire	= "1",
	armortype   = "building",
	normalstex = "unittextures/lego2skin_explorernormal.dds", 
	 buckettex = "unittextures/lego2skin_explorerbucket.dds",
	factionname	= "outer_colonies",  
	helptext = [[]],
  },
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "factorygroundplate.dds",
  BuildingGroundDecalSizeX = 1,
  BuildingGroundDecalSizeY = 1,
  BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------
local weapon1Damage = 200

local weaponDefs = {
  emineboom = {
   name="Land Mine",
    avoidFriendly      = false,
    avoidFeature       = false,
	collideFriendly    = false,
    collideFeature     = false,
	coreThickness      = 0.3,
	thickness          = 6,
    tolerance          = 1000,
   weaponType		   = "LaserCannon",
   turret=1,
   impulseFactor      = 0,
   edgeeffectiveness	= 1,
   energypershot      = weapon1Damage / 20,
   range=200,
   reloadtime=15,
   rgbColor           = "0.5 0.8 1",
   rgbColor2          = "1 1 1",
   texture1           = "shot",
   texture2           = "empty",
   weaponvelocity=2500,
   AreaOfEffect=15,
   soundstart="minedetonation.wav",
   explosiongenerator="custom:genericshellexplosion-small-white",
   customparams = {
	  damagetype		= "emine",
	  nofriendlyfire	= "true", 
    },  

    damage = {
      default           = weapon1Damage,
    },
  },
}
unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
