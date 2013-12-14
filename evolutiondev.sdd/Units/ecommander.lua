-- UNITDEF -- ECOMMANDER --
--------------------------------------------------------------------------------

local unitName = "ecommander"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 0.2,
  brakeRate          = 1,
  buildCostEnergy    = 0,
  buildCostMetal     = 500,
  buildDistance      = 1000,
  builder            = true,
  buildTime          = 2.5,
  commander			 = true,
  capturable		 = false,
  CanAttack			 = true,
  CanAssist			 = true,
  canBeAssisted      = true,
  CanCapture         = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canreclamate       = "1",
  canstop            = "1",
  category           = "NOTAIR SUPPORT LIGHT",
  description        = [[Armored
  
  • Armed with a small emp weapon capable of disabling light units for a short period of time (Must be manually fired!)
  
  There can only be one!]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "emp",
  fireState			 = "0",
  footprintX         = 4,
  footprintZ         = 4,
  hideDamage		 = true,
  iconType           = "commander",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  levelground        = true,
  maxDamage          = 5000,
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
  repairable		 = false,
  selfDestructAs     = "emp",
  showPlayerName	 = true,
  showNanoSpray      = false,
  sightDistance      = 1500,
  smoothAnim         = true,
  stealth            = false,
  turnRate           = 1000,
  unitname           = "ecommander",
  unitRestricted	 = 1,
  upright            = false,
  workerTime         = 1,
  capturespeed       = 0.25,
  TerraformSpeed     = 100000,
  ReclaimSpeed       = 1000,
  -- 0.03125 = 1 hp per second
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
    "ekmar",
    "elightturret2", --new
    "eheavyturret2", --new
    "eaaturret",
	"euwturret",
    "elrpc",
    "eshieldgen",
    "esilo",
	"eorb",
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
      def                = "emp",
	  onlyTargetCategories = " ",
    },
  },
  customParams = {
	iscommander = true,
    needed_cover = 2,
	death_sounds = "soldier",
    cancollect = "1",
	armortype   = "light",
	nofriendlyfire	= "1",
	RequireTech = "20 Power",
	normaltex = "unittextures/lego2skin_explorernormal.png", 
	helptext       = [[The Overseer has an EMP defense shockwave weapon that can be triggered every 10 seconds (default "D"). It costs 50 energy, so use it wisely.
	
	You can use this EMP to your advantage and use it offensively as well as defensively. For example, in the early game, you could use your Overseer aggressively in order to stun enemy raiders and get some free kills.]],
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
    range              = 1000,
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
  emp = {
    AreaOfEffect       = 500,
    avoidFriendly      = false,
    collideFriendly    = false,
	commandfire		   = true,
    explosionGenerator = "custom:EMPOVERSEERSHOT",
	coreThickness      = 0,
	cylinderTargeting  = 1,
    duration           = 1,
	rgbColor           = "0 0 0",
    rgbColor2          = "0 0 0",
    thickness          = 0,
    tolerance          = 1000,
	energypershot      = 50,
	edgeEffectiveness  = 1,
	explosionScar		= false,
    impulseFactor      = 0,
    name               = "Emp Blast Weapon",
	paralyzer		   = true,
	paralyzetime	   = 5,
    range              = 500,
    reloadtime         = 10,
    weaponType		   = "LaserCannon",
    soundhit         = "emp.wav",
    turret             = true,
    weaponVelocity     = 5000,
	customparams = {
	  damagetype		= "medium",
	  nofriendlyfire	= 1,
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
