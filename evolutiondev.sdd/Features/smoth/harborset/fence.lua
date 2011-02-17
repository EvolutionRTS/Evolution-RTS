local objectname	= "fence"

local featureDef	=	{
	name				= objectname,
	blocking			= false,
	category			= "industrial",
	damage				= 20,
	description			= "hurricane fencing",
	energy				= 20,
	flammable			= 0,
	footprintX			= 1,
	footprintZ			= 2,
	height				= "36",
	hitdensity			= "5",
	metal				= 1,
	object				= "features/smoth/harborset/" .. objectname .. ".s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	upright				= true,
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef})

