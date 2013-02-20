local objectname	= "watertower_1"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "industrial",
	damage				= 2000,
	description			= "Water tower",
	energy = 10,
-- energy				= 30,
	flammable			= 0,
	collisionvolumetype  = "CylY",
	collisionvolumescales = "36 180 36",
	collisionvolumeoffsets = "0 0 0",	
	footprintX			= 2,
	footprintZ			= 2,
	height				= "36",
	hitdensity			= "5",
	metal = 0, 
 --metal				= 20,
	object				= "features/smoth/harborset/" .. objectname .. ".s3o",
	reclaimable			= true,
	autoreclaimable		= true, 
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef})

