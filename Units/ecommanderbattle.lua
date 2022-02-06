-- UNITDEF -- ECOMMANDERBATTLE --
--------------------------------------------------------------------------------

local unitName                   = "ecommanderbattle"

--------------------------------------------------------------------------------

local armortype				 = [[armored]]
local supplyGiven				 = [[0]]
local techprovided				 = [[tech0, -overseer]]
local techrequired				 = [[0 overseer]]

local weapon1Damage              = 200
local weapon1AOE				 = 250
local energycosttofire			 = 0 --weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local weapon2Damage              = 75
local weapon2AOE				 = 25
local energycosttofire2			 = weapon2Damage / 10 * ((weapon2AOE / 1000) + 1)


local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false; 

	--**

	acceleration                 = 0.2,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 1000,
	buildDistance                = 350,
	builder                      = true,
	buildTime                    = 2.5,
	buildpic					 = "ecommanderbattle.png",
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
	description                  = [[Experimental Assault Overseer]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "commnuke",
	footprintX                   = 4,
	footprintZ                   = 4,

	iconType                     = "commander",
	autoHeal                 	 = 0.5,
	idleAutoHeal                 = 50,
	idleTime                     = 300,
	levelground                  = true,
	maxDamage                    = 15000,
	maxSlope                     = 180,
	maxVelocity                  = 3,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 5000,
	metalmake                    = 0,
	metalStorage                 = 0,
	movementClass                = "COMMANDERTANK4",
	moveState			         = "0",
	name                         = "The Battle Overseer",
	noChaseCategories	         = "NOTAIR SUPPORT VTOL AMPHIB",
	objectName                   = "ecommander4-battle.s3o",
	script			             = "ecommander4-battle.cob",
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
			"custom:electricity",
		},
	},
	--buildoptions                 = Shared.buildList,
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
			def                  = "heavybeamweapon",
			badTargetCategory    = "BUILDING WALL",
		},
	},
	customParams                 = {
		unittype				  = "mobile",
		--area_mex_def			 = "emetalextractor",
		ProvideTech              = techprovided,
		RequireTech				 = techrequired,
		canbetransported 		 = "true",
		iscommander              = true,
		needed_cover             = 2,
		supply_granted            = supplyGiven,
		death_sounds             = "generic",
		
		armortype                = armortype,
		nofriendlyfire	         = "1",
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "ateran",
	},
}

--------------------------------------------------------------------------------

