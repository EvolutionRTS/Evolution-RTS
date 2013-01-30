-----------------------------------------------------------------------------
--  smothdist
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "smothdist",
	blocking			= true,
	category			= "industrial",
	damage				= 2000,
	description			= "distiller",
	energy = 10,
-- energy				= 20,
	featureDead			= "rubble",
	flammable			= 0,
	footprintX			= 6,
	footprintZ			= 5,
	height				= "36",
	hitdensity			= "5",
	metal				= 20,
	object				= "features/smoth/smothdist.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

