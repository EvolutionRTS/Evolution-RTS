-- UNITDEF -- ETRANSPORT --
--------------------------------------------------------------------------------

local unitName                   = "etransport"

--------------------------------------------------------------------------------

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 0.5,
	airStrafe                    = true,
	airHoverFactor	             = 0,
	brakeRate                    = 0.5,
	buildCostEnergy              = 0,
	buildCostMetal               = 20,
	builder                      = false,
	buildTime                    = 2.5,
	canAttack                    = false,
	canFly                       = true,
	canGuard                     = false,
	canMove                      = true,
	canload                      = true,
	canPatrol                    = false,
	canstop                      = "1",
	category                     = "ARMORED VTOL",
	collide                      = true,
	corpse                       = "ammobox",
	cruiseAlt                    = 150,
	description                  = [[Fast Armored Transport
	Armored

	Requires +2 Power
	Uses +2 Supply]],
	energyMake                   = 0,
	energyUse                    = 0,
	explodeAs                    = "hugeExplosionGenericRed",
	fallSpeed                    = 1000,
	footprintX                   = 8,
	footprintZ                   = 8,
	hoverAttack                  = true,
	holdSteady                   = true,
	--  hoverAttack              = true,
	icontype                     = "etransport",
	maxAcc                       = 0.3,
	maxDamage                    = 550,
	maxSlope                     = 60,
	maxVelocity                  = 18,
	verticalSpeed		         = 30,
	name                         = "Charter",
	objectName                   = "etransport2.s3o",
	script			             = "etransport2.cob",
	releaseHeld                  = false,
	repairable		             = false,
	selfDestructAs               = "hugeExplosionGenericRed",
	side                         = "GD",
	sightDistance                = 500,
	smoothAnim                   = true,
	transportCapacity            = 1,
	transportMass                = 10000,
	transportSize                = 6,
	--  transportUnloadMethod    = 1,
	turnRate                     = 900,
	unitname                     = "etransport",
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
		--    needed_cover       = 2,
		death_sounds             = "generic",
		RequireTech              = "2 Power",
		armortype                = "armored",
		supply_cost              = 2,
		normalstex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
	},
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
