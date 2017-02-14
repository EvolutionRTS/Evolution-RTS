-- UNITDEF -- eallterranarchid --
--------------------------------------------------------------------------------

local unitName                   = "eallterranarchid"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 225
local maxDamage					  = 2750

local tech						 = [[tech3]]
local armortype					 = [[armored]]
local supply					 = [[12]]

local weapon1Damage              = 300
local weapon1AOE				 = 10
local weapon2Damage              = 25
local weapon2AOE				 = 1
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
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = buildCostMetal,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = true,
	
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	cantBeTransported            = true,
	category                     = "ARMORED NOTAIR SKIRMISHER",
	corpse                       = "ammobox",

	-- Cloaking

	cancloak		             = true,
	cloakCost		             = 0,
	cloakCostMoving	             = 1,
	minCloakDistance             = 150,
	decloakOnFire	             = true,
	decloakSpherical             = true,
	initCloaked		             = false,
	
	-- End Cloaking
	
	description                  =[[Unit Type: Endbringer Class Base Assault Walker • Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "krabblast",
	firestandorders              = "1",
	footprintX                   = 6,
	footprintZ                   = 6,
	iconType                     = "anarchid",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = maxDamage,
	maxVelocity                  = 2.5,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 80,
	metalStorage                 = 0,
	movementClass                = "ALLTERRTANK6",
	name                         = "Anarchid",
	noChaseCategory              = "VTOL",
	objectName                   = "eallterranarchid.s3o",
	pushResistant		         = true,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "krabblast",
	shootme                      = "1",
	sightDistance                = 1000,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 4,
	turnInPlace                  = true,
	turnRate                     = 5000,
	unitname                     = "eallterranarchid",
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
			"custom:flamethrowerrange500",
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
		},
		[2]                      = {
			def                  = "flamethrower",
		},
		[3]                      = {
			def                  = "flamethrower",
		},
	},
	customParams                 = {
		death_sounds             = "nuke",
		RequireTech              = tech,
		armortype                = armortype,
		supply_cost              = supply,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
		helptext				 = [[Armortype: ]] ..armortype.. [[ 
	
Energy cost to fire Primary Laser: ]] .. roundToFirstDecimal(energycosttofire) .. [[ 
Energy cost to fire Secondary Cannons: ]] .. roundToFirstDecimal(energycosttofire2),
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
		cameraShake		         = 1,
		coreThickness            = 0.2,
		--	cegTag               = "mediumcannonweapon3",
		--    duration           = 0.2,
		energypershot            = energycosttofire,
		explosionGenerator       = "custom:genericshellexplosion-large-sparks-burn",
		fallOffRate              = 1,
		fireStarter              = 50,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		minintensity             = "1",
		name                     = "Laser",
		range                    = 1000,
		reloadtime               = 1,
		WeaponType               = "BeamLaser",
		rgbColor                 = "1 0 0",
		rgbColor2                = "1 1 1",
		soundTrigger             = true,
		soundstart               = "krabprimary.wav",
		--    soundHit           = "mediumcannonhit.wav",
		--	sweepfire		     = true,
		texture1                 = "shot",
		texture2                 = "empty",
		thickness                = 6,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 800,
		customparams             = {
			damagetype		     = "eallterranarchid",  
			
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
		collideFriendly          = false,
		collideFeature           = false,
		cylinderTargeting        = true,
		burnblow                 = true,
		explosionGenerator       = "custom:genericshellexplosion-medium",
		energypershot            = energycosttofire2,
		fireStarter              = 80,
		id                       = 1,
		impulseFactor            = 0.1,
		interceptedByShieldType  = 4,
		name                     = "Concussion Cannon",
		range                    = 1000,
		reloadtime               = 1,
		weaponType		         = "Cannon",
		soundHit                 = "explode2",
		soundStart               = "krabsecondary.wav",
		tolerance                = 500,
		turret                   = true,
		weaponVelocity           = 5000,
		customparams             = {
			damagetype		     = "eallterranarchid",  
			
			--Upgrades--
			upgradeClass		 = "groundweapons",
		},
		damage                   = {
			default              = weapon2Damage,
		},
	},
	flamethrower                 = {
		
		accuracy                 = 0,
		AreaOfEffect             = weapon2AOE,
		avoidFeature             = false,
		avoidFriendly            = false,
		collideFeature           = false,
		collideFriendly          = false,
		explosionGenerator       = "custom:burnblack",
		coreThickness            = 0,
		duration                 = 1,
		energypershot            = energycosttofire2,
		fallOffRate              = 1,
		fireStarter              = 50,
		interceptedByShieldType  = 4,
		soundstart               = "flamethrower1.wav",
		
		minintensity             = 1,
		impulseFactor            = 0,
		name                     = "Something with Flames",
		range                    = 500,
		reloadtime               = 0.1,
		WeaponType               = [[LaserCannon]],
		rgbColor                 = "0 0 0",
		rgbColor2                = "0 0 0",
		thickness                = 0,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 400,
		customparams             = {
			damagetype		     = "eallterranarchidflame",  
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

