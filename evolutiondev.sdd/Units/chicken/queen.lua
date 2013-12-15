-- UNITDEF -- EEXKRABGOTH --
--------------------------------------------------------------------------------

local unitName = "queen"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 0.18,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 1000,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  cantBeTransported  = true,
  category           = "ARMORED NOTAIR SKIRMISHER",
  corpse             = "ammobox",
  description        =[[Primary Laser:
600 Damage/s vs Building
60 Damage/s vs Light/Armored

Secondary Flamethrowers:
100 Damage/s vs Light/Armored
25 Damage/s vs Buildings

• Flames can hit multiple units]],
  energyMake         = 998,
  energyStorage      = 900,
  energyUse          = 0,
  explodeAs          = "nukemissile",
  firestandorders    = "1",
  footprintX         = 12,
  footprintZ         = 12,
  iconType           = "allterr",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 30000,
  maxVelocity        = 1,
  maxReverseVelocity = 0.2,
  maxWaterDepth      = 80,
  metalmake	         = 998,
  metalStorage       = 900,
  movementClass      = "EXPERIMENTALTANK12",
  name               = "Queen",
  noChaseCategory    = "VTOL",
  objectName         = "ekrabgroth.s3o",
  pushResistant		 = true,
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "krabblast",
  shootme            = "1",
  sightDistance      = 1500,
  smoothAnim         = true,
  turnInPlace        = true,
  turnRate           = 150,
  unitname           = "queen",
  unitnumber         = "110",
  unitRestricted	 = 1,
  upright            = false,
--  usePieceCollisionVolumes = true,
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:flamethrowerrange500",
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
      def                = "heavybeamweapon",
      onlyTargetCategory = "BUILDING",
    },
	[2]  = {
      def                = "concussioncannon",
	  onlyTargetCategory = "LIGHT ARMORED",
    },
	[3]  = {
      def                = "concussioncannon",
	  onlyTargetCategory = "LIGHT ARMORED",
    },
  },
   customParams = {
	death_sounds = "nuke",
    RequireTech = "40 Power",
	armortype   = "armored",
	normaltex = "unittextures/lego2skin_explorernormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  heavybeamweapon = {
    badTargetCategory = [[ARMORED LIGHT]],
    AreaOfEffect       = 0,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 1,
    beamWeapon         = true,
	cameraShake		   = 1,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 1,
--	cegTag             = "mediumcannonweapon3",
--    duration           = 0.2,
    energypershot      = 30,
    explosionGenerator = "custom:genericshellexplosion-large-purple",
    fallOffRate        = 1,
    fireStarter        = 50,
	impulseFactor      = 0,
	interceptedByShieldType = 4,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    range              = 1000,
    reloadtime         = 1,
    WeaponType         = "BeamLaser",
    rgbColor           = "1 0 0",
    rgbColor2          = "1 1 1",
    soundTrigger       = true,
    soundstart         = "krabprimary.wav",
	sweepfire			= true,
--    soundHit           = "mediumcannonhit.wav",
--	sweepfire		   = true,
    texture1           = "shot",
    texture2           = "empty",
    thickness          = 9,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 800,
	customparams = {
	  damagetype		= "queenbeam",  
    }, 
    damage = {
      default           = 600,
    },
  },
  concussioncannon = {
    accuracy           = 1,
    AreaOfEffect       = 100,
    avoidFriendly      = false,
    avoidFeature       = false,
    ballistic          = true,
    collideFriendly    = false,
    collideFeature     = false,
    cylinderTargeting = true,
    burnblow           = true,
    endsmoke           = "1",
    explosionGenerator = "custom:genericshellexplosion-large",
	energypershot      = 4,
    fireStarter        = 80,
    id                 = 1,
    impulseFactor      = 0.1,
	interceptedByShieldType = 4,
    name               = "Concussion Cannon",
    pitchtolerance     = "500",
    range              = 1000,
    reloadtime         = 1,
    weaponType		   = "Cannon",
    soundHit           = "explode2",
    soundStart         = "krabsecondary.wav",
    startsmoke         = "1",
    tolerance          = 500,
    turret             = true,
    weaponVelocity     = 5000,
	customparams = {
	  damagetype		= "queencannon",  
    },
    damage = {
      default            = 160,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------

