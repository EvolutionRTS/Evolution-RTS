-- UNITDEF -- ECOMMANDERBUILD --
--------------------------------------------------------------------------------

local unitName                   = "ecommanderbuild"

--------------------------------------------------------------------------------

local armortype					 = [[light]]
local supplyGiven				 = [[0]]
local techprovided				 = [[tech0, -overseer]]
local techrequired				 = [[0 overseer]]

local weapon1Damage              = 15
local weapon1AOE				 = 25
local energycosttofire1			 = 0 --weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)


local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false; 

	--**

	acceleration                 = 0.2,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 1000,
	buildDistance                = 600,
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
	category                     = "NOTAIR SUPPORT LIGHT",
	description                  = [[Builds Units x8 as fast]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "commnuke",
	footprintX                   = 4,
	footprintZ                   = 4,

	iconType                     = "commander",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	levelground                  = true,
	maxDamage                    = 6000,
	maxSlope                     = 180,
	maxVelocity                  = 3,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 5000,
	metalmake                    = 0,
	metalStorage                 = 0,
	movementClass                = "COMMANDERTANK4",
	moveState			         = "0",
	name                         = "The Builder Overseer",
	noChaseCategories	         = "NOTAIR SUPPORT VTOL AMPHIB",
	objectName                   = "ecommander4-battle.s3o",
	script			             = "ecommander4-battle.cob",
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
	upright                      = false,
	workerTime                   = 8,
	capturespeed                 = 0.25,
	TerraformSpeed               = 2147000,
	ReclaimSpeed                 = 0,
	-- 0.03125                   = 1 hp per second
	repairspeed                  = 1.5,
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
		[1]                      = {
			def                  = "machinegun",
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
		supply_granted            = supplyGiven,
		death_sounds             = "generic",
		
		armortype                = armortype,
		nofriendlyfire	         = "1",
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "ateran",
		helptext                 = [[Armortype: ]] ..armortype.. [[ 
x3 Buildpower
 
1000 EMP Damage vs Light/Armored/Building

Reclaims any energy cores within it's proximity.]],
	},
}

--------------------------------------------------------------------------------

local weaponDefs                 = {

	machinegun                   = {
		AreaOfEffect             = 50,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		
		coreThickness            = 0.5,
		duration                 = 0.2,
		explosionGenerator       = "custom:genericshellexplosion-small",
		energypershot            = 0,
		fallOffRate              = 0,
		fireStarter              = 50,
		interceptedByShieldType  = 4,
		impulsefactor			 = 0,
		
		minintensity             = "1",
		name                     = "Overseer Pulse Laser",
		range                    = 650,
		reloadtime               = 1,
		WeaponType               = "LaserCannon",
		rgbColor                 = "1 0.2 0",
		rgbColor2                = "1 1 1",
		soundTrigger             = true,
		soundstart               = "weapons/Sci Fi Sniper 10.wav",
		texture1                 = "shot",
		texture2                 = "empty",
		thickness                = 7,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 1500,
		customparams             = {
			damagetype		      = "light", 
			nocosttofire		    = true,
		}, 
		damage                   = {
			default              = 200,
		},
	},

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
		reloadtime               = 0.5,
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
		AreaOfEffect             = 250,
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
		reloadtime               = 5,
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
			nocosttofire		 = true,
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
