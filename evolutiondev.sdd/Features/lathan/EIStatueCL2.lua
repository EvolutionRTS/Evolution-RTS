-----------------------------------------------------------------------------
-- EIStatueCL2
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "EIStatueCL2",
	blocking			= true,
	category			= "Rocks",
	damage				= 500,
	description			= "Easter Island statue",
	energy				= 0,
	flammable			= 0,
	footprintX			= 2,
	footprintZ			= 6,
	height				= "12",
	hitdensity			= "5",
	metal				= 10,
	object				= "features/lathan/EIStatueCL2.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

