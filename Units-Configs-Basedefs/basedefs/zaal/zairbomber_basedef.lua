unitDef                    = {
	--acceleration                 = 0.5,
	airStrafe                    = false,
	airHoverFactor				 = 0,
	--brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 60,
	buildTime                    = 2.5,
	buildpic					 = "zaal_unitpics/zairbomber.png",
	canAttack                    = true,
	canFly                       = true,
	canGuard                     = true,
	canLoopbackAttack            = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = true,
	category                     = "LIGHT VTOL",
	collide                      = true,
	cruiseAlt                    = 140,
	description                  = [[Heavy Bomber]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "BUG_DEATH_MEDIUM",
	floater                      = true,
	footprintX                   = 7,
	footprintZ                   = 7,
	hoverAttack                  = false,
	iconType                     = "air_lit",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	maxacc						 = 1,
	maxDamage                    = 812,
	maxSlope                     = 90,
	maxVelocity                  = 12,
	maxWaterDepth                = 255,
	metalStorage                 = 0,
	moverate1                    = "8",
	name                         = humanName,
	objectName                   = objectName,
	script			             = script,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "BUG_DEATH_MEDIUM",
	side                         = "ARM",
	sightDistance                = 1000,
	smoothAnim                   = true,
	sonarDistance                = 0,
	transportbyenemy             = false;
	turnRate                     = 5000,
	turnradius					 = 250,
	unitname                     = unitName,
	upright						 = true,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"blood_spray", 
		}, 

		explosiongenerators      = {
			"custom:blood_spray",
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
			badtargetcategory = "VTOL",
			def = "WEAPON",
		},
	},
	customParams                 = {
		unittype				 = "mobile",
		--    needed_cover       = 2,
		death_sounds             = "bug",
		RequireTech              = tech,
		armortype                = armortype,
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		factionname	             = "zaal",
		corpse                   = "energycore",
		normaltex 				 = "unittextures/z_normals.dds",
		retreatRangeDAI			 = 0,
	},
}

weaponDefs                 = {
	weapon = {
		interceptedByShieldType   = 4,
		accuracy 				  = 1000,
		areaofeffect			  = 150,
		avoidfeature			  = false,
		avoidfriendly			  = false,
		burst					  = 11,
		burstrate				  = 0.41,
		collidefriendly			  = false,
		craterboost				  = 0,
		cratermult				  = 0,
		edgeeffectiveness		  = 0.1,
		explosiongenerator		  = "custom:gundam_MISSILE_EXPLOSION",
		impulseboost			  = 1,
		impulsefactor			  = 1,
		interceptedbyshieldtype	  = 4,
		model					  = "ChickenDefenseModels/chickeneggyellow.s3o",
		name					  = "GooBombs",
		noselfdamage			  = true,
		range					  = 700,
		reloadtime				  = 9,
		soundhit				  = "ChickenDefenseSounds/junohit2edit",
		sprayangle				  = 2000,
		weapontype				  = "AircraftBomb",
		customparams             = {
			damagetype		     = "default",
			nofriendlyfire	     = 1,
		},    
		damage = {
			default				  = 250,
		},
	},
}
