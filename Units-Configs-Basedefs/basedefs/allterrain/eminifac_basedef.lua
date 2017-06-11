-- ALL TERRAIN FACTORY : DEFFOS FOR INHERITING

unitDef                      = {
	activatewhenbuilt              = false,
	buildAngle                     = 1024,
	buildCostEnergy                = 0,
	buildCostMetal                 = buildCostMetal,
	builder                        = true,
	buildTime                      = 5,
	buildpic					   = "eminifac.png",
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

	description                    = [[Build a Tech Facility to unlock units. Build Supply Depots to increase your army size.]],
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
	name                           = humanName,
	objectName                     = objectName,
	script			               = script,
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
	buildoptions                   = AllTerrainFactoryBuildList,
	sounds                         = {
		underattack                = "other/unitsunderattack1",
		select                     = {
			"other/gdfactoryselect",
		},
	},
	customParams                   = {
		unittype				  = "building",
		death_sounds               = "generic",
		armortype                  = "building", 
		normaltex                 = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                  = "unittextures/lego2skin_explorerbucket.dds",
		factionname					= "outer_colonies",
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
