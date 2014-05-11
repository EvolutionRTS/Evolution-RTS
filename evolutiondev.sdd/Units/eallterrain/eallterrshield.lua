-- UNITDEF -- EALLTERRSHIELD --
--------------------------------------------------------------------------------

local unitName = "eallterrshield"

--------------------------------------------------------------------------------

local unitDef = {

--mobileunit 
  transportbyenemy   = false;

--**


  acceleration       = 1,
  brakeRate          = 1,
  buildCostEnergy    = 0,
  buildCostMetal     = 28,
  builder            = false,
  buildTime          = 5,
  canAttack          = false,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT NOTAIR RAID",
  corpse             = "ammobox",
  
-- Cloaking

	cancloak		 = true,
	cloakCost		 = 2,
	cloakCostMoving	 = 2,
	minCloakDistance = 75,
	decloakOnFire	 = false,
	decloakSpherical = true,
	initCloaked		 = true,
-- Starting out cloaked will dramatically increase the initial cost, however, it is much more convenient from a micromanagement standpoint.
-- End Cloaking
  
  description        = [[Shield Emitter
Light
Shield absorbs 500 damage
Shield can link with other shield units to increase charging and capacity

Requires +5 Power
+Uses +5 Supply]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "hugeExplosionGenericPurple",
  fireState			 = "0",
  footprintX         = 5,
  footprintZ         = 5,
  iconType           = "support",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 500,
  maxVelocity        = 3.5,
  maxReverseVelocity = 2,
  turninplacespeedlimit = 4,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "ALLTERRTANK5",
  moveState			 = "0",
  name               = "Widow",
  noChaseCategory    = "VTOL",
  objectName         = "eallterrshield.s3o",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "hugeExplosionGenericPurple",
  sightDistance      = 800,
  smoothAnim         = true,
  stealth			 = true,
  seismicSignature   = 5,
  turnInPlace        = true,
  turnRate           = 1000,
  unitname           = "eallterrshield",
  upright			 = false,
  workerTime         = 0,
    sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
		"custom:gdhcannon",
	    "custom:dirtsmall",
		"custom:blacksmoke",
    },
  },
  sounds = {
    underattack        = "unitsunderattack1",
    ok = {
      "ack",
    },
    select = {
      "unitselect",
    },
  },
  weapons = {
    [1]  = {
      def                = "allterrshield",
    },
  },
   customParams = {
    needed_cover = 3,
	death_sounds = "generic",
    RequireTech = "5 Power",
	armortype   = "light",
	nofriendlyfire	= "1",
	supply_cost = 5,
	normalstex = "unittextures/lego2skin_explorernormal.dds", 
	 buckettex = "unittextures/lego2skin_explorerbucket.dds",
	factionname	= "outer_colonies",  
  },
}


--------------------------------------------------------------------------------
local shield1PowerRegen = 5

local weaponDefs = {
  allterrshield = {
	IsShield         = true,
    Smartshield      = true,
    Exteriorshield   = true,
    Visibleshield    = true,
    Visibleshieldrepulse = true,
    ShieldStartingPower = 0,
    Shieldenergyuse  = 0,
    Shieldradius     = 300,
    Shieldpower      = 500,
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
