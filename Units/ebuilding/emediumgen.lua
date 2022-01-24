-- UNITDEF -- EMEDIUMGEN --
--------------------------------------------------------------------------------

local unitName                    = "emediumgen"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local energyproduced			 = [[5]]
local powerprovided				 = [[5 power]]
local powerradius				 = [[500]]
--local supplygranted				 = [[25]]

local unitDef                     = {
	activateWhenBuilt             = true,
	buildAngle                    = 2048,
	buildCostEnergy               = 0,
	buildCostMetal                = 90,
	builder                       = false,
	buildTime                     = 5,
	canAttack			          = false,
	category                      = "BUILDING NOTAIR ECO",
	damageModifier                = 0.33333,
	description                   = [[Armortype: ]] ..armortype.. [[ 

Produces +]] .. energyproduced .. [[ Energy 

Provides +]] .. powerprovided,
	energyStorage                 = 0,
	energyMake                    = energyproduced,
	explodeAs                     = "largeBuildingExplosionGenericBlueEMP",
	footprintX                    = 3,
	footprintZ                    = 3,
	icontype                      = "generator",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = 1400,
	maxSlope                      = 60,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = "Medium Generator",
	objectName                    = "emediumgen.s3o",
	script						  = "emediumgen.cob",
	onoffable                     = false,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "largeBuildingExplosionGenericBlueEMP",
	side                          = "CORE",
	sightDistance                 = 367,
	smoothAnim                    = true,
	unitname                      = "emediumgen",
	yardMap                       = "oooooo oooooo oooooo oooooo oooooo oooooo ",

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
			"other/gdenergy",
		},
	},
	weapons                       = {
	},
	customParams                  = {
		unittype				  = "building",
		iseco                     = 1,
		needed_cover              = 4,
		death_sounds              = "generic",
		ProvideTech               = powerprovided,
--		ProvideTechRange          = powerradius,
		--	RequireTech           = "1 Powergrid",
		armortype                 = armortype,
--		supply_granted            = supplygranted,
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "ateran",
		corpse                   = "energycore",
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
