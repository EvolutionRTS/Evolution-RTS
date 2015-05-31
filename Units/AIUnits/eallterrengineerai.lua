-- UNITDEF -- EALLTERRENGINEERAI --
--------------------------------------------------------------------------------

local unitName                   = "eallterrengineerai"

--------------------------------------------------------------------------------

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 1,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 45,
	buildDistance                = 800,
	builder                      = true,
	buildTime                    = 5,
	CanAttack			         = false,
	CanAssist			         = true,
	canBeAssisted                = true,
	CanCapture                   = false,
	CanRepair			         = true,
	cancollect                   = "1",
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canreclaim		             = false,
	canstop                      = true,
	category                     = "LIGHT NOTAIR SUPPORT",
	corpse                       = "ammobox",

	-- Cloaking

	cancloak		             = true,
	cloakCost		             = 1,
	cloakCostMoving	             = 2,
	minCloakDistance             = 70,
	decloakOnFire	             = true,
	decloakSpherical             = true,
	initCloaked		             = false,
	
	-- End Cloaking

	description                  = [[Engineer
	Light]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGenericGreen",
	footprintX                   = 3,
	footprintZ                   = 3,
	iconType                     = "engineer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	levelground                  = true,
	maxDamage                    = 600,
	maxSlope                     = 180,
	maxVelocity                  = 3,
	maxReverseVelocity           = 1,
	turninplacespeedlimit        = 3,
	maxWaterDepth                = 10,
	metalmake                    = 0,
	metalStorage                 = 0,
	mobilestandorders            = "1",
	movementClass                = "ALLTERRTANK3",
	moveState			         = "2",
	name                         = "The Architect (AI)",
	objectName                   = "eallterrengineer.s3o",
	script						 = "eallterrengineer.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericGreen",
	showNanoSpray                = "0",
	sightDistance                = 500,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	turnInPlace                  = true,
	turnRate                     = 5000,
	unitname                     = "eallterrengineerai",
	unitrestricted				  = 4,
	unitnumber                   = "20",
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
			"custom:nanoorb",
			"custom:dirtsmall",
			"custom:blacksmoke",
		},
	},
	buildoptions                 = {
		"eminifacai", --new
		"ebasefactoryai", --new
		"eamphibfacai",
		"eairplantai",
		"eexperimentalfac",
		"emetalextractorai", --new
		"emaker", --new
		"esolar2ai", 
		"emediumgenai",--new
		"egeothermal", --new
		"efusion2ai", --new
		"estorageai", --new
		"eradar2", --new
		"ejammer2", --new
		"ekmar",
		"elightturret2ai", --new
		"eheavyturret2ai", --new
		"eartyturret",
		"euwturret",
		"ecruisesiloai",
		"eshieldgen",
		"esilo",
		"emineai",
		"eorbai",
		"ecommanderai",
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
		canbetransported 		 = "true",
		needed_cover             = 1,
		death_sounds             = "generic",
		dronespawner             = "1",
		armortype                = "light",
		normalstex               = "unittextures/con_legonormal.png", 
	},
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
