-- UNITDEF -- EBOMB --
--------------------------------------------------------------------------------

local unitName = "ebomb"

--------------------------------------------------------------------------------

local unitDef = {
--Begin tags entered from Notepad++ en masse
  pieceTrailCEGTag   = "missiletrailsmall",
  pieceTrailCEGRange = 1,
--End tags entered from Notepad++
  acceleration       = 1,
  brakeRate          = 1,
  buildCostEnergy    = 0,
  buildCostMetal     = 100,
  builder            = false,
  buildTime          = 10,
  canAttack          = true,
  canGuard           = true,
  canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "NOTAIR",
  description        = [[Hovering Bomb 
  •Damagetype: Explosive :: Armortype: Light

Requires +12 Power]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "ebombboom",
  footprintX         = 2,
  footprintZ         = 2,
  iconType           = "hover",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  kamikaze           = true,
  kamikazeDistance   = 40,
  leaveTracks        = false,
  maxDamage          = 80,
  maxSlope           = 26,
  maxVelocity        = 7,
  maxReverseVelocity = 3,
  maxWaterDepth      = 10,
  metalStorage       = 0,
  movementClass      = "HOVERTANK2",
  name               = "Shellshock (B)",
  noChaseCategory    = "VTOL",
  objectName         = "ebomb.s3o",
  onlytargetcategory1 = "NOTAIR",
  onlytargetcategory2 = "NOTAIR",
  onlytargetcategory3 = "NOTAIR",
  onlytargetcategory4 = "NOTAIR",
  onlytargetcategory5 = "NOTAIR",
  onlytargetcategory6 = "NOTAIR",
  radarDistance      = 0,
  selfDestructAs     = "ebombboom",
  selfDestructCountdown = 0,
  side               = "CORE",
  sightDistance      = 175,
  smoothAnim         = true,
  stealth            = true,
  turnInPlace        = false,
  turnRate           = 2000,
  unitname           = "ebomb",
  upright            = true,
  workerTime         = 0,
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
      def                = "ebombboom",
      badTargetCategory  = "VTOL",
    },
  },
  customParams = {
	twokhotkey = 'b',
    RequireTech = "12 Power",
	armortype   = "lightarmor",
	nofriendlyfire	= "1",
	normaltex = "unittextures/ebombnormal.png", 
	helptext = [[The Shellshock hovering bomb is an extremely fast, stealthed warhead that packs an awesome punch. It's speed allows it to dart in and cause havoc wherever it explodes. It has next to no armor though, so use them wisely as they are a costly investment]],
  },
}

--------------------------------------------------------------------------------

local weaponDefs = {
  ebombboom = {
   name="hoverbomb",
   rendertype=4,
   ballistic=1,
   turret=1,
   impulseFactor      = 0,
   range=480,
   reloadtime=3.6,
   weaponvelocity=250,
   areaofeffect=556,
   soundstart="unitexplodemedium.wav",
   soundhit="unitexplodemedium.wav",
   explosiongenerator="custom:CRAWL_SUICIDE_Expl",
   customparams = {
	  damagetype		= "Explosive",
	  nofriendlyfire	= "true", 
    },  

    damage = {
      default            = 1000,
    },
  },
}
unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
