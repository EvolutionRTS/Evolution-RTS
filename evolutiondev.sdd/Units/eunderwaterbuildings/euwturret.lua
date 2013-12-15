-- UNITDEF -- EUWTURRET --
--------------------------------------------------------------------------------

local unitName = "euwturret"

--------------------------------------------------------------------------------

local unitDef = {

  buildAngle         = 2048,
  buildCostEnergy    = 0,
  buildCostMetal     = 40,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  canstop            = "1",
  category           = "BUILDING NOTAIR",
  collisionVolumeTest = "1",
  corpse             = "ammobox",
  description        = [[Anti-Amphibious Defense Platform
  Building
  120 Damage vs Light/Armored
  12 Damage vs Building
  ]],
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "MEDIUM_BUILDING",
  floater			 = true,
  footprintX         = 4,
  footprintZ         = 4,
  idleAutoHeal       = .5,
  idleTime           = 2200,
  iconType           = "defense",
  maxDamage          = 250,
  maxSlope           = 60,
  minWaterDepth      = 20,
  metalStorage       = 0,
  name               = "Rooter",
  objectName         = "euwturret.s3o",
  onlytargetcategory2 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "MEDIUM_BUILDING",
  side               = "CORE",
  sightDistance      = 250,
  SonarDistance      = 500,
  smoothAnim         = true,
  unitname           = "euwturret",
  workerTime         = 0,
  yardMap            = "oooo oooo oooo oooo",

  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:electricity",
      "custom:needspower",
	  "custom:blacksmoke",
    },
  },
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "turretselect",
    },
  },
  weapons = {
    [1]  = {
      def                = "euwturretmissile",
      onlyTargetCategory = "LIGHT ARMORED",
--	  MainDir	 		 = [[0 -1 0]],
--	  MaxAngleDif		 = 180,
    },
  },
  customParams = {
    needed_cover = 2,
	death_sounds = "generic",
	-- twokhotkey = 't',
	armortype   = "building",
	normaltex = "unittextures/lego2skin_explorernormal.png", 
	helptext = [[]],
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=6,
	buildingGroundDecalSizeY=6,
	useBuildingGroundDecal = false,
	buildingGroundDecalType=[[elightturret2_aoplane.dds]],
}


--------------------------------------------------------------------------------

local weaponDefs = {
  euwturretmissile = {
    AreaOfEffect       = 10,
    avoidFriendly      = false,
    avoidFeature       = false,
	cegTag             = "torpedotrailuwturret",
    collideFriendly    = false,
    collideFeature     = false,
    explosionGenerator = "custom:torpedoexplosion",
	energypershot      = 12,
    fireStarter        = 80,
    impulseFactor      = 0.1,
	interceptedByShieldType = 4,
	model              = "missilesmall.s3o",
    name               = "Underwater Torpedo",
    pitchtolerance     = 3000,
    range              = 500,
    reloadtime         = 1,
    weaponType		   = "TorpedoLauncher",
    soundHit           = "torpedolaunch.wav",
    soundStart         = "subhit.wav",
    tolerance          = 3000,
    turret             = true,
	startVelocity	   = 200,
	acceleration	   = 2000,
    weaponVelocity     = 10000,
	tracks				= true,
	turnrate			= 100000,
	flighttime			= 4,
	sprayangle			= 5000,
	waterweapon		   = true,
	
	customparams = {
	  damagetype		= "euwturret",  
    },
    damage = {
      default            = 120,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
