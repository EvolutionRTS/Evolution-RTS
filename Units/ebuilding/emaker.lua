-- UNITDEF -- EMAKER --
--------------------------------------------------------------------------------

local unitName                    = "emaker"

--------------------------------------------------------------------------------

local unitDef                     = {
	activateWhenBuilt             = true,
	buildAngle                    = 8192,
	buildCostEnergy               = 0,
	buildCostMetal                = 150,
	builder                       = false,
	buildTime                     = 5,
	canAttack			          = false,
	category                      = "BUILDING NOTAIR",
	corpse                        = "ammobox",
	damageModifier                = 0.5,
	description                   = [[Fabricates Metal
	Generates +0.5 metal per second]],
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "largeBuildingExplosionGenericPurple",
	footprintX                    = 8,
	footprintZ                    = 8,
	iconType                      = "eco",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	makesMetal                    = 0.5,
	maxDamage                     = 1700,
	maxSlope                      = 30,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = "Metal Fabricator",
	objectName                    = "emaker3.s3o",
	script			              = "emaker3.cob",
	onoffable                     = true,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "largeBuildingExplosionGenericPurple",
	side                          = "ARM",
	sightDistance                 = 360,
	smoothAnim                    = true,
	unitname                      = "emaker",
	workerTime                    = 0,
	yardMap                       = "oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo",

	sfxtypes                      = {
		pieceExplosionGenerators  = {
			"deathceg3",
			"deathceg4",
		},
		
		explosiongenerators       = {
			"custom:blacksmoke",
			"custom:fusionreactionmakernew",
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
		iseco                     = 1,
		needed_cover              = 8,
		death_sounds              = "generic",
		armortype                 = "building",
		normalstex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds", 
		factionname	              = "outer_colonies",
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 12,
	BuildingGroundDecalSizeY      = 12,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
