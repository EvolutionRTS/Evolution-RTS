-- UNITDEF -- ESCOUT_t2 --
--------------------------------------------------------------------------------

local unitName                   = "escout_t2"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 40
local maxDamage					  = 160 * 1.20

local power						 = [[1 power]]
local armortype					 = [[light]]

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 0.5,
	airStrafe                    = false,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 40,
	builder                      = false,
	buildTime                    = 2.5,
	canFly                       = true,
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "LIGHT VTOL",
	collide                      = false,
	corpse                       = "ammobox",
	cruiseAlt                    = 180,
	description                  = [[Unit Type: Air Scout
Armortype: ]] ..armortype.. [[ 

Requires +]] .. power,
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGenericBlue",
	footprintX                   = 4,
	footprintZ                   = 4,
	hoverAttack                  = true,
	floater                      = true,
	iconType                     = "air",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	isTargetingUpgrade           = false,
	maxDamage                    = 160,
	maxSlope                     = 90,
	maxVelocity                  = 20,
	verticalSpeed		         = 15,
	maxWaterDepth                = 0,
	metalStorage                 = 0,
	name                         = "AirScout T2",
	objectName                   = "escout2.s3o",
	script			             = "escout2.cob",
	radarDistance                = 1500,
	SonarDistance                = 1500,
	SeismicDistance	             = 1500,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericBlue",
	side                         = "ARM",
	sightDistance                = 750,
	smoothAnim                   = true,
	turnRate                     = 5000,
	unitname                     = unitName,
	workerTime                   = 0,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:jethtrail",
			"custom:blacksmoke",
		},
	},
	sounds                       = {
		underattack              = "unitsunderattack1",
		ok                       = {
			"ack",
		},
		select                   = {
			"unitselect",
		},
	},
	customParams                 = {
		--    needed_cover       = 1,
		death_sounds             = "generic",
		RequireTech              = power,
		armortype                = armortype,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
	},
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
