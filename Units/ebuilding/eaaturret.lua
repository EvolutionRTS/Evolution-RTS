-- UNITDEF -- EAATURRET --
--------------------------------------------------------------------------------

local unitName                    = "eaaturret"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local supply					 = [[2]]

local weapon1Damage               = 112.5
local weapon1AOE				  = 300
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                     = {

	buildCostEnergy               = 0,
	buildCostMetal                = 20,
	builder                       = false,
	buildTime                     = 5,
	canAttack                     = true,
	canstop                       = "1",
	category                      = "BUILDING NOTAIR",
	corpse                        = "ammobox",
	description                   = [[Anti-Air Flak Turret
Armortype: ]] ..armortype.. [[ 

112.5 Damage vs Armored
75 Damage vs Light/Building

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire) .. [[ 

Uses +]] .. supply .. [[ Supply]],
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "mediumBuildingExplosionGeneric",
	floater			              = true,
	footprintX                    = 5,
	footprintZ                    = 5,
	icontype                      = "defense",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = 800,
	maxSlope                      = 60,
	maxWaterDepth                 = 99999999999,
	metalStorage                  = 0,
	name                          = "Copperhead",
	noAutoFire                    = false,
	objectName                    = "eaaturret2.s3o",
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "mediumBuildingExplosionGeneric",
	sightDistance                 = 1500,
	smoothAnim                    = true,
	unitname                      = "eaaturret",
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
			def                   = "antiairgunflak",
			onlytargetcategory    = "VTOL",
		},
	},
	customParams                  = {
		unittype				  = "turret",
		supply_cost               = supply,
		needed_cover              = 1,
		death_sounds              = "generic",
		armortype                 = armortype,
		nofriendlyfire	          = "1",
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
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

local weaponDefs                  = {
	antiairgunflak                = {
		AreaOfEffect              = weapon1AOE,
		avoidFriendly             = false,
		avoidFeature              = false,
		collideFriendly           = false,
		collideFeature            = false,
		cylinderTargeting         = true,
		burnblow                  = true,
		explosionGenerator        = "custom:xamelImpact",
		energypershot             = energycosttofire,
		fireStarter               = 80,
		id                        = 1,
		impulseFactor             = 0,
		interceptedByShieldType   = 4,
		name                      = "AA Cannon",
		range                     = 1500,
		reloadtime                = 1,
		weaponType		          = "Cannon",
		soundHit                  = "flakhit",
		soundStart                = "flakgun_shoot.wav",
		tolerance                 = 500,
		turret                    = true,
		canAttackGround           = false,
		weaponVelocity            = 5000,
		customparams              = {
			damagetype		      = "eaaturret",  
			nofriendlyfire	      = 1,
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
