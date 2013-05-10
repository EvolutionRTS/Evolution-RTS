-----------------------------------------------------------------------------
-- STRoot101
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "STRoot101",
	blocking			= true,
	category			= "Vegitation",
	damage				= 6500,
	description			= "Gigantic Swamp Tree",
	energy = 10,
-- energy				= 2300,
	flammable			= 0,
	footprintX			= 3,
	footprintZ			= 3,
	height				= "4972",
	hitdensity			= "5",
	metal = 0,
--metal				= 10,
	object				= "features/lathan/STRoot101.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

