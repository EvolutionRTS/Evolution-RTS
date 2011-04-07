-- UNITDEF -- EAMPHIBROCK --
--------------------------------------------------------------------------------

local unitName = "eamphibrock"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 0.18,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 30,
  builder            = false,
  buildTime          = 6,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "AMPHIB SUPPORT",
  corpse             = "ammobox",
  description        = [[Missile support tank - Damagetype: Medium :: Armortype: Light
	• Switches to torpedos when underwater

Requires +7 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_UNIT",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "amphib",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 160,
  maxSlope           = 28,
  maxVelocity        = 3.4,
  maxReverseVelocity = 1,
  maxWaterDepth      = 5000,
  metalStorage       = 0,
  movementClass      = "TANK4",
  name               = "(S)pitter",
  noChaseCategory    = "VTOL",
  objectName         = "eamphibrock.s3o",
  onlytargetcategory2 = "VTOL",
  onlytargetcategory3 = "VTOL",
  onlytargetcategory4 = "VTOL",
  onlytargetcategory5 = "VTOL",
  onlytargetcategory6 = "VTOL",
  radarDistance      = 0,
  selfDestructAs     = "SMALL_UNIT",
  side               = "CORE",
  sightDistance      = 600,
  SonarDistance      = 300;
  stealth			 = true,
  sonarStealth		 = false,
  smoothAnim         = true,
  turnInPlace        = false,
  turnRate           = 430,
  unitname           = "eamphibrock",
  workerTime         = 0,
  sfxtypes = {
    explosiongenerators = {
      "custom:dirt",
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
      def                = "gunshipweapon",
      onlyTargetCategory = "NOTAIR",
    },
	[2]  = {
      def                = "TORP",
    },
  },
   customParams = {
	twokhotkey = 's',
    RequireTech = "7 Power",
	armortype   = "lightarmor",
	normaltex = "unittextures/eamphibrocknormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  gunshipweapon = {
    areaOfEffect       = 50,
    avoidFriendly      = false,
    cegTag             = "missiletrailsmall",
    collideFriendly    = false,
    explosionGenerator = "custom:BulletImpact3",
	energypershot      = 13,
    fireStarter        = 70,
    guidance           = false,
    id                 = 136,
    interceptedByShieldType = 4,
    lineOfSight        = true,
    metalpershot       = 0,
    model              = "missilesmallvlaunch.s3o",
    name               = "Rockets",
    range              = 650,
    reloadtime         = 2,
    renderType         = 1,
    selfprop           = true,
    smokedelay         = ".1",
    smokeTrail         = false,
    soundStart         = "rocket1.wav",
    soundHit           = "explode5.wav",
    startsmoke         = "0",
    startVelocity      = 250,
    tolerance          = 8000,
    turnRate           = 4680,
    turret             = true,
    weaponAcceleration = 131,
    weaponTimer        = 5,
    weaponVelocity     = 350,
	customparams = {
	  damagetype		= "medium",  
    },     
    damage = {
      default           = 130,
    },
  },
  
  TORP = {
	rendertype		= 1,
	lineofsight		= 1,
	turret			= 1,
    model              = "torpedo.s3o",
    energypershot      = 13,
	propeller		= 1,
	range			= 650,
	reloadtime		= 2,
	weapontimer		= 3,
	weaponvelocity	= 500,
	startvelocity	= 25,
	weaponacceleration	= 25,
	areaofeffect	= 50,
    soundHit           = "subhit.wav",
    soundStart         = "torpedolaunch.wav",
    explosionGenerator = "custom:dodaibomb",
	selfprop		= 1,
	waterweapon		= 1,
	burnblow		= 1,
	predictboost	= 0,
	impulsefactor	= 0,
	cratermult		= 0,
	craterboost		= 0,
	noselfdamage	= 1,
	avoidfriendly	= 0,
	collidefriendly	= 0,
	customparams = {
	  damagetype		= "medium",  
    }, 
    damage = {
      default            = 130,
    },
  },  
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
