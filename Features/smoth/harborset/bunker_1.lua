local objectname	= "bunker_1"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "millitary",
	damage				= 2000,
	description			= "fortified bunker",
	energy = 10,
-- energy				= 10000,
	flammable			= 0,
	collisionvolumetype  = "box",
	collisionvolumescales = "160 50 128",
	collisionvolumeoffsets = "0 0 0",		
	footprintX			= 10,
	footprintZ			= 8,
	height				= "36",
	hitdensity			= "5",
	metal = 0,
--metal = 0, 
 --metal = 0,
--metal				= 1000,
	object				= "features/smoth/harborset/" .. objectname .. ".s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef})

