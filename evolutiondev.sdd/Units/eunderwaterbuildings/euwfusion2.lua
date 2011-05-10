-- UNITDEF -- EUWFUSION2 --
--------------------------------------------------------------------------------

local unitName = "euwfusion2"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  activateWhenBuilt  = true,
  buildAngle         = 2500,
  buildCostEnergy    = 0,
  buildCostMetal     = 180,
  builder            = false,
  buildTime          = 10,
  category           = "NOTAIR ECO",
  corpse             = "ammobox",
  description        = [[Produces +10 Energy
Provides +10 Power]],
  energyMake         = 10,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "FUSIONPOP",
  footprintX         = 8,
  footprintZ         = 8,
  iconType           = "energy",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 1600,
  maxSlope           = 60,
  minWaterDepth      = 50,
  maxWaterDepth      = 10000,
  metalStorage       = 0,
  name               = "Underwater Nuclear Powerplant",
  objectName         = "efusion.s3o",
  radarDistance      = 0,
  reclaimable		 = false,
  selfDestructAs     = "FUSIONPOP",
  sightDistance      = 367,
  smoothAnim         = true,
  unitname           = "euwfusion2",
  workerTime         = 0,
  yardMap            = "oooooooooooooooooooo",
--  useBuildingGroundDecal = true,
--  BuildingGroundDecalType = "powergrounddecal.png",
--  BuildingGroundDecalSizeX = 50,
--  BuildingGroundDecalSizeY = 50,
--  BuildingGroundDecalDecaySpeed = 0.9,
  sfxtypes = {
    explosiongenerators = {
      "custom:bubbles",
    },
  },
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdenergy",
    },
  },
  weapons = {
    [1]  = {
      def                = "fusionfx",
    },
  },
  customParams = {
  	death_sounds = "generic",
    ProvideTech = "10 Power",
    ProvideTechRange = "800",
	armortype   = "eco",
	normaltex = "unittextures/efusion2normal.png", 
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=50,
	buildingGroundDecalSizeY=50,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[euwfusion2_aoplane.dds]],
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
    rgbColor           = "0.5 0.5 0.5",
    rgbColor2          = "0.2 0.2 0.8",
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
}
unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
