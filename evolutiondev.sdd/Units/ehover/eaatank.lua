-- UNITDEF -- EAATANK --
--------------------------------------------------------------------------------

local unitName = "eaatank"

--------------------------------------------------------------------------------


local unitDef = {
  acceleration       = 0.18,
  bmcode             = "1",
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 25,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR SUPPORT",
  corpse             = "ammobox",
  defaultmissiontype = "Standby",
  description        = [[Anti-Air Support Tank 
  •Damagetype: Explosive :: Armortype: Medium

Requires +5 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_UNIT",
  firestandorders    = "1",
  footprintX         = 2,
  footprintZ         = 2,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 185,
  maxSlope           = 26,
  maxVelocity        = 2.9,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  mobilestandorders  = "1",
  movementClass      = "HOVERTANK2",
  name               = "Spewer (A)",
  noAutoFire         = false,
  noChaseCategory    = "VTOL",
  objectName         = "eaatank.s3o",
  radarDistance      = 0,
  selfDestructAs     = "SMALL_UNIT",
  sightDistance      = 350,
  smoothAnim         = true,
  turnInPlace        = false,
  turnRate           = 430,
  unitname           = "eaatank",
  upright            = true,
  sfxtypes = {
    explosiongenerators = {
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
      def                = "eaatankmissile",
    },
  },
  customParams = {
	twokhotkey = 'a',
    RequireTech = "5 Power",
	armortype   = "mediumarmor",
	normaltex = "unittextures/eaatanknormal.png", 
	helptext	= [[The spewer is the only dedicated mobile Anti-Air tank in Evolution RTS. It's range is quite limited, so make sure to bring along some scouts for the additional line of sight distance. Fires 5 missiles in a burst.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  eaatankmissile = {
    accuracy           = 1,
    areaOfEffect       = 48,
    avoidFriendly      = false,
    burnblow           = true,
    burst              = 4,
    burstrate          = 0.5,
    cegTag             = "missiletrailflashy",
    collideFriendly    = false,
    CylinderTargetting = true,
    explosionGenerator = "custom:BulletImpact3",
	energypershot      = 3,
    flighttime         = 8,
    fireStarter        = 70,
    guidance           = true,
    id                 = 101,
	interceptedByShieldType = 4,
    lineOfSight        = true,
    metalpershot       = 0,
    model              = "missilesmall.s3o",
    name               = "Missile",
    range              = 650,
    reloadtime         = 10,
    renderType         = 1,
    selfprop           = true,
    smokedelay         = ".1",
    smokeTrail         = false,
    soundHit           = "mediumcannonhit.wav",
    soundStart         = "rocket_launcher.wav",
    startsmoke         = "0",
    startVelocity      = 800,
    tolerance          = 9000,
    tracks             = true,
    turnRate           = 30000,
    turret             = true,
    weaponAcceleration = 100,
    weaponTimer        = 7,
    weaponType         = "MissileLauncher",
    weaponVelocity     = 1200,
	customparams = {
	  damagetype		= "explosive",  
    },    
    damage = {
     default         = 30,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
