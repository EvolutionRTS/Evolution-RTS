-- UNITDEF -- ESILO --
--------------------------------------------------------------------------------

local unitName                    = "esilo"

--------------------------------------------------------------------------------

local armortype					 = [[building]]

local weapon1Damage               = 1400
local weapon1AOE				  = 500
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)
--local stockpiletime				 = 60

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                     = {

	buildAngle                    = 8192,
	buildCostEnergy               = 0,
	buildCostMetal                = 450,
	builder                       = false,
	buildTime                     = 5,
	canAttack                     = true,
	canstop                       = "1",
	category                      = "BUILDING NOTAIR",
	corpse                        = "ammobox",
	description                   = [[Nuclear Missile Silo
Armortype: ]] ..armortype.. [[ 

]] .. weapon1Damage .. [[ Damage vs Light/Armored/Buildings

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire),
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
	maxDamage                     = 4000,
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
		death_sounds              = "nuke",
		armortype                 = "building",
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds", 
		helptext                  = [[]],
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
		commandfire               = true,
		craterBoost               = 0,
		craterMult                = 0,
		edgeeffectiveness		  = 1,
		energypershot             = energycosttofire,
		explosionGenerator        = "custom:NUKEDATBEWMSMALL",
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
		reloadtime                = 60,
		weaponType		          = "MissileLauncher",
		
		
		smokeTrail                = false,
		soundHit                  = "explosion_enormous.wav",
		soundStart                = "nukelaunch.wav",
		
--		stockpile                 = true,
--		stockpileTime             = stockpiletime,
		startVelocity             = 10,
		tracks                    = true,
		turnRate                  = 3000,
		targetable			      = 1,
		
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
