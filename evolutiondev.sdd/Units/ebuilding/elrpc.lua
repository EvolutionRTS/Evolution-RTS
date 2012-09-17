-- UNITDEF -- ELRPC --
--------------------------------------------------------------------------------

local unitName = "elrpc"

--------------------------------------------------------------------------------

local unitDef = {

  activateWhenBuilt  = true,
  buildCostEnergy    = 0,
  buildCostMetal     = 160,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  canstop            = "1",
  category           = "BUILDING NOTAIR",
  
   collisionVolumeOffsets = "0 0 0",
   collisionVolumeScales  = "120 310 120",
   collisionVolumeTest    = 1,
   collisionVolumeType    = "box",
  
  corpse             = "ammobox",
  description        = [[Long Range Plasma Cannon - 50e Per Shot

Requires +15 Power]],
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "LARGE_BUILDING",
  footprintX         = 8,
  footprintZ         = 8,
  iconType           = "elrpc",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 4800,
  maxSlope           = 30,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "Executioner (L)",
  noChaseCategory    = "VTOL",
  objectName         = "elrpc.s3o",
  onlytargetcategory2 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  selfDestructAs     = "LARGE_BUILDING",
  side               = "ARM",
  sightDistance      = 900,
  smoothAnim         = true,
  unitname           = "elrpc",
  workerTime         = 0,
  yardMap            = "oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo",
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:electricity",
      "custom:factorysparks",
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
      def                = "lrpcweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
  },
  customParams = {
	death_sounds = "generic",
	twokhotkey = 'l',
    RequireTech = "15 Power",
	armortype   = "building",
	normaltex = "unittextures/elrpcnormal.png", 
	helptext = [[Long Range Plasma Cannon

LRPC’s provide long range bombardment of defensive positions and base structures.

Damagetype: Explosive

Armortype: Building

+900 Line of Sight

+6000 Range

+200 Area of Effect

-100 Energy per Shot

10s Reload Time

Requires:

+15 Power]],
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=11,
	buildingGroundDecalSizeY=11,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[elrpc_aoplane.dds]],
}


--------------------------------------------------------------------------------

local weaponDefs = {
  lrpcweapon = {
    accuracy           = 500,
    AreaOfEffect       = 200,
    avoidFriendly      = false,
    cegTag             = "BURNGREEN",
    collideFriendly    = false,
    explosionGenerator = "custom:BLUE_EXPLOSION",
    fireStarter        = 70,
    guidance           = false,
    id                 = 136,
	impulsefactor	   = 0,
    interceptedByShieldType = 1,
    lineOfSight        = true,
    energypershot       = 100,
    model              = "rocket.s3o",
    name               = "Rockets",
    range              = 6000,
    reloadtime         = 10,
    weaponType		   = "Cannon",
    selfprop           = true,
    smokedelay         = ".1",
    smokeTrail         = false,
    soundHit           = "lrpchit.wav",
    soundStart         = "heavyplasmashot.wav",
    startsmoke         = "0",
    tolerance          = 8000,
    turnRate           = 4680,
    turret             = true,
    weaponTimer        = 5,
    weaponVelocity     = 800,
	customparams = {
	  damagetype		= "explosive",  
    },      
    damage = {
      default            = 250,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
