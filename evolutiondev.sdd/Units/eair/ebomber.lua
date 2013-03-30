-- UNITDEF -- EBOMBER --
--------------------------------------------------------------------------------

local unitName = "ebomber"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 0.2,
  altfromsealevel    = "1",
  BadTargetCategory  = "VTOL",
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 55,
  builder            = false,
  buildTime          = 2.5,
  canAttack          = true,
  canFly             = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "ARMORED VTOL",
  collide            = true,
--Collision Volumes... Because the engine devs are silly.
	collisionVolumeScales = [[35 35 35]],
--End Collision volumes
  corpse             = "ammobox",
  cruiseAlt          = 350,
  description        = [[Bomber
Armored, 800% Damage vs Buildings
  
Requires +10 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  footprintX         = 4,
  footprintZ         = 3,
  fireState			 = 0,
  floater            = true,
  iconType           = "air",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  loopbackattack     = "1",
  maxAcc             = 0.18,
  maxDamage          = 240,
  maxSlope           = 10,
  maxVelocity        = 18,
  verticalSpeed		 = 15,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "Cardinal (b)",
  noChaseCategory    = "VTOL",
  objectName         = "ebomber.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 800,
  smoothAnim         = true,
  stealth            = false,
  turnRate           = 1500,
  unitname           = "ebomber",
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:jethtrail",
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
      def                = "SBOMB",
      OnlyTargetCategory = "NOTAIR AMPHIB",
      BadTargetCategory  = "VTOL LIGHT ARMORED",
      noChaseCategory    = "VTOL",
    },
  },
   customParams = {
--    needed_cover = 2,
	death_sounds = "soldier",
	twokhotkey = 'b',
	nofriendlyfire = "1",
    RequireTech = "10 Power",
	armortype   = "armored",
	normaltex = "unittextures/ebombernormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  SBOMB = {
    badTargetCategory = [[ARMORED LIGHT]],
    AreaOfEffect       = 300,
    avoidFriendly      = false,
    ballistic          = true,
    burst              = 10,
    burstrate          = 0.1,
    cegTag             = "lightbomb",
    collideFriendly    = false,
    cylinderTargeting = true,
    explosionGenerator = "custom:dodaibomb",
	energypershot      = 1.25,
    id                 = 5,
	impulsefactor	   = 0,
    interceptedByShieldType = 4,
    name               = "Bombs",
    noSelfDamage       = true,
    range              = 300,
    reloadtime         = 8,
    weaponType		   = "Cannon",
    sprayangle         = 2000,
    soundHit           = "bombhit.wav",
    soundStart         = "18393_inferno_reject.wav",
    startVelocity      = 50,
    turret             = true,
    tolerance          = 1000,
    weaponVelocity     = 200,
	customparams = {
	  damagetype		= "bomber",  
	  nofriendlyfire	= 1,
    },
    damage = {
      default           = 12.5,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
