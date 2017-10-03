-- UNITDEF -- ESILO --
--------------------------------------------------------------------------------

local unitName                    = "esilo"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
--local supply					 = [[50]]
local techprovided				 = [[-nukesilo]]
local techrequired				 = [[tech3, 1 nukesilo]]

local weapon1Damage               = 3000
local weapon1AOE				  = 1500
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)
--local stockpiletime				 = 60

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local buildCostMetal 			  = 750
local maxDamage					  = buildCostMetal * 12.5

local unitDef                     = {

	buildAngle                    = 8192,
	buildCostEnergy               = 0,
	buildCostMetal                = buildCostMetal,
	builder                       = false,
	buildTime                     = 5,
	canAttack                     = true,
	canstop                       = "1",
	category                      = "BUILDING NOTAIR",
	corpse                        = "ammobox",
	description                   = [[Nuclear Missile Silo]],
	energyMake                    = 0,
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "nukemissile",
	floater						  = true,
	fireState					  = 0,
	footprintX                    = 16,
	footprintZ                    = 16,
	iconType                      = "esilo",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = maxDamage,
	maxSlope                      = 30,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = [[Eradicator: Nuclear Strike Facility]],
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
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators       = {
			"custom:needspower",
			"custom:blacksmoke",
			"custom:steam",
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
			def                   = "nukemissile",
			badTargetCategory    = "LIGHT ARMORED",
		},
	},
	customParams                  = {
		ProvideTech              = techprovided,
		RequireTech				 = techrequired,
		unittype				  = "turret",
		needed_cover              = 8,
		--supply_cost               = supply,
		death_sounds              = "nuke",
		armortype                 = "building",
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds", 
		helptext                  = [[Armortype: ]] ..armortype.. [[ 

]] .. weapon1Damage .. [[ Damage vs Light/Armored/Buildings

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire),
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 18,
	BuildingGroundDecalSizeY      = 18,
	BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                  = {
	nukemissile                   = {
		AreaOfEffect              = weapon1AOE,
		avoidFriendly             = false,
		avoidFeature              = false,
		cegTag                    = "NUKETRAIL",
		collideFriendly           = false,
		collideFeature            = false,
		commandFire				  = true,
		craterBoost               = 0,
		craterMult                = 0,
		edgeeffectiveness		  = 1,
		energypershot             = energycosttofire,
		explosionGenerator        = "custom:nukedatbewm",
		fireStarter               = 100,
		flightTime                = 400,
		
		id                        = 124,
		impulseBoost              = 0,
		impulseFactor             = 0,
		interceptedByShieldType   = 4,
		
		metalpershot              = 0,
		model                     = "enuke.s3o",
		name                      = "Nuke",
		range                     = 32000,
		reloadtime                = 200,
		weaponType		          = "MissileLauncher",
		
		
		smokeTrail                = false,
		soundHit                  = "explosions/explosion_enormous.wav",
		soundStart                = "weapons/nukelaunch.wav",
		
--		stockpile                 = true,
--		stockpileTime             = stockpiletime,
		startVelocity             = 10,
		tracks                    = true,
		turnRate                  = 3000,
		targetable			      = 1,
		
		weaponAcceleration        = 60,
		weaponTimer               = 5,
		weaponType                = "StarburstLauncher",
		weaponVelocity            = 1000,
		customparams              = {
			damagetype		      = "default",  
			death_sounds 		  = "nuke",
			oldcosttofireforumula = true,
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
