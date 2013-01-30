local objectname	= "raddome_1"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "industrial",
	damage				= 20000,
	description			= "Radar Dome",
	energy = 10,
-- energy				= 2000,
	flammable			= 0,
	collisionvolumetype  = "CylY",
	collisionvolumescales = "80 180 80",
	collisionvolumeoffsets = "0 0 0",		
	footprintX			= 5,
	footprintZ			= 5,
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

