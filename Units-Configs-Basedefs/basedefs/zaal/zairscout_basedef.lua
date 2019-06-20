unitDef                    = {
	acceleration                 = 0.5,
	airStrafe                    = true,
	bankscale                    = "1",
	brakeRate                    = 0.7,
	buildCostEnergy              = 0,
	buildCostMetal               = 33,
	buildTime                    = 2.5,
	buildpic					 = "zaal_unitpics/zairscout.png",
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
	cruiseAlt                    = 75,
	description                  = [[Harassment Specialist Drone]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "smallExplosionGenericPurple",
	footprintX                   = 5,
	footprintZ                   = 5,
	hoverAttack                  = true,
	iconType                     = "drone",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	maxDamage                    = 560,
	maxSlope                     = 90,
	maxVelocity                  = 11,
	--verticalSpeed		         = 15,
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
	},
	customParams                 = {
		unittype				  = "mobile",
		death_sounds             = "generic",
		normaltex 				 = "unittextures/z_normals.dds", 
		RequireTech              = tech,
		armortype                = armortype,
		supply_cost              = supply,
		nofriendlyfire	         = "1",
		factionname	             = "zaal",
		retreatRangeDAI			 = 5000,
	},
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
