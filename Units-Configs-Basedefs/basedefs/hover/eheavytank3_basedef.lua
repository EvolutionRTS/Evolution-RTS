unitDef                    = {
	acceleration                 = 1,
	brakeRate                    = 0.2,
	buildCostEnergy              = 0,
	buildCostMetal               = 59,
	builder                      = false,
	buildTime                    = 5,
	buildpic					 = "eheavytank3.png",
	canAttack                    = true,
	canGuard                     = true,
	canHover                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "ARMORED NOTAIR SKIRMISHER",
	description                  = [[Main Battle Tank]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "largeExplosionGenericRed",
	footprintX                   = 2,
	footprintZ                   = 2,
	iconType                     = "td_arm_all",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 375,
	maxSlope                     = 26,
	maxVelocity                  = 3.5,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "HOVERTANK2",
	name                         = humanName,
	noChaseCategory              = "VTOL",
	objectName                   = objectName,
	script			             = script,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "largeExplosionGenericRed",
	side                         = "CORE",
	sightDistance                = 650,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	transportbyenemy             = false;
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 2.8,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 350,
	unitname                     = unitName,
	upright                      = true,
	workerTime                   = 0,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:gdhcannon",
			"custom:dirt",
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
			def                  = "heavytankweapon",
			onlyTargetCategory   = "BIO LIGHT ARMORED BUILDING",
			badTargetCategory    = "BUILDING WALL",
		},
	},
	customParams                 = {
		isupgraded			  	 = isUpgraded,
		unittype				 = "mobile",
		canbetransported 		 = "true",
		needed_cover             = 3,
		death_sounds             = "generic",
		RequireTech              = tech,
		armortype                = armortype,
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "ateran",
		corpse                   = "energycore",
	}
}

weaponDefs                 = {
	heavytankweapon              = {
		AreaOfEffect             = 0,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,	
		cegTag                   = "antiassualtshot2",
		explosionGenerator       = "custom:genericshellexplosion-medium",
		energypershot            = 0,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		name                     = unitName .. "Weapon",
		range                    = 650,
		reloadtime               = 1,
		size					 = 16,
		weaponType		         = "Cannon",
		soundHit                 = "explosions/42024_digifishmusic_Missile_Strike.wav",
		soundStart               = "weapons/triotfire.wav",
		tolerance                = 2000,
		turret                   = true,
		weaponVelocity           = 1000,
		customparams             = {
			isupgraded			 = isUpgraded,			
			damagetype		     = "antilightarmored",  
		},      
		damage                   = {
			default              = 150,
		},
	},
}
