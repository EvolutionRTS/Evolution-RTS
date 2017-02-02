-- UNITDEF -- EBASEFACTORY_t2 --
--------------------------------------------------------------------------------

local unitName                    = "ebasefactory_t2"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 460
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
	name                          = "Hovertank Factory Upgraded",
	objectName                    = "ehoverfactory.s3o",
	script	                      = "ehoverfac.cob",
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "LARGE_BUILDING",
	showNanoSpray                 = true,
	side                          = "CORE",
	sightDistance                 = 388,
	smoothAnim                    = true,
	TEDClass                      = "PLANT",
	unitname                      = "ebasefactory_t2",
	--  unitRestricted	          = 1,
	workerTime                    = 1,
	yardMap                       = "oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo oooccccccccccccccooo",
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
		"eengineer5_t2", --new
		"elighttank3_t2", --new
		--    "eflametank", --new
		"eriottank2_t2", --new
		--    "emediumtank3", --new
		"eheavytank3_t2", --new
		"emissiletank_t2", --new
--		"eaatank",
		--	"efatso2", --new
		"eartytank_t2", --new
		--    "ebomb",
		"elacerator_t2", --new
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
		death_sounds              = "generic",
		armortype                 = "building", 
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "outer_colonies",   
		helptext                  = [[The hovertank factory is the most robust of all the technology avenues in Evolution RTS. Unlike their amphibious and all-terrain counterparts, the Hover Factory does not possess any innate traits (other than the ability to traverse the surface of water), but the larger selection of units makes up for the lack of innate abilities.]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 26,
	BuildingGroundDecalSizeY      = 26,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
