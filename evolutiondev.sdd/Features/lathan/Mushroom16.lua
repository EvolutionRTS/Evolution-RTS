-----------------------------------------------------------------------------
-- Mushroom16
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Mushroom16",
	blocking			= true,
	category			= "Vegitation",
	damage				= 120,
	description			= "Purple Mushrooms",
	energy = 10,
-- energy				= 400,
	flammable			= 0,
	footprintX			= 6,
	footprintZ			= 6,
	height				= "66",
	hitdensity			= "5",
	metal = 0,
--metal				= 10,
	object				= "features/lathan/Mushroom16.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

