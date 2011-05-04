-- UNITDEF -- EFLAMETANK --
--------------------------------------------------------------------------------

local unitName = "eflametank"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "deathceg",
  pieceTrailCEGRange = 2,
--End tags entered from Notepad++
  acceleration       = 0.2,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 15,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR RAID",
  corpse             = "ammobox",
  description        = [[Flamethrower Raider 
  •Damagetype: Explosive :: Armortype: Light

Requires +2 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "PYRO_BLAST",
  footprintX         = 3,
  footprintZ         = 3,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 130,
  maxSlope           = 26,
  maxVelocity        = 5.5,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK3",
  name               = "(P)yromaniac",
  noChaseCategory    = "VTOL",
  objectName         = "eflametank.s3o",
  onlytargetcategory2 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  selfDestructAs     = "PYRO_BLAST",
  side               = "CORE",
  sightDistance      = 600,
  smoothAnim         = true,
  turnInPlace        = false,
  turnRate           = 950,
  unitname           = "eflametank",
  upright            = true,
  workerTime         = 0,
  sfxtypes = {
    explosiongenerators = {
      "custom:dirt",
       "custom:flamethrowerrange500",
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
      def                = "lightlaser",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
  },
  customParams = {
	twokhotkey = 'p',
    RequireTech = "2 Power",
	armortype   = "lightarmor",
	normaltex = "unittextures/eflametanknormal.png", 
	helptext	=	[[The pyromaniac has a long range flamethrower that is deadly versus base structures and especially economy buildings. Very fast and agile, however, it has a short line of sight. For best results, couple with Lightning raiders.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
    lightlaser = {
    accuracy           = 200,
    areaOfEffect       = 50,
    avoidFeature       = false,
    avoidFriendly      = false,
    collideFeature     = false,
    collideFriendly    = false,
    explosionGenerator = "custom:burnblack",
    coreThickness      = 0,
    duration           = 1,
    energypershot      = 1,
    fallOffRate        = 1,
    fireStarter        = 50,
	interceptedByShieldType = 4,
    soundstart         = "flamethrower1.wav",
    lineOfSight        = true,
    minintensity       = 0.1,
    impulseFactor      = 0,
    name               = "Something with Flames",
    range              = 500,
    reloadtime         = 0.1,
    WeaponType         = [[LaserCannon]],
    rgbColor           = "0 0 0",
    rgbColor2          = "0 0 0",
    thickness          = 0,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 400,
	customparams = {
	  damagetype		= "explosive",  
    },      
    damage = {
      default           = 15,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
