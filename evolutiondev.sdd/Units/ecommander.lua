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
  objectName         = "ecommander3.s3o",
  script			 = "ecommander3.cob",
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "emp",
  showPlayerName	 = true,
  showNanoSpray      = false,
  sightDistance      = 500,
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
	"emine",
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
	normaltex = "unittextures/lego2skin_explorernormal.dds", 
	helptext       = [[The Overseer has an EMP defense shockwave weapon that can be triggered every 10 seconds (default "D"). It costs 50 energy, so use it wisely.
	
	You can use this EMP to your advantage and use it offensively as well as defensively. For example, in the early game, you could use your Overseer aggressively in order to stun enemy raiders and get some free kills.]],
  },
}

--------------------------------------------------------------------------------

local weaponDefs        = {
  emp                   = {
    AreaOfEffect        = 500,
    avoidFriendly       = false,
    collideFriendly     = false,
	commandfire		    = true,
    explosionGenerator  = "custom:EMPOVERSEERSHOT",
    tolerance           = 1000,
	energypershot       = 50,
	explosionScar		= false,
    impulseFactor       = 0,
    name                = "Emp Blast Weapon",
	paralyzer		    = true,
	paralyzetime	    = 5,
    range               = 500,
    reloadtime          = 10,
    weaponType		    = "Cannon",
    soundhit            = "emp.wav",
	size				= 0,
    turret              = true,
    weaponVelocity      = 10000,
	onlyforward			= true,
	customparams        = {
	  damagetype		= "default",
	  nofriendlyfire	= 1,
    },      
    damage              = {
      default           = 1000,
    },
  },
}
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
