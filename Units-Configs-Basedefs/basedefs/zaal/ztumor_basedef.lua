unitDef                    = {

	buildCostEnergy              = 0,
	buildCostMetal               = 10,
	buildDistance                = buildDistance,
	builder                      = true,
	buildTime                    = 20,
	buildpic					 = "zaal_unitpics/ztumor.png",
	blocking					 = false,
	CanAttack			         = true,
	CanAssist			         = false,
	canBeAssisted                = false,
	CanCapture                   = false,
	CanRepair			         = false,
	canRestore					 = false,
	cantBeTransported			 = true,
	canGuard                     = false,
	canHover                     = false,
	canMove                      = false,
	canPatrol                    = false,
	canreclaim		             = false,
	canstop                      = true,
	category                     = "BUILDING",
	
	-- Cloaking

	cancloak		             = true,
	cloakCost		             = 0,
	cloakCostMoving	             = 0,
	minCloakDistance             = 0,
	decloakOnFire	             = false,
	decloakSpherical             = true,
	initCloaked		             = true,
	
	-- End Cloaking
	
	description                  = [[Builds Units]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "BUG_DEATH_MEDIUM",
	floater			              = true,
	footprintX                   = 2,
	footprintZ                   = 2,
	iconType                     = "boxsmall",
	levelground                  = false,
	maxDamage                    = 100,
	maxSlope                     = 90,
	maxVelocity                  = 0.001,
	maxReverseVelocity           = 0.001,
	maxWaterDepth                = 5000,
	metalmake                    = 0,
	metalStorage                 = 0,
	--movementClass                = "ZAALKBOT6",
	moveState			         = 2,
	name                         = humanName,
	noChaseCategory              = "VTOL LIGHT ARMORED BUILDING",
	objectName                   = objectName,
	script			             = script,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "BUG_DEATH_MEDIUM",
	showNanoSpray                = false,
	sightDistance                = 0,
	smoothAnim                   = true,
	stealth			             = false,
	seismicDistance 			 = buildDistance,
	seismicSignature             = 2,
	unitname                     = unitName,
	upright                      = false,
	yardmap 					 = "oooo oooo oooo oooo",
	workerTime                   = 1,
	TerraformSpeed               = 2147000,
	usePieceCollisionVolumes	 = false,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"blood_spray", 
		}, 

		explosiongenerators      = {
			"custom:blood_spray",
		},
	},
	buildoptions                 = Shared.buildListZaalTumor,
	sounds                       = {
		underattack              = "other/unitsunderattack1",
		ok                       = {
			"ack",
		},
		select                   = {
			"BugSelect",
		},
	},
	customParams                 = {
		unittype				 = "building",
		--area_mex_def			 = "zhatch",
		--ProvideTech              = techprovided,
		unitdefbuildtime		 = true,
		decloakradiusmodifier	 = 20,
		canbetransported 		 = "false",
		needed_cover             = 1,
		death_sounds             = "bug",
		armortype                = armortype,
		normaltex               = "unittextures/ztumor_normals.dds", 
		factionname	             = "zaal",  
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "zgroundtexture.dds",
	BuildingGroundDecalSizeX      = 14,
	BuildingGroundDecalSizeY      = 14,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
