-----------------------------------------------------------------------------
-- SLRock1
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "SLRock1",
	blocking			= true,
	category			= "Rocks",
	damage				= 6000,
	description			= "ShorelineRock",
	energy = 10,
-- energy				= 0,
	flammable			= 0,
	footprintX			= 11,
	footprintZ			= 7,
	height				= "298",
	hitdensity			= "5",
	metal				= 50,
	object				= "features/lathan/SLRock1.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

