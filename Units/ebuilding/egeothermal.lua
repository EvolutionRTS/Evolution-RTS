-- UNITDEF -- EGEOTHERMAL --
--------------------------------------------------------------------------------

local unitName                    = "egeothermal"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local energyproduced			 = [[7]]
local techprovided				 = [[1 Generator]]
local powerradius				 = [[600]]
--local supplygranted				 = [[35]]

local unitDef                     = {
	activateWhenBuilt             = true,
	buildAngle                    = 2048,
	buildCostEnergy               = 0,
	buildCostMetal                = 100,
	builder                       = false,
	buildTime                     = 5,
	canAttack			          = false,
	category                      = "BUILDING NOTAIR ECO",
	corpse                        = "ammobox",
	description                   = [[Produces +]] .. energyproduced .. [[ Energy • Provides +]] .. techprovided,
	energyMake                    = energyproduced,
	energyStorage                 = 0,
	explodeAs                     = "largeBuildingExplosionGenericBlueEMP",
	footprintX                    = 4,
	footprintZ                    = 4,
	iconType                      = "energy",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = 2000,
	maxSlope                      = 60,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = "Geothermal Generator",
	objectName                    = "egeothermal2.s3o",
	onoffable			          = false,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "largeBuildingExplosionGenericBlueEMP",
	side                          = "ARM",
	sightDistance                 = 367,
	smoothAnim                    = true,
	unitname                      = "egeothermal",
	workerTime                    = 0,
	yardMap                       = "oooo oGGo oGGo oooo",

	sfxtypes                      = {
		pieceExplosionGenerators  = {
			"deathceg3",
			"deathceg4",
		},
		explosiongenerators       = {
			"custom:blacksmoke",
			"custom:fusionreactiongeo",
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
		needed_cover              = 2,
		death_sounds              = "generic",
		ProvideTech               = techprovided,
--		ProvideTechRange          = powerradius,
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
--		groundtexselectxsize      = 600, -- optional
--		groundtexselectzsize      = 600, -- optional
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 6,
	BuildingGroundDecalSizeY      = 6,
	BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
