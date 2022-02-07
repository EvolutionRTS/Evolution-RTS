unitDef                    = {
	acceleration                 = 1,
	brakeRate                    = 0.2,
	buildCostEnergy              = 0,
	buildCostMetal               = 62,
	builder                      = false,
	buildTime                    = 5,
	buildpic					 = "emissiletank.png",
	canAttack                    = true,
	
	canGuard                     = true,
	canHover                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "LIGHT NOTAIR SUPPORT",
	description                  = [[Missile Support Tank]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "largeExplosionGeneric",
	footprintX                   = 2,
	footprintZ                   = 2,
	iconType                     = "mtd_lit_all",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 320,
	maxSlope                     = 26,
	maxVelocity                  = 2.5,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "HOVERTANK2",
	name                         = humanName,
	objectName                   = objectName,
	script						 = script,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "largeExplosionGeneric",
	side                         = "ARM",
	sightDistance                = 850,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	transportbyenemy             = false;
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 2.6,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 300,
	unitname                     = unitName,
	upright                      = true,
	workerTime                   = 0,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:factorysparks",
			"custom:emptydirt",
			"custom:blacksmoke",
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
	weapons                      = {
		[1]                      = {
			def                  = "missletankweapon",
			badTargetCategory    = "BUILDING LIGHT",
		},
	},
	customParams                 = {
		isupgraded			 	= isUpgraded,
		unittype				  = "mobile",
		canbetransported 		 = "true",
		canareaattack            ="1",
		needed_cover             = 3,
		death_sounds             = "generic",
		RequireTech              = tech,
		armortype                = armortype,
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "ateran",
		corpse                   = "energycore",
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

weaponDefs                 = {
	missletankweapon             = {

		AreaOfEffect             = 100,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		cegTag                   = "emissiletanktrail-optimized",
		craterBoost              = 0,
		craterMult               = 0,
		explosionGenerator       = "custom:genericshellexplosion-medium-red",
		energypershot            = 0,
		fireStarter              = 100,
		flightTime               = 5,
		impulseBoost             = 0,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		
		model                    = "missilesmallvlaunch.s3o",
		name                     = "Rocket",
		range                    = 850,
		reloadtime               = 3,
		weaponType		         = "MissileLauncher",
		
		
		smokeTrail               = false,
		soundHit                 = "explosions/explode_large.wav",
		soundStart               = "weapons/missile_launch1.wav",
		
		tracks                   = true,
		turnrate                 = 30000,
		
		weaponAcceleration       = 400,
		weaponTimer              = 1,
		weaponType               = "StarburstLauncher",
		weaponVelocity           = 3000,
		customparams             = {
			isupgraded			 = isUpgraded,
			damagetype		     = "antilightarmored",  
		},      
		damage                   = {
			default              = 150,
		},
	},
}
