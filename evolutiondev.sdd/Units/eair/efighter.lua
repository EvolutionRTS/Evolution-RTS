-- UNITDEF -- EFIGHTER --
--------------------------------------------------------------------------------

local unitName = "efighter"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "missiletrailsmall",
  pieceTrailCEGRange = 1,
--End tags entered from Notepad++
  acceleration       = 0.55,
  bankscale          = "1",
  brakeRate          = 6,
  buildCostEnergy    = 0,
  buildCostMetal     = 35,
  buildTime          = 7,
  canAttack          = true,
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
  cruiseAlt          = 400,
  description        = [[Fighter - Damagetype: Light :: Armortype: Light

Requires +5 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_UNIT",
  footprintX         = 3,
  footprintZ         = 2,
  floater            = true,
  iconType           = "air",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxAcc             = 0.25,
  maxDamage          = 160,
  maxSlope           = 10,
  maxVelocity        = 16,
  maxWaterDepth      = 255,
  metalStorage       = 0,
  moverate1          = "8",
  name               = "(C)oyote",
  noChaseCategory    = "NOTAIR",
  objectName         = "efighter.s3o",
  onlytargetcategory3 = "VTOL",
  onlytargetcategory4 = "VTOL",
  onlytargetcategory5 = "VTOL",
  onlytargetcategory6 = "VTOL",
  radarDistance      = 0,
  radarDistanceJam   = 100,
  selfDestructAs     = "SMALL_UNIT",
  side               = "ARM",
  sightDistance      = 800,
  smoothAnim         = true,
  sonarDistance      = 0,
  turnRate           = 1500,
  TurnRadius         = 500,
  unitname           = "efighter",
  workerTime         = 0,
  sfxtypes = {
    explosiongenerators = {
      "custom:gunshipcannon",
      "custom:jethtrail",
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
      def                = "antiairmissile",
	  onlyTargetCategory = "VTOL",
    },
  },
   customParams = {
	twokhotkey = 'c',
    RequireTech = "5 Power",
	armortype   = "lightarmor",
	normaltex = "unittextures/efighternormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  antiairmissile = {
    accuracy           = 1,
    areaOfEffect       = 48,
    avoidFriendly      = false,
    burnblow           = true,
    cegTag             = "missiletrailflashy",
    collideFriendly    = false,
    dance              = 97,
    explosionGenerator = "custom:BulletImpact3",
	energypershot      = 2,
    flighttime         = 8,
    fireStarter        = 70,
    guidance           = true,
    id                 = 101,
    interceptedByShieldType = 4,
    lineOfSight        = true,
    metalpershot       = 0,
    model              = "missilesmall.s3o",
    name               = "Missile",
    range              = 900,
    reloadtime         = 5,
    renderType         = 1,
    selfprop           = true,
    smokedelay         = ".1",
    smokeTrail         = false,
    soundHit           = "mediumcannonhit.wav",
    soundStart         = "aircraft_missile_01.wav",
    startsmoke         = "0",
    startVelocity      = 800,
    tolerance          = 9000,
    tracks             = true,
    turnRate           = 18000,
    turret             = false,
    weaponAcceleration = 800,
    weaponTimer        = 5,
    weaponType         = "MissileLauncher",
    weaponVelocity     = 800,
	customparams = {
	  damagetype		= "light",  
    },  
    damage = {
      default           = 20,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
