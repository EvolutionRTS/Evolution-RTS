-- UNITDEF -- ESOLAR2 --
--------------------------------------------------------------------------------

local unitName                    = "esolar2"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local energyproduced			 = [[1]]
local powerprovided				 = [[1 power]]
local powerradius				 = [[400]]
local supplygranted				 = [[5]]

local unitDef                     = {
	activateWhenBuilt             = true,
	buildAngle                    = 2048,
	buildCostEnergy               = 0,
	buildCostMetal                = 20,
	builder                       = false,
	buildTime                     = 5,
	canAttack			          = false,
	category                      = "BUILDING NOTAIR ECO",
	corpse                        = "ammobox",
	damageModifier                = 0.33333,
	description                   = [[Armortype: ]] ..armortype.. [[ 

Produces +]] .. energyproduced .. [[ Energy 

Provides +]] .. powerprovided .. [[ 
Power Radius: ]] .. powerradius .. [[ 

Provides +]] .. supplygranted .. [[ Supply]],
	energyStorage                 = 0,
	energyMake                    = energyproduced,
	explodeAs                     = "mediumBuildingExplosionGenericBlueEMP",
	footprintX                    = 4,
	footprintZ                    = 4,
	icontype                      = "energy",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = 800,
	maxSlope                      = 60,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = "Basic Generator",
	objectName                    = "epowerplant.s3o",
	onoffable                     = false,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "mediumBuildingExplosionGenericBlueEMP",
	side                          = "CORE",
	sightDistance                 = 367,
	smoothAnim                    = true,
	unitname                      = "esolar2",
	yardMap                       = "oooo oooo oooo oooo",

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
		ProvideTech               = powerprovided,
		ProvideTechRange          = powerradius,
		--	RequireTech           = "1 Powergrid",
		armortype                 = armortype,
		supply_granted            = supplygranted,
		normalstex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "outer_colonies",  
		groundtexselectimg        = ":nc:bitmaps/power/power.png",
		groundtexselectimg1       = ":nc:bitmaps/power/power1.png",
		groundtexselectimg2       = ":nc:bitmaps/power/power2.png",
		groundtexselectimg3       = ":nc:bitmaps/power/power3.png",
		groundtexselectimg4       = ":nc:bitmaps/power/power4.png",
		groundtexselectimg5       = ":nc:bitmaps/power/power5.png",
		groundtexselectimg6       = ":nc:bitmaps/power/power6.png",
		groundtexselectxsize      = 400, -- optional
		groundtexselectzsize      = 400, -- optional
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
