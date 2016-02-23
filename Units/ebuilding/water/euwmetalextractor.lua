-- UNITDEF -- EUWMETALEXTRACTOR --
--------------------------------------------------------------------------------

local unitName = "euwmetalextractor"

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
	description        = "Extracts Metal",
	energyStorage      = 0,
	energyUse          = 0,
	explodeAs          = "SMALL_BUILDING",
	extractsMetal      = 0.0000001,
	makesMetal         = 0,
	footprintX         = 6,
	footprintZ         = 6,
	iconType           = "eco",
	idleAutoHeal       = .5,
	idleTime           = 2200,
	maxDamage          = 1000,
	maxSlope           = 60,
	minWaterDepth      = 20,
	maxWaterDepth      = 10000,
	metalStorage       = 0,
	metalMake          = 0,
	name               = "Underwater Metal Extractor",
	objectName         = "euwmetalextractor.s3o",
	onoffable          = true,
	radarDistance      = 0,
	repairable		 = false,
	selfDestructAs     = "SMALL_BUILDING",
	selfDestructCountdown = 1,
	side               = "CORE",
	sightDistance      = 367,
	smoothAnim         = true,
	unitname           = "euwmetalextractor",
	workerTime         = 0,
	yardMap            = "oooooo oooooo oooooo oooooo oooooo oooooo",
	sfxtypes = {
		pieceExplosionGenerators = {
			"deathceg3",
			"deathceg4",
		},

		explosiongenerators = {
			"custom:bubbles",
		},
	},
	sounds = {
		underattack        = "unitsunderattack1",
		select = {
			"gdmex",
		},
	},
	weapons = {
		[1]  = {
			def                = "fusionfx",
		},
	},
	customParams = {
		iseco = 1,
		death_sounds = "generic",
		armortype   = "BUILDING",
		normalstex = "unittextures/lego2skin_explorernormal.dds", 
		buckettex = "unittextures/lego2skin_explorerbucket.dds",
		factionname	= "outer_colonies",  
	},
	useBuildingGroundDecal = true,
	BuildingGroundDecalType = "factorygroundplate.dds",
	BuildingGroundDecalSizeX = 8,
	BuildingGroundDecalSizeY = 8,
	BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------

local weaponDefs = {
	fusionfx = {

		AreaOfEffect       = 5,
		avoidFeature       = false,
		avoidFriendly      = false,
		beamTime           = 0.1,
		
		collideFeature     = false,
		collideFriendly    = false,
		rgbColor           = "0 0 1",
		rgbColor2          = "0.5 0.5 0.5",
		coreThickness      = 0.3,
		craterBoost        = 0,
		craterMult         = 0,
		explosionGenerator = "custom:bubbles",
		fallOffRate        = 0.5,
		minintensity       = 1,
		impulseFactor      = 0,
		largeBeamLaser     = true,
		
		name               = "fake",
		noSelfDamage       = true,
		range              = 650,
		reloadtime         = 0.1,
		WeaponType         = "BeamLaser",
		
		soundTrigger       = true,
		startVelocity      = 1500,
		targetMoveError    = 0.3,
		thickness          = 1,
		turret             = true,
		weaponVelocity     = 1500,
		damage = {
			default            = 1E-06,
		},
	},
}
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
