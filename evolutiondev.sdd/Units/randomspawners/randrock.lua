-- UNITDEF -- ZEONMINOVSKY --
--------------------------------------------------------------------------------

local unitName = "randrock"

--------------------------------------------------------------------------------

local unitDef = {
  bmcode             = "0",
  buildCostEnergy    = 0,
  buildCostMetal     = 0,
  description        = "Spawns a random rock",
  explodeAs          = "ELECTRIC_EXPLOSION",
  footprintX         = 6,
  footprintZ         = 6,
  levelGround		= false,
  maxslope			= 255,
  maxwaterdepth		= 255,
  maxDamage          = 1000,
  name               = "rock spawner",
  objectName         = "features/lathan/GreyRock5.s3o",
  power              = 1,
  reclaimable        = false,
  selfDestructAs     = "ELECTRIC_EXPLOSION",
  script		 	 = "default.cob",  
  shootme            = "1",
  unitname			 = unitName,
  yardMap            = "oo oo",
  customparams = {
	armortype			= "building",  
  	factionname		   = "randm",
  },
}
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
