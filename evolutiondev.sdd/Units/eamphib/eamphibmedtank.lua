-- UNITDEF -- EAMPHIBMEDTANK --
--------------------------------------------------------------------------------

local unitName = "eamphibmedtank"

--------------------------------------------------------------------------------

local unitDef = {

  acceleration       = 1,
  brakeRate          = 0.1,
  buildCostEnergy    = 0,
  buildCostMetal     = 28,
  builder            = false,
  buildTime          = 5,
  canAttack          = true,
  cancollect         = "1",
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "LIGHT AMPHIB SKIRMISHER",
  corpse             = "ammobox",
  description        = [[Tank Destroyer
Light
140 Damage vs Light/Armored
70 Damage vs Building

	• Can fire while underwater

Requires +4 Power
Uses +4 Supply]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = 0,
  explodeAs          = "MEDIUM_UNIT",
  footprintX         = 3,
  footprintZ         = 3,
  iconType           = "tankdestroyer",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  leaveTracks        = false,
  maxDamage          = 360,
  maxSlope           = 28,
  maxVelocity        = 4.5,
  maxReverseVelocity = 1,
  maxWaterDepth      = 5000,
  metalStorage       = 0,
  movementClass      = "TANK3",
  name               = "Razor",
  noChaseCategory    = "VTOL",
  objectName         = "eamphibmedtank2.s3o",
  script			 = "eamphibmedtank2.cob",
  radarDistance      = 0,
  repairable		 = false,
 selfDestructAs     = "MEDIUM_UNIT",
  side               = "CORE",
  sightDistance      = 550,
  SonarDistance      = 550,
  stealth			 = true,
  sonarStealth		 = false,
  smoothAnim         = true,
  --  turnInPlace        = false,
  --  turnInPlaceSpeedLimit = 4.5,
  turnRate           = 1000,
--  turnrate           = 430,
  unitname           = "eamphibmedtank",
  workerTime         = 0,
  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

    explosiongenerators = {
      "custom:factorysparks",
      "custom:dirt",
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
      def                = "medtankbeamlaser",
	  badTargetCategory  = "BUILDING WALL",
    },
--[[	
	[2]  = {
      def                = "TORP",
    },
]]--
  },
   customParams = {
    needed_cover = 2,
   	death_sounds = "generic",
    RequireTech = "4 Power",
	armortype   = "light",
	nofriendlyfire	= "1",
	supply_cost = 4,
	normaltex = "unittextures/lego2skin_explorernormal.dds", 
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  medtankbeamlaser = {
	badTargetCategory = [[BUILDING]],
	TargetMoveError	   = 0.3,
    AreaOfEffect       = 1,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.2,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.5,
    duration           = 0.2,
    energypershot      = 2.8,
    explosionGenerator = "custom:genericshellexplosion-medium-sparks-burn",
    fallOffRate        = 1,
    fireStarter        = 50,
    interceptedByShieldType = 4,
	impulsefactor		= 0.1,
    lineOfSight        = true,
	largebeamlaser	   = true,
	laserflaresize 	   = 5,
	leadlimit			= 15,
    minintensity       = 1,
    name               = "Laser",
    range              = 550,
    reloadtime         = 0.2,
    WeaponType         = "BeamLaser",
    rgbColor           = "0 0.5 0",
    rgbColor2          = "0.8 0.8 0.8",
    soundTrigger       = true,
    soundstart         = "amphibmedtankshothit.wav",
--	soundHit		   = "amphibmedtankshothit.wav",
	scrollspeed		   = 5,
    texture1           = "lightning",
    texture2           = "laserend",
    thickness          = 4,
    tolerance          = 3000,
    turret             = true,
    weaponVelocity     = 1000,
	waterweapon		   = true,
	customparams = {
	  damagetype		= "eamphibmedtank",  
	  
	  --Upgrades--
	  upgradeClass		= "groundweapons",
    }, 
    damage = {
      default           = 28, -- multiply * 1.2 for correct dps output
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
