-- UNITDEF -- EMINIFAC_t2 --
--------------------------------------------------------------------------------

local unitName                     = "eminifac_t2"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 460
local maxDamage					  = buildCostMetal * 12.5

local armortype					 = [[building]]

local unitDef                      = {

	activatewhenbuilt              = false,
	buildAngle                     = 1024,
	buildCostEnergy                = 0,
	buildCostMetal                 = buildCostMetal,
	builder                        = true,
	buildTime                      = 5,
	canBeAssisted                  = true,
	canGuard                       = true,
	canMove                        = true,
	canPatrol                      = true,
	canReclaim		               = false,
	canstop                        = true,
	category                       = "BUILDING NOTAIR",

	collisionVolumeOffsets         = "0 60 0",
	collisionVolumeScales          = "298 142 168",
	collisionVolumeTest            = 1,
	collisionVolumeType            = "box",

	corpse                         = "ammobox",

	-- Cloaking

	cancloak		               = true,
	cloakCost		               = 0,
	minCloakDistance               = 250,
	decloakOnFire	               = true,
	decloakSpherical               = true,
	initCloaked		               = false,
	
	-- End Cloaking

	description                    = [[Build a Tech Facility to unlock units. Build Supply Depots to increase your army size.
Armortype: ]] ..armortype,
	energyStorage                  = 0,
	energyUse                      = 0,
	energyMake                     = 0,
	explodeAs                      = "MEXPOP2",
	footprintX                     = 22,
	footprintZ                     = 22,
	iconType                       = "factory",
	idleAutoHeal                   = .5,
	idleTime                       = 2200,
	maxDamage                      = maxDamage,
	maxSlope                       = 90,
	maxWaterDepth                  = 0,
	metalStorage                   = 0,
	metalMake                      = 0,
	name                           = "All-Terrain Factory Upgraded",
	objectName                     = "eallterrfac2.s3o",
	script			               = "eallterrfac2.cob",
	radarDistance                  = 0,
	repairable		               = false,
	selfDestructAs                 = "LARGE_BUILDING",
	showNanoSpray                     = true,
	sightDistance                  = 388,
	smoothAnim                     = true,
	TEDClass                       = "PLANT",
	unitname                       = unitName,
	--  unitRestricted	           = 1,
	workerTime                     = 1,
	yardMap                        = "oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo oooccccccccccccccccooo",
	--  usePieceCollisionVolumes   = true,
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
--		"eallterrengineer_t2", --new
		"eallterrlight_t2",
		"eallterrriot_t2",
--		"eallterraa",
		"eallterrmed_t2",
		"eallterrheavy_t2",
		"eallterrassault_t2",
		"eallterranarchid_t2",
		"eallterrshield_t2",
	},
	sounds                         = {
		underattack                = "unitsunderattack1",
		select                     = {
			"gdfactoryselect",
		},
	},
	customParams                   = {
		death_sounds               = "generic",
		armortype                  = armortype, 
		normaltex                 = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                  = "unittextures/lego2skin_explorerbucket.dds",
		--	ProvideTech            = "1 Powergrid",
		--    ProvideTechRange     = "1500",
		--	groundtexselectimg     = ":nc:bitmaps/power/powergrid.png",
		--	groundtexselectxsize   = 1500, -- optional
		--    groundtexselectzsize = 1500, -- optional
	},
	useGroundDecal                 = true,
	BuildingGroundDecalType        = "factorygroundplate.dds",
	BuildingGroundDecalSizeX       = 27,
	BuildingGroundDecalSizeY       = 27,
	BuildingGroundDecalDecaySpeed  = 0.9,
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
