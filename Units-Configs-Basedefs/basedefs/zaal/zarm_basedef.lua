unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**

	acceleration                 = 0,
	brakeRate                    = 0,
	buildCostEnergy              = 0,
	buildCostMetal               = 40,
	buildDistance                = buildDistance,
	builder                      = true,
	buildTime                    = 5,
	CanAttack			         = false,
	CanAssist			         = false,
	canBeAssisted                = false,
	CanCapture                   = false,
	CanRepair			         = false,
	canRestore					 = false,
	cantBeTransported			 = true,
	canGuard                     = false,
	canHover                     = false,
	canMove                      = true,
	canPatrol                    = false,
	canreclaim		             = false,
	canstop                      = true,
	category                     = "LIGHT NOTAIR SUPPORT",
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
	movementClass                = "ZAALKBOT6",
	moveState			         = "0",
	pushResistant				 = true,
	name                         = humanName,
	objectName                   = objectName,
	script			             = script,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericGreen",
	showNanoSpray                = false,
	side                         = "ARM",
	sightDistance                = buildDistance,
	smoothAnim                   = true,
	stealth			             = false,
	seismicSignature             = 2,
	--  turnInPlace              = false,
	turnInPlace                  = true,
	turnRate                     = 0.001,
	--  turnrate                 = 1020,
	unitname                     = unitName,
	upright                      = true,
	workerTime                   = 1,
	capturespeed                 = 1,
	TerraformSpeed               = 100000,
	ReclaimSpeed                 = 0,
	repairspeed                  = 0.5,
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
		unittype				  = "building",
		area_mex_def			 = "zhive",
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
