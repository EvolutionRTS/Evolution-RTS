-- UNITDEF -- EMETALEXTRACTOR --
--------------------------------------------------------------------------------

local unitName                    = "emetalextractor"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local metal						 = [[0.5]] --The actual amount is set in resourcegifts gadget

local buildCostMetal 			  = 20
local maxDamage					  = buildCostMetal * 12.5

local energyUse = tonumber(Spring.GetModOptions().mexenergyuse) or 2.5
local metalMultiplier = tonumber(Spring.GetModOptions().mexincomemultiplier) or 1
	
local unitDef                     = {

	activateWhenBuilt             = true,
	buildAngle                    = 2048,
	buildCostEnergy               = 0,
	buildCostMetal                = buildCostMetal,
	buildingMask				  = 0,
	builder                       = false,
	buildTime                     = 5,
	canAttack			          = false,
	category                      = "BUILDING NOTAIR ECO",
	corpse                        = "ammobox",
	description                   = [[Generates Metal from Resource Nodes at the cost of -2.5 Energy/s]],
	energyStorage                 = 0,
	energyUse                     = energyUse,
	explodeAs                     = "largeBuildingExplosionGenericRed",
	makesMetal                    = 0,
	footprintX                    = 7,
	footprintZ                    = 7,
	iconType                      = "eco",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = maxDamage,
	maxSlope                      = 60,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	metalMake                     = 0,
	name                          = "Metal Extractor",
	objectName                    = "emetalextractor2.s3o",
	onoffable                     = true,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "largeBuildingExplosionGenericRed",
	selfDestructCountdown         = 1,
	side                          = "CORE",
	sightDistance                 = 200,
	smoothAnim                    = true,
	unitname                      = "emetalextractor",
	workerTime                    = 0,
	yardMap                       = "ooooooo ooooooo ooooooo ooooooo ooooooo ooooooo ooooooo",
	sfxtypes                      = { 
		pieceExplosionGenerators  = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators       = {
			"custom:blacksmoke",
			"custom:fusionreactionmex",
			"custom:skyhatelaser",
		},
	},
	sounds                        = {
		underattack               = "unitsunderattack1",
		select                    = {
			"gdmex",
		},
	},
	weapons                       = {
	},
	customParams                  = {
		unittype				  = "building",
		metal_extractor			  = metalMultiplier,
		iseco                     = 1,
		needed_cover              = 3,
		death_sounds              = "generic",
		armortype                 = armortype,
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "outer_colonies", 
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 9,
	BuildingGroundDecalSizeY      = 9,
	BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
