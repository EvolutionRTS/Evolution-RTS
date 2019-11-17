-- UNITDEF -- xstorage --
--------------------------------------------------------------------------------

local unitName                    = "xstorage"

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
	buildpic					  = [[pattern/xstorage.png]],
	canAttack			          = false,
	category                      = "BUILDING NOTAIR ECO",

	description                   = [[Provides +]] .. supplygranted .. [[ Supply • Provides +]] .. storage .. [[ Metal/Energy Storage]],
	energyStorage                 = storage,
	metalStorage                 = storage,
	energyUse                     = 0,
	explodeAs                     = "smallBuildingExplosionGenericPurple",
	footprintX                    = 8,
	footprintZ                    = 8,
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	icontype                      = "storage",
	maxDamage                     = maxDamage,
	maxSlope                      = 50,
	maxWaterDepth                 = 5000,
	--metalStorage                  = storage,
	name                          = "Supply/Storage Depot",
	objectName                    = "faction/xstorage.s3o",
	script			              = "faction/xstorage.cob",
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "smallBuildingExplosionGenericPurple",
	side                          = "CORE",
	sightDistance                 = 367,
	smoothAnim                    = true,
	unitname                      = "xstorage",
	workerTime                    = 0,
	yardMap                       = "oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo",

	sfxtypes                      = {
		pieceExplosionGenerators  = {
			"deathceg3",
			"deathceg4",
		},
		
		explosiongenerators       = {
			"custom:blacksmoke",
			"custom:fusionreactionstoragenew",
			"custom:fusionreactionstoragenew-blue",
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
		normaltex                = "unittextures/bfaction_normals.dds", 
		--buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "ateran",  
		helptext                  = [[]],
		corpse                   = "energycore",
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 12,
	BuildingGroundDecalSizeY      = 12,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
