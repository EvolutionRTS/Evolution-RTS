-- UNITDEF -- EFUSION2 --
--------------------------------------------------------------------------------

local unitName                    = "efusion2"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local techrequired				 = [[tech3]]
local energyproduced			 = [[50]]

local buildCostMetal 			  = 400
local maxDamage					  = buildCostMetal * 12.5

local unitDef                     = {
	activateWhenBuilt             = true,
	buildAngle                    = 2500,
	buildCostEnergy               = 0,
	buildCostMetal                = buildCostMetal,
	builder                       = false,
	buildTime                     = 5,
	canAttack			          = false,
	category                      = "BUILDING NOTAIR ECO",
	description                   = [[Produces +]] .. energyproduced .. [[ Energy]],
	energyStorage                 = 0,
	energyMake                    = energyproduced,
	explodeAs                     = "hugeBuildingExplosionGenericBlueEMP",
	footprintX                    = 12,
	footprintZ                    = 12,
	iconType                      = "generator",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = maxDamage,
	maxSlope                      = 60,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = "Cold Fusion Energy Generator",
	objectName                    = "efusion2-huge.s3o",
	onoffable 		              = false,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "hugeBuildingExplosionGenericBlueEMP",
	side                          = "ARM",
	sightDistance                 = 367,
	smoothAnim                    = true,
	unitname                      = "efusion2",
	yardMap                       = "oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo oooooooooooo",

	sfxtypes                      = { 
		pieceExplosionGenerators  = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators       = {
			"custom:blacksmoke",
			"custom:fusionreactionnuclear-huge-4color",
			"custom:skyhatelaser",
		},
	},
	sounds                        = {
		underattack               = "other/unitsunderattack1",
		select                    = {
			"other/gdenergy.wav",
		},
	},
	weapons                       = {
	},
	customParams                  = {
		unittype				  = "building",
		iseco                     = 1,
		needed_cover              = 5,
		death_sounds              = "generic",
		RequireTech				 = techrequired,
		armortype                 = armortype,
		noenergycost			  = true,
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
--		groundtexselectxsize      = 800, -- optional
--		groundtexselectzsize      = 800, -- optional
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 14,
	BuildingGroundDecalSizeY      = 14,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
