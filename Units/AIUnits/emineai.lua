-- UNITDEF -- EMINEAI --
--------------------------------------------------------------------------------

local unitName                    = "emineai"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
local supply					 = [[1]]

local weapon1Damage              = 305
local weapon1AOE				 = 1
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                     = {
	activateWhenBuilt             = true,
	blocking			          = false,
	buildAngle                    = 1024,
	buildCostEnergy               = 0,
	buildCostMetal                = 20,
	builder                       = false,
	buildTime                     = 20,
	category                      = "BUILDING NOTAIR",

	-- Cloaking

	cancloak		              = true,
	cloakCost		              = 0,
	cloakCostMoving	              = 0,
	minCloakDistance              = 0,
	decloakOnFire	              = false,
	decloakSpherical              = true,
	initCloaked		              = true,
	
	-- End Cloaking

	description                   = [[Anti-Tank Land Mine
Armortype: ]] ..armortype.. [[ 

Fires a projectile dealing ]] .. weapon1Damage .. [[ damage

Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire),
	energyMake                    = 0,
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "smallBuildingExplosionGenericWhite",
	footprintX                    = 2,
	footprintZ                    = 2,
	iconType                      = "mine",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	levelground                   = false,
	maxDamage                     = 10,
	maxSlope                      = 60,
	maxWaterDepth                 = 0,
	metalStorage                  = 0,
	name                          = "Land Mine",
	objectName                    = "emine.s3o",
	script			              = "emine.cob",
	onoffable                     = false,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "smallBuildingExplosionGenericWhite",
	selfDestructCountdown         = 0,
	side                          = "CORE",
	sightDistance                 = 400,
	smoothAnim                    = true,
	sonarDistance                 = 0,
	seismicDistance               = 0,
	stealth                       = false,
	unitname                      = "emineai",
	unitrestricted				  = 8,
	workerTime                    = 0,
	yardMap                       = "oo oo",

	sfxtypes                      = {
		pieceExplosionGenerators  = {
			"deathceg3",
			"deathceg4",
		},
		
		explosiongenerators       = {
			"custom:blacksmoke",
		},
	},

	sounds                        = {
		underattack               = "unitsunderattack1",
		select                    = {
			"turretselect",
		},
	},

	weapons                       = {
		[1]                       = {
			def                   = "emineboom",
			onlyTargetCategory    = "LIGHT ARMORED",
			badTargetCategory	  = "DRONE VTOL",
		},
	},

	customParams                  = {
		needed_cover              = 1,
		death_sounds              = "generic",
		nofriendlyfire	          = "1",
		armortype                 = armortype,
		supply_cost               = supply,
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "outer_colonies",  
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 3,
	BuildingGroundDecalSizeY      = 3,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

local weaponDefs                  = {
	emineboom                     = {
		name                      ="Land Mine",
		AreaOfEffect             = weapon1AOE,
		avoidFriendly             = false,
		avoidFeature              = false,
		collideFriendly           = false,
		collideFeature            = false,
		canAttackGround           = false,
		cegTag                   = "missiletrail",
		flightTime               = 5,
		
		tolerance                 = 1000,
		turret                    = true,
		impulseFactor             = 0,
		
		model                    = "missilesmallvlaunch.s3o",
		edgeeffectiveness	      = 1,
		energypershot             = energycosttofire,
		range                     =400,
		reloadtime                =8,
		weaponvelocity            =2500,
		
		
		smokeTrail               = false,
		tracks                   = true,
		turnrate                 = 200000,
		
		weaponAcceleration       = 800,
		weaponTimer              = 0.5,
		weaponType               = "StarburstLauncher",
		weaponVelocity           = 2500,
		soundHit                ="minedetonation.wav",
		soundStart				= "minewhir.wav",
		explosiongenerator        ="custom:genericshellexplosion-large-white",
		customparams              = {
			damagetype		      = "emine",
			nofriendlyfire	      = "true", 
		},  

		damage                    = {
			default               = weapon1Damage,
		},
	},
}
unitDef.weaponDefs                = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
