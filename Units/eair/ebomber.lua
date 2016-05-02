-- UNITDEF -- EBOMBER --
--------------------------------------------------------------------------------

local unitName                   = "ebomber"

--------------------------------------------------------------------------------
local power						 = [[18 power]]
local armortype					 = [[light]]
local supply					 = [[5]]

local weapon1Damage              = 200
local weapon1AOE				 = 1
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 0.5,
	airStrafe                    = false,
	BadTargetCategory            = "VTOL",
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 55,
	builder                      = false,
	buildTime                    = 2.5,
	canAttack                    = true,
	canFly                       = true,
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = true,
	category                     = "ARMORED VTOL",
	collide                      = true,
	corpse                       = "ammobox",
	cruiseAlt                    = 140,
	description                  = [[Unit Type: Bomber
Armortype: ]] ..armortype.. [[ 
	
200 Damage vs Buildings
150 Damage vs Light/Armored

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire) .. [[ 

Requires +]] .. power .. [[ 
Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "hugeExplosionGeneric",
	footprintX                   = 7,
	footprintZ                   = 7,
	floater                      = true,
	hoverAttack                  = true,
	iconType                     = "assault",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	loopbackattack               = false,
	maxDamage                    = 270,
	maxSlope                     = 90,
	maxVelocity                  = 11,
	verticalSpeed		         = 15,
	maxWaterDepth                = 0,
	metalStorage                 = 0,
	name                         = "Kamper",
	noChaseCategory              = "VTOL",
	objectName                   = "ebomber2.s3o",
	script			             = "ebomber2.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "hugeExplosionGeneric",
	side                         = "CORE",
	sightDistance                = 900,
	smoothAnim                   = true,
	stealth                      = false,
	turnRate                     = 5000,
	unitname                     = "ebomber",
	workerTime                   = 0,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
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
			def                  = "SBOMB",
			noChaseCategory      = "VTOL",
			badTargetCategory    = "VTOL",
		},
	},
	customParams                 = {
		--    needed_cover       = 2,
		death_sounds             = "generic",
		nofriendlyfire           = "1",
		RequireTech              = power,
		armortype                = armortype,
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",   
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                 = {
	SBOMB                        = {
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		cegTag                   = "missiletrailgunship",
		explosionGenerator       = "custom:genericshellexplosion-large-red",
		energypershot            = energycosttofire,
		edgeEffectiveness        = 0.1,
		fireStarter              = 70,
		
		id                       = 136,
		impulseBoost             = 0,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		
		metalpershot             = 0,
		model                    = "missile.s3o",
		name                     = "Rockets",
		range                    = 750,
		reloadtime               = 3,
		weaponType		         = "MissileLauncher",  -- This causes the missile trail to go off kilter
		--	rendertype		     = 1,
		
		
		smokeTrail               = false,
		soundHit                 = "unitexplodebig.wav",
		soundHitWet				 = "subhitbomb.wav",
		soundHitVolume	         = 10,
		soundStart               = "bomberlaunch.wav",
		soundStartVolume         = 10,
		
		startVelocity            = 500,
		tolerance                = 8000,
		turnRate                 = 10000,
		tracks                   = false,
		turret			         = false,
		weaponAcceleration       = 10,
		waterweapon				 = true,
		flightTime               = 10,
		weaponVelocity           = 800,
		customparams             = {
			damagetype		     = "ebomber",  
			nofriendlyfire	     = 1,
		},
		damage                   = {
			default              = weapon1Damage,
		},
	},
}
unitDef.weaponDefs               = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
