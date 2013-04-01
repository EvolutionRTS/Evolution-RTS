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
  description        = [[Anti-Amphibious Defense Platform]],
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
  sightDistance      = 750,
  SonarDistance      = 750,
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
      def                = "euwturretlaser",
      onlyTargetCategory = "AMPHIB",
	  MainDir	 		 = [[0 -1 0]],
	  MaxAngleDif		 = 180,
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
  euwturretlaser = {
	badTargetCategory = [[BUILDING]],
	TargetMoveError	   = 0.3,
    AreaOfEffect       = 0,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.2,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.5,
	cylinderTargeting	= 128,
    duration           = 0.2,
    energypershot      = 1.9,
    explosionGenerator = "custom:burn",
    fallOffRate        = 1,
    fireStarter        = 50,
    interceptedByShieldType = 4,
	impulsefactor		= 0.1,
    lineOfSight        = true,
	largebeamlaser	   = true,
	laserflaresize 	   = 5,
	leadlimit			= 20,
    minintensity       = 1,
    name               = "Laser",
    range              = 750,
    reloadtime         = 0.2,
    WeaponType         = "BeamLaser",
    rgbColor           = "0 0 0.5",
    rgbColor2          = "0.8 0.8 0.8",
    soundTrigger       = true,
    soundstart         = "amphibmedtankshothit.wav",
--	soundHit		   = "amphibmedtankshothit.wav",
	scrollspeed		   = 5,
    texture1           = "lightning",
    texture2           = "laserend",
    thickness          = 4,
    tolerance          = 3000,
    turret             = true,
    weaponVelocity     = 1000,
	waterweapon		   = true,
	customparams = {
	  damagetype		= "tankdestroyer",  
    }, 
    damage = {
      default           = 19.2, -- multiply * 1.2 for correct dps output
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
