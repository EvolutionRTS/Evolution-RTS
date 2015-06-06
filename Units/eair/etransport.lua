-- UNITDEF -- ETRANSPORT --
--------------------------------------------------------------------------------

local unitName                   = "etransport"

--------------------------------------------------------------------------------

local power						 = [[5 power]]
local armortype					 = [[armored]]
local supply					 = [[0]]

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 0.5,
	airStrafe                    = true,
	airHoverFactor	             = 0,
	brakeRate                    = 2,
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
	description                  = [[Unit Type: Fast Armored Transport
Armortype: ]] ..armortype.. 
[[ 

Requires +]] .. power .. [[ 
Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyUse                    = 0,
	explodeAs                    = "hugeExplosionGenericRed",
	fallSpeed                    = 1000,
	footprintX                   = 3,
	footprintZ                   = 3,
	hoverAttack                  = true,
	holdSteady                   = true,
	--  hoverAttack              = true,
	icontype                     = "etransport",
	maxDamage                    = 200,
	maxSlope                     = 90,
	maxVelocity                  = 18,
	verticalSpeed		         = 30,
	name                         = "Charter",
	objectName                   = "etransport2-small.s3o",
	script			             = "etransport2.cob",
	releaseHeld                  = false,
	repairable		             = false,
	selfDestructAs               = "hugeExplosionGenericRed",
	side                         = "GD",
	sightDistance                = 500,
	smoothAnim                   = true,
	transportCapacity            = 2,
	transportMass                = 10000,
	transportSize                = 6,
	transportUnloadMethod   	 = 0,
	turnRate                     = 5000,
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
		transportcapa      		 = "6",
		death_sounds             = "generic",
		RequireTech              = power,
		armortype                = armortype,
		supply_cost              = supply,
		normalstex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
	},
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
