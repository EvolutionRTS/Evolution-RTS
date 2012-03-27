-- UNITDEF -- EALLTERRSHIELD --
--------------------------------------------------------------------------------

local unitName = "eallterrshield"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 1,
  buildCostEnergy    = 0,
  buildCostMetal     = 80,
  builder            = false,
  buildTime          = 10,
  canAttack          = false,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR RAID",
  corpse             = "ammobox",
  
-- Cloaking

	cancloak		 = true,
	cloakCost		 = 2,
	cloakCostMoving	 = 2,
	minCloakDistance = 75,
	decloakOnFire	 = true,
	decloakSpherical = true,
	initCloaked		 = true,
-- Starting out cloaked will dramatically increase the initial cost, however, it is much more convenient form a micromanagement standpoint.
-- End Cloaking
  
  description        = [[Shield Emitter - Armortype: Light

Requires +10 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "HUGE_UNIT",
  fireState			 = "0",
  footprintX         = 5,
  footprintZ         = 5,
  iconType           = "allterr",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 250,
  maxVelocity        = 4,
  maxReverseVelocity = 2,
  turninplacespeedlimit = 4,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "ALLTERRTANK5",
  moveState			 = "0",
  name               = "(W)idow",
  noChaseCategory    = "VTOL",
  objectName         = "eallterrshield.s3o",
  radarDistance      = 0,
  selfDestructAs     = "HUGE_UNIT",
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
	death_sounds = "soldier",
	twokhotkey = 'w',
    RequireTech = "10 Power",
	armortype   = "lightarmor",
	normaltex = "unittextures/lego2skin_explorernormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  allterrshield = {
    IsShield         = true,
    Smartshield      = true,
    Exteriorshield   = true,
    Visibleshield    = true,
    Visibleshieldrepulse = true,
    ShieldStartingPower = 0,
    Shieldenergyuse  = 5,
    Shieldradius     = 300,
    Shieldpower      = 750,
    Shieldpowerregen = 10,
    Shieldpowerregenenergy = 5,
    Shieldintercepttype = 4,
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
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
