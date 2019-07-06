unitDef                    = {

	buildCostEnergy              = 0,
	buildCostMetal               = 15,
	buildDistance                = buildDistance,
	builder                      = true,
	buildTime                    = 5,
	buildpic					 = "zaal_unitpics/zarm.png",
	blocking					 = true,
	CanAttack			         = false,
	CanAssist			         = true,
	canBeAssisted                = true,
	CanCapture                   = false,
	CanRepair			         = true,
	canRestore					 = false,
	cantBeTransported			 = true,
	canGuard                     = false,
	canHover                     = false,
	canMove                      = false,
	canPatrol                    = false,
	canreclaim		             = false,
	canstop                      = true,
	category                     = "BUILDING",
	description                  = [[Builds Units]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGenericGreen",
	floater			              = true,
	footprintX                   = 6,
	footprintZ                   = 6,
	iconType                     = "engineer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	levelground                  = true,
	maxDamage                    = 500,
	maxSlope                     = 60,
	maxVelocity                  = 0.001,
	maxReverseVelocity           = 0.001,
	maxWaterDepth                = 5000,
	metalmake                    = 0,
	metalStorage                 = 0,
	--movementClass                = "ZAALKBOT6",
	moveState			         = 2,
	name                         = humanName,
	objectName                   = objectName,
	script			             = script,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericGreen",
	showNanoSpray                = true,
	side                         = "ARM",
	sightDistance                = buildDistance,
	smoothAnim                   = true,
	stealth			             = false,
	seismicSignature             = 2,
	unitname                     = unitName,
	upright                      = true,
	yardmap 					 = "oooooo oooooo oooooo oooooo oooooo oooooo",
	workerTime                   = 1,
	TerraformSpeed               = 2147000,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"blood_spray", 
		}, 

		explosiongenerators      = {
			"custom:blood_spray",
		},
	},
	buildoptions                 = Shared.buildListZaalArm,
	sounds                       = {
		underattack              = "other/unitsunderattack1",
		ok                       = {
			"ack",
		},
		select                   = {
			"unitselect",
		},
	},
	customParams                 = {
		unittype				 = "building",
		area_mex_def			 = "zhive",
		ProvideTech               = techprovided,
		canbetransported 		 = "false",
		needed_cover             = 1,
		death_sounds             = "generic",
		armortype                = armortype,
		normaltex               = "unittextures/zarm_normals.dds", 
		factionname	             = "zaal",  
	},
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
