-- UNITDEF -- ERIOTTANK2 --
--------------------------------------------------------------------------------

local unitName = "eriottank2"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 15,
  builder            = false,
  buildTime          = 7,
  canAttack          = true,
  cancollect         = "1",
--  canDgun			 = true,
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "ARMORED NOTAIR RIOT",
  corpse             = "ammobox",
  description        = [[Anti-Swarm Tank
Armored, 200% Damage vs Light

Requires +4 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  footprintX         = 3,
  footprintZ         = 3,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 300,
  maxSlope           = 26,
  maxVelocity        = 3.3,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK3",
  name               = "(S)pas",
  noChaseCategory    = "VTOL",
  objectName         = "eriottank2.s3o",
  onlytargetcategory2 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 750,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 3.3,
  turnRate           = 1000,
--  turnrate           = 430,
  unitname           = "eriottank2",
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
      def                = "riottankweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
  },
  customParams = {
    needed_cover = 2,
	death_sounds = "soldier",
	twokhotkey = 's',
    RequireTech = "4 Power",
	armortype   = "armored",
	normaltex = "unittextures/eriottank2normal.png", 
	helptext	= [[The Spas is a unit designed to take on large amounts of raiders and pound them all to dust. Features 10 concussion shells in a burst that will knock back opposing units. It has Light armor, and should be paired with escorts if possible.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  riottankweapon = {
    badTargetCategory = [[ARMORED BUILDING]],
	accuracy		   = 0,
    AreaOfEffect       = 25,
	avoidFeature       = false,
    avoidFriendly      = false,
    ballistic          = true,
    cegTag             = "riotweapon",
    collideFriendly    = false,
    explosionGenerator = "custom:PLASMA_Expl",
	energypershot      = 2.25,
    id                 = 172,
    impulseFactor      = 0.5,
	interceptedByShieldType = 4,
    name               = "Light Cannon",
    range              = 750,
    reloadtime         = 0.25,
    weaponType		   = "Cannon",
--    soundHit           = "mediumcannonhit.wav",
    soundStart         = "riottankshot.wav",
    tolerance          = 2000,
    turret             = true,
    weaponVelocity     = 500,
	customparams = {
	  damagetype		= "riot",  
    },   
    damage = {
      default           = 45,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
