-- UNITDEF -- EKMAR --
--------------------------------------------------------------------------------

local unitName = "ekmar"

--------------------------------------------------------------------------------

local unitDef = {
  activateWhenBuilt  = true,
  buildAngle         = 4096,
  buildCostEnergy    = 0,
  buildCostMetal     = 60,
  builder            = false,
  buildTime          = 1,
  canAttack          = false,
  canstop            = "1",
  category           = "BUILDING NOTAIR WALL",
  damageModifier     = 0.2,
  description        = [[Protective Turret Shield
  
  Shield recharges at a rate of 20hp/s
  Maximum shield power is 500hp]],
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "ESTOR_BUILDING",
  footprintX         = 3,
  footprintZ         = 3,
  iconType           = "barricade",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 250,
  maxSlope           = 60,
  maxWaterDepth      = 0,
  mass				 = 1000,
  metalStorage       = 0,
  name               = "Kmar",
  objectName         = "ebarricade3.s3o",
  script			 = "ebarricade3.cob",
  repairable		 = false,
  selfDestructAs     = "ESTOR_BUILDING",
  selfDestructCountdown = 0,
  side               = "ARM",
  sightDistance      = 0,
  smoothAnim         = true,
  TEDClass           = "FORT",
  unitname           = "ekmar",
  workerTime         = 0,
  yardMap            = "ooo ooo ooo",
  
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
  },
  
  customParams = {
    needed_cover = 1,
	death_sounds = "generic",
	armortype   = "building",
	normaltex = "unittextures/lego2skin_explorernormal.png", 
	helptext = [[]],
  },
	-- buildingGroundDecalDecaySpeed=30,
	-- buildingGroundDecalSizeX=5,
	-- buildingGroundDecalSizeY=5,
	-- useBuildingGroundDecal = true,
	-- buildingGroundDecalType=[[ebarricade_aoplane.dds]],
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
    Shieldradius     = 200,
    Shieldpower      = 1000,
    Shieldpowerregen = 20,
    Shieldpowerregenenergy = 2,
    Shieldintercepttype = 4,
    Shieldgoodcolor  = "0.2 0.2 0.5",
    Shieldbadcolor   = "0.1 0 0",
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
