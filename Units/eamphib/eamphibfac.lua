-- UNITDEF -- EAMPHIBFAC --
--------------------------------------------------------------------------------

local unitName                     = "eamphibfac"

--------------------------------------------------------------------------------

local unitDef                      = {

	activatewhenbuilt              = false,
	buildAngle                     = 1024,
	buildCostEnergy                = 0,
	buildCostMetal                 = 60,
	builder                        = true,
	buildTime                      = 5,
	canBeAssisted                  = true,
	canGuard                       = true,
	canMove                        = true,
	canPatrol                      = true,
	canReclaim		               = false,
	canstop                        = true,
	category                       = "BUILDING NOTAIR AMPHIB",
	--   collisionVolumeOffsets    = "0 20 0",
	--   collisionVolumeScales     = "238 92 128",
	--   collisionVolumeTest       = 1,
	--   collisionVolumeType       = "box",
	corpse                         = "ammobox",
	description                    = [[Place generators near this factory to unlock higher tier units]],
	energyStorage                  = 0,
	energyUse                      = 0,
	energyMake                     = 0,
	explodeAs                      = "MEXPOP2",
	footprintX                     = 16,
	footprintZ                     = 16,
	iconType                       = "factory",
	idleAutoHeal                   = .5,
	idleTime                       = 2200,
	maxDamage                      = 1500,
	maxSlope                       = 25,
	maxWaterDepth                  = 5000,
	metalStorage                   = 0,
	metalMake                      = 0,
	name                           = "Amphibious Tank Factory",
	objectName                     = "eamphibfac2.s3o",
	script			               = "eamphibfac2.cob",
	radarDistance                  = 0,
	repairable		               = false,
	selfDestructAs                 = "LARGE_BUILDING",
	showNanoSpray                  = "0",
	side                           = "CORE",
	sightDistance                  = 388,
	SonarDistance                  = 175,
	smoothAnim                     = true,
	TEDClass                       = "PLANT",
	unitname                       = "eamphibfac",
	--  unitRestricted	           = 1,
	workerTime                     = 1,
	yardMap                        = "ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo ccccccccoooooooo",
	--  usePieceCollisionVolumes   = true,

	useGroundDecal                 = true,
	BuildingGroundDecalType        = "factorygroundplate.dds",
	BuildingGroundDecalSizeX       = 18,
	BuildingGroundDecalSizeY       = 18,
	BuildingGroundDecalDecaySpeed  = 0.9,
	sfxtypes                       = { 
		pieceExplosionGenerators   = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators        = {
			"custom:nanoorb",
			"custom:nano",
			"custom:blacksmoke",
			"custom:fusionreactionbasic",
		},
	},
	buildoptions                   = {
		"eamphibengineer", --new
		"eamphibbuggy", --new
		"eamphibriot", --new
		"eamphibaa",
		"eamphibmedtank", --new
		"eamphibrock", --new
		"eamphibarty", --new
	},
	sounds                         = {
		underattack                = "unitsunderattack1",
		select                     = {
			"gdfactoryselect",
		},
	},
	customParams                   = {
		death_sounds               = "generic",
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

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
