-- UNITDEF -- EFUSION2 --
--------------------------------------------------------------------------------

local unitName                    = "efusion2"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local energyproduced			 = [[10]]
local techprovided				 = [[1 Generator]]
local powerradius				 = [[800]]
--local supplygranted				 = [[50]]

local unitDef                     = {
	activateWhenBuilt             = true,
	buildAngle                    = 2500,
	buildCostEnergy               = 0,
	buildCostMetal                = 125,
	builder                       = false,
	buildTime                     = 5,
	canAttack			          = false,
	category                      = "BUILDING NOTAIR ECO",
	corpse                        = "ammobox",
	description                   = [[Produces +]] .. energyproduced .. [[ Energy • Provides +]] .. techprovided,
	energyStorage                 = 0,
	energyMake                    = energyproduced,
	explodeAs                     = "hugeBuildingExplosionGenericBlueEMP",
	footprintX                    = 8,
	footprintZ                    = 8,
	iconType                      = "energy",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = 2400,
	maxSlope                      = 60,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = "Generator",
	objectName                    = "efusion2.s3o",
	onoffable 		              = false,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "hugeBuildingExplosionGenericBlueEMP",
	side                          = "ARM",
	sightDistance                 = 367,
	smoothAnim                    = true,
	unitname                      = "efusion2",
	workerTime                    = 0,
	yardMap                       = "oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo",

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
		underattack               = "unitsunderattack1",
		select                    = {
			"gdenergy",
		},
	},
	weapons                       = {
	},
	customParams                  = {
		iseco                     = 1,
		needed_cover              = 5,
		death_sounds              = "generic",
		ProvideTech               = techprovided,
--		ProvideTechRange          = powerradius,
		--	RequireTech           = "1 Powergrid",
		armortype                 = armortype,
--		supply_granted            = supplygranted,
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "outer_colonies",  
--		groundtexselectimg        = ":nc:bitmaps/power/power.png",
--		groundtexselectimg1       = ":nc:bitmaps/power/power1.png",
--		groundtexselectimg2       = ":nc:bitmaps/power/power2.png",
--		groundtexselectimg3       = ":nc:bitmaps/power/power3.png",
--		groundtexselectimg4       = ":nc:bitmaps/power/power4.png",
--		groundtexselectimg5       = ":nc:bitmaps/power/power5.png",
--		groundtexselectimg6       = ":nc:bitmaps/power/power6.png",
--		groundtexselectxsize      = 800, -- optional
--		groundtexselectzsize      = 800, -- optional
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 10,
	BuildingGroundDecalSizeY      = 10,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
