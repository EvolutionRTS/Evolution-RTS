-- UNITDEF -- ELRPC --
--------------------------------------------------------------------------------

local unitName                    = "elrpc"

--------------------------------------------------------------------------------

local unitDef                     = {

	activateWhenBuilt             = true,
	buildCostEnergy               = 0,
	buildCostMetal                = 750,
	builder                       = false,
	buildTime                     = 5,
	canAttack                     = true,
	canstop                       = "1",
	category                      = "BUILDING NOTAIR",

	collisionVolumeOffsets        = "0 0 0",
	collisionVolumeScales         = "120 310 120",
	collisionVolumeTest           = 1,
	collisionVolumeType           = "box",

	corpse                        = "ammobox",
	description                   = [[Long Range Plasma Cannon - 100e Per Shot
	Building
	2000 Damage vs Buildings
	500 Damage vs Light/Armored]],
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "LARGE_BUILDING",
	footprintX                    = 8,
	footprintZ                    = 8,
	iconType                      = "elrpc",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = 4800,
	maxSlope                      = 30,
	maxWaterDepth                 = 0,
	metalStorage                  = 0,
	name                          = "Executioner",
	noChaseCategory               = "VTOL",
	objectName                    = "elrpc.s3o",
	onlytargetcategory2           = "NOTAIR",
	onlytargetcategory3           = "NOTAIR",
	onlytargetcategory4           = "NOTAIR",
	onlytargetcategory5           = "NOTAIR",
	onlytargetcategory6           = "NOTAIR",
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "LARGE_BUILDING",
	side                          = "ARM",
	sightDistance                 = 900,
	smoothAnim                    = true,
	unitname                      = "elrpc",
	workerTime                    = 0,
	yardMap                       = "oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo",
	sfxtypes                      = { 
		pieceExplosionGenerators  = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators       = {
			"custom:electricity",
			"custom:factorysparks",
			"custom:needspower",
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
			def                   = "lrpcweapon",
			onlyTargetCategory    = "NOTAIR AMPHIB",
			badTargetCategory     = "LIGHT ARMORED WALL",
		},
	},
	customParams                  = {
		canareaattack             ="1",
		death_sounds              = "generic",
		RequireTech               = "0 Power",
		armortype                 = "building",
		normaltex                = "unittextures/elrpcnormal.png", 
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 10,
	BuildingGroundDecalSizeY      = 10,
	BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------
local weapon1Damage               = 2000

local weaponDefs                  = {
	lrpcweapon                    = {
		accuracy                  = 500,
		AreaOfEffect              = 500,
		avoidFriendly             = false,
		cegTag                    = "BURNGREEN",
		collideFriendly           = false,
		explosionGenerator        = "custom:genericshellexplosion-large-green",
		fireStarter               = 70,

		id                        = 136,
		impulsefactor	          = 0,
		interceptedByShieldType   = 4,
		
		energypershot             = weapon1Damage / 20,
		edgeEffectiveness         = 0.1,
		model                     = "rocket.s3o",
		name                      = "Rockets",
		range                     = 6000,
		reloadtime                = 35,
		weaponType		          = "Cannon",
		

		smokeTrail                = false,
		soundHit                  = "lrpchit.wav",
		soundStart                = "lrpcshot2.wav",
		
		tolerance                 = 8000,
		turnRate                  = 4680,
		turret                    = true,
		weaponTimer               = 5,
		weaponVelocity            = 800,
		customparams              = {
			damagetype		      = "elrpc",  
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
