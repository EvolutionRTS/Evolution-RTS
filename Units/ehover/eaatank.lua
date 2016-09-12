-- UNITDEF -- EAATANK --
--------------------------------------------------------------------------------

local unitName                   = "eaatank"

--------------------------------------------------------------------------------

local power						 = [[5 power]]
local armortype					 = [[light]]
local supply					 = [[5]]

local weapon1Damage              = 105
local weapon1AOE				 = 50
local burstProjectiles           = 4
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1) * burstProjectiles

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 1,
	bmcode                       = "1",
	brakeRate                    = 0.1,
	buildCostEnergy              = 0,
	buildCostMetal               = 28,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = true,
	cancollect                   = "1",
	canGuard                     = true,
	canHover                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "LIGHT NOTAIR SUPPORT",
	corpse                       = "ammobox",
	defaultmissiontype           = "Standby",
	description                  = [[Unit Type: Anti-Air Support Tank
Armortype: ]] ..armortype.. [[ 

105 Damage vs Armored
70 Damage vs Light/Building

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire) .. [[ 

Requires +]] .. power .. [[ 
Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "smallExplosionGeneric",
	firestandorders              = "1",
	footprintX                   = 4,
	footprintZ                   = 4,
	iconType                     = "aa",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 600,
	maxSlope                     = 26,
	maxVelocity                  = 2.9,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	mobilestandorders            = "1",
	movementClass                = "HOVERTANK4",
	name                         = "Paladin",
	noAutoFire                   = false,
	noChaseCategory              = "VTOL AMPHIB NOTAIR SUPPORT",
	objectName                   = "eaatank2.s3o",
	script			             = "eaatank2.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "smallExplosionGeneric",
	sightDistance                = 750,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 2.9,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 430,
	tolerance			         = 1000,
	unitname                     = "eaatank",
	upright                      = true,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:dirt",
			"custom:gdhcannon",
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
			def                  = "eaatankantiairmissile",
			onlyTargetCategory   = "BIO VTOL",
		},
	},
	customParams                 = {
		canbetransported 		 = "true",
		needed_cover             = 1,
		death_sounds             = "generic",
		RequireTech              = power,
		armortype                = armortype,
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies", 
		helptext	             = [[]],
},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                 = {
eaatankantiairmissile            = {
	AreaOfEffect                 = weapon1AOE,
	avoidFriendly                = false,
	avoidFeature                 = false,
	collideFriendly              = false,
	collideFeature               = false,
	burst				         = burstProjectiles,
	burstrate			         = 0.5,
	cegTag                       = "missiletrailaa",
	canAttackGround              = false,
	edgeEffectiveness            = 0.5,
	explosionGenerator           = "custom:BulletImpact3",
	energypershot                = energycosttofire,
	fireStarter                  = 80,
	impulseFactor                = 0,
	interceptedByShieldType      = 4,
	model                        = "missilesmall.s3o",
	name                         = "AA Missile",
	range                        = 1000,
	reloadtime                   = 4,
	weaponType		             = "MissileLauncher",
	soundHit                     = "mediumcannonhit.wav",
	soundStart                   = "missilefiring.wav",
	tolerance                    = 3000,
	turret                       = true,
	startVelocity	             = 750,
	acceleration	             = 2000,
	weaponVelocity               = 10000,
	tracks				         = true,
	turnrate			         = 100000,
	flighttime			         = 2,
	sprayangle			         = 5000,
	
	customParams                 = {
		canbetransported 		 = "true",
	damagetype		             = "eaatank",  
	nofriendlyfire	             = 1,
	
	--Upgrades--
	upgradeClass		         = "groundweapons",
	},
	damage                       = {
	default                      = weapon1Damage,
	},
},

}
unitDef.weaponDefs               = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
