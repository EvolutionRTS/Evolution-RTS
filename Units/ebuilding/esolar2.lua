-- UNITDEF -- ESOLAR2 --
--------------------------------------------------------------------------------

local unitName                    = "esolar2"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local energyproduced			 = [[5]]
--local powerprovided				 = [[1 power]]
--local powerradius				 = [[400]]
-- local supplygranted				 = [[5]]

local buildCostMetal 			  = 100
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
	description                   = [[Produces +]] .. energyproduced .. [[ Energy]],
	energyStorage                 = 0,
	energyMake                    = energyproduced,
	explodeAs                     = "mediumBuildingExplosionGenericBlueEMP",
	footprintX                    = 6,
	footprintZ                    = 6,
	icontype                      = "generator",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = maxDamage,
	maxSlope                      = 60,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = "Basic Energy Generator",
	objectName                    = "epowerplant6x6.s3o",
	onoffable                     = false,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "mediumBuildingExplosionGenericBlueEMP",
	side                          = "CORE",
	sightDistance                 = 367,
	smoothAnim                    = true,
	unitname                      = "esolar2",
	yardMap                       = "oooooo oooooo oooooo oooooo oooooo oooooo",

	sfxtypes                      = {
		pieceExplosionGenerators  = {
			"deathceg3",
			"deathceg4",
		},
		
		explosiongenerators       = {
			"custom:blacksmoke",
			"custom:fusionreactionbasic",
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
		death_sounds              = "generic",
--		ProvideTech               = powerprovided,
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
--		groundtexselectxsize      = 400, -- optional
--		groundtexselectzsize      = 400, -- optional
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
