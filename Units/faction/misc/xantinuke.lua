-- UNITDEF -- ESHIELDGEN --
--------------------------------------------------------------------------------

local unitName                    = "xantinuke"

--------------------------------------------------------------------------------

local armortype					 = [[building]]
--local supply					 = [[20]]
--local techprovided				 = [[-baseshield]]
local techrequired				 = [[tech2]]

local weapon1Damage              = 3001
local weapon1AOE				 = 1
--local stockpiletime				 = 60

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
	name                          = "Anti-Nuke",
	objectName                    = "faction/xantinuke.s3o",
	script						  = "faction/xantinuke.cob",
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
		[1]                       = {
			def                   = "nukeinterceptor",
		},
	},
	customParams                  = {
		--ProvideTech              = techprovided,
		RequireTech				 = techrequired,
		unittype				  = "building",
		--supply_cost               = supply,
		needed_cover              = 5,
		death_sounds              = "generic",
		--ProvideTechRange          = "300",
		armortype                 = armortype, 
		normaltex                = "unittextures/afaction_normals.dds", 
		corpse                   = "energycore",
		factionname	             = "ateran",
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
		customparams             = {
			nofriendlyfire	     = 1,
			nocosttofire		 = true,
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
