-- UNITDEF -- EBOMBER --
--------------------------------------------------------------------------------

local unitName = "ebomber"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "missiletrailsmall",
  pieceTrailCEGRange = 1,
--End tags entered from Notepad++
  acceleration       = 0.2,
  altfromsealevel    = "1",
  BadTargetCategory  = "VTOL",
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 80,
  builder            = false,
  buildTime          = 10,
  canAttack          = true,
  canFly             = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "VTOL",
  collide            = true,
  collisionSphereScale = 1,
  corpse             = "ammobox",
  cruiseAlt          = 350,
  description        = [[Stealth Bomber - Damagetype: Explosive :: Armortype: Medium

Requires +10 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  footprintX         = 6,
  footprintZ         = 3,
  floater            = true,
  iconType           = "air",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  loopbackattack     = "1",
  maxAcc             = 0.18,
  maxDamage          = 120,
  maxSlope           = 10,
  maxVelocity        = 18,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "Cardinal (b)",
  noChaseCategory    = "VTOL",
  objectName         = "ebomber.s3o",
  onlytargetcategory1 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  radarDistanceJam   = 100,
  selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 800,
  smoothAnim         = true,
  stealth            = true,
  turnRate           = 1500,
  TurnRadius         = 1000,
  unitname           = "ebomber",
  workerTime         = 0,
  sfxtypes = {
    explosiongenerators = {
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
      def                = "SBOMB",
      OnlyTargetCategory = "NOTAIR AMPHIB",
      BadTargetCategory  = "VTOL",
      noChaseCategory    = "VTOL",
    },
  },
   customParams = {
	twokhotkey = 'b',
    RequireTech = "10 Power",
	armortype   = "mediumarmor",
	normaltex = "unittextures/ebombernormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  SBOMB = {
    areaOfEffect       = 50,
    avoidFriendly      = false,
    ballistic          = true,
    burst              = 10,
    burstrate          = 0.1,
    cegTag             = "lightbomb",
    collideFriendly    = false,
    CylinderTargetting = true,
    Commandfire        = true,
    explosionGenerator = "custom:dodaibomb",
	energypershot      = 4,
    id                 = 5,
    interceptedByShieldType = 4,
    name               = "Bombs",
    noSelfDamage       = true,
    range              = 300,
    reloadtime         = 8,
    renderType         = 4,
    sprayangle         = 2000,
    soundHit           = "bombhit.wav",
    soundStart         = "18393_inferno_reject.wav",
    startVelocity      = 50,
    turret             = true,
    tolerance          = 1000,
    weaponVelocity     = 200,
	customparams = {
	  damagetype		= "explosive",  
    },
    damage = {
      default           = 40,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
