-- UNITDEF -- ECOMMANDERCLOAK --
--------------------------------------------------------------------------------

local unitName                   = "ecommandershield"

--------------------------------------------------------------------------------

local armortype					 = [[light]]
local supplyGiven				 = [[10]]

local shield1Power               = 5000
local shield1PowerRegen          = 25
local shield1PowerRegenEnergy    = 0

local weapon1Damage              = 200
local weapon1AOE				 = 250
local energycosttofire			 = 0 --weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

if Spring.GetModOptions().luamex ~= "enabled" then
	buildList = { [[ehbotfac]],[[eminifac]],[[ebasefactory]],[[eamphibfac]],[[eairplant]],[[etech1]],[[esolar2]],[[egeothermal]],[[efusion2]],[[estorage]],[[eradar2]],[[ejammer2]],[[ekmar]],[[elightturret2]],[[eheavyturret2]],[[eartyturret]],[[euwturret]],[[eshieldgen]],[[esilo]],[[emine]],[[eorb]],
	}
end
if Spring.GetModOptions().luamex == "enabled" then
	buildList = { 
		[[ehbotfac]],[[eminifac]],[[ebasefactory]],[[eamphibfac]],[[eairplant]],[[etech1]],[[esolar2]],[[egeothermal]],[[efusion2]],[[estorage]],[[eradar2]],[[ejammer2]],[[ekmar]],[[elightturret2]],[[eheavyturret2]],[[eartyturret]],[[euwturret]],[[eshieldgen]],[[esilo]],[[emine]],[[eorb]],[[emetalextractor]],
	}
end

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
	canRestore					 = false,
	cancollect                   = "1",
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canreclaim		             = false,
	canstop                      = true,
	category                     = "NOTAIR SUPPORT LIGHT",
	description                  = [[Builds Units • Provides large shielding • Gives ]] ..supplyGiven.. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "commnuke",
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
	name                         = "The Shielded Overseer",
	noChaseCategories	         = "NOTAIR SUPPORT VTOL AMPHIB",
	objectName                   = "ecommander4.s3o",
	script			             = "ecommander3shield.cob",
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
	buildoptions                 = buildList,
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
			def                  = "riottankempweapon",
		},
		[2]                      = {
			def                  = "shield",
		},
	},
	customParams                 = {
		area_mex_def			 = "emetalextractor",
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

Generates a large shield

Reclaims any energy cores within it's proximity.]],	
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
		reloadtime               = 1,
		WeaponType               = "LaserCannon",
		rgbColor                 = "0 0.2 1",
		rgbColor2                = "1 1 1",
		soundTrigger             = true,
		soundstart               = "fnubeamfire.wav",
		soundHit                 = "phasegun1hit.wav",
		texture1                 = "wave",
		texture2                 = "empty",
		thickness                = 40,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 1000,
		customparams             = {
			damagetype		     = "eriottank2",  
			nofriendlyfire	     = 1,
			
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
	shield                = {
		
		Smartshield              = true,
		Exteriorshield           = true,
		Visibleshield            = true,
		Visibleshieldrepulse     = true,
		ShieldStartingPower      = 0,
		Shieldenergyuse          = 0,
		Shieldradius             = 400,
		Shieldpower              = shield1Power,
		Shieldpowerregen         = shield1PowerRegen,
		Shieldpowerregenenergy   = shield1PowerRegenEnergy,
		Shieldintercepttype      = 4,
		Shieldgoodcolor          = "0.0 0.2 1.0",
		Shieldbadcolor           = "1.0 0 0",
		Shieldalpha              = 0.2,
		
		texture1		         = "shield4",
		
		visibleShieldHitFrames   = 1,
		weaponType               = [[Shield]],
		damage                   = {
			default              = 1,
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
