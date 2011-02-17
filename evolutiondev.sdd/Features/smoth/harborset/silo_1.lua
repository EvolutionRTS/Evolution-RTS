local objectname	= "silo_1"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "military",
	damage				= 2000,
	description			= "Underground Silo Entrance",
	energy				= 2000,
	flammable			= 0,
	collisionvolumetype  = "box",
	collisionvolumescales = "80 5 64",
	collisionvolumeoffsets = "0 0 0",		
	footprintX			= 5,
	footprintZ			= 4,
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

