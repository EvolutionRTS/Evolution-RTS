-- UNITDEF -- EARTYTANK --
--------------------------------------------------------------------------------

local unitName = "eartytank"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 36,
  builder            = false,
  buildTime          = 5,
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
Light
1000 Damage vs Buildings (Per Volley)
250 Damage vs Light/Armored (Per Volley)

Requires +8 Power
Uses +8 Supply]],
  energyMake         = 0.5,
  energyStorage      = 0,
  energyUse          = 0.5,
  explodeAs          = "BIG_UNIT",
  footprintX         = 3,
  footprintZ         = 3,
  highTrajectory     = 2,
  iconType           = "assault",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 300,
  maxVelocity        = 2.3,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK3",
  name               = "ShadowFury",  --Because he first one to get the "Lobster" pun
  noChaseCategory    = "VTOL",
  objectName         = "eartytank2.s3o",
  script			 = "eartytank2.cob",
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
      onlyTargetCategory = "BUILDING",
    },
  },
  customParams = {
	canareaattack="1",
    needed_cover = 3,
  	death_sounds = "soldier",
    RequireTech = "8 Power",
	armortype   = "light",
	supply_cost = 8,
	normaltex = "unittextures/lego2skin_explorernormal.dds", 
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
	avoidFriendly	   = false,
	avoidFeature	   = false,
	avoidNeutral	   = false,
    collideFriendly    = false,
    explosionGenerator = "custom:genericshellexplosion-large",
	energypershot      = 50,
    id                 = 59,
    impulse            = "0",
    impulseFactor      = 0,
    interceptedByShieldType = 4,
    minbarrelangle     = "-25",
    name               = "Plasma Cannon",
    range              = 1500,
    reloadtime         = 24,
    weaponType		   = "Cannon",
    soundHit           = "artyhit.wav",
    soundStart         = "arty2.wav",
    startsmoke         = "1",
    turret             = true,
    weaponVelocity     = 500,
	customparams = {
	  damagetype		= "eartytank",  
    },  
    damage = {
      default           = 200,
     },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
