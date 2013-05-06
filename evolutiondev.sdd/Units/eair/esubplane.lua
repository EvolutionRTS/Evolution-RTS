-- UNITDEF -- ESUBPLANE --
--------------------------------------------------------------------------------

local unitName = "esubplane"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 0.2,
  airStrafe          = true,
  brakeRate          = 7,
  buildCostEnergy    = 0,
  buildCostMetal     = 50,
  buildTime          = 2.5,
  canAttack          = true,
  canDropFlare       = false,
  canFly             = true,
  canGuard           = true,
  canLoopbackAttack  = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = true,
  category           = "LIGHT VTOL",
  collide            = true,
--Collision Volumes... Because the engine devs are silly.
	collisionVolumeScales = [[35 35 35]],
--End Collision volumes
  corpse             = "ammobox",
  cruiseAlt          = 350,
  description        = "Stealth Sonar Plane - Can morph into a submarine",
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
  maxVelocity        = 18,
  verticalSpeed		 = 15,
  maxWaterDepth      = 6000,
   amphibious         = true,
   canSubmerge        = true,
  metalStorage       = 0,
  name               = "SeaGull",
  noChaseCategory    = "VTOL",
  objectName         = "esubplane.s3o",
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "BIG_UNIT",
  sightDistance      = 800,
  sonardistance      = 1000,
  smoothAnim         = true,
  stealth            = false,
  turnRate           = 920,
  unitname           = "esubplane",
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
      def                = "esubplanetorpedo",
      OnlyTargetCategory = "BUILDING AMPHIB",
      noChaseCategory    = "VTOL",
    },
  },
  
   customParams = {
--    needed_cover = 2,
	death_sounds = "soldier",
	twokhotkey = 't',
	nofriendlyfire = "1",
    RequireTech = "10 Power",
	armortype   = "armored",
	normaltex = "unittextures/esubplanenormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  esubplanetorpedo = {
    AreaOfEffect       = 10,
    avoidFriendly      = false,
    avoidFeature       = false,
	canattackground	   = false,
	cegTag             = "torpedotrailuwturret",
    collideFriendly    = false,
    collideFeature     = false,
	cylinderTargeting  = true,
    explosionGenerator = "custom:torpedoexplosion",
	energypershot      = 12,
    fireStarter        = 80,
    impulseFactor      = 0.1,
	interceptedByShieldType = 4,
	model              = "missilesmall.s3o",
    name               = "Underwater Torpedo",
    pitchtolerance     = 3000,
    range              = 1000,
    reloadtime         = 1,
    weaponType		   = "TorpedoLauncher",
    soundHit           = "torpedolaunch.wav",
    soundStart         = "18393_inferno_reject.wav",
    tolerance          = 3000,
    turret             = true,
	startVelocity	   = 200,
	acceleration	   = 2000,
    weaponVelocity     = 10000,
	tracks				= true,
	turnrate			= 100000,
	flighttime			= 4,
	sprayangle			= 5000,
	waterweapon		   = true,
	
	customparams = {
	  damagetype		= "euwturret",  
    },
    damage = {
      default            = 120,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
