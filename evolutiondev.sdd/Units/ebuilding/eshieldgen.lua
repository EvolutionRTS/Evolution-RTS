-- UNITDEF -- ESHIELDGEN --
--------------------------------------------------------------------------------

local unitName = "eshieldgen"

--------------------------------------------------------------------------------

local unitDef = {
  buildAngle         = 8192,
  buildCostEnergy    = 0,
  buildCostMetal     = 250,
  builder            = false,
  buildTime          = 5,
  canAttack          = false,
  canstop            = "1",
  category           = "BUILDING NOTAIR",
  corpse             = "ammobox",
  description        = [[Anti-Nuke Platform
Anti-Artillery base shield Facility

Drains -50 Energy while stockpiling Anti-Nuke Ammunition
Drains -2.5 Energy while charging shield

Shield recharges at a rate of 50hp/s
Maximum shield power is 5000hp]],
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
  name               = "Protector",
  objectName         = "eshieldgen.s3o",
  onlytargetcategory2 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  repairable		 = false,
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
      def                = "nukeinterceptor",
    },
    [2]  = {
      def                = "shield",
    },
  },
  customParams = {
    needed_cover = 5,
	death_sounds = "generic",
    ProvideTechRange = "300",
	armortype   = "building", 
	normalstex = "unittextures/eshieldgennormal.png", 
	helptext = [[Anti-Nuke Platform / Anti-Artillery base shield Facility]],
  },
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "factorygroundplate.dds",
  BuildingGroundDecalSizeX = 7,
  BuildingGroundDecalSizeY = 7,
  BuildingGroundDecalDecaySpeed = 0.9,
}


--------------------------------------------------------------------------------
local weapon1Damage = 100000
local shield1PowerRegen = 50

local weaponDefs = {
  nukeinterceptor = {
    AreaOfEffect       = 8,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 5,
    collideFeature     = false,
    collideFriendly    = false,
	coverage			= 2500,
    rgbColor           = "0 0 0.5",
    rgbColor2          = "0.5 0.5 0.5",
    coreThickness      = 0.5,
    duration           = 0.4,
    explosionGenerator = "custom:genericshellexplosion-large-blue",
	energypershot      = weapon1Damage / 20,
    fallOffRate        = 0.1,
    fireStarter        = 50,
	interceptor			= 1,
	interceptSolo		= true,
    largeBeamLaser     = true,
	laserflaresize 	   = 5,
    lineOfSight        = true,
	minintensity       = 1,
    name               = "Laser",
    range              = 2500,
    reloadtime         = 5,
    WeaponType         = "BeamLaser",
    soundStart         = "antinukelaser.wav",
    soundTrigger       = true,
	stockpile			= true,
	stockpiletime		= 100,
    texture1           = "lightning",
    texture2           = "laserend",
    thickness          = 20,
    tolerance          = 500,
    turret             = true,
    weaponVelocity     = 1500,
	waterweapon		   = true,
    damage = {
      default           = weapon1Damage,
    },
  },
  
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
    Shieldpowerregen = shield1PowerRegen,
    Shieldpowerregenenergy = shield1PowerRegen / 20,
    Shieldintercepttype = 4,
    Shieldgoodcolor  = "0.0 0.2 1.0",
    Shieldbadcolor   = "1.0 0 0",
    Shieldalpha      = 0.3,
    ShieldRepulsor   = false,
	texture1		 = "shield4",
    visibleShieldHit = true,
    visibleShieldHitFrames = 50,
    weaponType       = [[Shield]],
    damage = {
      default            = 1,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
