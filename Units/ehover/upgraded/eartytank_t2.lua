-- UNITDEF -- EARTYTANK_t2 --
--------------------------------------------------------------------------------

local unitName                   = "eartytank_t2"

--------------------------------------------------------------------------------

local buildCostMetal			 = 36
local maxDamage					 = 300 * 1.20

local tech						 = [[tech1]]
local armortype					 = [[light]]
local supply					 = [[8]]

local weapon1Damage              = 200 * 1.20
local weapon1AOE				 = 50
local weapon2Damage              = 20 * 1.20
local weapon2AOE				 = 250

local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                    = {

	--mobileunit 
	transportbyenemy             = false;

	--**


	acceleration                 = 1,
	brakeRate                    = 0.2,
	buildCostEnergy              = 0,
	buildCostMetal               = buildCostMetal,
	builder                      = false,
	buildTime                    = 5,
	canAttack                    = true,
	
	canGuard                     = true,
	canHover                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "LIGHT NOTAIR SUPPORT",
	corpse                       = "ammobox",
	description                  = [[Unit Type: Artillery Support Tank • Uses +]] .. supply .. [[ Supply]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "mediumExplosionGeneric",
	footprintX                   = 3,
	footprintZ                   = 3,
	iconType                     = "arty_lit",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = maxDamage,
	maxVelocity                  = 2.3,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "HOVERTANK3",
	name                         = "ShadowFury Upgraded",  --Because he was the first one to get the "Lobster" pun
	noChaseCategory              = "VTOL",
	objectName                   = "eartytank2.s3o",
	script			             = "eartytank2.cob",
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "mediumExplosionGeneric",
	side                         = "CORE",
	sightDistance                = 1300,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	--  turnInPlace              = false,
	--  turnInPlaceSpeedLimit    = 2.3,
	turnInPlace                  = true,
	turnRate                     = 5000,
	--  turnrate                 = 250,
	unitname                     = "eartytank_t2",
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
			def                  = "Artilleryweapon",
			badTargetCategory    = "VTOL",
		},
		[2]                      = {
			def                  = "SaturationArtilleryweapon",
			badTargetCategory    = "VTOL",
		},
	},
	customParams                 = {
		canbetransported 		 = "true",
		canareaattack            ="1",
		needed_cover             = 3,
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

local weaponDefs                 = {
	Artilleryweapon              = {
		
		accuracy                 = 500,
		AreaOfEffect             = weapon1AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		
		cegTag                   = "artyshot2",
		avoidNeutral	         = false,
		explosionGenerator       = "custom:genericshellexplosion-medium",
		energypershot            = energycosttofire,
		
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		highTrajectory	         = 0,
		name                     = "Plasma Cannon",
		range                    = 1300,
		reloadtime               = 5,
		weaponType		         = "Cannon",
		soundHit                 = "artyhit.wav",
		soundStart               = "arty2.wav",
		
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
		
		accuracy                 = 750,
		AreaOfEffect             = weapon2AOE,
		avoidFriendly            = false,
		avoidFeature             = false,
		collideFriendly          = false,
		collideFeature           = false,
		
		cegTag                   = "artyshot2",
		avoidNeutral	         = false,
		explosionGenerator       = "custom:genericshellexplosion-large",
		energypershot            = weapon2Damage / 10 * ((weapon2AOE / 1000) + 1),
		edgeEffectiveness        = 1,
		
		impulseFactor            = 0,
		interceptedByShieldType  = 4,
		highTrajectory	         = 1,
		name                     = "Plasma Cannon",
		range                    = 1300,
		reloadtime               = 0.5,
		weaponType		         = "Cannon",
		soundHit                 = "artyhit.wav",
		soundStart               = "arty2.wav",
		
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
