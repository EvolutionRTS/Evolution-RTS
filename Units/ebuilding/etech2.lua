-- UNITDEF -- ETECH2 --
--------------------------------------------------------------------------------

local unitName                    = "etech2"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local energyproduced			 = [[0]]
local techprovided				 = [[tech0, tech1, tech2, 1 baseshield]]

local tech						 = [[tech1]]
--local supplygranted				 = [[25]]

local buildCostMetal 			  = 300
local maxDamage					  = buildCostMetal * 12.5

local unitDef                     = {
	activateWhenBuilt             = true,
	buildAngle                    = 2048,
	buildCostEnergy               = 0,
	buildCostMetal                = buildCostMetal,
	builder                       = false,
	buildTime                     = 5,
	canAttack			          = false,
	category                      = "BUILDING NOTAIR ECO",
	corpse                        = "ammobox",
	damageModifier                = 0.33333,
	description                   = "",
	energyStorage                 = 0,
	energyMake                    = energyproduced,
	explodeAs                     = "hugeBuildingExplosionGenericPurple",
	footprintX                    = 6,
	footprintZ                    = 6,
	icontype                      = "energy",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = maxDamage,
	maxSlope                      = 60,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = "Tech Level 2 Facility",
	objectName                    = "emediumgen.s3o",
	script						  = "emediumgen.cob",
	onoffable                     = false,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "hugeBuildingExplosionGenericPurple",
	side                          = "CORE",
	sightDistance                 = 367,
	smoothAnim                    = true,
	unitname                      = unitName,
	yardMap                       = "oooooo oooooo oooooo oooooo oooooo oooooo ",

	sfxtypes                      = {
		pieceExplosionGenerators  = {
			"deathceg3",
			"deathceg4",
		},
		
		explosiongenerators       = {
			"custom:blacksmoke",
			"custom:fusionreactionnuclearpurple",
			"custom:skyhatelaser",
		},
	},

	sounds                        = {
		underattack               = "other/unitsunderattack1",
		select                    = {
			"other/gdenergy",
		},
	},
	customParams                  = {
		unittype				  = "building",
		iseco                     = 1,
		needed_cover              = 4,
		death_sounds              = "generic",
		ProvideTech               = techprovided,
		RequireTech               = tech,
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
--		groundtexselectxsize      = 500, -- optional
--		groundtexselectzsize      = 500, -- optional
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 8,
	BuildingGroundDecalSizeY      = 8,
	BuildingGroundDecalDecaySpeed = 0.9,
}
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
