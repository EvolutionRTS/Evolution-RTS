local objectname	= "pipe_large_2"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "industrial",
	damage				= 2000,
	description			= "Pipeline",
	energy = 10,
-- energy				= 2000,
	flammable			= 0,
	collisionvolumetype  = "cylinder",
	collisionvolumescales = "144 20 16",
	collisionvolumeoffsets = "0 20 0",		
	footprintX			= 2,
	footprintZ			= 9,
	height				= "36",
	hitdensity			= "5",
	metal = 0,
--metal = 0, 
 --metal = 0,
--metal				= 100,
	object				= "features/smoth/harborset/" .. objectname .. ".s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef})

