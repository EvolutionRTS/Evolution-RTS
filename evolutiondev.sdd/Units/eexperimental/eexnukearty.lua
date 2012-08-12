-- UNITDEF -- EEXNUKEARTY --
--------------------------------------------------------------------------------

local unitName = "eexnukearty"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 0.18,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 1600,
  builder            = false,
  buildTime          = 320,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT NOTAIR SUPPORT",
  corpse             = "ammobox",
  description        = [[Low Yeild Nuclear Artillery Support Tank
Light, 200% Damage vs Buildings

Requires +80 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  footprintX         = 9,
  footprintZ         = 9,
  highTrajectory     = 1,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 3000,
  maxVelocity        = 1.3,
  maxReverseVelocity = 0.8,
  maxWaterDepth      = 20,
  metalStorage       = 0,
  movementClass      = "HOVERTANKEXPERIMENTAL9",
  name               = "L(a)cerator",
  noChaseCategory    = "VTOL",
  objectName         = "eexnukearty.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 500,
  smoothAnim         = true,
  turnInPlace        = false,
  turnRate           = 100,
  unitname           = "eexnukearty",
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:gdhcannon",
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
      def                = "nukeartyweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
  },
  customParams = {
	death_sounds = "nuke",
	twokhotkey = 'a',
    RequireTech = "80 Power",
	armortype   = "light",
	normaltex = "unittextures/lego2skin_explorernormal.png", 
	helptext = [[]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  nukeartyweapon = {
    badTargetCategory = [[ARMORED LIGHT]],
    accuracy           = 200,
    AreaOfEffect       = 1000,
    avoidFriendly      = false,
    ballistic          = true,
    cegTag             = "nukeartyshot",
    collideFriendly    = false,
	commandfire		   = true,
    explosionGenerator = "custom:nukeartyexpl",
	energypershot      = 100,
    id                 = 172,
    impulseFactor      = 0,
    interceptedByShieldType = 4,
    name               = "Light Cannon",
    range              = 2500,
    reloadtime         = 12,
    weaponType		   = "Cannon",
    soundHit           = "nukeartyhit.wav",
    soundStart         = "nukeartyshot.wav",
    startsmoke         = "1",
    tolerance          = 2000,
    turret             = true,
    weaponVelocity     = 800,
	customparams = {
	  damagetype		= "antibuilding",  
    }, 
    damage = {
      default           = 1000,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
