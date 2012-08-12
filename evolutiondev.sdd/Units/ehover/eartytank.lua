-- UNITDEF -- EARTYTANK --
--------------------------------------------------------------------------------

local unitName = "eartytank"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 180,
  builder            = false,
  buildTime          = 36,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT NOTAIR SUPPORT",
  corpse             = "ammobox",
  description        = [[Artillery Support Tank
Light, 200% Damage vs Buildings

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
  maxDamage          = 300,
  maxVelocity        = 2.3,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK3",
  name               = "(L)obster",
  noChaseCategory    = "VTOL",
  objectName         = "eartytank.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 1500,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 2.3,
  turnRate           = 1000,
--  turnrate           = 250,
  unitname           = "eartytank",
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:gdmarty",
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
  weapons = {
    [1]  = {
      def                = "Artilleryweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
  },
  customParams = {
    needed_cover = 3,
  	death_sounds = "soldier",
	twokhotkey = 'l',
    RequireTech = "8 Power",
	armortype   = "light",
	normaltex = "unittextures/eartytanknormal.png", 
	helptext = [[The Lobster has extremely long range, fires five rounds in a burst but does very low damage in a large area of effect. Damage boost versus structures and defenses. Reduced damage to mobile units.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  Artilleryweapon = {
    badTargetCategory = [[ARMORED LIGHT]],
    accuracy           = 500,
    AreaOfEffect       = 50,
    avoidFriendly      = false,
    ballistic          = true,
	burst			   = 5,
	burstrate          = 1,
    cegTag             = "artyshot2",
    collideFriendly    = false,
    explosionGenerator = "custom:ARTILLERY_EXPLOSION",
	energypershot      = 10,
    id                 = 59,
    impulse            = "0",
    impulseFactor      = 0,
    interceptedByShieldType = 4,
    minbarrelangle     = "-25",
    name               = "Plasma Cannon",
    range              = 1500,
    reloadtime         = 24,
    weaponType		   = "Cannon",
    soundHit           = "explode5.wav",
    soundStart         = "eartillery.wav",
    startsmoke         = "1",
    turret             = true,
    weaponVelocity     = 500,
	customparams = {
	  damagetype		= "antibuilding",  
    },  
    damage = {
      default           = 100,
     },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
