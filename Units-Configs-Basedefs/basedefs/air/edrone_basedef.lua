unitDef                    = {
	acceleration                 = 0.5,
	airStrafe                    = false,
	bankscale                    = "1",
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 45,
	buildTime                    = 2.5,
	buildpic					 = "edrone.png",
	canAttack                    = true,
	canDropFlare                 = false,
	canFly                       = true,
	canGuard                     = true,
	canLoopbackAttack            = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "LIGHT VTOL DRONE",
	collide                      = false,
	cruiseAlt                    = 120,
	description                  = [[Drone Harassment Specialist • Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "smallExplosionGenericPurple",
	flareDelay                   = 0.1,
	flareDropVector              = "0 0 -1",
	flareefficieny               = "0.3",
	flareReload                  = 3,
	footprintX                   = 3,
	footprintZ                   = 3,
	hoverAttack                  = true,
	iconType                     = "drone",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	maxDamage                    = 280,
	maxSlope                     = 90,
	maxVelocity                  = 7,
	verticalSpeed		         = 15,
	maxWaterDepth                = 0,
	metalStorage                 = 0,
	moverate1                    = "8",
	name                         = humanName,
	objectName                   = objectName,
	script			             = script,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "smallExplosionGenericPurple",
	side                         = "CORE",
	sightDistance                = 500,
	SonarDistance                = 500,
	smoothAnim                   = true,
	stealth                      = true,
	turnRate                     = 5000,
	unitname                     = unitName,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:jetstrail",
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
			def                  = "droneweapon",
			badTargetCategory    = "LIGHT ARMORED",
		},
	},
	customParams                 = {
		unittype				  = "mobile",
		isupgraded               = isUpgraded,
		death_sounds             = "generic",
		RequireTech              = tech,
		armortype                = armortype,
		supply_cost              = supply,
		nofriendlyfire	         = "1",
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",
	},
}


--------------------------------------------------------------------------------

weaponDefs                 = {
	droneweapon                  = {
		accuracy                 = 500,
		AreaOfEffect             = 1,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		beamTime                 = 0.2,
		
		coreThickness            = 0.5,
		craterBoost              = 0,
		craterMult               = 0,
		duration                 = 0.2,
		energypershot            = 0,
		explosionGenerator       = "custom:genericshellexplosion-small-sparks-burn",
		fallOffRate              = 0.1,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		largeBeamLaser           = true,
		
		name                     = unitName .. "Weapon",
		noSelfDamage             = true,
		range                    = 500,
		reloadtime               = 1,
		WeaponType               = "LaserCannon",
		rgbColor                 = "0.1 0.5 0.2",
		rgbColor2                = "0 1 0",
		
		soundHit                 = "weapons/18393_inferno_reject.wav",
		soundStart               = "weapons/18389_inferno_medlas.wav",
		soundTrigger             = true,
		startVelocity            = 1000,
		targetMoveError          = 0,
		texture1                 = "shot",
		texture2                 = "empty",
		texture3                 = "empty",
		texture4                 = "empty",
		thickness                = 5,
		turret                   = true,
		weaponVelocity           = 1000,
		waterweapon				 = true,
		customparams             = {
			damagetype		     = "edrone",
			isupgraded			 = isUpgraded,			
		},    
		damage                   = {
			default              = 30,
		},
	},
}
unitDef.weaponDefs               = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
