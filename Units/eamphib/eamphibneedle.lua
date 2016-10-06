-- UNITDEF -- eamphibneedle --
--------------------------------------------------------------------------------

local unitName                   = "eamphibneedle"

--------------------------------------------------------------------------------

local buildCostMetal 			  = 42
local maxDamage					  = 340

local tech						 = [[1 Generator]]
local armortype					 = [[light]]
local supply					 = [[3]]

local weapon1Damage              = 20
local weapon1AOE				 = 0
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
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
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "LIGHT AMPHIB RAID",
	corpse                       = "ammobox",
	description                  = [[Light Tank Destroyer • Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGenericPurple",
	footprintX                   = 4,
	footprintZ                   = 4,
	iconType                     = "tankdestroyer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = maxDamage,
	maxSlope                     = 28,
	maxVelocity                  = 4.9,
	maxReverseVelocity           = 2,
	maxWaterDepth                = 5000,
	metalStorage                 = 0,
	movementClass                = "TANK4",
	name                         = "Ikinz",
	objectName                   = "eamphibaa.s3o",
	script			             = "eamphibaa.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericPurple",
	sightDistance                = 400,
	sonarDistance                = 400,
	stealth			             = true,
	seismicSignature             = 2,
	sonarStealth		         = false,
	smoothAnim                   = true,
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 6.0,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 475,
	unitname                     = unitNeedle,
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
			def                  = "medtankbeamlaser",
			badTargetCategory    = "BUILDING WALL",
		},
		--[[	
		[2]                      = {
			def                  = "TORP",
		},
		]]--
	},
	customParams                 = {
		canbetransported 		 = "true",
		needed_cover             = 2,
		death_sounds             = "generic",
		RequireTech              = tech,
		armortype                = "light",
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
		helptext				 = [[Armortype: ]] ..armortype.. [[ 

Can fire while underwater

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire * 10) .. [[/s]],
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                 = {

	medtankbeamlaser             = {
		AreaOfEffect             = weapon1AOE,
		avoidFeature             = false,
		avoidFriendly            = false,
		beamTime                 = 0.1,
		collideFeature           = false,
		collideFriendly          = false,
		coreThickness            = 0.2,
		duration                 = 0.1,
		energypershot            = energycosttofire,
		explosionGenerator       = "custom:genericshellexplosion-medium-sparks-burn",
		fallOffRate              = 1,
		fireStarter              = 50,
		interceptedByShieldType  = 4,
		impulsefactor		     = 0,
		
		largebeamlaser	         = true,
		laserflaresize 	         = 5,
		leadlimit			     = 15,
		minintensity             = 1,
		name                     = "Laser",
		range                    = 400,
		reloadtime               = 0.1,
		WeaponType               = "BeamLaser",
		rgbColor                 = "0.25 0 0.6",
		rgbColor2                = "0.8 0.8 0.8",
		soundTrigger             = true,
		soundstart               = "plasma2.wav",
		--	soundHit		     = "amphibmedtankshothit.wav",
		scrollspeed		         = 5,
		texture1                 = "lightning",
		texture2                 = "laserend",
		thickness                = 10,
		tolerance                = 3000,
		turret                   = true,
		weaponVelocity           = 1000,
		waterweapon		         = true,
		customparams             = {
			damagetype		     = "eamphibneedle",  
			
			--Upgrades--
			upgradeClass		 = "groundweapons",
		}, 
		damage                   = {
			default              = weapon1Damage, -- multiply * 1.2 for correct dps output
		},
	},

	antiaircannon                = {
		AreaOfEffect             = weapon1AOE,
		avoidFeature             = false,
		avoidFriendly            = false,
		collideFeature           = false,
		collideFriendly          = false,
		coreThickness            = 0.4,
		burnblow		         = true,
		--	cegTag               = "mediumcannonweapon3",
		duration                 = 0.05,
		energypershot            = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1),
		explosionGenerator       = "custom:genericshellexplosion-medium-sparks-burn",
		fallOffRate              = 1,
		fireStarter              = 50,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		
		minintensity             = "1",
		name                     = "Laser",
		range                    = 800,
		reloadtime               = 0.1,
		WeaponType               = "LaserCannon",
		rgbColor                 = "1 0.5 0",
		rgbColor2                = "1 1 1",
		soundTrigger             = true,
		soundstart               = "tmediumtankfire.wav",
		texture1                 = "shot",
		texture2                 = "empty",
		thickness                = 6,
		tolerance                = 1000,
		turret                   = true,
		weaponVelocity           = 2500,
		customparams             = {
			damagetype		     = "eamphibneedle",  
			
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
