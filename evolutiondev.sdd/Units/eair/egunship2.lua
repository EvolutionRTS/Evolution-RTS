-- UNITDEF -- EGUNSHIP2 --
--------------------------------------------------------------------------------

local unitName = "egunship2"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 0.2,
  airStrafe          = true,
  bankscale          = "1",
  brakeRate          = 7,
  buildCostEnergy    = 0,
  buildCostMetal     = 120,
  buildTime          = 24,
  canAttack          = true,
  canDropFlare       = true,
  canFly             = true,
  canGuard           = true,
  canLoopbackAttack  = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT VTOL",
  collide            = true,
--Collision Volumes... Because the engine devs are idiots.
	collisionVolumeScales = [[35 35 35]],
--End Collision volumes
  corpse             = "ammobox",
  cruiseAlt          = 300,
  description        = [[Gunship Tank Destroyer
Light

Requires +7 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  flareDelay         = 0.1,
  flareDropVector    = "0 0 -1",
  flareefficieny     = "0.3",
  flareReload        = 3,
  floater            = true,
  footprintX         = 3,
  footprintZ         = 3,
  hoverAttack        = true,
  iconType           = "air",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 280,
  maxSlope           = 10,
  maxVelocity        = 14,
  verticalSpeed		 = 15,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  moverate1          = "8",
  name               = "(W)ildcat",
  noChaseCategory    = "VTOL",
  objectName         = "EGUNSHIP2.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 800,
  smoothAnim         = true,
  turnRate           = 920,
  unitname           = "egunship2",
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
      def                = "gunshipweapon",
      mainDir            = "0 0 1",
      maxAngleDif        = 45,
      OnlyTargetCategory = "NOTAIR AMPHIB",
      BadTargetCategory  = "VTOL",
      noChaseCategory    = "VTOL",
    },
    -- [2]  = {
      -- def                = "gunshipweapon",
      -- OnlyTargetCategory = "NOTAIR AMPHIB",
      -- BadTargetCategory  = "VTOL",
      -- noChaseCategory    = "VTOL",
      -- slaveTo            = 1,
    -- },
  },
   customParams = {
--    needed_cover = 2,
	death_sounds = "soldier",
	twokhotkey = 'w',
    RequireTech = "7 Power",
	armortype   = "light",
	normaltex = "unittextures/egunship2normal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  gunshipweapon = {
    badTargetCategory = [[BUILDING]],
    AreaOfEffect       = 75,
    avoidFriendly      = false,
    cegTag             = "missiletrailsmall",
    collideFriendly    = false,
    explosionGenerator = "custom:BulletImpact3",
	energypershot      = 6.5,
    fireStarter        = 70,
    guidance           = false,
    id                 = 136,
    impulseBoost       = 0,
    impulseFactor      = 0,
    interceptedByShieldType = 4,
    lineOfSight        = true,
    metalpershot       = 0,
    model              = "missilegunship.s3o",
    name               = "Rockets",
    range              = 520,
    reloadtime         = 1,
    weaponType		   = "Cannon",  -- This causes the missile trail to go off kilter
--	rendertype		   = 1,
    selfprop           = true,
    smokedelay         = ".1",
    smokeTrail         = false,
    soundHit           = "bombhit.wav",
	soundHitVolume	   = 10,
    soundStart         = "18395_inferno_rltx.wav",
	soundStartVolume   = 10,
    startsmoke         = "0",
    startVelocity      = 250,
    tolerance          = 8000,
    turnRate           = 4680,
    tracks             = true,
    weaponAcceleration = 131,
    weaponTimer        = 100,
    weaponVelocity     = 600,
	customparams = {
	  damagetype		= "gunship",  
    },      
    damage = {
      default           = 130,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
