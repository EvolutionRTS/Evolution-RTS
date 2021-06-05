-- UNITDEF -- EMINE --
--------------------------------------------------------------------------------

local unitName                    = "emine"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
--local supply					 = [[1]]

local weapon1Damage              = 1000
local weapon1AOE				 = 25

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                     = {
	activateWhenBuilt             = true,
	blocking			          = false,
	buildAngle                    = 1024,
	buildCostEnergy               = 0,
	buildCostMetal                = 5,
	builder                       = false,
	buildTime                     = 5,
	category                      = "LIGHT NOTAIR",

	-- Cloaking

	cancloak		              = true,
	cloakCost		              = 0,
	cloakCostMoving	              = 0,
	minCloakDistance              = 0,
	decloakOnFire	              = false,
	decloakSpherical              = true,
	initCloaked		              = true,
	
	-- End Cloaking

	description                   = [[Air/Land Mine]],
	energyMake                    = 0,
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "smallBuildingExplosionGenericWhite",
	footprintX                    = 2,
	footprintZ                    = 2,
	iconType                      = "mine",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	levelground                   = false,
	maxDamage                     = 100,
	maxSlope                      = 60,
	maxWaterDepth                 = 0,
	metalStorage                  = 0,
	name                          = "Land Mine",
	objectName                    = "emine.s3o",
	script			              = "emine.cob",
	onoffable                     = false,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "smallBuildingExplosionGenericWhite",
	selfDestructCountdown         = 0,
	side                          = "CORE",
	sightDistance                 = 400,
	smoothAnim                    = true,
	sonarDistance                 = 0,
	seismicDistance               = 0,
	stealth                       = false,
	unitname                      = "emine",
	workerTime                    = 0,
	yardMap                       = "oo oo",

	sfxtypes                      = {
		pieceExplosionGenerators  = {
			"deathceg3",
			"deathceg4",
		},
		
		explosiongenerators       = {
			"custom:blacksmoke",
		},
	},

	sounds                        = {
		underattack               = "other/unitsunderattack1",
		select                    = {
			"other/turretselect",
		},
	},

	weapons                       = {
		[1]                       = {
			def                   = "emineboom",
			onlyTargetCategory    = "BIO LIGHT ARMORED",
			badTargetCategory	  = "DRONE VTOL",
		},
	},

	customParams                  = {
		unittype				  = "landmine",
		decloakradiusmodifier	  = 10,
		needed_cover              = 1,
		death_sounds              = "generic",
		nofriendlyfire	          = "1",
		armortype                 = armortype,
		--supply_cost               = supply,
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "ateran",  
	},
	useGroundDecal                = false,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 3,
	BuildingGroundDecalSizeY      = 3,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

local weaponDefs                  = {
	emineboom                     = {
		name                      ="Land Mine",
		AreaOfEffect             = weapon1AOE,
		avoidFriendly             = false,
		avoidFeature              = false,
		collideFriendly           = false,
		collideFeature            = false,
		canAttackGround           = false,
		cegTag                   = "missiletrail",
		flightTime               = 2.5,
		
		tolerance                 = 1000,
		turret                    = true,
		impulseFactor             = 0,
		
		model                    = "missilesmallvlaunch.s3o",
		edgeeffectiveness	      = 1,
		energypershot             = 0,
		range                     =400,
		reloadtime                =8,
		weaponvelocity            =2500,
		
		
		smokeTrail               = false,
		tracks                   = true,
		turnrate                 = 200000,
		
		weaponAcceleration       = 800,
		weaponTimer              = 0.5,
		weaponType               = "StarburstLauncher",
		weaponVelocity           = 2500,
		soundHit                ="explosions/minedetonation.wav",
		soundStart				= "weapons/minewhir.wav",
		explosiongenerator        ="custom:genericshellexplosion-small-white",
		customparams              = {
			damagetype		      = "light",
			nofriendlyfire	      = "true", 
			effectedByunitHealthModifier = true,
		},  

		damage                    = {
			default               = weapon1Damage,
		},
	},
}
unitDef.weaponDefs                = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
