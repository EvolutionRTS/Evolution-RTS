-- UNITDEF -- ELIGHTTURRET2 --
--------------------------------------------------------------------------------

local unitName                    = "elightturret2"

--------------------------------------------------------------------------------

local unitDef                     = {

	buildAngle                    = 2048,
	buildCostEnergy               = 0,
	buildCostMetal                = 40,
	builder                       = false,
	buildTime                     = 5,
	canAttack                     = true,
	canstop                       = "1",
	category                      = "BUILDING NOTAIR",
	collisionVolumeTest           = "1",
	corpse                        = "ammobox",
	description                   = [[Anti-Raid Defense Platform (Anti-Light)
	Building
	125 Damage vs Light
	31.25 Damage vs Armored
	12.5 Damage vs Buildings

	Uses +1 Supply]],
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "MEDIUM_BUILDING",
	footprintX                    = 4,
	footprintZ                    = 4,
	floater			              = true,
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	iconType                      = "defense",
	maxDamage                     = 750,
	maxSlope                      = 60,
	maxWaterDepth                 = 999999,
	metalStorage                  = 0,
	name                          = "Lightning Rod",
	objectName                    = "elightturret3.s3o",
	onlytargetcategory2           = "NOTAIR",
	onlytargetcategory3           = "NOTAIR",
	onlytargetcategory4           = "NOTAIR",
	onlytargetcategory5           = "NOTAIR",
	onlytargetcategory6           = "NOTAIR",
	radarDistance                 = 0,
	repairable		              = false,
	-- script			          = "elightturret2-script.lua",
	selfDestructAs                = "MEDIUM_BUILDING",
	side                          = "CORE",
	sightDistance                 = 600,
	smoothAnim                    = true,
	unitname                      = "elightturret2",
	workerTime                    = 0,
	yardMap                       = "oooo oooo oooo oooo",

	sfxtypes                      = { 
		pieceExplosionGenerators  = { 
			"deathceg0", 
			"deathceg1", 
		}, 

		explosiongenerators       = {
			"custom:electricity",
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
			def                   = "lighteweapon",
			badTargetCategory     = "VTOL ARMORED",
			onlyTargetCategory    = "LIGHT VTOL ARMORED",
		},
	},
	customParams                  = {
		needed_cover              = 2,
		supply_cost               = 1,
		death_sounds              = "generic",
		armortype                 = "building",
		normalstex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "outer_colonies",  
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 6,
	BuildingGroundDecalSizeY      = 6,
	BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weapon1Damage               = 125
local weapon1AOE				  = 25

local weaponDefs                  = {
	lighteweapon                  = {
		AreaOfEffect              = weapon1AOE,
		avoidFriendly             = false,
		collideFriendly           = false,
		craterBoost               = 0,
		craterMult                = 0,
		explosionGenerator        = "custom:genericshellexplosion-medium-lightning",
		energypershot             = weapon1Damage / 20 * ((weapon1AOE / 1000) + 1),
		impulseBoost              = 0,
		impulseFactor             = 0,
		interceptedByShieldType   = 4,
		lineOfSight               = true,
		noSelfDamage              = true,
		range                     = 600,
		reloadtime                = 1,
		WeaponType                = "LightningCannon",
		rgbColor                  = "0.1 0.2 0.5",
		rgbColor2                 = "0 0 1",
		soundStart                = "jacobs.wav",
		startsmoke                = "1",
		texture1                  = "lightning",
		thickness                 = 10,
		turret                    = true,
		weaponVelocity            = 400,
		customparams              = {
			damagetype		      = "elightturret2",  
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
