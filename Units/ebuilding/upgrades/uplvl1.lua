-- UNITDEF -- EUWSOLAR2 --
--------------------------------------------------------------------------------

local unitName = "uplvl1"

--------------------------------------------------------------------------------

local unitDef = {
	activateWhenBuilt  = true,
	buildAngle         = 2048,
	buildCostEnergy    = 0,
	buildCostMetal     = 20,
	builder            = false,
	buildTime          = 5,
	category           = "BUILDING NOTAIR ECO",
	corpse             = "ammobox",
	damageModifier     = 0.33333,
	description        = [[]],
	energyMake         = 0,
	energyStorage      = 0,
	energyUse          = 0,
	explodeAs          = "SMALL_BUILDING",
	footprintX         = 4,
	footprintZ         = 4,
	icontype           = "energy",
	idleAutoHeal       = .5,
	idleTime           = 2200,
	maxDamage          = 800,
	maxSlope           = 60,
	maxWaterDepth      = 0,
	metalStorage       = 0,
	name               = "Upgrade Level 1",
	objectName         = "esolar2.s3o",
	script			 = "euwsolar2.cob",
	onoffable          = false,
	radarDistance      = 0,
	repairable		 = false,
	selfDestructAs     = "SMALL_BUILDING",
	side               = "CORE",
	sightDistance      = 367,
	smoothAnim         = true,
	unitname           = "uplvl1",
	yardMap            = "oooo oooo oooo oooo",

	sfxtypes = {
		pieceExplosionGenerators = {
			"deathceg0",
			"deathceg1",
		},

		explosiongenerators = {
			"custom:bubbles",
		},
	},
	sounds = {
		underattack        = "unitsunderattack1",
		select = {
			"gdenergy",
		},
	},
	weapons = {
	},
	customParams = {
		iseco = 1,
		death_sounds = "generic",
		armortype   = "BUILDING",
		normalstex = "unittextures/esolar2normal.png", 
		upgradeTech = "groundweapons",
		upgradeLevel = "1.15",
	},
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
