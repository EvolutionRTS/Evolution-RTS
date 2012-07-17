-- UNITDEF -- EMISSILETANK --
--------------------------------------------------------------------------------

local unitName = "emissiletank"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 30,
  builder            = false,
  buildTime          = 8,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR SUPPORT",
  corpse             = "ammobox",
  description        = [[Missile Support Tank
Light, 200% vs Armored

Requires +7 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 320,
  maxSlope           = 26,
  maxVelocity        = 2.6,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK4",
  name               = "(D)roplet",
  objectName         = "emissiletank.s3o",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  side               = "ARM",
  sightDistance      = 400,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 2.6,
  turnRate           = 1000,
--  turnrate           = 300,
  unitname           = "emissiletank",
  upright            = true,
  workerTime         = 0,
    sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:factorysparks",
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
      def                = "missletankweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
  },
  customParams = {
    needed_cover = 3,
  	death_sounds = "soldier",
	twokhotkey = 'd',
    RequireTech = "7 Power",
	armortype   = "light",
	normaltex = "unittextures/emissiletanknormal.png", 
	helptext	= [[The Droplet is a medium range missile artillery battery. Does increased damage versus structures and units with heavy armor but is not very agile. Make sure that it has an escort.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  missletankweapon = {
    AreaOfEffect       = 100,
    avoidFriendly      = false,
    cegTag             = "missiletrail",
    collideFriendly    = false,
    craterBoost        = 0,
    craterMult         = 0,
    explosionGenerator = "custom:xamelimpact",
	energypershot      = 10,
    fireStarter        = 100,
    flightTime         = 10,
    guidance           = false,
    id                 = 124,
    impulseBoost       = 0,
    impulseFactor      = 0,
    interceptedByShieldType = 4,
    lineOfSight        = true,
    model              = "missilesmallvlaunch.s3o",
    name               = "Rocket",
    range              = 850,
    reloadtime         = 6,
    weaponType		   = "MissileLauncher",
    selfprop           = true,
    smokedelay         = "0.1",
    smokeTrail         = false,
    soundHit           = "explode_large.wav",
    soundStart         = "missile_launch1.wav",
    startsmoke         = "0",
    tracks             = true,
    turnrate           = 30000,
    vlaunch            = true,
    weaponAcceleration = 400,
    weaponTimer        = 1,
    weaponType         = "StarburstLauncher",
    weaponVelocity     = 1800,
	customparams = {
	  damagetype		= "armoredtankdestroyer",  
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
