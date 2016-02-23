-- UNITDEF -- ECRUISESILOAI --
--------------------------------------------------------------------------------

local unitName                    = "ecruisesiloai"

--------------------------------------------------------------------------------

local armortype					 = [[building]]

local weapon1Damage              = 1250
local weapon1AOE				 = 250
local energycosttofire			 = weapon1Damage / 10 * ((weapon1AOE / 1000) + 1)
local reloadtime				 = 35

local function roundToFirstDecimal(energycosttofire)
    return math.floor(energycosttofire*10 + 0.5)*0.1
end

local unitDef                     = {

	activateWhenBuilt             = true,
	buildCostEnergy               = 0,
	buildCostMetal                = 500,
	builder                       = false,
	buildTime                     = 5,
	canAttack                     = true,
	canstop                       = "1",
	category                      = "BUILDING NOTAIR",

	corpse                        = "ammobox",
	description                   = [[Long Range Tactical Cruise Missile
Armortype: ]] ..armortype.. [[ 

]] .. weapon1Damage .. [[ Damage vs Light/Armored/Buildings in a small area

Energy cost to fire missiles: ]] .. roundToFirstDecimal(energycosttofire) .. [[/s]],
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "cruisemissile",
	floater						  = true,
	footprintX                    = 10,
	footprintZ                    = 10,
	iconType                      = "elrpc",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = 1500,
	maxSlope                      = 30,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	name                          = "Executioner",
	noChaseCategory               = "VTOL",
	objectName                    = "ecruisesilo.s3o",
	script						  = "ecruisesilo.cob",
	onlytargetcategory2           = "NOTAIR",
	onlytargetcategory3           = "NOTAIR",
	onlytargetcategory4           = "NOTAIR",
	onlytargetcategory5           = "NOTAIR",
	onlytargetcategory6           = "NOTAIR",
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "cruisemissile",
	side                          = "ARM",
	sightDistance                 = 900,
	smoothAnim                    = true,
	unitname                      = "ecruisesiloai",
	unitrestricted				  = 1,
	workerTime                    = 0,
	yardMap                       = "oooooooooo oooooooooo oooooooooo oooooooooo oooooooooo oooooooooo oooooooooo oooooooooo oooooooooo oooooooooo ",
	sfxtypes                      = { 
		pieceExplosionGenerators  = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators       = {
			"custom:blacksmoke",
			"custom:steam",
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
			def                   = "cruisemissile",
			badTargetCategory     = "LIGHT ARMORED",
		},
	},
	customParams                  = {
		death_sounds              = "generic",
		armortype                 = armortype,
		normalstex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                 = "unittextures/lego2skin_explorerbucket.dds", 
		helptext                  = [[]],
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 12,
	BuildingGroundDecalSizeY      = 12,
	BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------
-- Energy Per Shot Calculation is: dmg / 20 * ((aoe / 1000) + 1)

local weaponDefs                  = {
	cruisemissile                   = {
		AreaOfEffect              = weapon1AOE,
		avoidFriendly             = false,
		avoidFeature              = false,
		cegTag                    = "cruisemissiletrail",
		collideFriendly           = false,
		collideFeature            = false,
		craterBoost               = 0,
		craterMult                = 0,
		edgeeffectiveness		  = 0.1,
		energypershot             = energycosttofire,
		explosionGenerator        = "custom:ebombexpl",
		fireStarter               = 100,
		flightTime                = 400,
		impulseBoost              = 0,
		impulseFactor             = 0,
		interceptedByShieldType   = 4,
		
		metalpershot              = 0,
		model                     = "ecruisemissile.s3o",
		name                      = "Cruise Missile",
		range                     = 6000,
		reloadtime                = reloadtime,
		weaponType		          = "MissileLauncher",
		
		
		smokeTrail                = false,
		soundHit                  = "explode4.wav",
		soundStart                = "cruisemissilelaunch.wav",
		
		startVelocity             = 10,
		turnRate                  = 6000,
		tracks					  = true,
		
		weaponAcceleration        = 60,
		weaponTimer               = 5,
		weaponType                = "StarburstLauncher",
		weaponVelocity            = 1000,
		customparams              = {
			damagetype		      = "default",  
			death_sounds 		  = "nuke",
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
