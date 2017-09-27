-- UNITDEF -- EUWTURRET --
--------------------------------------------------------------------------------

local unitName                       = "euwturret"

--------------------------------------------------------------------------------

local armortype						 = [[building]]
local supply						 = [[2]]

local techrequired				     = [[tech1]]

local weapon1Damage		             = 120
local weapon1AOE		             = 10
local energycosttofire				 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local buildCostMetal 			  = 40
local maxDamage					  = buildCostMetal * 12.5

local unitDef                        = {

	buildAngle                       = 2048,
	buildCostEnergy                  = 0,
	buildCostMetal                   = buildCostMetal,
	builder                          = false,
	buildTime                        = 5,
	canAttack                        = true,
	canstop                          = "1",
	category                         = "BUILDING NOTAIR",
	collisionVolumeTest              = "1",
	corpse                           = "ammobox",
	description                      = [[Anti-Amphibious Defense Platform • Uses +]] .. supply .. [[ Supply]],
	energyStorage                    = 0,
	energyUse                        = 0,
	explodeAs                        = "mediumBuildingExplosionGenericGreen",
	floater			                 = true,
	footprintX                       = 4,
	footprintZ                       = 4,
	idleAutoHeal                     = .5,
	idleTime                         = 2200,
	iconType                         = "turret_lit",
	maxDamage                        = maxDamage,
	maxSlope                         = 60,
	minWaterDepth                    = 20,
	metalStorage                     = 0,
	name                             = "Rooter",
	objectName                       = "euwturret.s3o",
	onlytargetcategory2              = "NOTAIR",
	onlytargetcategory3              = "NOTAIR",
	onlytargetcategory4              = "NOTAIR",
	onlytargetcategory5              = "NOTAIR",
	onlytargetcategory6              = "NOTAIR",
	radarDistance                    = 0,
	repairable		                 = false,
	selfDestructAs                   = "mediumBuildingExplosionGenericGreen",
	side                             = "CORE",
	sightDistance                    = 250,
--	SonarDistance                    = 600,
	smoothAnim                       = true,
	unitname                         = "euwturret",
	workerTime                       = 0,
	yardMap                          = "oooo oooo oooo oooo",

	sfxtypes                         = { 
		pieceExplosionGenerators     = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators          = {
			"custom:electricity",
			"custom:needspower",
			"custom:blacksmoke",
		},
	},
	sounds                           = {
		underattack                  = "other/unitsunderattack1",
		select                       = {
			"other/turretselect",
		},
	},
	weapons                          = {
		[1]                          = {
			def                      = "euwturretmissile",
			onlyTargetCategory       = "LIGHT ARMORED",
			--	  MainDir	 		 = [[0 -1 0]],
			--	  MaxAngleDif		 = 180,
		},
	},
	customParams                     = {
		unittype				     = "turret",
		RequireTech				  = techrequired,
		needed_cover                 = 2,
		supply_cost                  = supply,
		death_sounds                 = "generic",
		-- twokhotkey                = 't',
		armortype                    = armortype,
		normaltex                    = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                    = "unittextures/lego2skin_explorerbucket.dds",
		factionname	                 = "outer_colonies",  
		helptext                     = [[Energy cost to fire: ]] .. roundToFirstDecimal(energycosttofire),
	},
	-- buildingGroundDecalDecaySpeed    =30,
	-- buildingGroundDecalSizeX         =6,
	-- buildingGroundDecalSizeY         =6,
	-- useBuildingGroundDecal           = false,
	-- buildingGroundDecalType          =[[elightturret2_aoplane.dds]],
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                     = {
	euwturretmissile                 = {
		AreaOfEffect                 = weapon1AOE,
		avoidFriendly                = false,
		avoidFeature                 = false,
		cegTag                       = "torpedotrailuwturret",
		collideFriendly              = false,
		collideFeature               = false,
		explosionGenerator           = "custom:torpedoexplosion",
		energypershot                = energycosttofire,
		fireStarter                  = 80,
		impulseFactor                = 0.1,
		interceptedByShieldType      = 4,
		model                        = "missilesmall.s3o",
		name                         = "Underwater Torpedo",
		range                        = 600,
		reloadtime                   = 1,
		weaponType		             = "TorpedoLauncher",
		soundHit                     = "weapons/torpedolaunch.wav",
		soundStart                   = "weapons/subhit.wav",
		tolerance                    = 3000,
		turret                       = true,
		startVelocity	             = 200,
		acceleration	             = 2000,
		weaponVelocity               = 10000,
		tracks				         = true,
		turnrate			         = 100000,
		flighttime			         = 8,
		sprayangle			         = 5000,
		waterweapon		             = true,
		
		customparams                 = {
			damagetype		         = "euwturret",  
		},
		damage                       = {
			default                  = weapon1Damage,
		},
	},
}
unitDef.weaponDefs                   = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]        = unitDef })

--------------------------------------------------------------------------------
