-- UNITDEF -- EARTYTANK --
--------------------------------------------------------------------------------

local unitName = "eartytank"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  acceleration       = 0.18,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 90,
  builder            = false,
  buildTime          = 10,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR SUPPORT",
  corpse             = "ammobox",
  description        = [[Artillery Support Tank 
  •Damagetype: Explosive :: Armortype: Light

Requires +8 Power]],
  energyMake         = 0.5,
  energyStorage      = 0,
  energyUse          = 0.5,
  explodeAs          = "BIG_UNIT",
  footprintX         = 3,
  footprintZ         = 3,
  highTrajectory     = 2,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 150,
  maxVelocity        = 2.3,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK3",
  name               = "(L)obster",
  noChaseCategory    = "VTOL",
  objectName         = "eartytank.s3o",
  radarDistance      = 0,
  selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 500,
  smoothAnim         = true,
  turnInPlace        = false,
  turnRate           = 250,
  unitname           = "eartytank",
  workerTime         = 0,
  sfxtypes = {
    explosiongenerators = {
      "custom:gdmarty",
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
      def                = "Artilleryweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
  },
  customParams = {
	twokhotkey = 'l',
    RequireTech = "8 Power",
	armortype   = "lightarmor",
	normaltex = "unittextures/eartytanknormal.png", 
	helptext = [[The Lobster has extremely long range, fires five rounds in a burst but does very low damage in a large area of effect. Damage boost versus structures and defenses. Reduced damage to mobile units.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  Artilleryweapon = {
    accuracy           = 500,
    areaOfEffect       = 200,
    avoidFriendly      = false,
    ballistic          = true,
	burst			   = 5,
	burstrate          = 1,
    cegTag             = "artyshot2",
    collideFriendly    = false,
    explosionGenerator = "custom:ARTILLERY_EXPLOSION",
	energypershot      = 5,
    id                 = 59,
    impulse            = "0",
    impulseFactor      = 0,
    interceptedByShieldType = 4,
    minbarrelangle     = "-25",
    name               = "Plasma Cannon",
    range              = 1500,
    reloadtime         = 24,
    renderType         = 4,
    soundHit           = "explode5.wav",
    soundStart         = "eartillery.wav",
    startsmoke         = "1",
    turret             = true,
    weaponVelocity     = 500,
	customparams = {
	  damagetype		= "explosive",  
    },  
    damage = {
      default           = 50,
     },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
