-- UNITDEF -- ARMFLASH --
--------------------------------------------------------------------------------

local unitName = "armflash"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  acceleration       = 0.18,
  bmcode             = "1",
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 1000,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "ARMORED NOTAIR",
  copyright          = "Copyright 1997 Humongous Entertainment. All rights reserved.",
  corpse             = "ammobox",
  defaultmissiontype = "Standby",
  description        = "Assault Tank Upgrade 2",
  designation        = "",
  energyMake         = 0.5,
  energyStorage      = 0,
  energyUse          = 0.5,
  explodeAs          = "BIG_UNITEX",
  firestandorders    = "1",
  footprintX         = 2,
  footprintZ         = 2,
  frenchdescription  = "Char d'assaut",
  frenchname         = "Agitator",
  germandescription  = "Gefechtspanzer",
  germanname         = "Instigator",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  italiandescription = "Carro armato d'assalto",
  italianname        = "Instigator",
  leaveTracks        = false,
  maneuverleashlength = "640",
  maxDamage          = 10000,
  maxSlope           = 10,
  maxVelocity        = 3.5,
  maxWaterDepth      = 5000,
  metalStorage       = 0,
  mobilestandorders  = "1",
  movementClass      = "TANK2",
  movestate			 = 0,
  name               = "Flash",
  noAutoFire         = false,
  noChaseCategory    = "VTOL GROUND",
  objectName         = "armflash.s3o",
  ovradjust          = "1",
  radarDistance      = 0,
  selfDestructAs     = "BIG_UNIT",
  shootme            = "1",
  side               = "CORE",
  sightDistance      = 600,
  smoothAnim         = true,
  spanishdescription = "Tanque de asalto",
  spanishname        = "Instigator",
  standingfireorder  = "2",
  standingmoveorder  = "1",
  steeringmode       = "1",
  threed             = "1",
  trackOffset        = 3,
  trackStrength      = 5,
  trackStretch       = 1,
  trackType          = "VehTrack",
  trackWidth         = 24,
  turnRate           = 1000,
  unitname           = "armflash",
  unitnumber         = "108",
  upright            = false,
  version            = "1",
  workerTime         = 0,
  zbuffer            = "1",
   sfxtypes = {
    explosiongenerators = {
      "custom:emgcannon",
	  "custom:dirt",
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
      def                = "flashweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
    [2]  = {
      def                = "flashweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
  },
   customParams = {
    RequireTech = "4 Power",
	armortype   = "armored",
	normaltex = "unittextures/armregskinnormal.png", 
  },
}

--------------------------------------------------------------------------------

local weaponDefs = {
  flashweapon = {
    AreaOfEffect       = 8,
    avoidFriendly      = false,
    collideFriendly    = false,
    rgbColor           = "0.8 0.5 0",
    rgbColor2          = "0.5 0.5 0.5",
    explosionGenerator = "custom:burn",
    id                 = 19,
    lineOfSight        = true,
    name               = "E.M.G.",
    range              = 510,
    reloadtime         = 0.1,
    weaponType		   = "Cannon",
    soundStart         = "tgunshipfire.wav",
    soundTrigger       = true,
    sprayAngle         = 1024,
    startsmoke         = "1",
    tolerance          = 1000,
    turret             = true,
    weaponTimer        = 1,
    weaponVelocity     = 400,
    damage = {
      default            = 7,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
