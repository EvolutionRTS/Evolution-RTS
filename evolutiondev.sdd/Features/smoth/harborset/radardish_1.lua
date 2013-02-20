local objectname	= "radardish_1"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "industrial",
	damage				= 20000,
	description			= "Satellite Dish",
	energy = 10,
-- energy				= 2000,
	flammable			= 0,
	collisionvolumetype  = "CylY",
	collisionvolumescales = "32 32 32",
	collisionvolumeoffsets = "0 0 0",		
	footprintX			= 2,
	footprintZ			= 2,
	height				= "36",
	hitdensity			= "5",
	metal = 0, 
 --metal				= 350,
	object				= "features/smoth/harborset/" .. objectname .. ".s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef})

