local objectname	= "forklift_1"

local featureDef	=	{
	name				= objectname,
	blocking			= false,
	category			= "industrial",
	damage				= 2000,
	description			= "forklift",
	energy				= 500,
	flammable			= 0,
	footprintX			= 1,
	footprintZ			= 1,
	height				= "36",
	hitdensity			= "5",
	metal				= 3,
	object				= "features/smoth/harborset/" .. objectname .. ".s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef})

