-- UNITDEF -- XSOLAR --
--------------------------------------------------------------------------------

local unitName                    = "xsolar"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local techrequired				 = [[tech1]]
local energyproduced			 = [[10]]

local buildCostMetal 			  = 100
local maxDamage					  = buildCostMetal * 12.5

local unitDef                     = {
	activateWhenBuilt             = true,
	buildAngle                    = 2048,
	buildCostEnergy               = 0,
	buildCostMetal                = buildCostMetal,
	builder                       = false,
	buildTime                     = 5,
	buildPic					  = "pattern/xsolar.png",
	canAttack			          = false,
	category                      = "BUILDING NOTAIR ECO",
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
	name                          = "Fission Energy Generator",
	objectName                    = "faction/xsolar.s3o",
	script                   	  = "faction/xsolar.cob",
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
		RequireTech				 = techrequired,
		armortype                 = armortype,
		noenergycost			  = true,
		normaltex               = "unittextures/bfaction_normals.dds",  
		factionname	              = "pattern",
		corpse                   = "energycore",
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
