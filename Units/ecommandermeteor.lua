-- UNITDEF -- ECOMMANDERMETEOR --
--------------------------------------------------------------------------------

local unitName                   = "ecommandermeteor"

--------------------------------------------------------------------------------

local armortype				 = [[armored]]
--local supplyGiven				 = [[10]]
local techprovided				 = [[tech0, -overseer]]
local techrequired				 = [[0 overseer, tech3]]


local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false; 

	--**

	acceleration                 = 0.2,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 2500,
	buildDistance                = 500,
	builder                      = true,
	buildTime                    = 2.5,
	capturable		             = false,
	CanAttack			         = true,
	CanAssist			         = true,
	canBeAssisted                = true,
	CanCapture                   = false,
	CanRepair			         = true,
	canRestore					 = false,
	
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canreclaim		             = false,
	canstop                      = true,
	category                     = "NOTAIR SUPPORT ARMORED",
	description                  = [[Builds Units • Provides support in battles]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "commnuke",
	footprintX                   = 4,
	footprintZ                   = 4,
	hideDamage		             = true,
	iconType                     = "commander",
	idleAutoHeal                 = 5,
	idleTime                     = 300,
	levelground                  = true,
	maxDamage                    = 10000,
	maxSlope                     = 180,
	maxVelocity                  = 3,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 5000,
	metalmake                    = 0,
	metalStorage                 = 0,
	movementClass                = "COMMANDERTANK4",
	moveState			         = "0",
	name                         = "The Meteor Overseer",
	noChaseCategories	         = "NOTAIR SUPPORT VTOL AMPHIB",
	fireState					 = 0,
	objectName                   = "ecommander4.s3o",
	script			             = "ecommander4-meteor.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "commnuke",
	showPlayerName	             = true,
	showNanoSpray                = true,
	sightDistance                = 650,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	turnInPlace                  = true,
	turnRate                     = 5000,
	unitname                     = unitName,
	upright                      = false,
	workerTime                   = 1,
	capturespeed                 = 0.25,
	TerraformSpeed               = 2147000,
	ReclaimSpeed                 = 0,
	-- 0.03125                   = 1 hp per second
	repairspeed                  = 0.5,
	sfxtypes                     = {
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 
		
		explosiongenerators      = {
			"custom:nanoorb",
			"custom:dirt",
			"custom:blacksmoke",
			"custom:gdhcannon",
		},
	},
	buildoptions                 = Shared.buildList,
	sounds                       = {
		build					 = "miscfx/buildstart.wav",
		underattack              = "other/unitsunderattack1",
		ok                       = {
			"ack",
		},
		select                   = {
			"unitselect",
		},
	},
	weapons                      = {
		-- [1]                      = {
			-- def                  = "riottankempweapon",
		-- },
		[1]                      = {
			def                  = "meteor",
			badtargetcategory     = "VTOL",
		},
	},
	customParams                 = {
		unittype				  = "mobile",
		area_mex_def			 = "emetalextractor",
		ProvideTech              = techprovided,
		RequireTech				 = techrequired,
		canbetransported 		 = "true",
		iscommander              = true,
		needed_cover             = 2,
--		supply_granted            = supplyGiven,
		death_sounds             = "generic",
		
		armortype                = armortype,
		nofriendlyfire	         = "1",
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",
	},
}

--------------------------------------------------------------------------------

local weaponDefs                 = {
	meteor             = {
		AreaOfEffect             = 500,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		commandFire				 = true,
		burst					 = 50,
		burstrate				 = 0.1,
		--projectiles			 = 5,
		cegTag                   = "METEORTRAIL",
		commandfire				 = true,
		explosionGenerator       = "custom:genericshellexplosion-large",
		energypershot            = 0,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		name                     = unitName .. "Weapon",
		range                    = 10000,
		reloadtime               = 45,
		size					 = 16,
		weaponType		         = "Cannon",
		soundHit                 = "explosions/explode3.wav",
		soundStart               = "weapons/meteorwhoosh.wav",
		sprayangle 				 = 1000,
		tolerance                = 2000,
		turret                   = true,
		weaponVelocity           = 1000,
		customparams             = {		
			damagetype		     = "ecommandermeteor",  
		},      
		damage                   = {
			default              = 200,
		},
	},
	commnuke                   = {
		AreaOfEffect              = 500,
		avoidFriendly             = false,
		avoidFeature              = false,
		cegTag                    = "NUKETRAIL",
		collideFriendly           = false,
		collideFeature            = false,
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
		soundHit                  = "explosions/explosion_enormous.wav",
		soundStart                = "weapons/nukelaunch.wav",
		
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
			nocosttofire		  = true,
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
