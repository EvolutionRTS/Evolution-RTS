-- UNITDEF -- elacerator --
--------------------------------------------------------------------------------

local unitName                   = "elacerator"

--------------------------------------------------------------------------------

local buildCostMetal 			 = 200
local maxDamage					 = 2500

local tech						 = [[tech3]]
local armortype					 = [[armored]]
local supply					 = [[8]]

local weapon1Damage              = 1000
local weapon1AOE				 = 500
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 0.18,
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
	category                     = "ARMORED NOTAIR SUPPORT",
	corpse                       = "ammobox",
	description                  = [[Low Yield Nuclear Saturation Artillery • Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "BIG_UNIT",
	footprintX                   = 6,
	footprintZ                   = 6,
	--highTrajectory               = 1,
	iconType                     = "lacerator",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = maxDamage,
	maxVelocity                  = 2.3,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 20,
	metalStorage                 = 0,
	movementClass                = "HOVERTANK6",
	name                         = "Lacerator",
	noChaseCategory              = "VTOL",
	objectName                   = "elacerator.s3o",
	pushResistant		         = true,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "BIG_UNIT",
	side                         = "CORE",
	sightDistance                = 1500,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 4,
	turnInPlace                  = true,
	turnRate                     = 5000,
	unitname                     = "elacerator",
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
			def                  = "nukeartyweapon",
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
		helptext                 = [[Armortype: ]] ..armortype.. [[ 

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire),
	},
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                 = {
	nukeartyweapon               = {
		accuracy                 = 2000,
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		
		cegTag                   = "nukeartyshot",
		explosionGenerator       = "custom:nukeartyexpl",
		edgeEffectiveness        = 0.1,
		energypershot            = energycosttofire,
		id                       = 172,
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		name                     = "Light Cannon",
		range                    = 1500,
		reloadtime               = 5,
		weaponType		         = "Cannon",
		soundHit                 = "nukeartyhit.wav",
		soundStart               = "nukeartyshot.wav",
		
		tolerance                = 2000,
		turret                   = true,
		weaponVelocity           = 800,
		customparams             = {
			damagetype		     = "elacerator",  
			
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
