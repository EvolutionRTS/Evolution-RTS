-- UNITDEF -- EAIRENGINEERAI --
--------------------------------------------------------------------------------

local unitName                   = "eairengineerai"

--------------------------------------------------------------------------------

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 0.5,
	airStrafe                    = true,
	brakeRate                    = 0.5,
	buildCostEnergy              = 0,
	buildCostMetal               = 80,
	buildTime                    = 2.5,
	builder                      = true,
	buildDistance                = 600,
	canAttack                    = false,
	CanAssist			         = true,
	canBeAssisted                = true,
	CanCapture                   = false,
	CanRepair			         = true,
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
	description                  = "Airborne Engineer :: Armortype: Light",
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
	maxDamage                    = 450,
	maxSlope                     = 90,
	maxVelocity                  = 7,
	verticalSpeed		         = 15,
	maxWaterDepth                = 0,
	metalStorage                 = 0,
	moverate1                    = "8",
	moveState			         = "2",
	name                         = "The Originator (AI)",
	objectName                   = "eairengineer2.s3o",
	script			             = "eairengineer2.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericGreen",
	showNanoSpray                = false,
	sightDistance                = 600,
	smoothAnim                   = true,
	turnRate                     = 5000,
	unitname                     = "eairengineerai",
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
	buildoptions                 = {
		"eminifac", --new
		"ebasefactory", --new
		"eamphibfac",
		"eairplant",
		"eexperimentalfac",
		"emetalextractorai", --new
		"emaker", --new
		"esolar2", --new
		"egeothermal", --new
		"efusion2", --new
		"estorage", --new
		"eradar2", --new
		"ejammer2", --new
		"ekmar",
		"elightturret2", --new
		"eheavyturret2", --new
		"eartyturret",
		"euwturret",
		"ecruisesilo",
		"eshieldgen",
		"esilo",
		"emine",
		"eorb",
		"ecommander",
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
		--    airdronespawner    = "1",
		armortype                = "light",
		normalstex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
	},
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
