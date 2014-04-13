-- UNITDEF -- EHEAVYTURRET2 --
--------------------------------------------------------------------------------

local unitName = "eheavyturret2"

--------------------------------------------------------------------------------

local unitDef = {

  buildAngle         = 8192,
  buildCostEnergy    = 0,
  buildCostMetal     = 90,
  builder            = false,
  buildTime          = 5,
   collisionVolumeOffsets = "0 0 0",
   collisionVolumeScales  = "80 115 80",
   collisionVolumeTest    = 1,
   collisionVolumeType    = "box",
  canAttack          = true,
  canstop            = "1",
  category           = "BUILDING NOTAIR",
  corpse             = "ammobox",
  description        = [[Heavy Plasma Battery (Anti-Armor)

Building
300 Damage vs Armored
125 Damage vs Light
30 Damage vs Buildings

Uses +2 Supply]],
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "MEDIUM_BUILDING",
  footprintX         = 6,
  footprintZ         = 6,
  idleAutoHeal       = .5,
  idleTime           = 2200,
  iconType           = "defense",
  maxDamage          = 1250,
  maxSlope           = 60,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "Immolator",
  objectName         = "eheavyturret3.s3o",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "MEDIUM_BUILDING",
  side               = "CORE",
  sightDistance      = 1000,
  smoothAnim         = true,
  unitname           = "eheavyturret2",
  workerTime         = 0,
  yardMap            = "oooooo oooooo oooooo oooooo oooooo oooooo",

  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:gdhcannon",
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
      def                = "eheavyturretweapon2",
	  badTargetCategory  = "LIGHT VTOL",
      onlyTargetCategory = "ARMORED LIGHT",
    },
  },
  customParams = {
    needed_cover = 5,
	supply_cost = 2,
	death_sounds = "generic",
	armortype   = "building", 
	normalstex = "unittextures/lego2skin_explorernormal.dds", 
	 buckettex = "unittextures/lego2skin_explorerbucket.dds",
	factionname	= "outer_colonies",  
	helptext = [[]],
  },
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "factorygroundplate.dds",
  BuildingGroundDecalSizeX = 8,
  BuildingGroundDecalSizeY = 8,
  BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------

local weaponDefs = {
  eheavyturretweapon2 = {
    badTargetCategory = [[BUILDING LIGHT]],
    AreaOfEffect       = 50,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.6,
--	cegTag             = "mediumcannonweapon3",
    duration           = 0.4,
    energypershot      = 30,
    explosionGenerator = "custom:genericshellexplosion-medium",
    fallOffRate        = 1,
    fireStarter        = 100,
	impulseFactor      = 0,
	interceptedByShieldType = 4,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    range              = 1000,
    reloadtime         = 1,
    WeaponType         = "LaserCannon",
    rgbColor           = "1 0.5 0",
    rgbColor2          = "1 1 1",
    soundTrigger       = true,
    soundstart         = "heavyturretshot.wav",
    soundHit           = "explode5.wav",
    texture1           = "shot",
    texture2           = "empty",
    thickness          = 9,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 750,
	customparams = {
	  damagetype		= "eheavyturret2",  
    }, 
    damage = {
      default           = 300,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
