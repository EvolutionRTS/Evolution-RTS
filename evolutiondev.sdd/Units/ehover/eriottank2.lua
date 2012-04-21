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
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
--  canDgun			 = true,
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR RIOT",
  corpse             = "ammobox",
  description        = [[Anti-Swarm Tank - Damagetype: Light :: Armortype: Heavy

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
  maxDamage          = 150,
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
  selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 400,
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
--[[    [2]  = {
      def                = "riottanksupaweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    }, ]]--
  },
  customParams = {
    needed_cover = 2,
	death_sounds = "soldier",
	twokhotkey = 's',
    RequireTech = "4 Power",
	armortype   = "heavyarmor",
	normaltex = "unittextures/eriottank2normal.png", 
	helptext	= [[The Spas is a unit designed to take on large amounts of raiders and pound them all to dust. Features 10 concussion shells in a burst that will knock back opposing units. It has Light armor, and should be paired with escorts if possible.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  riottankweapon = {
    AreaOfEffect       = 50,
	avoidFeature       = false,
    avoidFriendly      = false,
    ballistic          = true,
    cegTag             = "riotweapon",
    collideFriendly    = false,
    explosionGenerator = "custom:PLASMA_Expl",
	energypershot      = 50,
    id                 = 172,
    impulseFactor      = 0.5,
	interceptedByShieldType = 4,
    name               = "Light Cannon",
    projectiles        = 10,
    range              = 750,
    reloadtime         = 5,
    weaponType		   = "Cannon",
--    soundHit           = "mediumcannonhit.wav",
    soundStart         = "riottankshot.wav",
    sprayAngle         = 2000,
    tolerance          = 2000,
    turret             = true,
    weaponVelocity     = 500,
	customparams = {
	  damagetype		= "light",  
    },   
    damage = {
      default           = 50,
    },
  },

  riottanksupaweapon = {
    AreaOfEffect       = 100,
    avoidFriendly      = false,
    ballistic          = true,
	burst			   = 5,
	burstrate		   = 0.1,
    cegTag             = "riotweapon",
    collideFriendly    = false,
    commandfire        = true,
    explosionGenerator = "custom:PLASMA_Expl",
	energypershot      = 187,
    id                 = 172,
    impulseFactor      = 0.5,
	interceptedByShieldType = 4,
    name               = "Light Cannon",
    projectiles        = 5,
    range              = 400,
    reloadtime         = 5,
    weaponType		   = "Cannon",
    soundHit           = "mediumcannonhit.wav",
    soundStart         = "rocket_launcher2.wav",
    sprayAngle         = 2000,
    stockpile          = true,
    stockpileTime      = 30,
    startsmoke         = "1",
    tolerance          = 2000,
    turret             = true,
    weaponVelocity     = 500,
	customparams = {
	  damagetype		= "light",  
    },   
    damage = {
      default           = 38,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
