-- UNITDEF -- EFATSO2 --
--------------------------------------------------------------------------------

local unitName = "efatso2"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 40,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "ARMORED NOTAIR ASSAULT",
  corpse             = "ammobox",
  description        = [[Armored Anti-Base Tank
Armored
350 Damage vs Building
43.75 Damage vs Light/Armored

Requires +10 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  footprintX         = 5,
  footprintZ         = 5,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 1500,
  maxSlope           = 26,
  maxVelocity        = 2.2,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK5",
  name               = "Fatso",
  noChaseCategory    = "VTOL",
  objectName         = "efatso2.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 800,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 2.2,
  turnRate           = 1000,
--  turnrate           = 1000,
  unitname           = "efatso2",
  upright            = true,
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:gdmcannon",
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
      def                = "eheavyturretweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
	  badTargetCategory  = "LIGHT ARMORED WALL",
    },
    [2]  = {
      def                = "eheavyturretweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
	  badTargetCategory  = "LIGHT ARMORED WALL",
      slaveTo            = 1,
    },
  },
  customParams = {
    needed_cover = 5,
  	death_sounds = "soldier",
    RequireTech = "10 Power",
	armortype   = "armored", 
	normaltex = "unittextures/efatso2normal.png", 
	helptext = [[The Fatso is the pinnacle of anti-base technology. It has enough hitpoints to allow it to take a beating and keep barreling down upon base structures and defenses, however, this amazing power comes at a cost. It is incapable of properly defending itself as it's weapon is slow to recharge and it simply is too slow to outmaneuver skirmish units. Bring an escort.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  eheavyturretweapon = {
    badTargetCategory = [[ARMORED LIGHT]],
    accuracy           = 1,
    AreaOfEffect       = 50,
    avoidFriendly      = false,
    ballistic          = true,
    cegTag             = "factorysparks",
    collideFriendly    = false,
    explosionGenerator = "custom:fatsoimpact",
	energypershot      = 17.5,
    id                 = 71,
    interceptedByShieldType = 4,
    impulse            = "0",
    impulseBoost       = 0,
    impulseFactor      = 0,
    name               = "Plasma Cannon",
    range              = 750,
    reloadtime         = 1.25,
    weaponType		   = "Cannon",
    soundHit           = "eturrethit.wav",
    soundStart         = "eturretfire.wav",
    tolerance          = 5000,
    startsmoke         = "1",
    turret             = true,
    weaponVelocity     = 315,
	customparams = {
	  damagetype		= "efatso",  
    },      
    damage = {
      default           = 350,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
