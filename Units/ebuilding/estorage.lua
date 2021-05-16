-- UNITDEF -- ESTORAGE --
--------------------------------------------------------------------------------

local unitName                    = "estorage"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local storage					  = 25
local supplygranted				  = 10

local buildCostMetal 			  = 25
local maxDamage					  = buildCostMetal * 12.5

local unitDef                     = {
	activateWhenBuilt             = true,
	buildAngle                    = 8196,
	buildCostEnergy               = 0,
	buildCostMetal                = buildCostMetal,
	builder                       = false,
	buildTime                     = 5,
	canAttack			          = false,
	category                      = "BUILDING NOTAIR ECO",

	collisionVolumeScales         = [[66 74 126]],
	collisionVolumeOffsets        = [[0 10 0]],
	collisionVolumeTest           = 1,
	collisionVolumeType           = "box",

	description                   = [[Provides +]] .. supplygranted .. [[ Supply • Provides +]] .. storage .. [[ Metal/Energy Storage]],
	energyStorage                 = storage,
	metalStorage                 = storage,
	energyUse                     = 0,
	explodeAs                     = "smallBuildingExplosionGenericPurple",
	footprintX                    = 2,
	footprintZ                    = 4,
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	icontype                      = "storage",
	maxDamage                     = maxDamage,
	maxSlope                      = 50,
	maxWaterDepth                 = 5000,
	--metalStorage                  = storage,
	name                          = "Supply/Storage Depot",
	objectName                    = "estorage2_small.s3o",
	script			              = "estorage2.cob",
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "smallBuildingExplosionGenericPurple",
	side                          = "CORE",
	sightDistance                 = 367,
	smoothAnim                    = true,
	unitname                      = "estorage",
	workerTime                    = 0,
	yardMap                       = "oo oo oo oo oo oo oo oo",

	sfxtypes                      = {
		pieceExplosionGenerators  = {
			"deathceg3",
			"deathceg4",
		},
		
		explosiongenerators       = {
			"custom:blacksmoke",
			"custom:fusionreactionstoragenew-small",
			"custom:fusionreactionstoragenew-blue-small",
			"custom:skyhatelaser",
		},
	},

	sounds                        = {
		underattack               = "other/unitsunderattack1",
		select                    = {
			"other/gdenergy",
		},
	},
	weapons                       = {
	},
	customParams                  = {
		unittype				  = "building",
		iseco                     = 1,
		needed_cover              = 2,
		supply_granted            = supplygranted,
		death_sounds              = "generic",
		armortype                 = "building", 
		noenergycost			  = true,
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "ateran",  
		helptext                  = [[]],
		corpse                   = "energycore",
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 4,
	BuildingGroundDecalSizeY      = 6,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
