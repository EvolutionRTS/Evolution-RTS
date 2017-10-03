-- UNITDEF -- EARTYTURRET --
--------------------------------------------------------------------------------

local unitName                    = "eartyturret"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local supply					 = [[15]]
local techrequired				 = [[tech3]]

local weapon1Damage               = 1000
local weapon1AOE				  = 500
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local buildCostMetal 			  = 500
local maxDamage					  = buildCostMetal * 12.5

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                     = {

	buildCostEnergy               = 0,
	buildCostMetal                = buildCostMetal,
	builder                       = false,
	buildTime                     = 5,
	canAttack                     = true,
	canstop                       = "1",
	category                      = "BUILDING NOTAIR",
	corpse                        = "ammobox",
	description                   = [[Long Range Artillery Turret • Uses +]] .. supply .. [[ Supply]],
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "mediumBuildingExplosionGeneric",
	floater			              = true,
	footprintX                    = 8,
	footprintZ                    = 8,
	icontype                      = "turret_arty",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = maxDamage,
	maxSlope                      = 60,
	maxWaterDepth                 = 99999999999,
	metalStorage                  = 0,
	name                          = "Lobber",
	noAutoFire                    = false,
	objectName                    = "eartyturret.s3o",
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "mediumBuildingExplosionGeneric",
	sightDistance                 = 500,
	smoothAnim                    = true,
	unitname                      = "eartyturret",
	yardMap                       = "oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo",
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
			def                   = "artyweapon",
			badtargetcategory    = "LIGHT ARMORED",
		},
	},
	customParams                  = {
		RequireTech				 = techrequired,
		unittype				  = "turret",
		supply_cost               = supply,
		needed_cover              = 1,
		death_sounds              = "generic",
		armortype                 = armortype,
		nofriendlyfire	          = "1",
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "outer_colonies",  
		helptext                  = [[Armortype: ]] ..armortype.. [[ 

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire),
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 10,
	BuildingGroundDecalSizeY      = 10,
	BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                  = {
	artyweapon  		          = {
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		
		cegTag                   = "artyshot2",
		avoidNeutral	         = false,
		explosionGenerator       = "custom:NUKEDATBEWMSMALL",
		energypershot            = energycosttofire,
		edgeEffectiveness        = 1,
		
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		name                     = "Plasma Cannon",
		range                    = 8000,
		reloadtime               = 40,
		size					 = 16,
		weaponType		         = "Cannon",
		soundHit                 = "explosions/artyhit.wav",
		soundStart               = "weapons/arty2.wav",
		
		turret                   = true,
		weaponVelocity           = 1000,
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
