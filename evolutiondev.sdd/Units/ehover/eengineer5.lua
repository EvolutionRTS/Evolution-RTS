-- UNITDEF -- EENGINEER5 --
--------------------------------------------------------------------------------

local unitName = "eengineer5"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.24,
  buildCostEnergy    = 0,
  buildCostMetal     = 15,
  buildDistance      = 800,
  builder            = true,
  buildTime          = 5,
  CanAttack			 = false,
  CanAssist          = true,
  CanCapture         = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canreclamate       = "1",
  canstop            = "1",
  category           = "NOTAIR SUPPORT",
  description        = [[Engineer 
  •Armortype: Light]],
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
  maxDamage          = 300,
  maxSlope           = 26,
  maxVelocity        = 3,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalmake          = 0,
  metalStorage       = 0,
  movementClass      = "HOVERTANK4",
  name               = "The (E)rector",
  objectName         = "eengineer5.s3o",
  radarDistance      = 0,
  selfDestructAs     = "CONSTRUCTOR",
  showNanoSpray      = "0",
  side               = "ARM",
  sightDistance      = 500,
  smoothAnim         = true,
  stealth            = false,
  --  turnInPlace        = false,
  turnRate           = 1000,
--  turnrate           = 1020,
  unitname           = "eengineer5",
  upright            = true,
  workerTime         = 2,
  capturespeed       = 1,
  TerraformSpeed     = 20000,
  ReclaimSpeed       = 1000,
  repairspeed        = 0.05,
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
  buildoptions = {
    "eminifac", --new
    "ebasefactory", --new
    "eamphibfac",
    "eairplant",
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
    },
  },
  customParams = {
    needed_cover = 1,
  	death_sounds = "soldier",
	twokhotkey = 'e',
    dronespawner = "1",
	armortype   = "lightarmor",
	normaltex = "unittextures/con_legonormal.png", 
	helptext = [[The Erector can build new structures, reclaim features, turn energy cores into gunship drones, and capture enemy units. Upon it's death, it emits a wave of nanoparticles that will repair 100 hitpoints to any units in proximity]],
	
	ring1radius = "800", --How large of a radius the ring will cover.
		
		ring1color = "1,0.5,0,0.8", --R,G,B,A on a scale from 0 - 1. A is the opacity with 1 being fully opaque to 0 being fully transparent. Easy and quick color picker here: http://www.dematte.at/colorPicker/  Take 255 divided by the color value you want, and that is it's value on a scale from 0 - 1. 
		
		ring1thickness = "2", --1 is basically 1 pixel thick. It will scale as you zoom in and out. Maximum value seems to be 32.
		
		ring1showselected = "1", --boolean (I.e. 1 = True, 0 = False) If True, ring only shows when the unit is selected, if False, show all the time.
		
		ring1sides = "32", -- Number of sides the ring has. 32 sides means a perfectly smooth ring. Setting to 3 will result in triangle, 4 a diamond, 5 a pentagon, etc (2 or less will not display at all).
	
	ring2radius = "500", --How large of a radius the ring will cover.
		
		ring2color = "0.5,0,1,0.2", --R,G,B,A on a scale from 0 - 1. A is the opacity with 1 being fully opaque to 0 being fully transparent. Easy and quick color picker here: http://www.dematte.at/colorPicker/  Take 255 divided by the color value you want, and that is it's value on a scale from 0 - 1. 
		
		ring2thickness = "5", --1 is basically 1 pixel thick. It will scale as you zoom in and out. Maximum value seems to be 32.
		
		ring2showselected = "0", --boolean (I.e. 1 = True, 0 = False) If True, ring only shows when the unit is selected, if False, show all the time.
		
		ring2sides = "32", -- Number of sides the ring has. 32 sides means a perfectly smooth ring. Setting to 3 will result in triangle, 4 a diamond, 5 a pentagon, etc (2 or less will not display at all).
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
    range              = 400,
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
}
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
