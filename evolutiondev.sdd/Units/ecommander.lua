-- UNITDEF -- ECOMMANDER --
--------------------------------------------------------------------------------

local unitName = "ecommander"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  acceleration       = 0.2,
  brakeRate          = 0.24,
  buildCostEnergy    = 0,
  buildCostMetal     = 15,
  buildDistance      = 800,
  builder            = true,
  buildTime          = 5,
  commander			 = true,
  capturable		 = false,
  CanAttack			 = true,
  CanAssist          = true,
  CanCapture         = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canreclamate       = "1",
  canstop            = "1",
  category           = "NOTAIR SUPPORT",
  description        = [[Armortype: Heavy
  • Press 'D' to activate EMP Defense]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "emp",
  fireState			 = "0",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "commander",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  levelground        = true,
  maxDamage          = 2500,
  maxSlope           = 180,
  maxVelocity        = 3,
  maxReverseVelocity = 1,
  maxWaterDepth      = 5000,
  metalmake          = 0,
  metalStorage       = 0,
  movementClass      = "COMMANDERTANK4",
  moveState			 = "0",
  name               = "The Overseer",
  noChaseCategories	 = "NOTAIR SUPPORT VTOL AMPHIB",
  objectName         = "ecommander2.s3o",
  radarDistance      = 0,
  selfDestructAs     = "emp",
  showNanoSpray      = "0",
  sightDistance      = 1500,
  smoothAnim         = true,
  stealth            = false,
  turnRate           = 1500,
  unitname           = "ecommander",
  upright            = false,
  workerTime         = 2,
  capturespeed       = 2,
  TerraformSpeed     = 20000,
  ReclaimSpeed       = 1000,
  repairspeed        = 0.05,
  sfxtypes = {
    explosiongenerators = {
      "custom:nanoflame",
      "custom:dirt",
    },
  },
  buildoptions = {
--	"eexperimentalfac",
    "ebasefactory", --new
    "eminifac", --new
    "eamphibfac",
    "eairplant",
	"eexperimentalfac",
    "emetalextractor", --new
    "emaker", --new
    "esolar2", --new
    "egeothermal", --new
    "efusion2", --new
    "estorage", --new
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
  weapons = {
    [1]  = {
      def                = "fusionfx",
	  onlyTargetCategories = " ",
    },
    [2]  = {
      def                = "emp",
	  onlyTargetCategories = " ",
    },
  },
  customParams = {
    needed_cover = 2,
	death_sounds = "soldier",
    cancollect = "1",
	armortype   = "heavyarmor",
	nofriendlyfire	= "1",
	normaltex = "unittextures/lego2skin_explorernormal.png", 
	helptext       = [[The commander has an EMP defense shockwave weapon that can be triggered every 10 seconds. It costs 50 energy, so use it wisely.]],

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
    name               = "Light Laser",
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
      default            = 0,
    },
  },
  emp = {
    AreaOfEffect       = 1000,
    avoidFriendly      = false,
    ballistic          = true,
    collideFriendly    = false,
	commandfire		   = true,
    explosionGenerator = "custom:POWERPLANT_EXPLOSION_BIG",
	energypershot      = 50,
	edgeEffectiveness  = 1,
    impulseFactor      = 0,
    name               = "Emp Blast Weapon",
	paralyzer		   = true,
	paralyzetime	   = 5,
    range              = 50,
    reloadtime         = 10,
    weaponType		   = "Cannon",
    soundStart         = "emp.wav",
    startsmoke         = "1",
    turret             = true,
    weaponVelocity     = 1000,
	customparams = {
	  damagetype		= "medium",
	  nofriendlyfire	= "true",
    },      
    damage = {
      default           = 1000,
    },
  },
}
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
