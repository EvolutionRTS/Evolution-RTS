-- UNITDEF -- EAATANK --
--------------------------------------------------------------------------------

local unitName = "eaatank"

--------------------------------------------------------------------------------


local unitDef = {

  acceleration       = 1,
  bmcode             = "1",
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 25,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR SUPPORT",
  corpse             = "ammobox",
  defaultmissiontype = "Standby",
  description        = [[Anti-Air Support Tank 
  •Damagetype: Explosive :: Armortype: Medium

Requires +5 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_UNIT",
  firestandorders    = "1",
  footprintX         = 2,
  footprintZ         = 2,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 185,
  maxSlope           = 26,
  maxVelocity        = 2.9,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  mobilestandorders  = "1",
  movementClass      = "HOVERTANK2",
  name               = "Spewer (A)",
  noAutoFire         = false,
  noChaseCategory    = "VTOL AMPHIB NOTAIR SUPPORT",
  objectName         = "eaatank.s3o",
  radarDistance      = 0,
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
      def                = "eaatankshot",
      onlytargetcategory = "VTOL",
    },
  },
  customParams = {
    needed_cover = 1,
  	death_sounds = "soldier",
	twokhotkey = 'a',
    RequireTech = "5 Power",
	armortype   = "mediumarmor",
	normaltex = "unittextures/eaatanknormal.png", 
	helptext	= [[The spewer is the only dedicated mobile Anti-Air tank in Evolution RTS. It's range is quite limited, so make sure to bring along some scouts for the additional line of sight distance. Fires 4 flak shells in a burst.]],
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
    burst              = 4,
    burstrate          = 0.5,
	cegTag             = "missiletrailflashy",
    collideFriendly    = false,
    collideFeature     = false,
    cylinderTargetting = 1,
    burnblow           = true,
	edgeEffectiveness  = 1,
    endsmoke           = "1",
    energypershot      = 0,
    explosionGenerator = "custom:xamelImpact",
	energypershot      = 12,
    fireStarter        = 80,
    id                 = 1,
    impulseFactor      = 0,
	interceptedByShieldType = 4,
	model              = "missilesmall.s3o",
    name               = "AA Cannon",
    pitchtolerance     = "500",
    range              = 1000,
    reloadtime         = 10,
    weaponType		   = "Cannon",
    soundHit           = "aatankshot.wav",
    soundStart         = "aircraft_missile_01.wav",
    startsmoke         = "1",
    tolerance          = 500,
    turret             = true,
	toairweapon		   = true,
	canAttackGround    = false,
    weaponVelocity     = 1200,
	customparams = {
	  damagetype		= "explosive",  
    },
    damage = {
      default            = 30,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
