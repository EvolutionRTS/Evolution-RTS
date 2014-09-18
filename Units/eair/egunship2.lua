-- UNITDEF -- EGUNSHIP2 --
--------------------------------------------------------------------------------

local unitName                   = "egunship2"

--------------------------------------------------------------------------------

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 0.5,
	airStrafe                    = true,
	brakeRate                    = 0.5,
	buildCostEnergy              = 0,
	buildCostMetal               = 35,
	buildTime                    = 2.5,
	canAttack                    = true,
	canDropFlare                 = false,
	canFly                       = true,
	canGuard                     = true,
	canLoopbackAttack            = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = true,
	category                     = "LIGHT VTOL",
	collide                      = true,
	corpse                       = "ammobox",
	cruiseAlt                    = 300,
	description                  = [[Gunship Tank Destroyer
	Armored
	100 Damage vs Light/Armored
	25 Damage vs Building

	Can switch firemodes to torpedos

	Requires +7 Power
	Uses +7 Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "largeExplosionGenericRed",
	flareDelay                   = 0.1,
	flareDropVector              = "0 0 -1",
	flareefficieny               = "0.3",
	flareReload                  = 3,
	floater                      = true,
	footprintX                   = 4,
	footprintZ                   = 4,
	hoverAttack                  = true,
	iconType                     = "tankdestroyer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	maxDamage                    = 600,
	maxSlope                     = 90,
	maxVelocity                  = 14,
	verticalSpeed		         = 15,
	maxWaterDepth                = 0,
	metalStorage                 = 0,
	moverate1                    = "8",
	name                         = "Wildcat",
	noChaseCategory              = "VTOL",
	objectName                   = "egunship3.s3o",
	script			             = "egunship3.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "largeExplosionGenericRed",
	side                         = "CORE",
	sightDistance                = 800,
	smoothAnim                   = true,
	turnRate                     = 920,
	unitname                     = "egunship2",
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg0", 
			"deathceg1", 
		}, 

		explosiongenerators      = {
			"custom:jethtrail",
			"custom:blacksmoke",
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
			def                  = "gunshipweapon",
			mainDir              = "0 0 1",
			maxAngleDif          = 90,
			OnlyTargetCategory   = "NOTAIR AMPHIB",
			BadTargetCategory    = "BUILDING WALL",
			noChaseCategory      = "VTOL",
		},
		[2]                      = {
			def                  = "gunshiptorpedo",
			mainDir              = "0 0 1",
			maxAngleDif          = 180,
			OnlyTargetCategory   = "NOTAIR AMPHIB SUB",
			BadTargetCategory    = "BUILDING WALL",
			noChaseCategory      = "VTOL",
		},
	},
	customParams                 = {
		--    needed_cover       = 2,
		canareaattack            ="1",
		death_sounds             = "generic",
		RequireTech              = "7 Power",
		armortype                = "armored",
		nofriendlyfire	         = "1",
		supply_cost              = 7,
		normalstex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weapon1Damage              = 100
local weapon1AOE				 = 1
local weapon2Damage              = 100
local weapon2AOE				 = 1

local weaponDefs                 = {
	gunshipweapon                = {
		badTargetCategory        = [[BUILDING]],
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		cegTag                   = "missiletrailgunshiplesssmokey",
		explosionGenerator       = "custom:genericshellexplosion-medium",
		energypershot            = weapon1Damage / 20 * ((weapon1AOE / 1000) + 1),
		edgeEffectiveness        = 0.1,
		fireStarter              = 70,
		guidance                 = false,
		id                       = 136,
		impulseBoost             = 0,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		lineOfSight              = true,
		metalpershot             = 0,
		model                    = "missilegunship.s3o",
		name                     = "Rockets",
		range                    = 520,
		reloadtime               = 1,
		weaponType		         = "Cannon",  -- This causes the missile trail to go off kilter
		--	rendertype		     = 1,
		selfprop                 = true,
		smokedelay               = ".1",
		smokeTrail               = false,
		soundHit                 = "bombhit.wav",
		soundHitVolume	         = 10,
		soundStart               = "18395_inferno_rltx.wav",
		soundStartVolume         = 10,
		startsmoke               = "0",
		startVelocity            = 250,
		tolerance                = 8000,
		turnRate                 = 4680,
		turret			         = true,
		tracks                   = true,
		weaponAcceleration       = 131,
		weaponTimer              = 100,
		weaponVelocity           = 1200,
		customparams             = {
			damagetype		     = "egunship2",  
		},      
		damage                   = {
			default              = weapon1Damage,
		},
	},

	gunshiptorpedo               = {
		AreaOfEffect             = weapon2AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		cegTag                   = "torpedotrailuwturret",
		cylinderTargeting        = true,
		explosionGenerator       = "custom:torpedoexplosion",
		energypershot            = weapon2Damage / 20 * ((weapon2AOE / 1000) + 1),
		fireStarter              = 80,
		impulseFactor            = 0.1,
		interceptedByShieldType  = 4,
		model                    = "missilesmall.s3o",
		name                     = "Underwater Torpedo",
		pitchtolerance           = 3000,
		range                    = 520,
		reloadtime               = 1,
		weaponType		         = "TorpedoLauncher",
		soundHit                 = "torpedolaunch.wav",
		soundStart               = "18393_inferno_reject.wav",
		tolerance                = 3000,
		turret                   = true,
		startVelocity	         = 200,
		acceleration	         = 2000,
		weaponVelocity           = 10000,
		tracks				     = true,
		turnrate			     = 100000,
		flighttime			     = 4,
		customparams             = {
			damagetype		     = "egunship2torpedo",  
		},      
		damage                   = {
			default              = weapon2Damage,
		},
	},

}
unitDef.weaponDefs               = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
