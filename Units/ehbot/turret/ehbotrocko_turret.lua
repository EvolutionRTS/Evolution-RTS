-- UNITDEF -- ehbotrocko_turret --
--------------------------------------------------------------------------------

local unitName                   = "ehbotrocko_turret"

--------------------------------------------------------------------------------

local tech						 = [[tech2]]
local armortype					 = [[building]]
local supply					 = [[15]]
local maxDamage					 = 350 * 4


local weapon1Damage              = 100
local weapon1AOE				 = 500
local weapon1Range				 = 1000
local reloadTime				 = 2.5
--local projectiles				 = 5
--local burst						 = 10
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;
	--**

	acceleration                 = 1,
	brakeRate                    = 1,
	buildCostEnergy              = 0,
	buildCostMetal               = 110,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = true,
	
	canGuard                     = true,
	canHover                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "BUILDING NOTAIR",
	corpse                       = "ammobox",
	description                  = [[Tank Destroyer Artillery Turret • Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGenericRed",
	floater			              = true,
	footprintX                   = 3,
	footprintZ                   = 3,
	--highTrajectory		   		 = 2,
	iconType                     = "turret_arm",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = maxDamage,
	maxSlope                     = 26,
	maxVelocity                  = 0.001,
	maxReverseVelocity           = 0.001,
	maxWaterDepth                = 5000,
	metalStorage                 = 0,
	movementClass                = "HOVERHBOT3",
	pushResistant				 = true,
	name                         = "Rocko Turret",
	noChaseCategory              = "VTOL",
	objectName                   = "ehbotrocko_turret.s3o",
	script						 = "ehbotrocko_turret_lus.lua",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGenericRed",
	side                         = "CORE",
	sightDistance                = weapon1Range,
	smoothAnim                   = true,
	stealth			             = false,
	seismicSignature             = 2,
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 5.5,
	turnInPlace                  = true,
	turnRate                     = 0.001,
	--  turnrate                 = 475,
	unitname                     = unitname,
	--usePieceCollisionVolumes	 = true,
	upright                      = true,
	workerTime                   = 0,

	sfxtypes                     = {
		explosiongenerators      = {
			"custom:gdhcannon",
			"custom:dirt",
			"custom:blacksmoke",
			"custom:airfactoryhtrail",
		},
		pieceExplosionGenerators = {
			"deathceg3",
			"deathceg4",
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
			def                  = "rockets",
--			mainDir = "0 0 1", -- x:0 y:0 z:1 => that's forward!
--			maxAngleDif = 70,
			onlyTargetCategory    = "LIGHT ARMORED BIO",
		},
	},
	customParams                 = {
		canbetransported 		 = "true",
		needed_cover             = 1,
		death_sounds             = "generic",
		RequireTech              = tech,
		armortype                = armortype,
		nofriendlyfire	         = "1",
		supply_cost              = supply,
		normaltex               = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "outer_colonies",  
		helptext                 = [[Armortype: ]] ..armortype.. [[ 
 
Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire),
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                 = {
	rockets             = {
		accuracy				 = 1000,
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		cegTag                   = "missiletrailsmall",
		explosionGenerator       = "custom:genericshellexplosion-large-red",
		energypershot            = energycosttofire,
		fireStarter              = 70,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		model                    = "missilesmalllauncher.s3o",
		name                     = "Rockets",
		range                    = weapon1Range,
		reloadtime               = reloadTime,
		weaponType		         = "MissileLauncher",
		smokeTrail               = false,
		soundStart               = "emediumtankfire2.wav",
		soundHit                 = "explode5.wav",
		startVelocity            = 250,
		tolerance                = 8000,
		turnrate                 = 1500,
		turret                   = true,
		tracks                   = true,
		weaponAcceleration       = 100,
		flightTime               = 3,
		weaponVelocity           = 1500,
		customparams             = {
			damagetype		     = "ehbotrocko",  

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
