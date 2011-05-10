-- UNITDEF -- EMAKER --
--------------------------------------------------------------------------------

local unitName = "emaker"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  activateWhenBuilt  = true,
  buildAngle         = 8192,
  buildCostEnergy    = 0,
  buildCostMetal     = 100,
  builder            = false,
  buildTime          = 10,
  canAttack			 = false,
  category           = "NOTAIR",
  corpse             = "ammobox",
  damageModifier     = 0.5,
  description        = [[Converts Energy into Metal

Requires +20 Power]],
  energyStorage      = 0,
  energyUse          = 20,
  explodeAs          = "LARGE_BUILDING",
  footprintX         = 8,
  footprintZ         = 8,
  iconType           = "eco",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  makesMetal         = 1,
  maxDamage          = 50,
  maxSlope           = 30,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "Metal Maker (O)",
  objectName         = "emaker.s3o",
  onoffable          = true,
  radarDistance      = 0,
  selfDestructAs     = "LARGE_BUILDING",
  side               = "ARM",
  sightDistance      = 360,
  smoothAnim         = true,
  unitname           = "emaker",
  workerTime         = 0,
  yardMap            = "ooooooooo",
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdmex",
    },
  },
  weapons = {
    [1]  = {
      def                = "fusionfx",
    },
    [2]  = {
      def                = "fusionfx2",
    },
  },
  customParams = {
	death_sounds = "generic",
	twokhotkey = 'o',
    RequireTech = "20 Power",
	armortype   = "eco",
	normaltex = "unittextures/emakernormal.png", 
	helptext = [[Metal Maker

Creates metal from stored energy. Requires +20 energy per +1 metal generated

+1 Metal

-20 Energy]],
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=11,
	buildingGroundDecalSizeY=11,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[emaker_aoplane.dds]],
}


--------------------------------------------------------------------------------

local weaponDefs = {
  fusionfx = {

    areaOfEffect       = 5,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    color              = 255,
    color2             = 226,
    coreThickness      = 0.1,
    craterBoost        = 0,
    craterMult         = 0,
    explosionGenerator = "custom:burn",
    fallOffRate        = 0.5,
    minintensity       = 1,
    impulseFactor      = 0,
    largeBeamLaser     = true,
    lineOfSight        = true,
    name               = "Light Laser",
    noSelfDamage       = true,
    range              = 650,
    reloadtime         = 0.1,
    WeaponType         = "BeamLaser",
    selfprop           = true,
    soundTrigger       = true,
    startVelocity      = 1500,
    targetMoveError    = 0.3,
    thickness          = 1,
    turret             = true,
    weaponVelocity     = 1500,
    damage = {
      default            = 0,
    },
  },
    fusionfx2 = {
    areaOfEffect       = 8,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.5,
    duration           = 0.9,
    energypershot      = 0,
    explosionGenerator = "custom:burn",
    fallOffRate        = 0.5,
    fireStarter        = 50,
    
    largeBeamLaser     = true,
    lineOfSight        = true,
    name               = "Laser",
    range              = 500,
    reloadtime         = 1,
    WeaponType         = "LaserCannon",
    rgbColor           = "0.5 0 0",
    rgbColor2          = "0.2 0.2 0.2",
    soundTrigger       = true,
    sweep              = "1",
    sweepfire          = true,
    targetMoveError    = 0.3,
    texture1           = "plasmaball",
    texture2           = "empty",
    thickness          = 2,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 300,
    damage = {
      default            = 0,
    },
  },
}
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
