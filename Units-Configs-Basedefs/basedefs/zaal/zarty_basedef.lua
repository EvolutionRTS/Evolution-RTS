unitDef                    = {
	acceleration                 = 1,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 36,
	builder                      = false,
	buildTime                    = 5,
	buildpic					 = "zaal_unitpics/zarty.png",
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
	explodeAs                    = "BUG_DEATH_SMALL",
	footprintX                   = 3,
	footprintZ                   = 3,
	iconType                     = "zarty",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 300,
	maxVelocity                  = 1.5,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "HOVERTANK3",
	name                         = humanName,  --Because he was the first one to get the "Lobster" pun
	noChaseCategory              = "VTOL",
	objectName                   = objectName,
	script			             = script,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "BUG_DEATH_SMALL",
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
			def                  = "Artilleryweapon",
			badTargetCategory    = "VTOL",
		},
		-- [2]                      = {
			-- def                  = "SaturationArtilleryweapon",
			-- badTargetCategory    = "VTOL",
		-- },
	},
	customParams                 = {
		isupgraded			  	 = isUpgraded,
		unittype				 = "mobile",
		canbetransported 		 = "true",
		needed_cover             = 3,
		death_sounds             = "bug",
		RequireTech              = tech,
		armortype                = armortype,
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		normaltex 				 = "unittextures/z_normals.dds", 
		factionname	             = "zaal",
		--corpse                   = "energycore",
	},
}


--------------------------------------------------------------------------------

weaponDefs                 = {
	Artilleryweapon              = {
		
		accuracy                 = 1500,
		AreaOfEffect             = 250,
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
		highTrajectory	         = 1,
		name                     = "Plasma Cannon",
		range                    = 1500,
		reloadtime               = 5,
		size					 = 16,
		weaponType		         = "Cannon",
		soundHit                 = "explosions/artyhit.wav",
		soundStart               = "weapons/arty2.wav",
		
		turret                   = true,
		weaponVelocity           = 500,
		customparams             = {
			damagetype		     = "default",
			nofriendlyfire	     = 1,
		},  
		damage                   = {
			default              = 600,
		},
	},
}
