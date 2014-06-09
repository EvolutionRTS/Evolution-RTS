-----------------------------------------------------------------------------
--  EIStatue5
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "EIStatue5",
	blocking			= true,
	category			= "Rocks",
	damage				= 500,
	description			= "Easter Island statue",
	energy = 10,
-- energy				= 0,
	flammable			= 0,
	footprintX			= 7,
	footprintZ			= 7,
	height				= "42",
	hitdensity			= "5",
	metal = 0,
--metal				= 15,
	object				= "features/lathan/EIStatue5.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

