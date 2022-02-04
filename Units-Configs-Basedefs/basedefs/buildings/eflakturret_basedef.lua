unitDef                     = {
	buildAngle                    = 2048,
	buildCostEnergy               = 0,
	buildCostMetal                = 50,
	builder                       = false,
	buildTime                     = 5,
	buildpic					  = "elaserbattery.png",
	canAttack                     = true,
	canstop                       = "1",
	category                      = "BUILDING NOTAIR",
	collisionVolumeTest           = "1",
	description                   = [[Anti-AIR Flak Defense Platform]],
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "mediumBuildingExplosionGeneric",
	footprintX                    = 3,
	footprintZ                    = 3,
	floater			              = true,
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	iconType                      = "turret_lit",
	maxDamage                     = 625,
	maxSlope                      = 60,
	maxWaterDepth                 = 999999,
	metalStorage                  = 0,
	name                          = humanName,
	objectName                    = objectName,
	script						  = script,
	onlytargetcategory2           = "NOTAIR",
	onlytargetcategory3           = "NOTAIR",
	onlytargetcategory4           = "NOTAIR",
	onlytargetcategory5           = "NOTAIR",
	onlytargetcategory6           = "NOTAIR",
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "mediumBuildingExplosionGeneric",
	side                          = "CORE",
	sightDistance                 = 100,
	airsightdistance			  = 1500,
	smoothAnim                    = true,
	unitname                      = unitName,
	workerTime                    = 0,
	yardMap                       = "oooo oooo oooo oooo",

	sfxtypes                      = { 
		pieceExplosionGenerators  = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators       = {
			"custom:gdhcannon",
			"custom:needspower",
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
			def                   = "aircannon",
			onlyTargetCategory    = "VTOL",
		},
	},
	customParams                  = {
		isupgraded			  	  = isUpgraded,
		unittype				  = "turret",
		RequireTech				  = tech,
		needed_cover              = 2,
		--supply_cost               = supply,
		death_sounds              = "generic",
		armortype                 = armortype,
		normaltex                 = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "ateran",
		corpse                   = "energycore",
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 8,
	BuildingGroundDecalSizeY      = 8,
	BuildingGroundDecalDecaySpeed = 0.9,
}

weaponDefs                  = {
	aircannon   	             = {
		AreaOfEffect             = 250,
		avoidFeature             = false,
		avoidFriendly            = false,
		collideFeature           = false,
		collideFriendly          = false,
		canAttackGround 		 = false,
		coreThickness            = 0.5,
		burnblow		         = true,
		--cegTag                   = "railgun",
		duration                 = 0.05,
		energypershot            = 0,
		explosionGenerator       = "custom:genericshellexplosion-medium-purple",
		edgeEffectiveness		 = 1,
		fallOffRate              = 1,
		fireStarter              = 50,
		impulseFactor            = 0,
		minintensity             = "1",
		name                     = "Laser",
		range                    = 1500,
		reloadtime               = 1,
		WeaponType               = "Cannon",
		rgbColor                 = "1 0.5 0",
		rgbColor2                = "1 1 1",
		projectiles				 = 4,
		soundTrigger             = true,
		soundstart               = "weapons/Assault Rifle Shot_05.wav",
		soundhit				 = "deathsounds/generic/Explosion Fireworks_01.wav",
		sprayangle				 = 3000,
		size					 = 5,
		--texture1                 = "shot",
		--texture2                 = "empty",
		tolerance                = 7500,
		turret                   = true,
		weaponVelocity           = 3000,
		customparams             = {
			damagetype		     = "antiair",
			isupgraded           = isUpgraded,
			effectedByunitHealthModifier = true,
		}, 
		damage                   = {
			default              = 125,
		},
	},  
}