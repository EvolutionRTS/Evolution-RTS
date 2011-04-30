-- UNITDEF -- EHEAVYTANK3 --
--------------------------------------------------------------------------------

local unitName = "eheavytank3"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "missiletrailsmall",
  pieceTrailCEGRange = 1,
--End tags entered from Notepad++
  acceleration       = 0.18,
  brakeRate          = 0.2,
  buildCostEnergy    = 0,
  buildCostMetal     = 35,
  builder            = false,
  buildTime          = 10,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR SKIRMISHER",
  corpse             = "ammobox",
  description        = [[Armored Skirmish Tank 
  •Damagetype: Medium :: Armortype: Medium

Requires +5 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "BIG_UNIT",
  footprintX         = 4,
  footprintZ         = 4,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 300,
  maxSlope           = 26,
  maxVelocity        = 2.8,
  maxReverseVelocity = 1,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK4",
  name               = "(C)rusher",
  noChaseCategory    = "VTOL",
  objectName         = "eheavytank3.s3o",
  radarDistance      = 0,
  selfDestructAs     = "BIG_UNIT",
  side               = "CORE",
  sightDistance      = 500,
  smoothAnim         = true,
  turnInPlace        = false,
  turnRate           = 350,
  unitname           = "eheavytank3",
  upright            = true,
  workerTime         = 0,
  sfxtypes = {
    explosiongenerators = {
      "custom:gdhcannon",
      "custom:dirt",
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
      def                = "heavytankweapon",
      onlyTargetCategory = "NOTAIR AMPHIB",
    },
  },
  customParams = {
	twokhotkey = 'c',
    RequireTech = "5 Power",
	armortype   = "mediumarmor",
	normaltex = "unittextures/eheavytank3normal.png", 
	helptext = [[The Crusher is a heavy skirmish tank capable of taking out the most hardened of mobile units. The more of these you have, the better. Short line of sight. It is recommended that they be paired with raiders.]],
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  heavytankweapon = {
    accuracy           = 200,
    areaOfEffect       = 50,
    avoidFriendly      = false,
    ballistic          = true,
    cegTag             = "antiassualtshot2",
    collideFriendly    = false,
    explosionGenerator = "custom:MEDMECHPOP",
	energypershot      = 12,
    id                 = 172,
    impulseFactor      = 0,
    interceptedByShieldType = 4,
    name               = "Light Cannon",
    range              = 700,
    reloadtime         = 1.2,
    renderType         = 4,
    soundHit           = "42024_digifishmusic_Missile_Strike.wav",
    soundStart         = "triotfire.wav",
    startsmoke         = "1",
    tolerance          = 2000,
    turret             = true,
    weaponVelocity     = 800,
	customparams = {
	  damagetype		= "medium",  
    },      
    damage = {
     default         = 120,
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
