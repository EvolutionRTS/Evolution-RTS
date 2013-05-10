-----------------------------------------------------------------------------
--  GreyRock3
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "nGreyRock3",
	blocking			= true,
	category			= "Rocks",
	damage				= 1000,
	description			= "Grey Rock",
	energy = 10,
-- energy				= 0,
	flammable			= 0,
	footprintX			= 2,
	footprintZ			= 2,
	height				= "21",
	hitdensity			= "5",
	metal = 0,
--metal				= 10,
	object				= "features/noize/GreyRock3.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

