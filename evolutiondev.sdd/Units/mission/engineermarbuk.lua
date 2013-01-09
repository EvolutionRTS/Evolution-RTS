-- UNITDEF -- EALLTERRENGINEER --
--------------------------------------------------------------------------------

local unitName = "engineermarbuk"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 0.2,
  brakeRate          = 0.24,
  buildCostEnergy    = 0,
  buildCostMetal     = 5,
  buildDistance      = 400,
  builder            = true,
  buildTime          = 5,
  CanAttack			 = false,
  CanAssist          = true,
  CanCapture         = false,
  cancollect         = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canreclamate       = false,
  canstop            = "1",
  category           = "LIGHT NOTAIR SUPPORT",
  corpse             = "ammobox",
  collisionVolumeTest = 1,  
-- Cloaking

	cancloak		 = true,
	cloakCost		 = 2,
	cloakCostMoving	 = 2,
	minCloakDistance = 70,
	decloakOnFire	 = true,
	decloakSpherical = true,
	initCloaked		 = true,
	
-- End Cloaking
  
  description        = "Engineer :: Armortype: Light",
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "CONSTRUCTOR",
  footprintX         = 3,
  footprintZ         = 3,
  iconType           = "engineer",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  levelground        = true,
  maxDamage          = 500,
  maxSlope           = 180,
  maxVelocity        = 3,
  maxReverseVelocity = 1,
  turninplacespeedlimit = 3,
  maxWaterDepth      = 10,
  metalmake          = 0,
  metalStorage       = 0,
  mobilestandorders  = "1",
  movementClass      = "ALLTERRTANK3",
  name               = "Engineer Marbuk",
  objectName         = "eallterrengineer.s3o",
  radarDistance      = 0,
  selfDestructAs     = "CONSTRUCTOR",
  showNanoSpray      = "0",
  sightDistance      = 1000,
--  SonarDistance      = 500;
  smoothAnim         = true,
  stealth            = true,
  seismicSignature   = 3,
  turnInPlace        = true,
  turnRate           = 1020,
  unitname           = "engineermarbuk",
  workerTime         = 2,
  capturespeed       = 1,
  TerraformSpeed     = 100000,
  ReclaimSpeed       = 1000,
  repairspeed        = 0.25,
  sfxtypes = {
    explosiongenerators = {
      "custom:nanoorb",
      "custom:dirtsmall",
    },
	pieceExplosionGenerators = {
		"deathceg0",
		"deathceg1",
	},	
  },
  buildoptions = {
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
	armortype   = "light",
	normaltex = "unittextures/con_legonormal.png", 
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
