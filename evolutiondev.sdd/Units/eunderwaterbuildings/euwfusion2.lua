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
  buildCostMetal     = 360,
  builder            = false,
  buildTime          = 10,
  category           = "BUILDING NOTAIR ECO",
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
  maxDamage          = 3200,
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
	armortype   = "BUILDING",
	normaltex = "unittextures/efusion2normal.png", 
	normaltex = "unittextures/lego2skin_explorernormal.png", 
	groundtexselectimg = ":nc:bitmaps/power/power.png",
	groundtexselectimg1 = ":nc:bitmaps/power/power1.png",
	groundtexselectimg2 = ":nc:bitmaps/power/power2.png",
	groundtexselectimg3 = ":nc:bitmaps/power/power3.png",
	groundtexselectimg4 = ":nc:bitmaps/power/power4.png",
	groundtexselectimg5 = ":nc:bitmaps/power/power5.png",
	groundtexselectimg6 = ":nc:bitmaps/power/power6.png",
    groundtexselectxsize = 800, -- optional
    groundtexselectzsize = 800, -- optional
  },
	-- buildingGroundDecalDecaySpeed=30,
	-- buildingGroundDecalSizeX=50,
	-- buildingGroundDecalSizeY=50,
	-- useBuildingGroundDecal = true,
	-- buildingGroundDecalType=[[euwfusion2_aoplane.dds]],
}

--------------------------------------------------------------------------------

local weaponDefs = {
  fusionfx = {

    AreaOfEffect       = 5,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    rgbColor           = "0 0 1",
    rgbColor2          = "0.5 0.5 0.5",
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
