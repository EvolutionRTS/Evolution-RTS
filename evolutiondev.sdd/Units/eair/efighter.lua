-- UNITDEF -- EFIGHTER --
--------------------------------------------------------------------------------

local unitName = "efighter"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  acceleration       = 0.55,
  bankscale          = "1",
  brakeRate          = 6,
  buildCostEnergy    = 0,
  buildCostMetal     = 35,
  buildTime          = 7,
  canAttack          = true,
  canFly             = true,
  canGuard           = true,
  canLoopbackAttack  = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "VTOL",
  collide            = true,
--Collision Volumes... Because the engine devs are idiots.
	collisionVolumeScales = [[35 35 35]],
--End Collision volumes
  corpse             = "ammobox",
  cruiseAlt          = 400,
  description        = [[Fighter - Damagetype: Light :: Armortype: Light

Requires +5 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_UNIT",
  footprintX         = 3,
  footprintZ         = 2,
  floater            = true,
  iconType           = "air",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxAcc             = 0.25,
  maxDamage          = 160,
  maxSlope           = 10,
  maxVelocity        = 16,
  verticalSpeed		 = 15,
  maxWaterDepth      = 255,
  metalStorage       = 0,
  moverate1          = "8",
  name               = "(C)oyote",
  noChaseCategory    = "NOTAIR",
  objectName         = "efighter.s3o",
  radarDistance      = 0,
  selfDestructAs     = "SMALL_UNIT",
  side               = "ARM",
  sightDistance      = 750,
  smoothAnim         = true,
  sonarDistance      = 0,
  turnRate           = 50,
  TurnRadius         = 1000,
  unitname           = "efighter",
  workerTime         = 0,
  sfxtypes = {
    explosiongenerators = {
      "custom:gunshipcannon",
      "custom:jethtrail",
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
      def                = "antiairmissile",
	  onlyTargetCategory = "VTOL",
    },
  },
   customParams = {
	death_sounds = "soldier",
	twokhotkey = 'c',
    RequireTech = "5 Power",
	armortype   = "lightarmor",
	normaltex = "unittextures/efighternormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  antiairmissile = {
    accuracy           = 1,
    areaOfEffect       = 300,
    avoidFriendly      = false,
    avoidFeature       = false,
    ballistic          = true,
	cegTag             = "missiletrailflashy",
    collideFriendly    = false,
    collideFeature     = false,
    burnblow           = true,
	edgeEffectiveness  = 0.5,
    endsmoke           = "1",
    energypershot      = 0,
    explosionGenerator = "custom:BulletImpact3",
	energypershot      = 10,
    fireStarter        = 80,
    id                 = 1,
    impulseFactor      = 0,
	interceptedByShieldType = 4,
	model              = "missilesmall.s3o",
    name               = "AA Cannon",
    pitchtolerance     = "3000",
    range              = 1500,
    reloadtime         = 1,
    renderType         = 4,
    soundHit           = "mediumcannonhit.wav",
    soundStart         = "aircraft_missile_01.wav",
    startsmoke         = "1",
    tolerance          = 3000,
    turret             = false,
	toairweapon		   = true,
    weaponVelocity     = 2000,
	customparams = {
	  damagetype		= "explosive",  
    },
    damage = {
      default            = 150,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
