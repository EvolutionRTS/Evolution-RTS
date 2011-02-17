-----------------------------------------------------------------------------
--  neutralhlvlanding_dead
-----------------------------------------------------------------------------

local featureDef	=	{

  	name				= "neutralhlvlanding_dead",
    blocking			= true,
    category			= "corpse",
    damage				= 10000,
    description			= "Wreckage",
	energy				= 2000,
	featureDead			= "rubble",
	flammable			= 0,	
    footprintX			= 23,
    footprintZ			= 23,
    height				= "50",
    hitdensity			= "70",
    metal				= 150,
    object				= "neutralhlvlanding_dead.s3o",
	reclaimable			= true,
	autoreclaimable		= false, 	
    world				= "All Worlds",
  	customparams = { 
		randomrotate		= "true", 
	}, 
}

return lowerkeys({[featureDef.name] = featureDef})