-----------------------------------------------------------------------------
--  GreyRock7
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "GreyRock7",
	blocking			= true,
	category			= "rocks",
	damage				= 1000,
	description			= "Grey Rock",
	energy = 10,
-- energy				= 0,
	flammable			= 0,
	footprintX			= 3,
	footprintZ			= 2,
	height				= "36",
	hitdensity			= "5",
	metal = 0,
--metal				= 35,
	object				= "features/lathan/GreyRock7.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

