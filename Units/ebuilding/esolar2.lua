-- UNITDEF -- ESOLAR2 --
--------------------------------------------------------------------------------

local unitName = "esolar2"

--------------------------------------------------------------------------------

local unitDef = {
  activateWhenBuilt  = true,
  buildAngle         = 2048,
  buildCostEnergy    = 0,
  buildCostMetal     = 20,
  builder            = false,
  buildTime          = 5,
  canAttack			 = false,
  category           = "BUILDING NOTAIR ECO",
  corpse             = "ammobox",
  damageModifier     = 0.33333,
  description        = [[Produces +1 Energy
Provides +1 Power
Provides +5 Supply]],
  energyMake         = 0,
  energyStorage      = 0,
  energyUse          = -1,
  explodeAs          = "POWERPLANTPOP",
  footprintX         = 4,
  footprintZ         = 4,
  icontype           = "energy",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 800,
  maxSlope           = 60,
  maxWaterDepth      = 5000,
  metalStorage       = 0,
  name               = "Basic Generator",
  objectName         = "epowerplant.s3o",
  onoffable          = false,
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "POWERPLANTPOP",
  side               = "CORE",
  sightDistance      = 367,
  smoothAnim         = true,
  unitname           = "esolar2",
  yardMap            = "oooo oooo oooo oooo",
  
sfxtypes = {
	pieceExplosionGenerators = {
		"deathceg0",
		"deathceg1",
	},
	
	explosiongenerators = {
	  "custom:blacksmoke",
	  "custom:fusionreactionbasic",
	  "custom:skyhatelaser",
    },
},

  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdenergy",
    },
  },
  weapons = {
  },
  customParams = {
	iseco = 1,
    needed_cover = 2,
	death_sounds = "generic",
    ProvideTech = "1 Power",
    ProvideTechRange = "400",
--	RequireTech = "1 Powergrid",
	armortype   = "building",
	supply_granted = 5,
	normalstex = "unittextures/lego2skin_explorernormal.dds", 
	 buckettex = "unittextures/lego2skin_explorerbucket.dds",
	factionname	= "outer_colonies",  
	groundtexselectimg = ":nc:bitmaps/power/power.png",
	groundtexselectimg1 = ":nc:bitmaps/power/power1.png",
	groundtexselectimg2 = ":nc:bitmaps/power/power2.png",
	groundtexselectimg3 = ":nc:bitmaps/power/power3.png",
	groundtexselectimg4 = ":nc:bitmaps/power/power4.png",
	groundtexselectimg5 = ":nc:bitmaps/power/power5.png",
	groundtexselectimg6 = ":nc:bitmaps/power/power6.png",
    groundtexselectxsize = 400, -- optional
    groundtexselectzsize = 400, -- optional
	helptext = [[Basic Powerplant

Produces energy and power in a radius

+1 Energy

+1 Power

+400 Power Radius]],
  },
  useBuildingGroundDecal = true,
  BuildingGroundDecalType = "factorygroundplate.dds",
  BuildingGroundDecalSizeX = 6,
  BuildingGroundDecalSizeY = 6,
  BuildingGroundDecalDecaySpeed = 0.9,
}
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
