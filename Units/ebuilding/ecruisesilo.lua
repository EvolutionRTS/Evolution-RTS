-- UNITDEF -- ECRUISESILO --
--------------------------------------------------------------------------------

local unitName                    = "ecruisesilo"

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

	corpse                        = "ammobox",
	description                   = [[Long Range Cruise Missile - 100e Per Shot
	Building
	2000 Damage vs Buildings
	500 Damage vs Light/Armored]],
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "cruisemissile",
	floater						  = true,
	firestate					  = [[0]],
	footprintX                    = 10,
	footprintZ                    = 10,
	iconType                      = "elrpc",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = 4800,
	maxSlope                      = 30,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = "Executioner",
	noChaseCategory               = "VTOL",
	objectName                    = "ecruisesilo.s3o",
	onlytargetcategory2           = "NOTAIR",
	onlytargetcategory3           = "NOTAIR",
	onlytargetcategory4           = "NOTAIR",
	onlytargetcategory5           = "NOTAIR",
	onlytargetcategory6           = "NOTAIR",
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "cruisemissile",
	side                          = "ARM",
	sightDistance                 = 900,
	smoothAnim                    = true,
	unitname                      = "ecruisesilo",
	workerTime                    = 0,
	yardMap                       = "oooooooooo oooooooooo oooooooooo oooooooooo oooooooooo oooooooooo oooooooooo oooooooooo oooooooooo oooooooooo ",
	sfxtypes                      = { 
		pieceExplosionGenerators  = { 
			"deathceg0", 
			"deathceg1", 
		}, 

		explosiongenerators       = {
			"custom:blacksmoke",
			"custom:steam",
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
			def                   = "cruisemissile",
			onlyTargetCategory    = "NOTAIR AMPHIB",
			badTargetCategory     = "LIGHT ARMORED WALL",
		},
	},
	customParams                  = {
		death_sounds              = "generic",
		RequireTech               = "0 Power",
		armortype                 = "building",
		normalstex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds", 
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 12,
	BuildingGroundDecalSizeY      = 12,
	BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------
local weapon1Damage               = 2000

local weaponDefs                  = {
	cruisemissile                   = {
		AreaOfEffect              = 1000,
		avoidFriendly             = false,
		cegTag                    = "cruisemissiletrail",
		collideFriendly           = false,
		craterBoost               = 0,
		craterMult                = 0,
		energypershot             = weapon1Damage / 20,
		explosionGenerator        = "custom:cruisemissile",
		fireStarter               = 100,
		flightTime                = 400,
		impulseBoost              = 0,
		impulseFactor             = 0,
		interceptedByShieldType   = 2,
		lineOfSight               = true,
		metalpershot              = 0,
		model                     = "ecruisemissile.s3o",
		name                      = "Cruise Missile",
		range                     = 6000,
		reloadtime                = 5,
		weaponType		          = "MissileLauncher",
		selfprop                  = true,
		smokedelay                = "0.1",
		smokeTrail                = false,
		soundHit                  = "cruisemissilehit.wav",
		soundStart                = "cruisemissilelaunch.wav",
		startsmoke                = "0",
		stockpile                 = true,
		stockpileTime             = 35,
		startVelocity             = 10,
		turnRate                  = 6000,
		vlaunch                   = true,
		weaponAcceleration        = 60,
		weaponTimer               = 5,
		weaponType                = "StarburstLauncher",
		weaponVelocity            = 1000,
		customparams              = {
			damagetype		      = "default",  
			death_sounds 		  = "nuke",
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
