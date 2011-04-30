-- UNITDEF -- EDRONE --
--------------------------------------------------------------------------------

local unitName = "edrone"

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
  buildCostEnergy    = 1,
  buildCostMetal     = 1,
  buildTime          = 1,
  canAttack          = true,
  canDropFlare       = true,
  canFly             = true,
  canGuard           = true,
  canLoopbackAttack  = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "VTOL",
  collide            = false,
  collisionSphereScale = 1,
  corpse             = "ammobox",
  cruiseAlt          = 100,
  description        = "Drone Gunship",
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  flareDelay         = 0.1,
  flareDropVector    = "0 0 -1",
  flareefficieny     = "0.3",
  flareReload        = 3,
  footprintX         = 2,
  footprintZ         = 2,
  hoverAttack        = true,
  iconType           = "air",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 40,
  maxSlope           = 30,
  maxVelocity        = 30,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  moverate1          = "8",
  name               = "MidKnight",
  objectName         = "edrone.s3o",
  onlytargetcategory2 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 600,
  smoothAnim         = true,
  stealth            = true,
  turnRate           = 920,
  unitname           = "edrone",
  weaponslaveto2     = "1",
  sfxtypes = {
    explosiongenerators = {
      "custom:jetstrail",
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
  weapons = {
    [1]  = {
      def                = "droneweapon",
      mainDir            = "0 0 1",
      maxAngleDif        = 45,
    },
  },
  customParams = {
	normaltex = "unittextures/edronenormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  droneweapon = {
    accuracy           = 500,
    areaOfEffect       = 5,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.2,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.5,
    craterBoost        = 0,
    craterMult         = 0,
    duration           = 0.02,
    explosionGenerator = "custom:burn",
    fallOffRate        = 0.1,
    impulseFactor      = 0,
    interceptedByShieldType = 4,
    largeBeamLaser     = true,
    lineOfSight        = true,
    name               = "Light Laser",
    noSelfDamage       = true,
    range              = 800,
    reloadtime         = 0.5,
    WeaponType         = "LaserCannon",
    rgbColor           = "0.1 0.5 0.2",
    rgbColor2          = "0 1 0",
    selfprop           = true,
    soundHit           = "18393_inferno_reject.wav",
    soundStart         = "18389_inferno_medlas.wav",
    soundTrigger       = true,
    startVelocity      = 1000,
    targetMoveError    = 0,
    texture1           = "plasmaball",
    texture2           = "empty",
    texture3           = "empty",
    texture4           = "empty",
    thickness          = 5,
    turret             = true,
    weaponVelocity     = 1000,
	customparams = {
	  damagetype		= "beam",  
    },    
    damage = {
      default            = 5,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
