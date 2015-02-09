-- UNITDEF -- EEXKRABGOTH --
--------------------------------------------------------------------------------

local unitName                   = "eexkrabgroth"

--------------------------------------------------------------------------------

local power						 = [[25 power]]
local armortype					 = [[armored]]
local supply					 = [[25]]

local weapon1Damage              = 600
local weapon1AOE				 = 10
local weapon2Damage              = 600
local weapon2AOE				 = 10
local energycosttofire			 = weapon1Damage / 20 * ((weapon1AOE / 1000) + 1)
local energycosttofire2			 = weapon2Damage / 20 * ((weapon2AOE / 1000) + 1)

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
	brakeRate                    = 0.2,
	buildCostEnergy              = 0,
	buildCostMetal               = 450,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = true,
	cancollect                   = "1",
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	cantBeTransported            = true,
	category                     = "ARMORED NOTAIR SKIRMISHER",
	corpse                       = "ammobox",
	description                  =[[Unit Type: Endbringer Class Base Assault Walker
Armortype: ]] ..armortype.. [[ 

Primary Laser:
600 Damage/s vs Building
60 Damage/s vs Light/Armored

Secondary Cannons:
80 Damage vs Building
8 Damage vs Light/Armored

This unit can only attack buildings!
	
Energy cost to fire Primary Laser: ]] .. roundToFirstDecimal(energycosttofire) .. [[ 
Energy cost to fire Secondary Cannons: ]] .. roundToFirstDecimal(energycosttofire2) .. [[ 

Requires +]] .. power .. [[ 
Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "krabblast",
	firestandorders              = "1",
	footprintX                   = 12,
	footprintZ                   = 12,
	iconType                     = "assault",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 15000,
	maxVelocity                  = 2.5,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 80,
	metalStorage                 = 0,
	movementClass                = "EXPERIMENTALTANK12",
	name                         = "Anarchid",
	noChaseCategory              = "VTOL",
	objectName                   = "ekrabgroth.s3o",
	pushResistant		         = true,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "krabblast",
	shootme                      = "1",
	sightDistance                = 1000,
	smoothAnim                   = true,
	turnInPlace                  = true,
	turnRate                     = 5000,
	unitname                     = "eexkrabgroth",
	unitnumber                   = "110",
	upright                      = false,
	--  usePieceCollisionVolumes = true,
	workerTime                   = 0,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:gdhcannon",
			"custom:dirtsmall",
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
			def                  = "heavybeamweapon",
			onlyTargetCategory   = "BUILDING",
		},
		[2]                      = {
			def                  = "concussioncannon",
			onlyTargetCategory   = "BUILDING",
		},
		[3]                      = {
			def                  = "concussioncannon",
			onlyTargetCategory   = "BUILDING",
		},
	},
	customParams                 = {
		death_sounds             = "nuke",
		RequireTech              = power,
		armortype                = armortype,
		supply_cost              = supply,
		normalstex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                 = {
	heavybeamweapon              = {
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		beamTime                 = 1,
		beamWeapon               = true,
		cameraShake		         = 1,
		coreThickness            = 0.5,
		--	cegTag               = "mediumcannonweapon3",
		--    duration           = 0.2,
		energypershot            = energycosttofire,
		explosionGenerator       = "custom:genericshellexplosion-large-purple",
		fallOffRate              = 1,
		fireStarter              = 50,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		lineOfSight              = true,
		minintensity             = "1",
		name                     = "Laser",
		range                    = 1000,
		reloadtime               = 1,
		WeaponType               = "BeamLaser",
		rgbColor                 = "1 0 1",
		rgbColor2                = "1 1 1",
		soundTrigger             = true,
		soundstart               = "krabprimary.wav",
		--    soundHit           = "mediumcannonhit.wav",
		--	sweepfire		     = true,
		texture1                 = "shot",
		texture2                 = "empty",
		thickness                = 9,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 800,
		customparams             = {
			damagetype		     = "eexkrabgroth",  
			
			--Upgrades--
			upgradeClass		 = "groundweapons",
		}, 
		damage                   = {
			default              = weapon1Damage,
		},
	},

	concussioncannon             = {
		accuracy                 = 1,
		AreaOfEffect             = weapon2AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		ballistic                = true,
		collideFriendly          = false,
		collideFeature           = false,
		cylinderTargeting        = true,
		burnblow                 = true,
		endsmoke                 = "1",
		explosionGenerator       = "custom:genericshellexplosion-medium",
		energypershot            = energycosttofire2,
		fireStarter              = 80,
		id                       = 1,
		impulseFactor            = 0.1,
		interceptedByShieldType  = 4,
		name                     = "Concussion Cannon",
		pitchtolerance           = "500",
		range                    = 1000,
		reloadtime               = 1,
		weaponType		         = "Cannon",
		soundHit                 = "explode2",
		soundStart               = "krabsecondary.wav",
		startsmoke               = "1",
		tolerance                = 500,
		turret                   = true,
		weaponVelocity           = 5000,
		customparams             = {
			damagetype		     = "eexkrabgroth",  
			
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

