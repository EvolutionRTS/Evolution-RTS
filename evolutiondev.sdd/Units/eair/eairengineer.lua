-- UNITDEF -- EAIRENGINEER --
--------------------------------------------------------------------------------

local unitName = "eairengineer"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "missiletrailsmall",
  pieceTrailCEGRange = 1,
--End tags entered from Notepad++
  acceleration       = 0.2,
  airStrafe          = true,
  bankscale          = "1",
  brakeRate          = 7,
  buildCostEnergy    = 0,
  buildCostMetal     = 45,
  buildTime          = 10,
  builder            = true,
  buildDistance      = 400,
  canAttack          = false,
  CanAssist          = true,
  CanCapture         = true,
  cancollect         = "1",
  canDropFlare       = true,
  canFly             = true,
  canGuard           = true,
  canLoopbackAttack  = true,
  canMove            = true,
  canPatrol          = true,
  canreclamate       = "1",
  canstop            = "1",
  category           = "VTOL",
  collide            = true,
  collisionSphereScale = 1,
  corpse             = "ammobox",
  cruiseAlt          = 300,
  description        = "Airborne Engineer :: Armortype: Light",
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  flareDelay         = 0.1,
  flareDropVector    = "0 0 -1",
  flareefficieny     = "0.3",
  flareReload        = 3,
  floater            = true,
  footprintX         = 4,
  footprintZ         = 4,
  hoverAttack        = true,
  iconType           = "engineer",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 140,
  maxSlope           = 10,
  maxVelocity        = 14,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  moverate1          = "8",
  name               = "Th(e) Originator",
  objectName         = "eairengineer.s3o",
  radarDistance      = 0,
  selfDestructAs     = "BIG_UNIT",
  showNanoSpray      = "0",
  sightDistance      = 800,
  smoothAnim         = true,
  turnRate           = 920,
  unitname           = "eairengineer",
  unitnumber         = "148",
  workerTime         = 2,
  capturespeed       = 1,
  TerraformSpeed     = 5000,
  ReclaimSpeed       = 1000,
  repairspeed        = 0.05,
  sfxtypes = {
    explosiongenerators = {
      "custom:jethtrail",
      "custom:nanoflame",
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
	twokhotkey = 'e',
    airdronespawner = "1",
	armortype   = "lightarmor",
	normaltex = "unittextures/con_legonormal.png", 
  },
}

--------------------------------------------------------------------------------

local weaponDefs = {
  fusionfx = {

    areaOfEffect       = 5,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.1,
    craterBoost        = 0,
    craterMult         = 0,
    explosionGenerator = "custom:burn",
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
