local objectname	= "pipe_tall_2"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "industrial",
	damage				= 2000,
	description			= "Pipeline",
	energy = 10,
-- energy				= 2000,
	flammable			= 0,
	footprintX			= 2,
	footprintZ			= 1,
	height				= "36",
	hitdensity			= "5",
	metal				= 35,
	object				= "features/smoth/harborset/" .. objectname .. ".s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef})

