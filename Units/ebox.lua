-- UNITDEF -- EBOX --
--------------------------------------------------------------------------------

local unitName                   = "ebox"

--------------------------------------------------------------------------------

local armortype					 = [[armored]]

local techrequired				 = [[tech1]]

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**

	acceleration                 = 1,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 35,
	buildDistance                = 400,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = false,
	canCapture					 = false,
	canGuard                     = true,
	canHover                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "ARMORED NOTAIR",
	description                  = [[Long Range Radar and Seismic Detection]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "largeExplosionGenericWhite",
	footprintX                   = 6,
	footprintZ                   = 6,
	iconType                     = "box",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 400,
	maxSlope                     = 26,
	maxVelocity                  = 4,
	maxReverseVelocity           = 4,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "HOVERTANK6",
	name                         = "B.O.X.",
	noChaseCategory              = "VTOL",
	objectName                   = "ebox.s3o",
	script			             = "ebox_lus.lua",
	radarDistance                = 1250,
	radarEmitHeight				 = 300,
	repairable		             = false,
	selfDestructAs               = "largeExplosionGenericWhite",
	side                         = "CORE",
	sightDistance                = 250,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	seismicDistance              = 1250,
	turnInPlace                  = true,
	turnRate                     = 5000,
	unitname                     = unitName,
	upright                      = true,
	workerTime                   = 2,
	
	sfxtypes                     = {
		pieceExplosionGenerators = {
			"deathceg3",
			"deathceg4",
		},
		explosiongenerators      = {
			"custom:dirt",
		},
	},
	
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
		RequireTech				 = techrequired,
		unittype				  = "mobile",
		canbetransported 		 = "true",
		armortype                = armortype,
		energycoredronespawner   = true,
		needed_cover             = 1,
		death_sounds             = "generic",
		nofriendlyfire	         = "1",
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies", 
		helptext                 = [[]],
		retreatRangeDAI			 = 1250,
	},
}

--------------------------------------------------------------------------------

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
