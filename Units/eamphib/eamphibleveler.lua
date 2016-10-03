-- UNITDEF -- eamphibleveler --
--------------------------------------------------------------------------------

local unitName                   = "eamphibleveler"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 250
local maxDamage					  = 1250

local power						 = [[3 power]]
local armortype					 = [[armored]]
local supply					 = [[10]]

local weapon1Damage              = 250
local weapon1AOE				 = 8
local weapon2Damage              = 6
local weapon2AOE				 = 8
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)
local energycosttofire2			 = weapon2Damage / 10 * ((weapon2AOE / 1000) + 1)

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


	acceleration                 = 0.18,
	brakeRate                    = 0.1,
	buildCostEnergy              = 0,
	buildCostMetal               = buildCostMetal,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = true,
	cancollect                   = "1",
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "ARMORED AMPHIB SKIRMISHER",
	corpse                       = "ammobox",
	description                  = [[Unit Type: Endbringer Class Tank Destroyer
Armortype: ]] ..armortype.. [[ 

Main Cannon:
250 Damage vs Light/Armored
25 Damage vs Building

Secondary Machinegun:
60 Damage/s vs Light/Armored
6 Damage/s vs Building

This unit can only attack other mobile units!

Energy cost to fire Main Cannon: ]] .. roundToFirstDecimal(energycosttofire) .. [[ 
Energy cost to fire Secondary Machinegun: ]] .. roundToFirstDecimal(energycosttofire2 * 10) .. [[/s 

Requires +]] .. power .. [[ 
Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "krabblast",
	footprintX                   = 6,
	footprintZ                   = 6,
	iconType                     = "tankdestroyer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = maxDamage,
	maxSlope                     = 28,
	maxVelocity                  = 4,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 5000,
	metalStorage                 = 0,
	movementClass                = "TANK6",
	name                         = "Leveler",
	noChaseCategory              = "VTOL",
	objectName                   = "eamphibleveler.s3o",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "krabblast",
	side                         = "CORE",
	sightDistance                = 750,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 4,
	turnInPlace                  = true,
	turnRate                     = 5000,
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
			def                  = "tankkillerlaser",
		},
		[2]                      = {
			def                  = "machinegun",
		},
	},
	customParams                 = {
		death_sounds             = "nuke",
		RequireTech              = power,
		armortype                = armortype,
		supply_cost              = supply,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies", 
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                 = {
	tankkillerlaser              = {
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		beamTime                 = 0.1,
		
		coreThickness            = 0.5,
		duration                 = 0.2,
		energypershot            = energycosttofire,
		explosionGenerator       = "custom:genericshellexplosion-large-purple",
		fallOffRate              = 1,
		fireStarter              = 100,
		interceptedByShieldType  = 4,
		impulseFactor            = 0.1,
		
		minintensity             = "1",
		name                     = "Anti-Tank Laser",
		range                    = 750,
		reloadtime               = 0.5,
		WeaponType               = "LaserCannon",
		rgbColor                 = "0.2 0 0.5",
		rgbColor2                = "0.8 0.8 0.8",
		soundTrigger             = true,
		soundstart               = "tankdestroyermaingunfire.wav",
		texture1                 = "pulseshot2",
		texture2                 = "empty",
		thickness                = 9,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 1000,
		customparams             = {
			damagetype		     = "eamphibleveler",  
			
			--Upgrades--
			upgradeClass		 = "groundweapons",
		}, 
		damage                   = {
			default              = weapon1Damage,
		},
	},

	machinegun                   = {
		accuracy                 = 300,
		AreaOfEffect             = weapon2AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		beamTime                 = 0.1,
		
		coreThickness            = 0.5,
		duration                 = 0.1,
		explosionGenerator       = "custom:genericshellexplosion-large-sparks-burn",
		energypershot            = energycosttofire2,
		fallOffRate              = 1,
		fireStarter              = 50,
		interceptedByShieldType  = 4,
		
		minintensity             = "1",
		name                     = "Machine Gun",
		range                    = 750,
		reloadtime               = 0.1,
		WeaponType               = "LaserCannon",
		rgbColor                 = "1 0.5 0",
		rgbColor2                = "1 1 1",
		soundTrigger             = true,
		soundstart               = "tankdestroyerfire.wav",
		texture1                 = "shot",
		texture2                 = "empty",
		thickness                = 5,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 1000,
		customparams             = {
			damagetype		     = "eamphibleveler", 
			
			--Upgrades--
			upgradeClass		 = "groundweapons",
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
