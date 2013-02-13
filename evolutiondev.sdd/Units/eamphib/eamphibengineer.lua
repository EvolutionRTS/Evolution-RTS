-- UNITDEF -- EAMPHIBENGINEER --
--------------------------------------------------------------------------------

local unitName = "eamphibengineer"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.24,
  buildCostEnergy    = 0,
  buildCostMetal     = 50,
  buildDistance      = 800,
  builder            = true,
  buildTime          = 5,
  CanAttack			 = false,
  CanAssist			 = true,
  canBeAssisted      = true,
  CanCapture         = false,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canreclamate       = "1",
  canstop            = "1",
  category           = "LIGHT AMPHIB SUPPORT",
  description        = [[Engineer
Light]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "CONSTRUCTOR",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "engineer",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  levelground        = true,
  maxDamage          = 600,
  maxSlope           = 28,
  maxVelocity        = 4,
  maxReverseVelocity = 1,
  maxWaterDepth      = 5000,
  metalmake          = 0,
  metalStorage       = 0,
  movementClass      = "TANK4",
  moveState			 = "2",
  name               = "The D(e)veloper",
  objectName         = "eamphibengineer.s3o",
  radarDistance      = 0,
  radarDistanceJam   = 20,
  repairable		 = false,
 selfDestructAs     = "CONSTRUCTOR",
  showNanoSpray      = "0",
  side               = "ARM",
  sightDistance      = 500,
  SonarDistance      = 500,
  smoothAnim         = true,
  stealth            = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 4,
  turnRate           = 1000,
--  turnrate           = 1020,
  unitname           = "eamphibengineer",
  workerTime         = 1,
  capturespeed       = 1,
  TerraformSpeed     = 100000,
  ReclaimSpeed       = 1000,
  repairspeed        = 0.15625,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:nanoorb",
      "custom:dirt",
	  "custom:blacksmoke",
    },
  },
  buildoptions = {
    "eminifac", --new
    "ebasefactory", --new
    "eamphibfac",
    "eairplant",
	"eexperimentalfac",
    "emetalextractor", --new
    "euwmetalextractor", --new
    "emaker", --new
    "esolar2", --new
    "euwsolar2", --new
    "egeothermal", --new
    "efusion2", --new
    "euwfusion2", --new
    "estorage", --new
    "euwstorage", --new
    "eradar2", --new
    "ejammer2", --new
    "ebarricade",
    "elightturret2", --new
    "eheavyturret2", --new
    "eaaturret",
    "elrpc",
    "eshieldgen",
    "esilo"
  },
  sounds = {
    underattack        = "unitsunderattack1",
    ok = {
      "ack",
    },
    select = {
      "unitselect",
    },
  },
  customParams = {
    needed_cover = 1,
  	death_sounds = "soldier",
	twokhotkey = 'e',
    dronespawner = "1",
	armortype   = "light",
	normaltex = "unittextures/eamphibengineernormal.png", 
  },
  weapons = {
    [1]  = {
      def                = "fusionfx",
    },
  },
}

--------------------------------------------------------------------------------

local weaponDefs = {
  fusionfx = {

    AreaOfEffect       = 5,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.1,
    craterBoost        = 0,
    craterMult         = 0,
    explosionGenerator = "custom:empty",
    fallOffRate        = 0.5,
    minintensity       = 1,
    impulseFactor      = 0,
    largeBeamLaser     = true,
    lineOfSight        = true,
    name               = "fake",
    noSelfDamage       = true,
    range              = 800,
    reloadtime         = 0.1,
    WeaponType         = "BeamLaser",
    rgbColor           = "0 0 0.5",
    rgbColor2          = "0.2 0.2 0.2",
    selfprop           = true,
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
