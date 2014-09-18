-- UNITDEF -- EARTYTANK --
--------------------------------------------------------------------------------

local unitName                   = "eartytank"

--------------------------------------------------------------------------------

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 1,
	brakeRate                    = 0.2,
	buildCostEnergy              = 0,
	buildCostMetal               = 36,
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
	description                  = [[Artillery Support Tank
	Light
	200 Damage vs Buildings
	50 Damage vs Light/Armored

	Requires +8 Power
	Uses +8 Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGeneric",
	footprintX                   = 3,
	footprintZ                   = 3,
	iconType                     = "assault",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 300,
	maxVelocity                  = 2.3,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "HOVERTANK3",
	name                         = "ShadowFury",  --Because he was the first one to get the "Lobster" pun
	noChaseCategory              = "VTOL",
	objectName                   = "eartytank2.s3o",
	script			             = "eartytank2.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGeneric",
	side                         = "CORE",
	sightDistance                = 1500,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 2.3,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 250,
	unitname                     = "eartytank",
	workerTime                   = 0,
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg0", 
			"deathceg1", 
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
			def                  = "Artilleryweapon",
			onlyTargetCategory   = "BUILDING",
		},
		[2]                      = {
			def                  = "SaturationArtilleryweapon",
			onlyTargetCategory   = "BUILDING",
		},
	},
	customParams                 = {
		canareaattack            ="1",
		needed_cover             = 3,
		death_sounds             = "generic",
		RequireTech              = "5 Power",
		armortype                = "light",
		nofriendlyfire	         = "1",
		supply_cost              = 5,
		normalstex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
		helptext                 = [[]],
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)
local weapon1Damage              = 200
local weapon1AOE				 = 50
local weapon2Damage              = 20
local weapon2AOE				 = 250

local weaponDefs                 = {
	Artilleryweapon              = {
		badTargetCategory        = [[ARMORED LIGHT]],
		accuracy                 = 500,
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		ballistic                = true,
		cegTag                   = "artyshot2",
		avoidNeutral	         = false,
		explosionGenerator       = "custom:genericshellexplosion-medium",
		energypershot            = weapon1Damage / 20 * ((weapon1AOE / 1000) + 1),
		impulse                  = "0",
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		highTrajectory	         = 0,
		name                     = "Plasma Cannon",
		range                    = 1500,
		reloadtime               = 5,
		weaponType		         = "Cannon",
		soundHit                 = "artyhit.wav",
		soundStart               = "arty2.wav",
		startsmoke               = "1",
		turret                   = true,
		weaponVelocity           = 500,
		customparams             = {
			damagetype		     = "eartytank", 

			--Upgrades--
			upgradeClass		 = "groundweapons",	  
		},  
		damage                   = {
			default              = weapon1Damage,
		},
	},

	SaturationArtilleryweapon    = {
		badTargetCategory        = [[ARMORED LIGHT]],
		accuracy                 = 750,
		AreaOfEffect             = weapon2AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		ballistic                = true,
		cegTag                   = "artyshot2",
		avoidNeutral	         = false,
		explosionGenerator       = "custom:genericshellexplosion-large",
		energypershot            = weapon2Damage / 20 * ((weapon2AOE / 1000) + 1),
		edgeEffectiveness        = 1,
		impulse                  = "0",
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		highTrajectory	         = 1,
		name                     = "Plasma Cannon",
		range                    = 1500,
		reloadtime               = 0.5,
		weaponType		         = "Cannon",
		soundHit                 = "artyhit.wav",
		soundStart               = "arty2.wav",
		startsmoke               = "1",
		turret                   = true,
		weaponVelocity           = 500,
		customparams             = {
			damagetype		     = "eartytank", 

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
