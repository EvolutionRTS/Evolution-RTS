-- UNITDEF -- EEXNUKEARTY --
--------------------------------------------------------------------------------

local unitName = "eexnukearty"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 0.18,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 750,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "ARMORED NOTAIR SUPPORT",
  corpse             = "ammobox",
  description        = [[Low Yeild Nuclear Artillery Support Tank
Armored
2000 Damage vs Building
1000 Damage vs Light/Armored

Requires +80 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  footprintX         = 9,
  footprintZ         = 9,
  fireState			 = 0,
  highTrajectory     = 1,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 1500,
  maxVelocity        = 1.3,
  maxReverseVelocity = 0.8,
  maxWaterDepth      = 20,
  metalStorage       = 0,
  movementClass      = "HOVERTANKEXPERIMENTAL9",
  name               = "L(a)cerator",
  noChaseCategory    = "VTOL",
  objectName         = "eexnukearty.s3o",
  pushResistant		 = true,
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 1000,
  smoothAnim         = true,
  turnInPlace        = false,
  turnRate           = 100,
  unitname           = "eexnukearty",
  unitRestricted	 = 1,
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
	  badTargetCategory  = "LIGHT ARMORED",
    },
  },
  customParams = {
	death_sounds = "nuke",
	twokhotkey = 'a',
    RequireTech = "80 Power",
	armortype   = "armored",
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
    explosionGenerator = "custom:nukeartyexpl",
	energypershot      = 200,
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
	  damagetype		= "eexnukearty",  
    }, 
    damage = {
      default           = 2000,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
