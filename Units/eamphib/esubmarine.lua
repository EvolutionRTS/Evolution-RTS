-- UNITDEF -- ESUBMARINE --
--------------------------------------------------------------------------------

local unitName                   = "esubmarine"

--------------------------------------------------------------------------------

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 0.18,
	brakeRate                    = 0.1,
	buildCostEnergy              = 0,
	buildCostMetal               = 90,
	builder                      = false,
	buildTime                    = 2.5,
	canAttack                    = true,
	cancollect                   = "1",
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "LIGHT SUB",
	corpse                       = "ammobox",
	description                  = "Anti-Amphibious Submarine",
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "MEDIUM_UNIT",
	footprintX                   = 4,
	footprintZ                   = 4,
	iconType                     = "sub",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 300,
	maxSlope                     = 60,
	maxVelocity                  = 4.0,
	maxReverseVelocity           = 1,
	minWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "UBOAT4",
	name                         = "Lurker",
	noChaseCategory              = "VTOL",
	objectName                   = "esubplane.s3o",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "MEDIUM_UNIT",
	side                         = "CORE",
	sightDistance                = 500,
	SonarDistance                = 700,
	smoothAnim                   = true,
	turnInPlace                  = false,
	turnRate                     = 430,
	unitname                     = "esubmarine",
	workerTime                   = 0,
	waterline                    = 30,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:dirt",
			"custom:warp",
		},
	},
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
			def                  = "TORP",
			OnlyTargetCategory   = "AMPHIB SUB",
			BadTargetCategory    = "VTOL",
			noChaseCategory      = "VTOL",
		},
	},

	customParams                 = {
		death_sounds             = "generic",
		armortype                = "light",
		normalstex               = "unittextures/esubplanenormal.png", 
	},

}


--------------------------------------------------------------------------------

local weaponDefs                 = {
	TORP                         = {
		AreaOfEffect             = 10,
		avoidFriendly            = false,
		avoidFeature             = false,
		ballistic                = false,
		cegTag                   = "torpedotrail",
		collideFriendly          = false,
		cylinderTargeting        = true,
		explosionGenerator       = "custom:torpedoexplosion",
		id                       = 5,
		
		model                    = "missile.s3o",
		name                     = "Bombs",
		noSelfDamage             = true,
		range                    = 300,
		reloadtime               = 8,
		soundHit                 = "subhit.wav",
		soundStart               = "torpedolaunch.wav",
		startVelocity            = 100,
		turret                   = true,
		tracks                   = true,
		tolerance                = 1000,
		turnrate                 = 900,
		weaponVelocity           = 400,
		WeaponType               = "TorpedoLauncher",
		WeaponAcceleration       = 100,
		flighttime               = 10,
		waterweapon              = true,
		damage                   = {
			default              = 100,
		},
	},
}
unitDef.weaponDefs               = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
