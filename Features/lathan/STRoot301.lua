-----------------------------------------------------------------------------
-- STRoot301
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "STRoot301",
	blocking			= true,
	category			= "Vegitation",
	damage				= 6500,
	description			= "Gigantic Swamp Tree",
	energy = 10,
-- energy				= 2300,
	flammable			= 0,
	footprintX			= 4,
	footprintZ			= 13,
	height				= "4972",
	hitdensity			= "5",
	indestructible		= true, 
	metal = 0,
--metal				= 10,
	object				= "features/lathan/STRoot301.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

