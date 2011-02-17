-----------------------------------------------------------------------------
-- Mushroom18
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Mushroom18",
	blocking			= true,
	category			= "Vegitation",
	damage				= 120,
	description			= "Purple Mushrooms",
	energy				= 400,
	flammable			= 0,
	footprintX			= 7,
	footprintZ			= 7,
	height				= "66",
	hitdensity			= "5",
	metal				= 10,
	object				= "features/lathan/Mushroom18.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

