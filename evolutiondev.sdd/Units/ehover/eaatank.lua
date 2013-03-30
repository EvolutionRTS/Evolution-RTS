-- UNITDEF -- EAATANK --
--------------------------------------------------------------------------------

local unitName = "eaatank"

--------------------------------------------------------------------------------


local unitDef = {

  acceleration       = 1,
  bmcode             = "1",
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 28,
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
  defaultmissiontype = "Standby",
  description        = [[Anti-Air Support Tank
Light

Requires +5 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_UNIT",
  firestandorders    = "1",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 370,
  maxSlope           = 26,
  maxVelocity        = 2.9,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  mobilestandorders  = "1",
  movementClass      = "HOVERTANK4",
  name               = "Spewer (A)",
  noAutoFire         = false,
  noChaseCategory    = "VTOL AMPHIB NOTAIR SUPPORT",
  objectName         = "eaatank.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "SMALL_UNIT",
  sightDistance      = 350,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 2.9,
  turnRate           = 1000,
--  turnrate           = 430,
  tolerance			 = 1000,
  unitname           = "eaatank",
  upright            = true,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:dirt",
	  "custom:gdmcannon",
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
      def                = "eaatankantiairmissile",
      onlytargetcategory = "VTOL",
    },
  },
  customParams = {
    needed_cover = 1,
  	death_sounds = "soldier",
	twokhotkey = 'a',
    RequireTech = "3 Power",
	armortype   = "light",
	nofriendlyfire	= "1",
	normaltex = "unittextures/eaatanknormal.png", 
	helptext	= [[The spewer is the only dedicated mobile Anti-Air tank in Evolution RTS. It's range is quite limited, so make sure to bring along some scouts for the additional line of sight distance. Very large area of effect.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  eaatankshot = {
    accuracy           = 500,
    AreaOfEffect       = 300,
    avoidFriendly      = false,
    avoidFeature       = false,
    ballistic          = true,
	cegTag             = "missiletrailflashy",
    collideFriendly    = false,
    collideFeature     = false,
    cylinderTargeting  = true,
    burnblow           = true,
	edgeEffectiveness  = 1,
    endsmoke           = "1",
    energypershot      = 7,
    explosionGenerator = "custom:xamelImpact",
    fireStarter        = 80,
    impulseFactor      = 0,
	interceptedByShieldType = 4,
	model              = "missilesmall.s3o",
    name               = "AA Cannon",
    pitchtolerance     = "500",
    range              = 1000,
    reloadtime         = 1,
    weaponType		   = "Cannon",
    soundHit           = "aatankshot.wav",
    soundStart         = "missilefiring.wav",
    startsmoke         = "1",
    tolerance          = 500,
    turret             = true,
	toairweapon		   = true,
	canAttackGround    = false,
    weaponVelocity     = 1200,
	customparams = {
	  damagetype		= "antiair",  
	  nofriendlyfire	= 1,
    },
    damage = {
      default            = 70,
    },
  },

  eaatankantiairmissile = {
    AreaOfEffect       = 300,
    avoidFriendly      = false,
    avoidFeature       = false,
	burst				= 4,
	burstrate			= 0.5,
	cegTag             = "missiletrailaa",
    collideFriendly    = false,
    collideFeature     = false,
	canAttackGround    = false,
	edgeEffectiveness  = 0.5,
    explosionGenerator = "custom:BulletImpact3",
	energypershot      = 7,
    fireStarter        = 80,
    impulseFactor      = 1,
	interceptedByShieldType = 4,
	model              = "missilesmall.s3o",
    name               = "AA Missile",
    pitchtolerance     = 3000,
    range              = 1500,
    reloadtime         = 4,
    weaponType		   = "MissileLauncher",
    soundHit           = "mediumcannonhit.wav",
    soundStart         = "missilefiring.wav",
    tolerance          = 3000,
    turret             = true,
	toairweapon		   = true,
	startVelocity	   = 750,
	acceleration	   = 2000,
    weaponVelocity     = 10000,
	tracks				= true,
	turnrate			= 100000,
	flighttime			= 4,
	sprayangle			= 5000,
	
	customparams = {
	  damagetype		= "fighter",  
	  nofriendlyfire	= 1,
    },
    damage = {
      default            = 70,
    },
  },
  
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
