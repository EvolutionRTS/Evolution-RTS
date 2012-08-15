-- UNITDEF -- ESHIELDGEN --
--------------------------------------------------------------------------------

local unitName = "eshieldgen"

--------------------------------------------------------------------------------

local unitDef = {
  buildAngle         = 8192,
  buildCostEnergy    = 0,
  buildCostMetal     = 230,
  builder            = false,
  buildTime          = 2.5,
  canAttack          = false,
  canstop            = "1",
  category           = "BUILDING NOTAIR",
  corpse             = "ammobox",
  description        = [[Shield Generator - Anti-Nuke/Anti-LRPC Facility

Requires +10 Power
Must be connected to a powergrid]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "MEDIUM_BUILDING",
  footprintX         = 5,
  footprintZ         = 5,
  iconType           = "defense",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 4000,
  maxSlope           = 30,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "(P)rotector",
  objectName         = "eshieldgen.s3o",
  onlytargetcategory2 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  selfDestructAs     = "MEDIUM_BUILDING",
  side               = "ARM",
  sightDistance      = 600,
  smoothAnim         = true,
  unitlimit          = "2",
  unitname           = "eshieldgen",
  workerTime         = 0,
  yardMap            = "ooooo ooooo ooooo ooooo ooooo",
  
sfxtypes = {
	pieceExplosionGenerators = {
		"deathceg0",
		"deathceg1",
	},
	
	explosiongenerators = {
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
      def                = "shield",
    },
    [2]  = {
      def                = "invisiblenukeshield",
    },
    [3]  = {
      def                = "FX",
    },
  },
  customParams = {
    needed_cover = 5,
	death_sounds = "generic",
	twokhotkey = 'p',
    RequireTech = "10 Power, 1 Powergrid",
    ProvideTechRange = "300",
	armortype   = "building", 
	normaltex = "unittextures/eshieldgennormal.png", 
	helptext = [[Anti-Lrpc/Nuclear Shield Generator

Will protect from Nuclear missile strikes and Long Range Plasma Cannons

LRPC Shield:

+1500 Shield Range

+5000 Shield Hitpoints

-10 Energy (While shield is charging)

Nuclear Missile Shield:

+3000 Shield Range

+50000 Shield Hitpoints

-20 Energy (While shield is charging)

Requires:

+10 Power]],
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=8,
	buildingGroundDecalSizeY=8,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[eshieldgen_aoplane.dds]],
}


--------------------------------------------------------------------------------

local weaponDefs = {
  shield = {
    IsShield         = true,
    Smartshield      = true,
    Exteriorshield   = true,
    Visibleshield    = true,
    Visibleshieldrepulse = true,
    ShieldStartingPower = 0,
    Shieldenergyuse  = 0,
    Shieldradius     = 1500,
    Shieldpower      = 5000,
    Shieldpowerregen = 15,
    Shieldpowerregenenergy = 10,
    Shieldintercepttype = 1,
    Shieldgoodcolor  = "0.2 0.2 0.5",
    Shieldbadcolor   = "1 1 1",
    Shieldalpha      = 0.3,
    ShieldRepulsor   = false,
    visibleShieldHit = true,
    visibleShieldHitFrames = 50,
    weaponType       = [[Shield]],
    damage = {
      default            = 1,
    },
  },
  invisiblenukeshield = {
    IsShield         = true,
    Smartshield      = true,
    Exteriorshield   = true,
    Visibleshield    = true,
    Visibleshieldrepulse = true,
    ShieldStartingPower = 0,
    Shieldenergyuse  = 0,
    Shieldradius     = 3000,
    Shieldpower      = 50001,
    Shieldpowerregen = 50001/230,
    Shieldpowerregenenergy = 20,
    Shieldintercepttype = 2,
    Shieldgoodcolor  = "1 1 1",
    Shieldbadcolor   = "0 0 0",
    Shieldalpha      = 0.1,
    ShieldRepulsor   = false,
    visibleShieldHit = true,
    visibleShieldHitFrames = 10,
    weaponType       = [[Shield]],
    damage = {
      default            = 1,
    },
  },
  FX = {
    AreaOfEffect       = 0,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamlaser          = 1,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.1,
    duration           = 10,
    energypershot      = 0,
    explosionGenerator = "custom:empty",
    fallOffRate        = 0.1,
    fireStarter        = 90,
    guidance           = true,
    id                 = 666,
    impluse            = "0",
    interceptor        = true,
    largeBeamLaser     = true,
    lineOfSight        = true,
    name               = "Laser Battery",
    range              = 0,
    reloadtime         = 300,
    WeaponType         = "BeamLaser",
    rgbColor           = "0 0 1",
    rgbColor2          = "1 0.5 0",
    sweep              = "1",
    sweepfire          = true,
    targetMoveError    = 0,
    texture            = "fireyexplo",
    thickness          = 5,
    tolerance          = 8000,
    turret             = true,
    weaponVelocity     = 1000,
    damage = {
      default            = -1,
    },
  },
  nukekiller = {
    AreaOfEffect       = 0,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamlaser          = 1,
    beamTime           = 3,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.1,
    duration           = 10,
    energypershot      = 0,
    explosionGenerator = "custom:empty",
    fallOffRate        = 0.1,
    fireStarter        = 90,
    guidance           = true,
    id                 = 666,
    impluse            = "0",
    interceptor        = true,
    largeBeamLaser     = true,
    lineOfSight        = true,
    name               = "Laser Battery",
    range              = 1,
    reloadtime         = 300,
    WeaponType         = "BeamLaser",
    rgbColor           = "0 0 1",
    rgbColor2          = "1 0.5 0",
    sweep              = "1",
    sweepfire          = true,
    targetMoveError    = 0,
    texture            = "fireyexplo",
    thickness          = 30,
    tolerance          = 8000,
    turret             = true,
    weaponVelocity     = 1000,
    damage = {
      default            = 100,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
