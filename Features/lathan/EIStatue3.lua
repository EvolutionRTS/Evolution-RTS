-----------------------------------------------------------------------------
--  EIStatue3
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "EIStatue3",
	blocking			= true,
	category			= "Rocks",
	damage				= 500,
	description			= "Easter Island statue",
	energy = 10,
-- energy				= 0,
	flammable			= 0,
	footprintX			= 2,
	footprintZ			= 4,
	height				= "25",
	hitdensity			= "5",
	metal = 0,
--metal				= 15,
	object				= "features/lathan/EIStatue3.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

