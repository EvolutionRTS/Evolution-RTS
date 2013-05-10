-----------------------------------------------------------------------------
--  pdrock6
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "pdrock6",
	blocking			= true,
	category			= "Rocks",
	damage				= 1000,
	description			= "Grey Rock",
	energy = 10,
-- energy				= 0,
	flammable			= 0,
	footprintX			= 3,
	footprintZ			= 3,
	height				= "21",
	hitdensity			= "5",
	metal = 0,
--metal				= 10,
	object				= "features/noize/pdrock6.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

