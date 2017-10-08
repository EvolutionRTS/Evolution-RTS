-- UNITDEF -- EMETALEXTRACTOR --
--------------------------------------------------------------------------------

local unitName                    = "emetalextractor"

--------------------------------------------------------------------------------

local armortype					 = [[building]]

-- The math here is a bit more complicated than it should need to be mainly because the autohosts don't do well with decimal points, so first we pull numbers from 0 - 200 via the modoptions.
-- First we want to use the raw metalmultiplier amount from modoptions to determine the energy use, so we first multiply mexenergyusemultiplier by 0.001 (to move the decimal point over an extra place). This gets us a reasonable energy cost for each mex in existence.
-- Then metal income multiplier is multiplied by 0.1 so that we can then feed that number back to the luamex gadget which then does the actual mex spot calculations.
-- After that we calculate the cost of the mex using 250 as a base. This base cost can be altered by changing the multiplier in modoptions.
-- Finally, we calculate the HP of the mex based upon how much it costs.

-- It's a little bit overengineered, but the end result is a pretty dynamic luamex setup.
local metalMultiplier = tonumber(Spring.GetModOptions().mexincomemultiplier) or 50 -- Make sure to change this default number in the luamex config options, mex unitdef, and in modoptions
local energyUse = tonumber(Spring.GetModOptions().mexenergyusemultiplier) or 0
local energyUse = energyUse * 0.001
local energyUse = metalMultiplier * energyUse
local metalMultiplier = metalMultiplier * 0.01

local mexBaseCostMultiplier		  = tonumber(Spring.GetModOptions().mexbasecostmultiplier) or 100
local mexBaseCost			 	  = mexBaseCostMultiplier * 0.25
local buildCostMetal 			  = mexBaseCost * metalMultiplier
local maxDamage					  = buildCostMetal * 12.5
	
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
	description                   = [[Generates Metal from Resource Nodes]],
	energyStorage                 = 0,
	energyUse                     = energyUse,
	explodeAs                     = "largeBuildingExplosionGenericRed",
	makesMetal                    = 1,
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
			"custom:fusionreactionnuclear",
			"custom:skyhatelaser",
		},
	},
	sounds                        = {
		underattack               = "other/unitsunderattack1",
		select                    = {
			"other/gdmex",
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
