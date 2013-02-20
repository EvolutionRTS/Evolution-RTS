local objectname	= "ship_1"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "industrial",
	damage				= 20000,
	description			= "Cargo ship",
	energy = 10,
-- energy				= 10000,
	flammable			= 0,
	collisionvolumetype  = "box",
	collisionvolumescales = "144 50 520",
	collisionvolumeoffsets = "0 -20 -20",		
	footprintX			= 9,
	footprintZ			= 35,
	nodrawundergray		= true,
	waterline			= 10,
	height				= "36",
	hitdensity			= "5",
	metal = 0, 
 --metal				= 3500,
	object				= "features/smoth/harborset/" .. objectname .. ".s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef})

