-- UNITDEF -- EUWSOLAR2 --
--------------------------------------------------------------------------------

local unitName = "euwsolar2"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "missiletrailsmall",
  pieceTrailCEGRange = 1,
--End tags entered from Notepad++
  activateWhenBuilt  = true,
  buildAngle         = 2048,
  buildCostEnergy    = 0,
  buildCostMetal     = 20,
  builder            = false,
  buildTime          = 5,
  category           = "NOTAIR ECO",
  corpse             = "ammobox",
  damageModifier     = 0.33333,
  description        = [[Produces +1 Energy
Provides +1 Energy]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = -1,
  explodeAs          = "SMALL_BUILDING",
  footprintX         = 4,
  footprintZ         = 4,
  icontype           = "energy",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 150,
  maxSlope           = 60,
  minWaterDepth      = 20,
  maxWaterDepth      = 10000,
  metalStorage       = 0,
  name               = "Underwater Powerplant",
  objectName         = "esolar2.s3o",
  onoffable          = true,
  radarDistance      = 0,
  reclaimable		 = false,
  selfDestructAs     = "SMALL_BUILDING",
  side               = "CORE",
  sightDistance      = 367,
  smoothAnim         = true,
  unitname           = "euwsolar2",
  yardMap            = "oooooooooooooooo",
 -- useBuildingGroundDecal = true,
 -- BuildingGroundDecalType = "powergrounddecal.png",
 -- BuildingGroundDecalSizeX = 40,
 -- BuildingGroundDecalSizeY = 40,
 -- BuildingGroundDecalDecaySpeed = 0.9,
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
    ProvideTech = "Power",
    ProvideTechRange = "400",
	armortype   = "eco", 
	normaltex = "unittextures/esolar2normal.png", 
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=40,
	buildingGroundDecalSizeY=40,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[euwsolar2_aoplane.dds]],
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
