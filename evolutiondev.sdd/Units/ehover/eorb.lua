-- UNITDEF -- EORB --
--------------------------------------------------------------------------------

local unitName = "eorb"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.24,
  buildCostEnergy    = 0,
  buildCostMetal     = 50,
  buildDistance      = 800,
  builder            = true,
  buildTime          = 10,
  CanAttack			 = false,
  CanAssist			 = false,
  CanCapture         = false,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canreclamate       = "1",
  canstop            = "1",
  category           = "NOTAIR SUPPORT",
  description        = [[Field Medic
  Armortype: Light
   • Automatically repairs mobile units in the area]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "CONSTRUCTOR",
  footprintX         = 4,
  footprintZ         = 4,
  fireState			 = "0",
  iconType           = "orb",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  levelground        = true,
  maxDamage          = 300,
  maxSlope           = 26,
  maxVelocity        = 3,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalmake          = 0,
  metalStorage       = 0,
  movementClass      = "HOVERTANK4",
  moveState			 = "0",
  name               = "(O)RB",
  objectName         = "eorb.s3o",
  radarDistance      = 0,
  --radarDistanceJam   = 20,
  selfDestructAs     = "CONSTRUCTOR",
  showNanoSpray      = "0",
  side               = "ARM",
  sightDistance      = 800,
  smoothAnim         = true,
  stealth            = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 3,
  turnRate           = 1000,
--  turnrate           = 1020,
  unitname           = "eorb",
  upright            = true,
  workerTime         = 2,
  capturespeed       = 0,
  TerraformSpeed     = 5000,
  ReclaimSpeed       = 1000,
  repairspeed        = 0.10,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:nanoflame",
      "custom:dirt",
	  "custom:blacksmoke",
    },
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
    needed_cover = 2,
  	death_sounds = "soldier",
	twokhotkey = 'o',
    cancollect = "1",
	armortype   = "lightarmor",
	normaltex = "unittextures/eorbnormal.png", 
	helptext	= [[The ORB is a field medic designed to quickly repair damaged units. It has an Area Repair ability that will repair 10 hitpoints every second to any damaged unit (including allied units) in range. Unit must be out of combat for 5 seconds before repairs can take place.]],
	
	-- groundtexselectimg = ":nc:bitmaps/icons/repairzone.png",
    -- groundtexselectxsize = 1000, 
    -- groundtexselectzsize = 1000, 	
  },
  weapons = {
    [1]  = {
      def                = "fusionfx",
    },
--[[	[2]  = {
      def                = "aoeheal",
	  onlyTargetCategories = " ",
    }, ]]--
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
      default            = -1,
    },
  },
  
  aoeheal = {
    AreaOfEffect       = 1000,
    avoidFriendly      = false,
    ballistic          = true,
    collideFriendly    = false,
	commandfire		   = true,
    explosionGenerator = "custom:AREAHEALING",
	energypershot      = 50,
	edgeEffectiveness  = 1,
    impulseFactor      = 0,
    name               = "Area Healing Device",
    range              = 50,
    reloadtime         = 10,
    weaponType		   = "Cannon",
    soundStart         = "areaheal.wav",
    startsmoke         = "1",
    turret             = true,
    weaponVelocity     = 1000,
	customparams = {
	  damagetype		= "medium",
	  noenemyfire		= "1",
    },      
    damage = {
      default           = -250,
    },
  },
}
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
