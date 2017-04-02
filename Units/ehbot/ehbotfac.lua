-- UNITDEF -- EHBOTFAC --
--------------------------------------------------------------------------------

local unitName                    = "ehbotfac"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 30
local maxDamage					  = buildCostMetal * 12.5

local unitDef                     = {

	activatewhenbuilt             = false,
	buildAngle                    = 1024,
	buildCostEnergy               = 0,
	buildCostMetal                = buildCostMetal,
	builder                       = true,
	buildTime                     = 5,
	canAttack			          = false,
	canBeAssisted                 = true,
	canGuard                      = true,
	canMove                       = true,
	canPatrol                     = true,
	canReclaim		              = false,
	canstop                       = true,
	category                      = "BUILDING NOTAIR",
	corpse                        = "ammobox",
	description                   = [[Build a Tech Facility to unlock units. Build Supply Depots to increase your army size.]],
	energyStorage                 = 0,
	energyUse                     = 0,
	energyMake                    = 0,
	explodeAs                     = "MEXPOP2",
	footprintX                    = 20,
	footprintZ                    = 20,
	floater			              = true,
	iconType                      = "factory",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = maxDamage,
	maxSlope                      = 25,
	maxWaterDepth                 = 99999999999,
	metalStorage                  = 0,
	metalMake                     = 0,
	name                          = "H-Bot Factory",
	objectName                    = "ehbotfac.s3o",
	script	                      = "ehbotfac.cob",
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "LARGE_BUILDING",
	showNanoSpray                 = true,
	side                          = "CORE",
	sightDistance                 = 388,
	smoothAnim                    = true,
	TEDClass                      = "PLANT",
	unitname                      = unitName,
	--  unitRestricted	          = 1,
	workerTime                    = 1,
	yardMap                       = "oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo ",
	--  usePieceCollisionVolumes  = true,
	--  modelCenterOffset	      = {108, 10, 0},
	sfxtypes                      = { 
		pieceExplosionGenerators  = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators       = {
			"custom:nanoorb",
			"custom:nano",
			"custom:blacksmoke",
			"custom:fusionreactionbasic",
		},
	},
	buildoptions                  = {
--		"ehbotengineer",
		"ehbotpeewee",
		"ehbotthud",
		"ehbotsniper",
		"ehbotrocko",
	},
	sounds                        = {
		underattack               = "unitsunderattack1",
		select                    = {
			"gdfactoryselect",
		},
	},
	weapons                       = {
	},
	customParams                  = {
		unittype				  = "building",
		death_sounds              = "generic",
		armortype                 = "building", 
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "outer_colonies",   
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 20,
	BuildingGroundDecalSizeY      = 20,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
