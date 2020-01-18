unitDef                    = {

	buildCostEnergy              = 0,
	buildCostMetal               = buildCostMetal,
	buildDistance                = 0,
	builder                      = false,
	buildTime                    = 5,
	buildpic					 = "zaal_unitpics/zespire1.png",
	blocking					 = true,
	cantBeTransported			 = true,
	canMove                      = false,
	category                     = "BUILDING",
	description                  = [[Creates Energy]],
	energyMake                   = energyMake,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = "BUG_DEATH_MEDIUM",
	floater			              = false,
	footprintX                   = 8,
	footprintZ                   = 8,
	icontype                      = "generator",
	idleAutoHeal                  = 5,
	idleTime                      = 300,
	levelground                  = true,
	maxDamage                    = 500,
	maxSlope                     = 90,
	maxWaterDepth                 = 99999999999,
	metalmake                    = 0,
	metalStorage                 = 0,
	name                         = humanName,
	objectName                   = objectName,
	script			             = script,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = "BUG_DEATH_MEDIUM",
	sightDistance                = 250,
	smoothAnim                   = true,
	stealth			             = false,
	unitname                     = unitName,
	upright                      = true,
	yardmap 					 = "oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo",
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"blood_spray", 
		}, 

		explosiongenerators      = {
			"custom:blood_spray",
		},
	},
	customParams                 = {
		unittype				 = "building",
		needed_cover             = 1,
		death_sounds             = "bug",
		armortype                = armortype,
		normaltex               = "unittextures/zespire1_normals.dds", 
		factionname	             = "zaal",  
		supply_granted            = supplygranted,
		RequireTech              = tech,
		noenergycost			  = true,
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "zgroundtexture.dds",
	BuildingGroundDecalSizeX      = 14,
	BuildingGroundDecalSizeY      = 14,
	BuildingGroundDecalDecaySpeed = 0.9,
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
