unitDef                    = {
	acceleration                 = 1,
	brakeRate                    = 0.2,
	buildCostEnergy              = 0,
	buildCostMetal               = 36,
	builder                      = false,
	buildTime                    = 5,
	buildpic					 = "eartytank.png",
	canAttack                    = true,
	canGuard                     = true,
	canHover                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "LIGHT NOTAIR SUPPORT",
	description                  = [[Self-Propelled Long-Range Artillery]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGeneric",
	footprintX                   = 2,
	footprintZ                   = 2,
	iconType                     = "arty_lit",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 300,
	maxVelocity                  = 2.3,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "HOVERTANK2",
	name                         = humanName,  --Because he was the first one to get the "Lobster" pun
	noChaseCategory              = "VTOL",
	objectName                   = objectName,
	script			             = script,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGeneric",
	side                         = "CORE",
	sightDistance                = 425,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	transportbyenemy             = false;
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 2.3,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 250,
	unitname                      = unitName,
	workerTime                   = 0,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:gdhcannon",
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
			def                  = "Artilleryweapon",
			badTargetCategory    = "VTOL LIGHT ARMORED BIO",
		},
		-- [2]                      = {
			-- def                  = "SaturationArtilleryweapon",
			-- badTargetCategory    = "VTOL",
		-- },
	},
	customParams                 = {
		isupgraded			  	 = isUpgraded,
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

weaponDefs                 = {
	Artilleryweapon              = {
		
		accuracy                 = 500,
		AreaOfEffect             = 50,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		
		cegTag                   = "artyshot2",
		avoidNeutral	         = false,
		explosionGenerator       = "custom:genericshellexplosion-small",
		energypershot            = 0,
		
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		highTrajectory	         = 0,
		name                     = "Plasma Cannon",
		range                    = 1300,
		reloadtime               = 5,
		size					 = 16,
		weaponType		         = "Cannon",
		soundHit                 = "explosions/artyhit.wav",
		soundStart               = "weapons/arty2.wav",
		
		turret                   = true,
		weaponVelocity           = 500,
		customparams             = {
			isupgraded			 = isUpgraded,
			damagetype		     = "antibuildingarty",  
		},  
		damage                   = {
			default              = 200,
		},
	},

	SaturationArtilleryweapon    = {
		
		accuracy                 = 750,
		AreaOfEffect             = 250,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		
		cegTag                   = "artyshot2",
		avoidNeutral	         = false,
		explosionGenerator       = "custom:genericshellexplosion-large",
		energypershot            = 0,
		edgeEffectiveness        = 1,
		
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		highTrajectory	         = 1,
		size					 = 16,
		name                     = "Plasma Cannon",
		range                    = 1300,
		reloadtime               = 0.5,
		weaponType		         = "Cannon",
		soundHit                 = "explosions/artyhit.wav",
		soundStart               = "weapons/arty2.wav",
		
		turret                   = true,
		weaponVelocity           = 500,
		customparams             = {
			isupgraded			 = isUpgraded,
			damagetype		     = "antibuildingarty",  
		},  
		damage                   = {
			default              = 20,
		},
	},
}
