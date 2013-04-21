-- UNITDEF -- ERIOTTANK2 --
--------------------------------------------------------------------------------

local unitName = "eriottank2"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 25,
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
  category           = "ARMORED NOTAIR RIOT",
  corpse             = "ammobox",
  description        = [[Anti-Swarm Paralyzer Tank
Armored
200 Damage vs Light
100 Damage vs Armored/Building

• Paralyzes enemy units
• Projectile can hit multiple units

Requires +3 Power]],
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
  sightDistance      = 500,
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
      "custom:factorysparks",
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
      def                = "riottankempweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
	  badTargetCategory  = "WALL",
    },
  },
  customParams = {
    needed_cover = 2,
	death_sounds = "soldier",
	twokhotkey = 's',
    RequireTech = "3 Power",
	armortype   = "armored",
	nofriendlyfire	= "1",
	normaltex = "unittextures/eriottank2normal.png", 
	helptext	= [[The Spas is a unit designed to take on large amounts of raiders and pound them all to dust. Features 10 concussion shells in a burst that will knock back opposing units. It has Light armor, and should be paired with escorts if possible.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  riottankempweapon = {
    badTargetCategory = [[ARMORED BUILDING]],
    AreaOfEffect       = 100,
    avoidFeature       = false,
    avoidFriendly      = false,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.6,
--	cegTag             = "mediumcannonweapon3",
    duration           = 0.05,
    energypershot      = 10,
    explosionGenerator = "custom:fusionfx",
    fallOffRate        = 1,
    fireStarter        = 100,
	impulseFactor      = 0,
    lineOfSight        = true,
    minintensity       = 1,
    name               = "Laser",
	noexplode		   = true,
	paralyzer		   = true,
	paralyzetime	   = 2.5,
    range              = 500,
    reloadtime         = 1,
    WeaponType         = "LaserCannon",
    rgbColor           = "0 0.2 1",
    rgbColor2          = "1 1 1",
    soundTrigger       = true,
    soundstart         = "fnubeamfire.wav",
    soundHit           = "phasegun1hit.wav",
    texture1           = "wave",
    texture2           = "empty",
    thickness          = 40,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 1000,
	customparams = {
	  damagetype		= "eriottank2",  
	  nofriendlyfire	= 1,
    }, 
    damage = {
      default           = 200,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
