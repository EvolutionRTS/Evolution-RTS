-----------------------------------------------------------------------------
--  GreyRock1
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "GreyRock1",
	blocking			= true,
	category			= "rocks",
	damage				= 500,
	description			= "Grey Rock",
	energy				= 0,
	flammable			= 0,
	footprintX			= 5,
	footprintZ			= 5,
	height				= "36",
	hitdensity			= "5",
	metal				= 35,
	object				= "features/lathan/GreyRock1.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

