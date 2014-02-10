-- UNITDEF -- EFIGHTER --
--------------------------------------------------------------------------------

local unitName = "efighter"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 0.5,
  airStrafe          = true,
  bankscale          = "1",
  brakeRate          = 0.5,
  buildCostEnergy    = 0,
  buildCostMetal     = 30,
  buildTime          = 2.5,
  canAttack          = true,
  canFly             = true,
  canGuard           = true,
  canLoopbackAttack  = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT VTOL",
  collide            = true,
  corpse             = "ammobox",
  cruiseAlt          = 400,
  description        = [[Fighter
Light
300 Damage vs Light/Armored/s
75 Damage vs Building/s
 
Requires +3 Power
Uses +3 Supply]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "SMALL_UNIT",
  footprintX         = 5,
  footprintZ         = 5,
  hoverAttack        = true,
  floater            = true,
  iconType           = "aa",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxAcc             = 0.25,
  maxBank			 = 5,
  maxDamage          = 450,
  maxSlope           = 10,
  maxVelocity        = 16,
  verticalSpeed		 = 15,
  maxWaterDepth      = 255,
  metalStorage       = 0,
  moverate1          = "8",
  name               = "Coyote",
  noChaseCategory    = "NOTAIR",
  objectName         = "efighter2.s3o",
  script			 = "efighter2.cob",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "SMALL_UNIT",
  side               = "ARM",
  sightDistance      = 1500,
  smoothAnim         = true,
  sonarDistance      = 0,
  turnRate           = 1500,
  unitname           = "efighter",
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:gdhcannon",
      "custom:jethtrail",
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
      def                = "antiaircannon",
	  onlyTargetCategory = "VTOL",
    },
  },
   customParams = {
--    needed_cover = 2,
	death_sounds = "soldier",
    RequireTech = "3 Power",
	armortype   = "light",
	nofriendlyfire	= "1",
	supply_cost = 3,
	normaltex = "unittextures/lego2skin_explorernormal.dds", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  antiaircannon = {
    AreaOfEffect       = 25,
    avoidFeature       = false,
    avoidFriendly      = false,
    collideFeature     = false,
    collideFriendly    = false,
	canAttackGround    = false,
    coreThickness      = 0.4,
	burnblow		   = true,
--	cegTag             = "mediumcannonweapon3",
    duration           = 0.05,
    energypershot      = 1,
    explosionGenerator = "custom:genericshellexplosion-small",
    fallOffRate        = 1,
    fireStarter        = 50,
	impulseFactor      = 0,
	interceptedByShieldType = 4,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    range              = 1500,
    reloadtime         = 0.1,
    WeaponType         = "LaserCannon",
    rgbColor           = "1 0.5 0",
    rgbColor2          = "1 1 1",
    soundTrigger       = true,
    soundstart         = "tmediumtankfire.wav",
    texture1           = "shot",
    texture2           = "empty",
    thickness          = 6,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 2500,
	customparams = {
	  damagetype		= "efighter",  
    }, 
    damage = {
      default           = 30,
    },
  },  
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
