-- UNITDEF -- EHEAVYTANK3 --
--------------------------------------------------------------------------------

local unitName = "eheavytank3"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 30,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "ARMORED NOTAIR SKIRMISHER",
  corpse             = "ammobox",
  description        = [[Armored Tank Destroyer
Armored
100 Damage vs Light/Armored
50 Damage vs Building

Requires +5 Power
Uses +5 Supply]],
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
  maxDamage          = 600,
  maxSlope           = 26,
  maxVelocity        = 2.8,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK4",
  name               = "Crusher",
  noChaseCategory    = "VTOL",
  objectName         = "eheavytank3.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 750,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 2.8,
  turnRate           = 2500,
--  turnrate           = 350,
  unitname           = "eheavytank3",
  upright            = true,
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
      def                = "heavytankweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
	  badTargetCategory  = "BUILDING WALL",
    },
  },
  customParams = {
    needed_cover = 3,
  	death_sounds = "soldier",
    RequireTech = "5 Power",
	armortype   = "armored",
	supply_cost = 5,
	normaltex = "unittextures/eheavytank3normal.png", 
	helptext = [[The Crusher is a heavy tank destroyer capable of taking out the most hardened of mobile units. The more of these you have, the better. Short line of sight. It is recommended that they be paired with raiders.
	
	The Crusher is great vs all mobile units. It takes a damage penalty vs buildings so it isn't very good for base assaults]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  heavytankweapon = {
	badTargetCategory = [[BUILDING]],
    accuracy           = 200,
    AreaOfEffect       = 1,
    avoidFriendly      = false,
    ballistic          = true,
    cegTag             = "antiassualtshot2",
    collideFriendly    = false,
    explosionGenerator = "custom:MEDMECHPOP",
	energypershot      = 6,
    id                 = 172,
    impulseFactor      = 0,
    interceptedByShieldType = 4,
    name               = "Light Cannon",
    range              = 750,
    reloadtime         = 1,
    weaponType		   = "Cannon",
    soundHit           = "42024_digifishmusic_Missile_Strike.wav",
    soundStart         = "triotfire.wav",
    startsmoke         = "1",
    tolerance          = 2000,
    turret             = true,
    weaponVelocity     = 800,
	customparams = {
	  damagetype		= "eheavytank3",  
    },      
    damage = {
     default         = 100,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
