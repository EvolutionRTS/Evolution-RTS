-- UNITDEF -- EBASEFACTORY --
--------------------------------------------------------------------------------

local unitName = "ebasefactory"

--------------------------------------------------------------------------------

local unitDef = {

	activatewhenbuilt  = false,
	buildAngle         = 1024,
	buildCostEnergy    = 0,
	buildCostMetal     = 60,
	builder            = true,
	buildTime          = 5,
	canAttack			 = false,
	canBeAssisted      = true,
	canGuard           = true,
	canMove            = true,
	canPatrol          = true,
	canReclaim		 = false,
	canstop            = true,
	category           = "BUILDING NOTAIR",
	corpse             = "ammobox",
	description        = [[Place generators near this factory to unlock higher tier units]],
	energyStorage      = 0,
	energyUse          = 0,
	energyMake         = 0,
	explodeAs          = "MEXPOP2",
	footprintX         = 20,
	footprintZ         = 20,
	floater			 = true,
	iconType           = "factory",
	idleAutoHeal       = .5,
	idleTime           = 2200,
	maxDamage          = 1500,
	maxSlope           = 25,
	maxWaterDepth      = 99999999999,
	metalStorage       = 0,
	metalMake          = 0,
	name               = "Hovertank Factory",
	objectName         = "ehoverfactory.s3o",
	script	         = "ehoverfac.cob",
	radarDistance      = 0,
	repairable		 = false,
	selfDestructAs     = "LARGE_BUILDING",
	showNanoSpray      = "0",
	side               = "CORE",
	sightDistance      = 388,
	smoothAnim         = true,
	TEDClass           = "PLANT",
	unitname           = "ebasefactory",
	--  unitRestricted	 = 1,
	workerTime         = 1,
	yardMap            = "ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo ooooooccccccccoooooo",
	--  usePieceCollisionVolumes = true,
	--  modelCenterOffset	 = {108, 10, 0},
	sfxtypes = { 
		pieceExplosionGenerators = { 
			"deathceg0", 
			"deathceg1", 
		}, 

		explosiongenerators = {
			"custom:nanoorb",
			"custom:nano",
			"custom:blacksmoke",
			"custom:fusionreactionbasic",
		},
	},
	buildoptions = {
		"eengineer5", --new
		"elighttank3", --new
		--    "eflametank", --new
		"eriottank2", --new
		--    "emediumtank3", --new
		"eheavytank3", --new
		"emissiletank", --new
		"eaatank",
		--	"efatso2", --new
		"eartytank", --new
		--    "ebomb",
	},
	sounds = {
		underattack        = "unitsunderattack1",
		select = {
			"gdfactoryselect",
		},
	},
	weapons = {
	},
	customParams = {
		death_sounds = "generic",
		armortype   = "building", 
		normalstex = "unittextures/lego2skin_explorernormal.dds", 
		buckettex = "unittextures/lego2skin_explorerbucket.dds",
		factionname	= "outer_colonies",   
		helptext = [[The hovertank factory is the most robust of all the technology avenues in Evolution RTS. Unlike their amphibious and all-terrain counterparts, the Hover Factory does not possess any innate traits, but the larger selection of units makes up for the lack of innate abilities.]],
	},
	useBuildingGroundDecal = true,
	BuildingGroundDecalType = "factorygroundplate.dds",
	BuildingGroundDecalSizeX = 26,
	BuildingGroundDecalSizeY = 26,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
