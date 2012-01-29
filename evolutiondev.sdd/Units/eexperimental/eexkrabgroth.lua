-- UNITDEF -- EEXKRABGOTH --
--------------------------------------------------------------------------------

local unitName = "eexkrabgroth"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 0.18,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 500,
  builder            = false,
  buildTime          = 10,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  cantBeTransported  = true,
  category           = "NOTAIR SKIRMISHER",
  corpse             = "ammobox",
  description        =[[Destroyer Class Walker
    •Damagetype: Explosive :: Armortype: Light

Requires +40 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "krabblast",
  firestandorders    = "1",
  footprintX         = 12,
  footprintZ         = 12,
  iconType           = "allterr",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 5000,
  maxVelocity        = 1,
  maxReverseVelocity = 0.2,
  maxWaterDepth      = 80,
  metalStorage       = 0,
  movementClass      = "EXPERIMENTALTANK12",
  name               = "(K)rabgroth",
  noChaseCategory    = "VTOL",
  objectName         = "ekrabgroth.s3o",
  radarDistance      = 0,
  selfDestructAs     = "krabblast",
  shootme            = "1",
  sightDistance      = 1000,
  smoothAnim         = true,
  turnInPlace        = true,
  turnRate           = 150,
  unitname           = "eexkrabgroth",
  unitnumber         = "110",
  upright            = false,
  usePieceCollisionVolumes = true,
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:gdhcannon",
      "custom:dirtsmall",
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
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
	[2]  = {
      def                = "concussioncannon",
	  onlyTargetCategory = "NOTAIR AMPHIB",
    },
	[3]  = {
      def                = "concussioncannon",
	  onlyTargetCategory = "NOTAIR AMPHIB",
    },
  },
   customParams = {
	death_sounds = "nuke",
	twokhotkey = 'k',
    RequireTech = "40 Power",
	armortype   = "lightarmor",
	normaltex = "unittextures/lego2skin_explorernormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  heavybeamweapon = {
    areaOfEffect       = 200,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 1,
    beamWeapon         = true,
	cameraShake		   = 1,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.5,
--	cegTag             = "mediumcannonweapon3",
--    duration           = 0.2,
    energypershot      = 30,
    explosionGenerator = "custom:MEDMECHPOP",
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
    rgbColor           = "1 0 1",
    rgbColor2          = "1 1 1",
    soundTrigger       = true,
    soundstart         = "krabprimary.wav",
--    soundHit           = "mediumcannonhit.wav",
--	sweepfire		   = true,
    texture1           = "shot",
    texture2           = "empty",
    thickness          = 9,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 800,
	customparams = {
	  damagetype		= "explosive",  
    }, 
    damage = {
      default           = 300,
    },
  },
  concussioncannon = {
    accuracy           = 1,
    areaOfEffect       = 50,
    avoidFriendly      = false,
    avoidFeature       = false,
    ballistic          = true,
    collideFriendly    = false,
    collideFeature     = false,
    CylinderTargetting = true,
    burnblow           = true,
    endsmoke           = "1",
    explosionGenerator = "custom:xamelImpact",
	energypershot      = 4,
    fireStarter        = 80,
    id                 = 1,
    impulseFactor      = 0.1,
	interceptedByShieldType = 4,
    name               = "Concussion Cannon",
    pitchtolerance     = "500",
    range              = 1500,
    reloadtime         = 1,
    renderType         = 4,
    soundHit           = "explode2",
    soundStart         = "krabsecondary.wav",
    startsmoke         = "1",
    tolerance          = 500,
    turret             = true,
    weaponVelocity     = 5000,
	customparams = {
	  damagetype		= "explosive",  
    },
    damage = {
      default            = 40,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------

