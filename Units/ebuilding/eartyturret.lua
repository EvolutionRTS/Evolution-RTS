-- UNITDEF -- EARTYTURRET --
--------------------------------------------------------------------------------

local unitName                    = "eartyturret"

--------------------------------------------------------------------------------

local supply					 = [[2]]

local unitDef                     = {

	buildCostEnergy               = 0,
	buildCostMetal                = 20,
	builder                       = false,
	buildTime                     = 5,
	canAttack                     = true,
	canstop                       = "1",
	category                      = "BUILDING NOTAIR",
	corpse                        = "ammobox",
	description                   = [[Medium Range Artillery Turret
	Building
	
	200 Damage vs Buildings
	50 Damage vs Light/Armored
	
	Uses +]] .. supply .. [[ Supply]],
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "MEDIUM_BUILDING",
	floater			              = true,
	footprintX                    = 5,
	footprintZ                    = 5,
	icontype                      = "defense",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = 600,
	maxSlope                      = 60,
	maxWaterDepth                 = 99999999999,
	metalStorage                  = 0,
	name                          = "Lobber",
	noAutoFire                    = false,
	objectName                    = "eaaturret2.s3o",
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "MEDIUM_BUILDING",
	sightDistance                 = 800,
	smoothAnim                    = true,
	unitname                      = "eartyturret",
	yardMap                       = "ooooo ooooo ooooo ooooo ooooo",
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
		underattack               = "unitsunderattack1",
		select                    = {
			"turretselect",
		},
	},
	weapons                       = {
		[1]                       = {
			def                   = "artyweapon",
			onlytargetcategory    = "BUILDING",
		},
	},
	customParams                  = {
		supply_cost               = supply,
		needed_cover              = 1,
		death_sounds              = "generic",
		armortype                 = "building",
		nofriendlyfire	          = "1",
		normalstex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "outer_colonies",  
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 7,
	BuildingGroundDecalSizeY      = 7,
	BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weapon1Damage               = 200
local weapon1AOE				  = 50

local weaponDefs                  = {
	artyweapon  		          = {
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		ballistic                = true,
		cegTag                   = "artyshot2",
		avoidNeutral	         = false,
		explosionGenerator       = "custom:genericshellexplosion-large",
		energypershot            = weapon1Damage / 20 * ((weapon1AOE / 1000) + 1),
		edgeEffectiveness        = 1,
		impulse                  = "0",
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		highTrajectory	         = 1,
		name                     = "Plasma Cannon",
		range                    = 800,
		reloadtime               = 4,
		weaponType		         = "Cannon",
		soundHit                 = "artyhit.wav",
		soundStart               = "arty2.wav",
		startsmoke               = "1",
		turret                   = true,
		weaponVelocity           = 500,
		customparams             = {
			damagetype		     = "eartytank", 

			--Upgrades--
			upgradeClass		 = "groundweapons",	  
		},  
		damage                   = {
			default              = weapon1Damage,
		},
	},

}
unitDef.weaponDefs               = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
