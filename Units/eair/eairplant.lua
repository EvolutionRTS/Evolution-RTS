-- UNITDEF -- EAIRPLANT --
--------------------------------------------------------------------------------

local unitName                        = "eairplant"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 30
local maxDamage					  = buildCostMetal * 12.5

local armortype					 = [[building]]

local unitDef                         = {

	activatewhenbuilt                 = true,
	buildCostEnergy                   = 0,
	buildCostMetal                    = buildCostMetal,
	builder                           = true,
	buildTime                         = 2.5,
	canBeAssisted                     = true,
	canGuard                          = true,
	canMove                           = true,
	canPatrol                         = true,
	canReclaim		                  = false,
	canstop                           = true,
	category                          = "BUILDING NOTAIR VTOL",
	corpse                            = "ammobox",
	description                       = [[Build a Tech Facility to unlock units. Build Supply Depots to increase your army size.]],
	energyStorage                     = 0,
	energyUse                         = 0,
	energyMake                        = 0,
	explodeAs                         = "MEXPOP2",
	floater			                  = true,
	footprintX                        = 18,
	footprintZ                        = 18,
	iconType                          = "factory",
	idleAutoHeal                      = .5,
	idleTime                          = 2200,
	levelground		                  = false,
	maxDamage                         = maxDamage,
	maxSlope                          = 90,
	maxWaterDepth                     = 999999,
	metalStorage                      = 0,
	metalMake                         = 0,
	mobilestandorders                 = "1",
	name                              = "Aircraft Plant",
	objectName                        = "eairplant3.s3o",
	script			                  = "eairplant3.cob",
	radarDistance                     = 0,
	repairable		                  = false,
	selfDestructAs                    = "LARGE_BUILDING",
	showNanoSpray                     = true,
	sightDistance                     = 388,
	smoothAnim                        = true,
	TEDClass                          = "PLANT",
	unitname                          = unitName,
	--  unitRestricted	              = 1,
	unitnumber                        = "83",
	workerTime                        = 1,
	yardMap                           = "oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo oooooooooooooooooo",
	--  usePieceCollisionVolumes      = true,

	sfxtypes                          = { 
		pieceExplosionGenerators      = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators           = {
			"custom:nanoorb",
			"custom:nano",
			"custom:blacksmoke",
			"custom:fusionreactionbasic",
			"custom:airfactoryhtrail",
		},
	},
	zbuffer                           = "1",
	buildoptions                      = {
--		"eairengineer",
		"escout", --new
		"efighter", --new
		"egunship2", --new
		"ebomber", --new
		"etransport", --new

	},
	sounds                            = {
		underattack                   = "unitsunderattack1",
		select                        = {
			"gdfactoryselect",
		},
	},
	customParams                      = {
		unittype				  = "building",
		death_sounds                  = "generic",
		armortype                     = armortype, 
		normaltex                    = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                     = "unittextures/lego2skin_explorerbucket.dds",
		factionname	                  = "outer_colonies",  
		--	ProvideTech               = "1 Powergrid",
		--    ProvideTechRange        = "1500",
		--	groundtexselectimg        = ":nc:bitmaps/power/powergrid.png",
		--	groundtexselectxsize      = 1500, -- optional
		--    groundtexselectzsize    = 1500, -- optional
	},
	--  useGroundDecal                = true,
	--  BuildingGroundDecalType       = "factorygroundplate.dds",
	--  BuildingGroundDecalSizeX      = 20,
	--  BuildingGroundDecalSizeY      = 20,
	--  BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]         = unitDef })

--------------------------------------------------------------------------------
