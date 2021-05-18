unitDef                     = {
	activateWhenBuilt             = true,
	buildAngle                    = 8196,
	buildCostEnergy               = 0,
	buildCostMetal                = 25,
	builder                       = false,
	buildTime                     = 5,
	canAttack			          = false,
	category                      = "BUILDING NOTAIR ECO",
	description                   = [[Provides +]] .. supplygranted .. [[ Supply • Provides +]] .. storage .. [[ Metal/Energy Storage]],
	energyStorage                 = storage,
	metalStorage                  = storage,
	energyUse                     = 0,
	explodeAs                     = "BUG_DEATH_MEDIUM",
	footprintX                    = 4,
	footprintZ                    = 4,
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	icontype                      = "storage",
	maxDamage                     = 500,
	maxSlope                      = 90,
	maxWaterDepth                 = 99999999999,
	name                          = humanName,
	objectName                    = objectName,
	script			              = script,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "BUG_DEATH_MEDIUM",
	side                          = "CORE",
	sightDistance                 = 250,
	smoothAnim                    = true,
	unitname                      = unitName,
	workerTime                    = 0,
	yardMap                       = [[oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo]],

	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"blood_spray", 
		}, 

		explosiongenerators      = {
			"custom:blood_spray",
		},
	},

	sounds                        = {
		underattack               = "other/unitsunderattack1",
		select                    = {
			BugSelect,
		},
	},
	weapons                       = {
	},
	customParams                  = {
		unittype				  = "building",
		iseco                     = 1,
		needed_cover              = 2,
		supply_granted            = supplygranted,
		death_sounds              = "bug",
		armortype                 = "building", 
		noenergycost			  = true,
		normaltex                = "unittextures/ztiberium_normals.dds", 
		factionname	              = "zaal",
		corpse                   = "energycore",
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "zgroundtexture.dds",
	BuildingGroundDecalSizeX      = 8,
	BuildingGroundDecalSizeY      = 8,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]     = unitDef })

--------------------------------------------------------------------------------
