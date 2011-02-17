local objectname	= "warehouse_small_dead"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "industrial",
	damage				= 20000,
	description			= "Warehouse",
	energy				= 1000,
	flammable			= 0,
	collisionvolumetype  = "box",
	collisionvolumescales = "80 20 112",
	collisionvolumeoffsets = "0 0 0",		
	footprintX			= 5,
	footprintZ			= 7,
	height				= "36",
	hitdensity			= "5",
	metal				= 50,
	object				= "features/smoth/harborset/" .. objectname .. ".s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef})

