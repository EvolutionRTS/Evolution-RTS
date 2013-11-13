-- UNITDEF -- EFUSION2 --
--------------------------------------------------------------------------------

local unitName = "efusion2"

--------------------------------------------------------------------------------

local unitDef = {
  activateWhenBuilt  = true,
  buildAngle         = 2500,
  buildCostEnergy    = 0,
  buildCostMetal     = 180,
  builder            = false,
  buildTime          = 5,
  canAttack			 = false,
  category           = "BUILDING NOTAIR ECO",
  corpse             = "ammobox",
  description        = [[Produces +10 Energy 
Provides +10 Power
Provides +10 Supply]],
--  energyMake         = 10,
  energyStorage      = 0,
  energyUse          = -10,
  explodeAs          = "FUSIONPOP",
  footprintX         = 8,
  footprintZ         = 8,
  iconType           = "energy",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxDamage          = 2400,
  maxSlope           = 60,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "Advanced Generator",
  objectName         = "efusion2.s3o",
  onoffable 		 = false,
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "FUSIONPOP",
  side               = "ARM",
  sightDistance      = 367,
  smoothAnim         = true,
  unitname           = "efusion2",
  workerTime         = 0,
  yardMap            = "oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo oooooooo",

  sfxtypes = { 
	 pieceExplosionGenerators = { 
 		"deathceg0", 
 		"deathceg1", 
 	}, 

	explosiongenerators = {
	  "custom:blacksmoke",
	  "custom:fusionreactionnuclear",
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
    needed_cover = 5,
	death_sounds = "generic",
    ProvideTech = "10 Power",
    ProvideTechRange = "800",
--	RequireTech = "1 Powergrid",
	armortype   = "building",
	supply_granted = 10,
	normaltex = "unittextures/lego2skin_explorernormal.png", 
	groundtexselectimg = ":nc:bitmaps/power/power.png",
	groundtexselectimg1 = ":nc:bitmaps/power/power1.png",
	groundtexselectimg2 = ":nc:bitmaps/power/power2.png",
	groundtexselectimg3 = ":nc:bitmaps/power/power3.png",
	groundtexselectimg4 = ":nc:bitmaps/power/power4.png",
	groundtexselectimg5 = ":nc:bitmaps/power/power5.png",
	groundtexselectimg6 = ":nc:bitmaps/power/power6.png",
    groundtexselectxsize = 800, -- optional
    groundtexselectzsize = 800, -- optional
	helptext = [[Nuclear Powerplant

Produces energy and power in an increased capacity and radius

+10 Energy

+10 Power

+1000 Power Radius]],
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=11,
	buildingGroundDecalSizeY=11,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[efusion2_aoplane.dds]],
}

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
