-- UNITDEF -- EAMPHIBMEDTANK --
--------------------------------------------------------------------------------

local unitName                   = "eamphibmedtank"

--------------------------------------------------------------------------------

local power						 = [[4 power]]
local armortype					 = [[light]]
local supply					 = [[4]]

local weapon1Damage              = 12.5
local weapon1AOE				 = 1
local energycosttofire			 = weapon1Damage / 20 * ((weapon1AOE / 1000) + 1)

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
	buildCostMetal               = 33,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = true,
	cancollect                   = "1",
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "LIGHT AMPHIB SKIRMISHER",
	corpse                       = "ammobox",
	description                  = [[Unit Type: Tank Destroyer
Armortype: ]] ..armortype.. [[ 

135 Damage/s vs Light
80 Damages/s vs Armored/Building

125 Damage vs Light/Armored
70 Damage vs Building

Can fire while underwater

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire * 10) .. [[/s 

Requires +]] .. power .. [[ 
Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGenericGreen",
	footprintX                   = 3,
	footprintZ                   = 3,
	iconType                     = "tankdestroyer",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 360,
	maxSlope                     = 28,
	maxVelocity                  = 4.5,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 5000,
	metalStorage                 = 0,
	movementClass                = "TANK3",
	name                         = "Razor",
	noChaseCategory              = "VTOL",
	objectName                   = "eamphibmedtank2.s3o",
	script			             = "eamphibmedtank_lus.lua",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericGreen",
	side                         = "CORE",
	sightDistance                = 550,
	SonarDistance                = 550,
	stealth			             = true,
	seismicSignature             = 2,
	sonarStealth		         = false,
	smoothAnim                   = true,
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 4.5,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 430,
	unitname                     = "eamphibmedtank",
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
		RequireTech              = power,
		armortype                = armortype,
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		normalstex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                 = {
	medtankbeamlaser             = {
		badTargetCategory        = [[BUILDING]],
		TargetMoveError	         = 0.3,
		AreaOfEffect             = weapon1AOE,
		avoidFeature             = false,
		avoidFriendly            = false,
		beamTime                 = 0.1,
		collideFeature           = false,
		collideFriendly          = false,
		coreThickness            = 0.5,
		duration                 = 0.1,
		energypershot            = energycosttofire,
		explosionGenerator       = "custom:genericshellexplosion-medium-sparks-burn",
		fallOffRate              = 1,
		fireStarter              = 50,
		interceptedByShieldType  = 4,
		impulsefactor		     = 0.1,
		lineOfSight              = true,
		largebeamlaser	         = true,
		laserflaresize 	         = 5,
		leadlimit			     = 15,
		minintensity             = 1,
		name                     = "Laser",
		range                    = 550,
		reloadtime               = 0.1,
		WeaponType               = "BeamLaser",
		rgbColor                 = "0 0.5 0",
		rgbColor2                = "0.8 0.8 0.8",
		soundTrigger             = true,
		soundstart               = "amphibmedtankshothit.wav",
		--	soundHit		     = "amphibmedtankshothit.wav",
		scrollspeed		         = 5,
		texture1                 = "lightning",
		texture2                 = "laserend",
		thickness                = 4,
		tolerance                = 3000,
		turret                   = true,
		weaponVelocity           = 1000,
		waterweapon		         = true,
		customparams             = {
			damagetype		     = "eamphibmedtank",  
			
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
