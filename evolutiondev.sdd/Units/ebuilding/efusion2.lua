-- UNITDEF -- EFUSION2 --
--------------------------------------------------------------------------------

local unitName = "efusion2"

--------------------------------------------------------------------------------

local unitDef = {

  activateWhenBuilt  = true,
  buildAngle         = 2500,
  buildCostEnergy    = 0,
  buildCostMetal     = 180,
  builder            = false,
  buildTime          = 10,
  canAttack			 = false,
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
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "(N)uclear Powerplant",
  objectName         = "efusion2.s3o",
  radarDistance      = 0,
  selfDestructAs     = "FUSIONPOP",
  side               = "ARM",
  sightDistance      = 367,
  smoothAnim         = true,
  unitname           = "efusion2",
  workerTime         = 0,
  yardMap            = "oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo",

  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:fusionfx",
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
    [2]  = {
      def                = "fusionfx2",
    },
  },
  customParams = {
    needed_cover = 5,
	death_sounds = "generic",
	twokhotkey = 'n',
    ProvideTech = "10 Power",
    ProvideTechRange = "800",
	armortype   = "eco",
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
	helptext = [[Nuclear Powerplant

Produces energy and power in an increased capacity and radius

+10 Energy

+10 Power

+1000 Power Radius]],
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=11,
	buildingGroundDecalSizeY=11,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[efusion2_aoplane.dds]],
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
    explosionGenerator = "custom:empty",
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
    explosionGenerator = "custom:empty",
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
