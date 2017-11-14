-- UNITDEF -- ESHIELDGEN --
--------------------------------------------------------------------------------

local unitName                    = "eshieldgen"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
--local supply					 = [[20]]
--local techprovided				 = [[-baseshield]]
local techrequired				 = [[tech2]]

local weapon1Damage              = 3001
local weapon1AOE				 = 1
--local stockpiletime				 = 60

local shield1Power               = 7000
local shield1PowerRegen          = 50
local shield1PowerRegenEnergy    = shield1PowerRegen / 10

local buildCostMetal 			  = 450
local maxDamage					  = buildCostMetal * 12.5

local unitDef                     = {
	buildAngle                    = 8192,
	buildCostEnergy               = 0,
	buildCostMetal                = buildCostMetal,
	builder                       = false,
	buildTime                     = 5,
	canAttack                     = false,
	canstop                       = "1",
	category                      = "BUILDING NOTAIR",
	description                   = [[Anti-Nuke Defense Facility]],
	energyMake                    = 0,
	energyStorage                 = 0,
	energyUse                     = 0,
	explodeAs                     = "hugeBuildingExplosionGenericGreen",
	footprintX                    = 5,
	footprintZ                    = 5,
	iconType                      = "nukeshield",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = maxDamage,
	maxSlope                      = 30,
	maxWaterDepth                 = 0,
	metalStorage                  = 0,
	name                          = "Protector",
	objectName                    = "eshieldgen.s3o",
	onlytargetcategory2           = "NOTAIR",
	onlytargetcategory3           = "NOTAIR",
	onlytargetcategory4           = "NOTAIR",
	onlytargetcategory5           = "NOTAIR",
	onlytargetcategory6           = "NOTAIR",
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "hugeBuildingExplosionGenericGreen",
	side                          = "ARM",
	sightDistance                 = 600,
	smoothAnim                    = true,
	unitlimit                     = "2",
	unitname                      = unitName,
	workerTime                    = 0,
	yardMap                       = "ooooo ooooo ooooo ooooo ooooo",

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
		underattack               = "other/unitsunderattack1",
		select                    = {
			"other/turretselect",
		},
	},
	weapons                       = {
-- Make sure to change the weapon numbers if the nuke interceptor weapon is ever reinstated
		[1]                       = {
			def                   = "nukeinterceptor",
		},
--		[1]                       = {
--			def                   = "shield",
--		},
	},
	customParams                  = {
		--ProvideTech              = techprovided,
		RequireTech				 = techrequired,
		unittype				  = "shield",
		--supply_cost               = supply,
		needed_cover              = 5,
		death_sounds              = "generic",
		--ProvideTechRange          = "300",
		armortype                 = armortype, 
		normaltex                = "unittextures/eshieldgennormal.png",
		corpse                   = "energycore",
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "factorygroundplate.dds",
	BuildingGroundDecalSizeX      = 7,
	BuildingGroundDecalSizeY      = 7,
	BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------


local weaponDefs                  = {
	nukeinterceptor               = {
		AreaOfEffect              = weapon1AOE,
		avoidFeature              = false,
		avoidFriendly             = false,
		beamTime                  = 5,
		collideFeature            = false,
		collideFriendly           = false,
		coverage			      = 2000,
		rgbColor                  = "0.5 0.5 0",
		rgbColor2                 = "0.5 0.5 0.5",
		coreThickness             = 0.5,
		duration                  = 0.4,
		explosionGenerator        = "custom:genericshellexplosion-large-blue",
		energypershot             = 0,
		fallOffRate               = 0.1,
		fireStarter               = 50,
		interceptor			      = 1,
		interceptSolo		      = false,
		largeBeamLaser            = true,
		laserflaresize 	          = 5,
		
		minintensity              = 1,
		name                      = "Laser",
		range                     = 2000,
		reloadtime                = 170,
		WeaponType                = "BeamLaser",
		soundStart                = "weapons/antinukelaser.wav",
		soundTrigger              = true,
		--stockpile			      = true,
		--stockpiletime		      = stockpiletime,
		texture1                  = "lightning",
		texture2                  = "laserend",
		thickness                 = 20,
		tolerance                 = 500,
		turret                    = true,
		weaponVelocity            = 1500,
		waterweapon		          = true,
		damage                    = {
			default               = weapon1Damage,
		},
	},

	shield                        = {
		
		Smartshield               = true,
		Exteriorshield            = true,
		Visibleshield             = false,
		Visibleshieldrepulse      = false,
		ShieldStartingPower       = 3001,
		Shieldenergyuse           = 0,
		Shieldradius              = 2000,
		Shieldpower               = shield1Power,
		Shieldpowerregen          = shield1PowerRegen,
		Shieldpowerregenenergy    = shield1PowerRegenEnergy,
		Shieldintercepttype       = 4,
		Shieldgoodcolor           = "0.0 0.2 1.0",
		Shieldbadcolor            = "1.0 0 0",
		Shieldalpha               = 0.2,
		
		texture1		          = "shield4",
		
		visibleShieldHitFrames    = 1,
		weaponType                = [[Shield]],
		damage                    = {
			default               = 1,
		},
	},
}
unitDef.weaponDefs                = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
