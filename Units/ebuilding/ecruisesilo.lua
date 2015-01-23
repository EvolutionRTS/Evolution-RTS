-- UNITDEF -- ECRUISESILO --
--------------------------------------------------------------------------------

local unitName                    = "ecruisesilo"

--------------------------------------------------------------------------------

local unitDef                     = {

	activateWhenBuilt             = true,
	buildCostEnergy               = 0,
	buildCostMetal                = 500,
	builder                       = false,
	buildTime                     = 5,
	canAttack                     = true,
	canstop                       = "1",
	category                      = "BUILDING NOTAIR",

	corpse                        = "ammobox",
	description                   = [[Long Range Cruise Missile
	Building
	2000 Damage vs Light/Armored/Buildings]],
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
	maxDamage                     = 1500,
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
			"deathceg3", 
			"deathceg4", 
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
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weapon1Damage               = 1500
local weapon1AOE				  = 250

local weaponDefs                  = {
	cruisemissile                   = {
		AreaOfEffect              = weapon1AOE,
		avoidFriendly             = false,
		avoidFeature              = false,
		cegTag                    = "cruisemissiletrail",
		collideFriendly           = false,
		collideFeature            = false,
		commandfire               = true,
		craterBoost               = 0,
		craterMult                = 0,
		edgeeffectiveness		  = 0.1,
		energypershot             = weapon1Damage / 20 * ((weapon1AOE / 1000) + 1),
		explosionGenerator        = "custom:ebombexpl",
		fireStarter               = 100,
		flightTime                = 400,
		impulseBoost              = 0,
		impulseFactor             = 0,
		interceptedByShieldType   = 4,
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
		tracks					  = true,
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
