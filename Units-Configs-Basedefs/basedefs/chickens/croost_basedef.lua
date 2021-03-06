unitDef                     = {

	activateWhenBuilt             = true,
	acceleration                 = 1,
	brakeRate                    = 0.24,
	buildAngle                    = 2048,
	buildCostEnergy               = 0,
	buildCostMetal                = buildCostMetal,
	buildingMask				  = 0,
	buildDistance                 = 1500,
	builder                       = true,
	buildTime                     = 5,
	buildPic					  = "chicken_unitpics/roost.png",
	capturable		             = false,
	CanAttack			         = false,
	CanAssist			         = true,
	canBeAssisted                = true,
	CanCapture                   = false,
	CanRepair			         = true,
	canRestore					 = false,
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canreclaim		             = false,
	category                      = "BUILDING NOTAIR ECO",
	description                   = [[Generates Metal from Resource Nodes]],
	energyStorage                 = 0,
	energyUse                     = energyUse,
	explodeAs                     = "largeBuildingExplosionGenericRed",
	makesMetal                    = 0,
	footprintX                    = 2,
	footprintZ                    = 2,
	iconType                      = "eco",
	idleAutoHeal                  = .5,
	idleTime                      = 2200,
	maxDamage                     = 1000,
	maxSlope                      = 90,
	maxVelocity                   = 0.001,
	maxReverseVelocity            = 0.001,
	maxWaterDepth                 = 5000,
	metalStorage                  = 0,
	metalMake                     = 0,
	name                          = humanName,
	objectName                    = objectName,
	movementClass                = "HOVERHBOT4",
	pushResistant				  = true,
	script						  = script,
	onoffable                     = false,
	radarDistance                 = 0,
	repairable		              = false,
	selfDestructAs                = "largeBuildingExplosionGenericRed",
	selfDestructCountdown         = 15,
	side                          = "CORE",
	sightDistance                 = 200,
	smoothAnim                    = true,
	unitName                      = unitName,
	workerTime                   = 1,
	capturespeed                 = 0.25,
	TerraformSpeed               = 2147000,
	ReclaimSpeed                 = 0,
	-- 0.03125                   = 1 hp per second
	repairspeed                  = 0.5,
	yardMap                       = "yyyyyyyyy yoooooooy yoooooooy yoooooooy yoooooooy yoooooooy yoooooooy yoooooooy yyyyyyyyy",
	sfxtypes                      = { 
		pieceExplosionGenerators  = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators       = {
			"custom:blacksmoke",
			--primaryCEG,
			--"custom:skyhatelaser",
		},
	},
	buildoptions                 = Shared.buildListChicken,
	sounds                        = {
		underattack               = "other/unitsunderattack1",
		select                    = {
			"other/gdmex",
		},
	},
	weapons                       = {
	},
	customParams                  = {
		--RequireTech				  = tech,
		unittype				  = "building",
		metal_extractor			  = metalMultiplier,
		iseco                     = 1,
		needed_cover              = 3,
		death_sounds              = "generic",
		armortype                 = armortype,
		noenergycost			  = true,
		--normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		--buckettex                 = "unittextures/lego2skin_explorerbucket.dds",
		factionname	              = "chickens",
		--corpse                   = "energycore",
		helptext                  = [[]],
		customgrounddecal		  = true,
	},
	useGroundDecal                = true,
	BuildingGroundDecalType       = "chickengroundplate.dds",
	BuildingGroundDecalSizeX      = 18,
	BuildingGroundDecalSizeY      = 18,
	BuildingGroundDecalDecaySpeed = 0.9,
}