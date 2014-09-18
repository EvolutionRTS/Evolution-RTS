-- UNITDEF -- EHEAVYTANK3 --
--------------------------------------------------------------------------------

local unitName                   = "eheavytank3"

--------------------------------------------------------------------------------

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 1,
	brakeRate                    = 0.2,
	buildCostEnergy              = 0,
	buildCostMetal               = 29,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = true,
	cancollect                   = "1",
	canGuard                     = true,
	canHover                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "ARMORED NOTAIR SKIRMISHER",
	corpse                       = "ammobox",
	description                  = [[Armored Tank Destroyer
	Armored
	150 Damage vs Light/Armored
	75 Damage vs Building

	Requires +4 Power
	Uses +4 Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "largeExplosionGenericRed",
	footprintX                   = 4,
	footprintZ                   = 4,
	iconType                     = "tankdestroyer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 375,
	maxSlope                     = 26,
	maxVelocity                  = 3.5,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "HOVERTANK4",
	name                         = "Crusher",
	noChaseCategory              = "VTOL",
	objectName                   = "eheavytank4.s3o",
	script			             = "eheavytank4_lus.lua",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "largeExplosionGenericRed",
	side                         = "CORE",
	sightDistance                = 650,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 2.8,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 350,
	unitname                     = "eheavytank3",
	upright                      = true,
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
			def                  = "heavytankweapon",
			onlyTargetCategory   = "NOTAIR AMPHIB",
			badTargetCategory    = "BUILDING WALL",
		},
	},
	customParams                 = {
		needed_cover             = 3,
		death_sounds             = "generic",
		RequireTech              = "4 Power",
		armortype                = "armored",
		nofriendlyfire	         = "1",
		supply_cost              = 4,
		normalstex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
		helptext                 = [[]],
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)
local weapon1Damage              = 150
local weapon1AOE				 = 1

local weaponDefs                 = {
	heavytankweapon              = {
		badTargetCategory        = [[BUILDING]],
		accuracy                 = 200,
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		ballistic                = true,
		cegTag                   = "antiassualtshot2",
		explosionGenerator       = "custom:genericshellexplosion-medium",
		energypershot            = weapon1Damage / 20 * ((weapon1AOE / 1000) + 1),
		id                       = 172,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		name                     = "Light Cannon",
		range                    = 650,
		reloadtime               = 1,
		weaponType		         = "Cannon",
		soundHit                 = "42024_digifishmusic_Missile_Strike.wav",
		soundStart               = "triotfire.wav",
		startsmoke               = "1",
		tolerance                = 2000,
		turret                   = true,
		weaponVelocity           = 1500,
		customparams             = {
			damagetype		     = "eheavytank3",  
			
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
