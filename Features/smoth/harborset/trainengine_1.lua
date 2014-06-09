local objectname	= "trainengine_1"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "industrial",
	damage				= 2000,
	description			= "Train engine",
	energy = 10,
-- energy				= 5000,
	flammable			= 0,
	collisionvolumetype  = "box",
	collisionvolumescales = "13 16 45",
	collisionvolumeoffsets = "0 0 0",		
	footprintX			= 1,
	footprintZ			= 3,
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

