-- UNITDEF -- EMINE --
--------------------------------------------------------------------------------

local unitName = "emine"

--------------------------------------------------------------------------------

local unitDef = {
  activateWhenBuilt  = true,
  blocking			 = false,
  buildAngle         = 1024,
  buildCostEnergy    = 0,
  buildCostMetal     = 15,
  builder            = false,
  buildTime          = 5,
  category           = "BUILDING NOTAIR",
  
-- Cloaking

	cancloak		 = true,
	cloakCost		 = 0,
	cloakCostMoving	 = 0,
	minCloakDistance = 50,
	decloakOnFire	 = false,
	decloakSpherical = true,
	initCloaked		 = true,
	
-- End Cloaking
  
  description        = [[Explodes on contact dealing 650 damage to anything caught within it's large blast envelope. Very difficult to detect!
  
  Costs +1 Supply]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "emineboom",
  footprintX         = 1,
  footprintZ         = 1,
  iconType           = "mine",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  kamikaze           = true,
  kamikazeDistance   = 100,
  levelground        = false,
  maxDamage          = 200,
  maxSlope           = 60,
  maxWaterDepth      = 5000,
  metalStorage       = 0,
  name               = "Land Mine",
  objectName         = "emine.s3o",
  script			 = "emine.cob",
  onoffable          = false,
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "emineboom",
  selfDestructCountdown = 0,
  side               = "CORE",
  sightDistance      = 50,
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
  
  customParams = {
    needed_cover = 1,
	supply_cost = 1,
  	death_sounds = "generic",
	armortype   = "armored",
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

local weaponDefs = {
  emineboom = {
   name="Land Mine",
   weaponType		   = "Cannon",
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   edgeeffectiveness	= 1,
   range=100,
   reloadtime=3.6,
   weaponvelocity=1000,
   AreaOfEffect=350,
   soundhit="minedetonation.wav",
   soundstart="minedetonation.wav",
   explosiongenerator="custom:genericshellexplosion-large-white",
   customparams = {
	  damagetype		= "emine",
	  nofriendlyfire	= "true", 
    },  

    damage = {
      default            = 650,
    },
  },
}
unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
