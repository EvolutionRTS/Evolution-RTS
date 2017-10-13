-- UNITDEF -- EAIRENGINEER --
--------------------------------------------------------------------------------

local unitName                   = "eairfacai_up2"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 80
local maxDamage					  = 450

local armortype					 = [[light]]
--local supply					 = [[2]]

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 0.5,
	airStrafe                    = true,
	brakeRate                    = 0.5,
	buildCostEnergy              = 0,
	buildCostMetal               = buildCostMetal,
	buildTime                    = 2.5,
	builder                      = true,
	buildDistance                = 600,
	capturable		             = false,
	canAttack                    = false,
	CanAssist			         = true,
	canBeAssisted                = true,
	CanCapture                   = false,
	CanRepair			         = true,
	canRestore					 = false,
	canDropFlare                 = true,
	canFly                       = true,
	canGuard                     = true,
	canLoopbackAttack            = true,
	canMove                      = true,
	canPatrol                    = true,
	canreclaim		             = false,
	canstop                      = true,
	category                     = "LIGHT VTOL",
	collide                      = true,
	corpse                       = "ammobox",
	cruiseAlt                    = 300,
	description                  = [[Builds Units]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGenericGreen",
	flareDelay                   = 0.1,
	flareDropVector              = "0 0 -1",
	flareefficieny               = "0.3",
	flareReload                  = 3,
	floater                      = true,
	footprintX                   = 4,
	footprintZ                   = 4,
	hoverAttack                  = true,
	iconType                     = "engineer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	maxBank 			         = 5,
	maxDamage                    = maxDamage,
	maxSlope                     = 90,
	maxVelocity                  = 7,
	verticalSpeed		         = 15,
	maxWaterDepth                = 0,
	metalStorage                 = 0,
	moverate1                    = "8",
	moveState			         = "2",
	name                         = "The Originator",
	objectName                   = "eairengineer2.s3o",
	script			             = "eairengineer2.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericGreen",
	showNanoSpray                = true,
	sightDistance                = 600,
	smoothAnim                   = true,
	turnRate                     = 5000,
	unitname                     = unitName,
	unitnumber                   = "148",
	workerTime                   = 1,
	capturespeed                 = 1,
	TerraformSpeed               = 100000,
	ReclaimSpeed                 = 0,
	repairspeed                  = 0.15625,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:jethtrail",
			"custom:nanoorb",
			"custom:blacksmoke",
		},
	},
	buildoptions                 = Shared.buildListAIOverseer,
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
		unittype				  = "mobile",
		area_mex_def			 = "emetalextractor",
		--    needed_cover       = 2,
		death_sounds             = "generic",
		armortype                = armortype,
--		supply_cost              = supply,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
		helptext				 = [[Armortype: ]] .. armortype,
	},
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
