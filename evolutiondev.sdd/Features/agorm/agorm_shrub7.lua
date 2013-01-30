-----------------------------------------------------------------------------
--  agorm_shrub7
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "agorm_shrub7",
	blocking			= true,
	category			= "vegitation",
	damage				= 100,
	description			= "shrub",
	energy = 10,
-- energy				= 1,
	flammable			= 0,
	footprintX			= 1,
	footprintZ			= 1,
	height				= "36",
	hitdensity			= "5",

	object				= "features/agorm/shrub7.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})