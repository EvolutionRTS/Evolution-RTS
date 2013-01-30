local objectname	= "Industrial_structure_2"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "industrial",
	damage				= 2000,
	description			= "Building",
	energy = 10,
-- energy				= 2000,
	flammable			= 0,
	collisionvolumetype  = "box",
	collisionvolumescales = "60 80 32",
	collisionvolumeoffsets = "0 0 0",	
	footprintX			= 5,
	footprintZ			= 3,
	height				= "36",
	hitdensity			= "5",
	metal				= 350,
	object				= "features/smoth/harborset/" .. objectname .. ".s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef})

