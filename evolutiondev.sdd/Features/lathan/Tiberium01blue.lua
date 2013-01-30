-----------------------------------------------------------------------------
-- Tiberium01blue
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Tiberium01blue",
	blocking			= true,
	category			= "rocks",
	damage				= 2800,
	description			= "Tiberium Crystal",
	energy = 10,
-- energy				= 1000,
	flammable			= 0,
	footprintX			= 4,
	footprintZ			= 4,
	height				= 27,
	hitdensity			= "5",
	indestructible		= true, 
	metal				= 1000,
	object				= "features/lathan/Tiberium01blue.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

