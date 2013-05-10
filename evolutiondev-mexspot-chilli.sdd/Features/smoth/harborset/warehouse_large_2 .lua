local objectname	= "warehouse_large_2"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "industrial",
	damage				= 20000,
	description			= "Warehouse",
	featuredead			= "warehouse_large_dead",	
	energy = 10,
-- energy				= 2000,
	flammable			= 0,
	collisionvolumetype  = "box",
	collisionvolumescales = "110 50 172",
	collisionvolumeoffsets = "0 0 0",		
	footprintX			= 7,
	footprintZ			= 11,
	height				= "36",
	hitdensity			= "5",
	metal = 0,
--metal = 0, 
 --metal = 0,
--metal				= 400,
	object				= "features/smoth/harborset/" .. objectname .. ".s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef})

