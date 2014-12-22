-- UNITDEF -- EMINE --
--------------------------------------------------------------------------------

local unitName                    = "emine"

--------------------------------------------------------------------------------

local unitDef                     = {
	activateWhenBuilt             = true,
	blocking			          = true,
	buildAngle                    = 1024,
	buildCostEnergy               = 0,
	buildCostMetal                = 5,
	builder                       = false,
	buildTime                     = 5,
	category                      = "BUILDING NOTAIR",

	-- Cloaking

	cancloak		              = true,
	cloakCost		              = 0.25,
	cloakCostMoving	              = 0,
	minCloakDistance              = 100,
	decloakOnFire	              = true,
	decloakSpherical              = true,
	initCloaked		              = true,
	
	-- End Cloaking

	description                   = [[Anti-Tank Land Mine
	Fires a projectile dealing 200 damage

	Costs 0.25 Energy Upkeep]],
	energyMake                    = 0,
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "smallExplosionGenericWhite",
	footprintX                    = 2,
	footprintZ                    = 2,
	iconType                      = "mine",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	levelground                   = false,
	maxDamage                     = 10,
	maxSlope                      = 60,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = "Land Mine",
	objectName                    = "emine.s3o",
	script			              = "emine.cob",
	onoffable                     = false,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "smallExplosionGenericWhite",
	selfDestructCountdown         = 0,
	side                          = "CORE",
	sightDistance                 = 400,
	smoothAnim                    = true,
	sonarDistance                 = 0,
	seismicDistance               = 0,
	stealth                       = true,
	unitname                      = "emine",
	workerTime                    = 0,
	yardMap                       = "oo oo oo oo",

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
		underattack               = "unitsunderattack1",
		select                    = {
			"turretselect",
		},
	},

	weapons                       = {
		[1]                       = {
			def                   = "emineboom",
			onlyTargetCategory    = "LIGHT ARMORED",
		},
	},

	customParams                  = {
		needed_cover              = 1,
		death_sounds              = "generic",
		nofriendlyfire	          = "1",
		armortype                 = "building",
		normalstex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "outer_colonies",  
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 3,
	BuildingGroundDecalSizeY      = 3,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------
local weapon1Damage               = 200

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
		flightTime               = 5,
		guidance                 = true,
		tolerance                 = 1000,
		turret                    = true,
		impulseFactor             = 0,
		lineOfSight              = true,
		model                    = "missilesmallvlaunch.s3o",
		edgeeffectiveness	      = 1,
		energypershot             = weapon1Damage / 20,
		range                     =400,
		reloadtime                =15,
		weaponvelocity            =2500,
		selfprop                 = true,
		smokedelay               = "0.1",
		smokeTrail               = false,
		tracks                   = true,
		turnrate                 = 200000,
		vlaunch                  = true,
		weaponAcceleration       = 800,
		weaponTimer              = 0.5,
		weaponType               = "StarburstLauncher",
		weaponVelocity           = 2500,
		soundHit                ="minedetonation.wav",
		soundStart				= "minewhir.wav",
		explosiongenerator        ="custom:genericshellexplosion-large-white",
		customparams              = {
			damagetype		      = "emine",
			nofriendlyfire	      = "true", 
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
