local objectname	= "warehouse_small_4"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "industrial",
	damage				= 5000,
	description			= "Warehouse",
	featuredead			= "warehouse_small_dead",
	energy = 10,
-- energy				= 2000,
	flammable			= 0,
	collisionvolumetype  = "box",
	collisionvolumescales = "78 36 110",
	collisionvolumeoffsets = "0 0 0",		
	footprintX			= 5,
	footprintZ			= 7,
	height				= "36",
	hitdensity			= "5",
	metal				= 200,
	object				= "features/smoth/harborset/" .. objectname .. ".s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef})

