local objectname	= "streetlamp_1"

local featureDef	=	{
	name				= objectname,
	blocking			= true,
	category			= "urban",
	damage				= 2000,
	description			= "large streetlamp",
	energy = 10,
-- energy				= 20,
	flammable			= 0,
	footprintX			= 1,
	footprintZ			= 1,
	height				= "36",
	hitdensity			= "5",
	metal = 0,
--metal = 0, 
 --metal = 0,
--metal				= 3,
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

