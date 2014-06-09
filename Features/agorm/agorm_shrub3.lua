-----------------------------------------------------------------------------
--  agorm_shrub3
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "agorm_shrub3",
	blocking			= true,
	category			= "vegitation",
	damage				= 100,
	energy = 10,
-- energy				= 1,
	description			= "shrub",
	flammable			= true,
	footprintX			= 1,
	footprintZ			= 1,
	height				= "36",
	hitdensity			= "5",

	object				= "features/agorm/shrub3.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})