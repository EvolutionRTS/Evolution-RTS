-- UNITDEF -- ESILO --
--------------------------------------------------------------------------------

local unitName                    = "esilo"

--------------------------------------------------------------------------------

local unitDef                     = {

	buildAngle                    = 8192,
	buildCostEnergy               = 0,
	buildCostMetal                = 1000,
	builder                       = false,
	buildTime                     = 5,
	canAttack                     = true,
	canstop                       = "1",
	category                      = "BUILDING NOTAIR",
	corpse                        = "ammobox",
	description                   = [[Nuclear Missile Silo - Missile takes 4 minutes to build - Drains 50e while building]],
	energyMake                    = 0,
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "nukemissile",
	floater						  = true,
	footprintX                    = 16,
	footprintZ                    = 16,
	iconType                      = "esilo",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = 9800,
	maxSlope                      = 30,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = "Eradicator",
	objectName                    = "esilo2.s3o",
	onlytargetcategory2           = "NOTAIR",
	onlytargetcategory3           = "NOTAIR",
	onlytargetcategory4           = "NOTAIR",
	onlytargetcategory5           = "NOTAIR",
	onlytargetcategory6           = "NOTAIR",
	radarDistance                 = 0,
	repairable		              = false,
	script			              = "esilo2.cob",
	selfDestructAs                = "nukemissile",
	side                          = "ARM",
	sightDistance                 = 600,
	smoothAnim                    = true,
	unitlimit                     = "2",
	unitname                      = "esilo",
	workerTime                    = 0,
	yardMap                       = "oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo",

	sfxtypes                      = { 
		pieceExplosionGenerators  = { 
			"deathceg0", 
			"deathceg1", 
		}, 

		explosiongenerators       = {
			"custom:needspower",
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
			def                   = "nukemissile",
			onlyTargetCategory    = "NOTAIR",
		},
	},
	customParams                  = {
		needed_cover              = 8,
		RequireTech               = "0 Power",
		death_sounds              = "nuke",
		armortype                 = "building",
		normalstex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds", 
		helptext                  = [[Nuclear Missile Silo

		Will completely devastate a large area

		+50000 Damage

		+2000 Area of Effect

		-50 Energy (While missile is building)

		10s Reload Time]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 18,
	BuildingGroundDecalSizeY      = 18,
	BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weapon1Damage               = 2000
local weapon1AOE				  = 2000

local weaponDefs                  = {
	nukemissile                   = {
		AreaOfEffect              = weapon1AOE,
		avoidFriendly             = false,
		avoidFeature              = false,
		cegTag                    = "NUKETRAIL",
		collideFriendly           = false,
		collideFeature            = false,
		commandfire               = true,
		craterBoost               = 0,
		craterMult                = 0,
		energypershot             = weapon1Damage / 20 * ((weapon1AOE / 1000) + 1),
		explosionGenerator        = "custom:NUKEDATBEWM",
		fireStarter               = 100,
		flightTime                = 400,
		guidance                  = true,
		id                        = 124,
		impulseBoost              = 0,
		impulseFactor             = 0,
		interceptedByShieldType   = 2,
		lineOfSight               = true,
		metalpershot              = 0,
		model                     = "enuke.s3o",
		name                      = "Nuke",
		range                     = 32000,
		reloadtime                = 15,
		weaponType		          = "MissileLauncher",
		selfprop                  = true,
		smokedelay                = "0.1",
		smokeTrail                = false,
		soundHit                  = "explosion_enormous.wav",
		soundStart                = "nukelaunch.wav",
		startsmoke                = "0",
		stockpile                 = true,
		stockpileTime             = 60,
		startVelocity             = 10,
		tracks                    = true,
		turnRate                  = 3000,
		targetable			      = 1,
		vlaunch                   = true,
		weaponAcceleration        = 30,
		weaponTimer               = 15,
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
