-- UNITDEF -- ESILO --
--------------------------------------------------------------------------------

local unitName = "esilo"

--------------------------------------------------------------------------------

local unitDef = {

  buildAngle         = 8192,
  buildCostEnergy    = 0,
  buildCostMetal     = 250,
  builder            = false,
  buildTime          = 10,
  canAttack          = true,
  canstop            = "1",
  category           = "NOTAIR",
  corpse             = "ammobox",
  description        = [[Nuclear Missile Silo - Missile takes 4 minutes to build - Drains 50e while building

Requires +20 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "nukemissile",
  footprintX         = 8,
  footprintZ         = 8,
  iconType           = "silo",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 10000,
  maxSlope           = 30,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "Eradicator (I)",
  objectName         = "ESILO.s3o",
  onlytargetcategory2 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
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
	death_sounds = "nuke",
	twokhotkey = 'i',
    RequireTech = "20 Power",
	armortype   = "building", 
	normaltex = "unittextures/esilonormal.png", 
	helptext = [[Nuclear Missile Silo

Will completely devastate a large area

+50000 Damage

+2000 Area of Effect

-50 Energy (While missile is building)

10s Reload Time

Requires:

+20 Power]],
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=11,
	buildingGroundDecalSizeY=11,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[esilo_aoplane.dds]],
}


--------------------------------------------------------------------------------

local weaponDefs = {
  nukemissile = {
    areaOfEffect       = 2000,
    avoidFriendly      = false,
    cegTag             = "missiletrailnuke",
    collideFriendly    = false,
    commandfire        = true,
    craterBoost        = 0,
    craterMult         = 0,
    energypershot      = 12000,
    explosionGenerator = "custom:NUKE2",
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
    reloadtime         = 10,
    renderType         = 1,
    selfprop           = true,
    smokedelay         = "0.1",
    smokeTrail         = false,
    soundHit           = "explosion_enormous.wav",
    soundStart         = "lrpcshot.wav",
    startsmoke         = "0",
    stockpile          = true,
    stockpileTime      = 240,
    startVelocity      = 500,
    tracks             = true,
    turnRate           = 30000,
    vlaunch            = true,
    weaponAcceleration = 0,
    weaponTimer        = 10,
    weaponType         = "StarburstLauncher",
    weaponVelocity     = 500,
	customparams = {
	  damagetype		= "explosive",  
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
