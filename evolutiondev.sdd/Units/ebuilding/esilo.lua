-- UNITDEF -- ESILO --
--------------------------------------------------------------------------------

local unitName = "esilo"

--------------------------------------------------------------------------------

local unitDef = {

  buildAngle         = 8192,
  buildCostEnergy    = 0,
  buildCostMetal     = 1000,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  canstop            = "1",
  category           = "BUILDING NOTAIR",
  corpse             = "ammobox",
  description        = [[Nuclear Missile Silo - Missile takes 4 minutes to build - Drains 50e while building]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "nukemissile",
  footprintX         = 8,
  footprintZ         = 8,
  iconType           = "esilo",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 20000,
  maxSlope           = 30,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "Eradicator",
  objectName         = "ESILO.s3o",
  onlytargetcategory2 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "nukemissile",
  side               = "ARM",
  sightDistance      = 600,
  smoothAnim         = true,
  unitlimit          = "2",
  unitname           = "esilo",
  workerTime         = 0,
  yardMap            = "oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo",

    sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
	  "custom:needspower",
	  "custom:blacksmoke",
    },
  },
  
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "turretselect",
    },
  },
  weapons = {
    [1]  = {
      def                = "nukemissile",
      onlyTargetCategory = "NOTAIR",
    },
  },
  customParams = {
    needed_cover = 8,
	RequireTech = "0 Power",
	death_sounds = "nuke",
	armortype   = "building",
	normalstex = "unittextures/esilonormal.png", 
	helptext = [[Nuclear Missile Silo

Will completely devastate a large area

+50000 Damage

+2000 Area of Effect

-50 Energy (While missile is building)

10s Reload Time]],
  },
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "factorygroundplate.dds",
  BuildingGroundDecalSizeX = 10,
  BuildingGroundDecalSizeY = 10,
  BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------

local weaponDefs = {
  nukemissile = {
    AreaOfEffect       = 2000,
    avoidFriendly      = false,
    cegTag             = "NUKETRAIL",
    collideFriendly    = false,
    commandfire        = true,
    craterBoost        = 0,
    craterMult         = 0,
    energypershot      = 12000,
    explosionGenerator = "custom:NUKEDATBEWM",
    fireStarter        = 100,
    flightTime         = 400,
    guidance           = true,
    id                 = 124,
    impulseBoost       = 0,
    impulseFactor      = 0,
    interceptedByShieldType = 2,
    lineOfSight        = true,
    metalpershot       = 0,
    model              = "enuke.s3o",
    name               = "Nuke",
    range              = 32000,
    reloadtime         = 15,
    weaponType		   = "MissileLauncher",
    selfprop           = true,
    smokedelay         = "0.1",
    smokeTrail         = false,
    soundHit           = "explosion_enormous.wav",
    soundStart         = "nukelaunch.wav",
    startsmoke         = "0",
    stockpile          = true,
    stockpileTime      = 240,
    startVelocity      = 500,
    tracks             = true,
    turnRate           = 30000,
	targetable			= 1,
    vlaunch            = true,
    weaponAcceleration = 0,
    weaponTimer        = 10,
    weaponType         = "StarburstLauncher",
    weaponVelocity     = 500,
	customparams = {
	  damagetype		= "default",  
	  death_sounds 		= "nuke",
    },      
    damage = {
      default            = 50000,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
