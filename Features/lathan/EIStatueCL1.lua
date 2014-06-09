-----------------------------------------------------------------------------
-- EIStatueCL1
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "EIStatueCL1",
	blocking			= true,
	category			= "Rocks",
	damage				= 500,
	description			= "Easter Island statue",
	energy = 10,
-- energy				= 0,
	flammable			= 0,
	footprintX			= 12,
	footprintZ			= 2,
	height				= "12",
	hitdensity			= "5",
	metal = 0,
--metal				= 10,
	object				= "features/lathan/EIStatueCL1.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

