-- UNITDEF -- EAMPHIBRIOT--
--------------------------------------------------------------------------------

local unitName                   = "eamphibriot"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 23
local maxDamage					  = 340

local tech						 = [[tech1]]
local armortype					 = [[light]]
local supply					 = [[3]]

local weapon1Damage              = 200
local weapon1AOE				 = 250
local weapon2Damage              = 75
local weapon2AOE				 = 100
local weapon2Projectiles         = 10
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)
local energycosttofire2          = weapon2Damage / 10 * ((weapon2AOE / 1000) + 1) * weapon2Projectiles

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local function roundToFirstDecimal(energycosttofire2)
    return math.floor(energycosttofire2*10 + 0.5)*0.1
end

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 1,
	brakeRate                    = 0.1,
	buildCostEnergy              = 0,
	buildCostMetal               = buildCostMetal,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = true,
	cancollect                   = "1",
	--  canDgun			         = true,
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "LIGHT AMPHIB RIOT",
	corpse                       = "ammobox",
	description                  = [[Anti-Swarm EMP/Riot Tank • Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGenericWhite",
	footprintX                   = 3,
	footprintZ                   = 3,
	iconType                     = "riot_lit",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = maxDamage,
	maxSlope                     = 28,
	maxVelocity                  = 5,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 5000,
	metalStorage                 = 0,
	movementClass                = "TANK3",
	name                         = "Dicer",
	noChaseCategory              = "VTOL",
	objectName                   = "eamphibriot2.s3o",
	script	                     = "eamphibriot.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericWhite",
	side                         = "CORE",
	sightDistance                = 500,
	sonarDistance                = 500,
	stealth			             = true,
	seismicSignature             = 2,
	sonarStealth		         = false,
	smoothAnim                   = true,
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 3.7,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 430,
	unitname                     = unitName,
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
			def                  = "riottankempweapon",
			onlyTargetCategory   = "BIO LIGHT ARMORED BUILDING",
			badTargetCategory    = "WALL",
		},
		[2]                      = {
			def                  = "riottankshotgun",
			onlyTargetCategory   = "BIO LIGHT ARMORED BUILDING",
			badTargetCategory    = "WALL BUILDING",
		},
	},
	customParams                 = {
		canbetransported 		 = "true",
		needed_cover             = 2,
		death_sounds             = "generic",
		RequireTech              = tech,
		armortype                = "light",
		nofriendlyfire	         = "1",
		supply_cost              = 3,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
		helptext				 = [[Armortype: ]] ..armortype.. [[ 

Paralyzes enemy units
Projectile can hit multiple units

Alternate fire mode fires 10 projectiles in a shotgun spread with a small area of effect. Reduced damage vs buildings when in shotgun mode.

Energy cost to fire EMP: ]] .. roundToFirstDecimal(energycosttofire) .. [[ 
Energy cost to fire Shotgun: ]] .. roundToFirstDecimal(energycosttofire2),
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                 = {
	riottankempweapon            = {
		
		AreaOfEffect             = weapon1AOE,
		avoidFeature             = false,
		avoidFriendly            = false,
		collideFeature           = false,
		collideFriendly          = false,
		coreThickness            = 0.6,
		--	cegTag               = "mediumcannonweapon3",
		duration                 = 0.05,
		edgeeffectiveness        = 0.1,
		energypershot            = energycosttofire,
		explosionGenerator       = "custom:genericshellexplosion-medium-blue",
		fallOffRate              = 1,
		fireStarter              = 100,
		impulseFactor            = 0,
		
		minintensity             = 1,
		name                     = "Laser",
		noexplode		         = true,
		paralyzer		         = true,
		paralyzetime	         = 2.5,
		range                    = 400,
		reloadtime               = 1,
		WeaponType               = "LaserCannon",
		rgbColor                 = "0 0.2 1",
		rgbColor2                = "1 1 1",
		soundTrigger             = true,
		soundstart               = "fnubeamfire.wav",
		soundHit                 = "phasegun1hit.wav",
		texture1                 = "wave",
		texture2                 = "empty",
		thickness                = 40,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 1000,
		customparams             = {
			damagetype		     = "eamphibriot",  
			nofriendlyfire	     = 1,
			
			--Upgrades--
			upgradeClass		 = "groundweapons",
		}, 
		damage                   = {
			default              = weapon1Damage,
		},
	},

	riottankshotgun              = {
		AreaOfEffect             = weapon2AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		
		cegTag                   = "bruisercannon",
		explosionGenerator       = "custom:genericshellexplosion-small",
		energypershot            = energycosttofire2,
		interceptedByShieldType  = 4,
		impulseFactor            = 0,
		name                     = "Light Cannon",
		projectiles		         = weapon2Projectiles,
		range                    = 400,
		reloadtime               = 5,
		weaponType		         = "Cannon",
		soundHit                 = "mediumcannonhit.wav",
		soundStart               = "bruisercannon.wav",
		sprayangle		         = 2000,
		
		turret                   = true,
		weaponVelocity           = 400,
		customparams             = {
			damagetype		     = "eallterrriotshotgun",  
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
