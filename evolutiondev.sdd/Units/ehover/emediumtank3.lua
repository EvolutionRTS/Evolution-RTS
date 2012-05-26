-- UNITDEF -- EMEDIUMTANK3 --
--------------------------------------------------------------------------------

local unitName = "emediumtank3"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 20,
  builder            = false,
  buildTime          = 7,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR SKIRMISHER",
  corpse             = "ammobox",
  description        = [[Light Tank Destroyer 
  •Damagetype: Medium :: Armortype: Light

Requires +3 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "MEDIUM_UNIT",
  footprintX         = 3,
  footprintZ         = 3,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 250,
  maxSlope           = 26,
  maxVelocity        = 4.0,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK3",
  name               = "(B)ruiser",
  noChaseCategory    = "VTOL",
  objectName         = "emediumtank3.s3o",
  radarDistance      = 0,
  selfDestructAs     = "MEDIUM_UNIT",
  side               = "CORE",
  sightDistance      = 500,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 4,
  turnRate           = 1000,
--  turnrate           = 430,
  unitname           = "emediumtank3",
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
      def                = "mediumtankcannon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
  },
  customParams = {
    needed_cover = 2,
  	death_sounds = "soldier",
	twokhotkey = 'b',
    RequireTech = "3 Power",
	armortype   = "lightarmor",
	normaltex = "unittextures/emediumtank3normal.png", 
	helptext	= [[The brusier is a light tank destroyer, excellent versus raiders and other light units. Pair with light raiders and heavy tank destroyers for best results.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  mediumtankcannon = {
    AreaOfEffect       = 32,
    avoidFriendly      = false,
    ballistic          = true,
    cegTag             = "mediumcannonweapon",
    collideFriendly    = false,
    explosionGenerator = "custom:BulletImpactBlue",
	energypershot      = 10,
    id                 = 51,
    interceptedByShieldType = 4,
    name               = "Light Cannon",
    range              = 500,
    reloadtime         = 1.0,
    weaponType		   = "Cannon",
    soundHit           = "mediumcannonhit.wav",
    soundStart         = "medassualt_blast.wav",
    startsmoke         = "1",
    turret             = true,
    weaponVelocity     = 400,
	customparams = {
	  damagetype		= "medium",  
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
