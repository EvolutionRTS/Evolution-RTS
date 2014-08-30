-- UNITDEF -- EEXPERIMENTALFAC --
--------------------------------------------------------------------------------

local unitName                     = "eexperimentalfac"

--------------------------------------------------------------------------------

local unitDef                      = {

	activatewhenbuilt              = false,
	buildAngle                     = 1024,
	buildCostEnergy                = 0,
	buildCostMetal                 = 250,
	builder                        = true,
	buildTime                      = 2.5,
	canBeAssisted                  = true,
	canGuard                       = true,
	canMove                        = true,
	canPatrol                      = true,
	canReclaim		               = false,
	canstop                        = true,
	category                       = "BUILDING NOTAIR",
	corpse                         = "ammobox",
	description                    = [[Place generators near this factory to unlock higher tier units]],
	energyStorage                  = 0,
	energyUse                      = 0,
	energyMake                     = 0,
	explodeAs                      = "MEXPOP2",
	footprintX                     = 34,
	footprintZ                     = 34,
	iconType                       = "factory",
	idleAutoHeal                   = .5,
	idleTime                       = 2200,
	maxDamage                      = 5000,
	maxSlope                       = 25,
	maxWaterDepth                  = 0,
	metalStorage                   = 0,
	metalMake                      = 0,
	name                           = "Endbringer Class Factory",
	objectName                     = "eexperimentalfac.s3o",
	radarDistance                  = 0,
	repairable		               = false,
	selfDestructAs                 = "LARGE_BUILDING",
	showNanoSpray                  = "0",
	side                           = "CORE",
	sightDistance                  = 388,
	smoothAnim                     = true,
	TEDClass                       = "PLANT",
	unitname                       = "eexperimentalfac",
	unitrestricted	               = 1,
	workerTime                     = 1,
	yardMap                        = "ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo ooooooooooccccccccccccccoooooooooo",
	--  usePieceCollisionVolumes   = true,
	useBuildingGroundDecal         = true,
	BuildingGroundDecalType        = "factorygroundplate.dds",
	BuildingGroundDecalSizeX       = 36,
	BuildingGroundDecalSizeY       = 36,
	BuildingGroundDecalDecaySpeed  = 0.9,
	sfxtypes                       = { 
		pieceExplosionGenerators   = { 
			"deathceg0", 
			"deathceg1", 
		}, 

		explosiongenerators        = {
			"custom:nanohuge",
			"custom:blacksmoke",
		},
	},
	buildoptions                   = {
		"eextankdestroyer", --new
		"eexkrabgroth", --new
		"eexnukearty" --new
	},
	sounds                         = {
		underattack                = "unitsunderattack1",
		select                     = {
			"gdfactoryselect",
		},
	},
	customParams                   = {
		death_sounds               = "nuke",
		armortype                  = "building", 
		normalstex                 = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                  = "unittextures/lego2skin_explorerbucket.dds",
		factionname	               = "outer_colonies",  
		--	ProvideTech            = "1 Powergrid",
		--    ProvideTechRange     = "1500",
		--	groundtexselectimg     = ":nc:bitmaps/power/powergrid.png",
		--	groundtexselectxsize   = 1500, -- optional
		--    groundtexselectzsize = 1500, -- optional
	},
}



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
