-- UNITDEF -- EALLTERRRIOT --
--------------------------------------------------------------------------------

local unitName = "eallterrriot"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  acceleration       = 0.18,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 20,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
--  canDgun			 = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR RIOT",
  corpse             = "ammobox",
  
-- Cloaking

	cancloak		 = true,
	cloakCost		 = 2,
	decloakDistance	 = 100,
	decloakOnFire	 = true,
	decloakSpherical = true,
	startCloaked	 = false,
	
-- End Cloaking
  
  description        = [[Anti-Swarm Tank - Damagetype: Light :: Armortype: Heavy

Requires +3 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "allterr",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 200,
  maxSlope           = 180,
  maxVelocity        = 3.3,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "ALLTERRTANK4",
  name               = "(M)ossberg",
  noChaseCategory    = "VTOL",
  objectName         = "eallterrriot2.s3o",
  radarDistance      = 0,
  selfDestructAs     = "BIG_UNIT",
  sightDistance      = 550,
  smoothAnim         = true,
  stealth			 = true,
  seismicSignature   = 4,
  turnInPlace        = true,
  turnRate           = 1000,
  unitname           = "eallterrriot",
  upright            = false,
  workerTime         = 0,
  sfxtypes = {
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
      def                = "riottankweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
 --[[   [2]  = {
      def                = "riottanksupaweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    }, ]]--
  },
  customParams = {
	twokhotkey = 'm',
    RequireTech = "3 Power",
	armortype   = "lightarmor",
	normaltex = "unittextures/lego2skin_explorernormal.png", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  riottankweapon = {
    areaOfEffect       = 100,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    cegTag             = "riotweapon",
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.3,
    duration           = 0.1,
    energypershot      = 7.5,
    explosionGenerator = "custom:PLASMA_Expl",
    fallOffRate        = 1,
    fireStarter        = 50,
    impulseFactor      = 0.5,
	interceptedByShieldType = 4,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    range              = 450,
    reloadtime         = 0.5,
    WeaponType         = "LaserCannon",
    rgbColor           = "1 0.3 0.4",
    rgbColor2          = "1 1 1",
    sprayAngle         = 1000,
    soundTrigger       = true,
    soundstart         = "allterrriotweapon.wav",
    soundHit           = "mediumcannonhit.wav",
    texture1           = "shot",
    texture2           = "empty",
    thickness          = 7,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 500,
	customparams = {
	  damagetype		= "light",  
    }, 
    damage = {
      default           = 38,
    },
  },
  
  riottanksupaweapon = {
    areaOfEffect       = 100,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
	burst			   = 5,
	burstrate		   = 0.1,
    cegTag             = "riotweapon",
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.3,
	commandfire		   = true,
    duration           = 0.1,
    energypershot      = 187,
    explosionGenerator = "custom:PLASMA_Expl",
    fallOffRate        = 1,
    fireStarter        = 50,
    impulseFactor      = 0.5,
	interceptedByShieldType = 4,
    lineOfSight        = true,
    minintensity       = "1",
    name               = "Laser",
    projectiles        = 5,
    range              = 400,
    reloadtime         = 5,
    WeaponType         = "LaserCannon",
    rgbColor           = "1 0.3 0.4",
    rgbColor2          = "1 1 1",
    sprayAngle         = 2000,
    soundTrigger       = true,
    soundstart         = "allterrriotweapon.wav",
    soundHit           = "mediumcannonhit.wav",
    stockpile          = true,
    stockpileTime      = 30,
    texture1           = "shot",
    texture2           = "empty",
    thickness          = 7,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 500,
	customparams = {
	  damagetype		= "light",  
    }, 
    damage = {
      default           = 38,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
