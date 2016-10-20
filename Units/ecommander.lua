-- UNITDEF -- ECOMMANDER --
--------------------------------------------------------------------------------

local unitName                   = "ecommander"

--------------------------------------------------------------------------------

local armortype					 = [[light]]
local supplyGiven				 = [[10]]

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false; 

	--**

	acceleration                 = 0.2,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 500,
	buildDistance                = 1000,
	builder                      = true,
	buildTime                    = 2.5,
	capturable		             = false,
	CanAttack			         = true,
	CanAssist			         = true,
	canBeAssisted                = true,
	CanCapture                   = true,
	CanRepair			         = true,
	cancollect                   = "1",
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canreclaim		             = false,
	canstop                      = true,
	category                     = "NOTAIR SUPPORT LIGHT",
	description                  = [[Builds Units • Gives ]] ..supplyGiven.. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "commnuke",
	fireState			         = "1",
	footprintX                   = 4,
	footprintZ                   = 4,
	hideDamage		             = true,
	iconType                     = "commander",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	levelground                  = true,
	maxDamage                    = 5000,
	maxSlope                     = 180,
	maxVelocity                  = 3,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 5000,
	metalmake                    = 0,
	metalStorage                 = 0,
	movementClass                = "COMMANDERTANK4",
	moveState			         = "0",
	name                         = "The Overseer",
	noChaseCategories	         = "NOTAIR SUPPORT VTOL AMPHIB",
	objectName                   = "ecommander4.s3o",
	script			             = "ecommander3.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "commnuke",
	showPlayerName	             = true,
	showNanoSpray                = true,
	sightDistance                = 500,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	turnInPlace                  = true,
	turnRate                     = 5000,
	unitname                     = unitName,
	unitRestricted	             = 1,
	upright                      = false,
	workerTime                   = 1,
	capturespeed                 = 0.25,
	TerraformSpeed               = 100000,
	ReclaimSpeed                 = 0,
	-- 0.03125                   = 1 hp per second
	repairspeed                  = 0.15625,
	sfxtypes                     = {
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 
		
		explosiongenerators      = {
			"custom:nanoorb",
			"custom:dirt",
			"custom:blacksmoke",
		},
	},
	buildoptions                 = {
		"ehbotfac",
		"eminifac", --new
		"ebasefactory", --new
		"eamphibfac",
		"eairplant",
--		"eexperimentalfac",
--		"emetalextractor", --new
--		"emaker", --new
		--"esolar2", --new
		--"emediumgen", --new
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
		"eshieldgen",
		"esilo",
		"emine",
		"eorb",
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
	weapons                      = {
		[1]                      = {
			def                  = "emp",
		},
	},
	customParams                 = {
		canbetransported 		 = "true",
		iscommander              = true,
		needed_cover             = 2,
		supply_granted            = supplyGiven,
		death_sounds             = "generic",
		cancollect               = "1",
		armortype                = armortype,
		nofriendlyfire	         = "1",
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",
		helptext                 = [[Armortype: ]] ..armortype.. [[ 

1000 EMP Damage vs Light/Armored/Building

Reclaims any energy cores within it's proximity.]],
	},
}

--------------------------------------------------------------------------------

local weaponDefs                 = {
	emp                          = {
		AreaOfEffect             = 500,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		explosionGenerator       = "custom:genericshellexplosion-large-blue-emp",
		tolerance                = 1000,
		energypershot            = 0,
		explosionScar		     = false,
		impulseFactor            = 0,
		name                     = "Emp Blast Weapon",
		noSelfDamage            = true,
		paralyzer		         = true,
		paralyzetime	         = 5,
		range                    = 500,
		reloadtime               = 10,
		weaponType		         = "Cannon",
		soundhit                 = "emp.wav",
		size				     = 0,
		turret                   = true,
		weaponVelocity           = 10000,
		customparams             = {
			damagetype		     = "default",
			nofriendlyfire	     = 1,
			
			--Upgrades--
			upgradeClass		 = "groundweapons",
		},      
		damage                   = {
			default              = 1000,
		},
	},
	commnuke                   = {
		AreaOfEffect              = 500,
		avoidFriendly             = false,
		avoidFeature              = false,
		cegTag                    = "NUKETRAIL",
		collideFriendly           = false,
		collideFeature            = false,
		commandfire               = true,
		craterBoost               = 0,
		craterMult                = 0,
		edgeeffectiveness		  = 0.1,
		energypershot             = 0,
		explosionGenerator        = "custom:NUKEDATBEWMSMALL",
		fireStarter               = 100,
		flightTime                = 400,
		
		id                        = 124,
		impulseBoost              = 0,
		impulseFactor             = 0,
		interceptedByShieldType   = 4,
		
		metalpershot              = 0,
		model                     = "enuke.s3o",
		name                      = "Nuke",
		range                     = 32000,
		reloadtime                = 60,
		weaponType		          = "MissileLauncher",
		
		
		smokeTrail                = false,
		soundHit                  = "explosion_enormous.wav",
		soundStart                = "nukelaunch.wav",
		
--		stockpile                 = true,
--		stockpileTime             = stockpiletime,
		startVelocity             = 10,
		tracks                    = true,
		turnRate                  = 3000,
		targetable			      = 1,
		
		weaponAcceleration        = 30,
		weaponTimer               = 15,
		weaponType                = "StarburstLauncher",
		weaponVelocity            = 1000,
		customparams              = {
			damagetype		      = "default",  
			death_sounds 		  = "nuke",
		},      
		damage                    = {
			default               = 1000,
		},
	},
}
unitDef.weaponDefs               = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
