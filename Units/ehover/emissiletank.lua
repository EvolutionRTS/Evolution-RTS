-- UNITDEF -- EMISSILETANK --
--------------------------------------------------------------------------------

local unitName                   = "emissiletank"

--------------------------------------------------------------------------------

local buildCostMetal			 = 62
local maxDamage					 = 320

local tech						 = [[2 Generator]]
local armortype					 = [[light]]
local supply					 = [[14]]

local weapon1Damage              = 150
local weapon1AOE				 = 100
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 1,
	brakeRate                    = 0.2,
	buildCostEnergy              = 0,
	buildCostMetal               = buildCostMetal,
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
	description                  = [[Missile Support Tank • Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "largeExplosionGeneric",
	footprintX                   = 4,
	footprintZ                   = 4,
	iconType                     = "tankdestroyer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = maxDamage,
	maxSlope                     = 26,
	maxVelocity                  = 2.5,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "HOVERTANK4",
	name                         = "Droplet",
	objectName                   = "emissiletank2.s3o",
	script			             = "emissiletank2.cob",
	onlytargetcategory3          = "NOTAIR",
	onlytargetcategory4          = "NOTAIR",
	onlytargetcategory5          = "NOTAIR",
	onlytargetcategory6          = "NOTAIR",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "largeExplosionGeneric",
	side                         = "ARM",
	sightDistance                = 850,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 2.6,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 300,
	unitname                     = "emissiletank",
	upright                      = true,
	workerTime                   = 0,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:factorysparks",
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
			def                  = "missletankweapon",
			onlyTargetCategory   = "BIO LIGHT ARMORED BUILDING",
			badTargetCategory    = "BUILDING LIGHT",
		},
	},
	customParams                 = {
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
		factionname	             = "outer_colonies",  
		helptext	             = [[Armortype: ]] ..armortype.. [[ 

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire),
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                 = {
	missletankweapon             = {

		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		cegTag                   = "missiletrail",
		craterBoost              = 0,
		craterMult               = 0,
		explosionGenerator       = "custom:genericshellexplosion-medium-red",
		energypershot            = energycosttofire,
		fireStarter              = 100,
		flightTime               = 5,
		impulseBoost             = 0,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		
		model                    = "missilesmallvlaunch.s3o",
		name                     = "Rocket",
		range                    = 850,
		reloadtime               = 3,
		weaponType		         = "MissileLauncher",
		
		
		smokeTrail               = false,
		soundHit                 = "explode_large.wav",
		soundStart               = "missile_launch1.wav",
		
		tracks                   = true,
		turnrate                 = 17500,
		
		weaponAcceleration       = 400,
		weaponTimer              = 1,
		weaponType               = "StarburstLauncher",
		weaponVelocity           = 1000,
		customparams             = {
			damagetype		     = "emissiletank",  
			
			--Upgrades--
			upgradeClass		 = "groundweapons",
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
