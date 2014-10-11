-- UNITDEF -- EAMPHIBBUGGY --
--------------------------------------------------------------------------------

local unitName                   = "eamphibbuggy"

--------------------------------------------------------------------------------

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 1,
	brakeRate                    = 0.1,
	buildCostEnergy              = 0,
	buildCostMetal               = 18,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = true,
	cancollect                   = "1",
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "LIGHT AMPHIB RAID",
	corpse                       = "ammobox",
	description                  = [[Scout/Raider
	Light
	135 Damage/s vs Light
	80 Damages/s vs Armored/Building
	• Can fire while underwater

	Requires +1 Power
	Uses +1 Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "smallExplosionGenericRed",
	footprintX                   = 2,
	footprintZ                   = 2,
	iconType                     = "raider",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 120,
	maxSlope                     = 28,
	maxVelocity                  = 6.0,
	maxReverseVelocity           = 2,
	maxWaterDepth                = 5000,
	metalStorage                 = 0,
	movementClass                = "TANK2",
	name                         = "Snake",
	noChaseCategory              = "VTOL",
	objectName                   = "eamphibbuggy2.s3o",
	script			             = "eamphibbuggy_lus.lua",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "smallExplosionGenericRed",
	sightDistance                = 500,
	SonarDistance                = 500,
	stealth			             = true,
	seismicSignature             = 2,
	sonarStealth		         = false,
	smoothAnim                   = true,
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 6.0,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 475,
	unitname                     = "eamphibbuggy",
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
			def                  = "lightbeamlaser",
			badTargetCategory    = "ARMORED BUILDING WALL",
		},
		--[[	
		[2]                      = {
			def                  = "TORP",
		},
		]]--
	},
	customParams                 = {
		needed_cover             = 1,
		death_sounds             = "generic",
		RequireTech              = "1 Power",
		armortype                = "light",
		nofriendlyfire	         = "1",
		supply_cost              = 1,
		normalstex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weapon1Damage              = 13.5
local weapon1AOE				 = 1

local weaponDefs                 = {
	lightbeamlaser               = {
		badTargetCategory        = [[ARMORED BUILDING VTOL]],
		TargetMoveError	         = 0.3,
		AreaOfEffect             = weapon1AOE,
		avoidFeature             = false,
		avoidFriendly            = false,
		beamTime                 = 0.1,
		beamlaser                = true,
		collideFeature           = false,
		collideFriendly          = false,
		coreThickness            = 0.2,
		duration                 = 0.1,
		explosionGenerator       = "custom:genericshellexplosion-small-sparks-burn",
		energypershot            = weapon1Damage / 20 * ((weapon1AOE / 1000) + 1),
		fallOffRate              = 1,
		fireStarter              = 50,
		interceptedByShieldType  = 4,
		impulsefactor		     = 0.1,
		lineOfSight              = true,
		laserflaresize 	         = 5,
		largebeamlaser	         = true,
		leadlimit			     = 10,
		minintensity             = 1,
		name                     = "Laser",
		range                    = 300,
		reloadtime               = 0.1,
		WeaponType               = "BeamLaser",
		rgbColor                 = "0.5 0 0",
		rgbColor2                = "0.8 0.8 0.8",
		soundTrigger             = true,
		soundstart               = "amphibbuggytankshothit.wav",
		--	soundHit		     = "amphibbuggytankshothit.wav",
		scrollspeed		         = 5,
		texture1                 = "lightning",
		texture2                 = "laserend",
		thickness                = 5,
		tolerance                = 3000,
		turret                   = true,
		weaponVelocity           = 1000,
		waterweapon		         = true,
		customparams             = {
			damagetype		     = "eamphibbuggy",  
			
			--Upgrades--
			upgradeClass		 = "groundweapons",
		}, 
		damage                   = {
			default              = weapon1Damage, -- multiply * 1.2 for correct dps output
		},
	},
}
unitDef.weaponDefs               = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