local weaponDefs                 = {

	riottankempweapon            = {
		
		AreaOfEffect             = weapon1AOE,
		avoidFeature             = false,
		avoidFriendly            = false,
		avoidGround				 = false,
		collideFeature           = false,
		collideFriendly          = false,
		coreThickness            = 0.6,
		--	cegTag               = "mediumcannonweapon3",
		duration                 = 0.05,
		edgeeffectiveness        = 0.1,
		energypershot            = energycosttofire,
		explosionGenerator       = "custom:genericshellexplosion-medium-lightning",
		fallOffRate              = 1,
		fireStarter              = 100,
		impulseFactor            = 0,
		
		minintensity             = 1,
		name                     = "EMP Blast Wave",
		noexplode		         = true,
		paralyzer		         = true,
		paralyzetime	         = 2.5,
		range                    = 500,
		reloadtime               = 2,
		WeaponType               = "LaserCannon",
		rgbColor                 = "0 0.2 1",
		rgbColor2                = "1 1 1",
		soundTrigger             = true,
		soundstart               = "weapons/fnubeamfire.wav",
		soundHit                 = "explosions/phasegun1hit.wav",
		texture1                 = "wave",
		texture2                 = "empty",
		thickness                = 40,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 1000,
		customparams             = {
			damagetype		     = "light",  
			nofriendlyfire	     = 1,
			nocosttofire		 = true,
			
			--Upgrades--
			upgradeClass		 = "groundweapons",
		}, 
		damage                   = {
			default              = weapon1Damage,
		},
	},

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
		reloadtime               = 20,
		weaponType		         = "Cannon",
		soundhit                 = "explosions/emp.wav",
		size				     = 0,
		turret                   = true,
		weaponVelocity           = 10000,
		customparams             = {
			damagetype		     = "light",
			nofriendlyfire	     = 1,
			nocosttofire		 = true,
			
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
			damagetype		      = "light",  
			death_sounds 		  = "nuke",
			nocosttofire		  = true,
		},      
		damage                    = {
			default               = 1000,
		},
	},
	machinegun                   = {
		accuracy                 = 300,
		AreaOfEffect             = weapon2AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		beamTime                 = 0.1,
		
		coreThickness            = 0.5,
		duration                 = 0.1,
		explosionGenerator       = "custom:genericshellexplosion-large-sparks-burn",
		energypershot            = energycosttofire2,
		fallOffRate              = 0,
		fireStarter              = 50,
		interceptedByShieldType  = 4,
		impulsefactor			 = 0,
		
		minintensity             = "1",
		name                     = "Machine Gun",
		range                    = 650,
		reloadtime               = 0.1,
		WeaponType               = "LaserCannon",
		rgbColor                 = "1 0.5 0",
		rgbColor2                = "1 1 1",
		soundTrigger             = true,
		soundstart               = "weapons/tankdestroyerfire.wav",
		texture1                 = "shot",
		texture2                 = "empty",
		thickness                = 5,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 1000,
		customparams             = {
			damagetype		      = "antiarmored", 

			nocosttofire		    = true,
		}, 
		damage                   = {
			default              = weapon2Damage,
		},
	},
	sniper           = {
		AreaOfEffect              = 25,
		avoidFeature              = false,
		avoidFriendly             = false,
		beamTime                  = 0.1,
		
		collideFeature            = false,
		collideFriendly           = false,
		coreThickness             = 0.6,
		--	cegTag                = "mediumcannonweapon3",
		duration                  = 0.2,
		energypershot             = 0,
		explosionGenerator        = "custom:genericshellexplosion-medium-purple",
		fallOffRate            	  = 0,
		fireStarter               = 100,
		impulseFactor             = 0,
		interceptedByShieldType   = 4,
		
		minintensity              = "1",
		name                      = "Laser",
		range                     = 650,
		reloadtime                = 1,
		WeaponType                = "LaserCannon",
		rgbColor                  = "0 0.5 1",
		rgbColor2                 = "1 1 1",
		soundTrigger              = true,
		soundstart                = "weapons/Sci Fi Blaster 4.wav",
		soundHit                  = "explosions/explode5.wav",
		texture1                  = "shot",
		texture2                  = "empty",
		thickness                 = 5,
		tolerance                 = 1000,
		turret                    = true,
		weaponVelocity            = 3000,
		customparams              = {
			damagetype		      = "antilightarmored",
		}, 
		damage                    = {
			default               = 750,
		},
	},
	
	heavybeamweapon              = {
		AreaOfEffect             = 10,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		largebeamlaser			 = true,
		beamTime                 = 0.5,
		cameraShake		         = 0,
		coreThickness            = 0.5,
		--	cegTag               = "mediumcannonweapon3",
		--    duration           = 0.2,
		energypershot            = 0,
		explosionGenerator       = "custom:genericshellexplosion-large-sparks-burn",
		fallOffRate              = 0,
		fireStarter              = 50,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		minintensity             = 1,
		name                     = "Laser",
		range                    = 1000,
		reloadtime               = 0.5,
		WeaponType               = "BeamLaser",
		rgbColor                 = "0.25 0 0.25",
		rgbColor2                = "0.5 0.5 0.5",
		soundTrigger             = true,
		soundstart               = "weapons/Sci Fi Beam 3-short.wav",
		--    soundHit           = "explosions/mediumcannonhit.wav",
		--    sweepfire		     	 = true,
		texture1                 = "shot",
		texture2                 = "empty",
		thickness                = 5,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 800,
		customparams             = {
			isupgraded           	 = isUpgraded,
			damagetype		     = "antilightarmored",  
		}, 
		damage                   = {
			default              = 500,
		},
	},
	
}
unitDef.weaponDefs               = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
