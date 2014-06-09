-----------------------------------------------------------------------------
-- Tiberium08
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Tiberium08",
	blocking			= true,
	category			= "rocks",
	damage				= 2800,
	description			= "Tiberium Crystal",
	energy = 10,
-- energy				= 500,
	flammable			= 0,
	footprintX			= 2,
	footprintZ			= 2,
	height				= 11,
	hitdensity			= "5",
	indestructible		= true, 
	metal = 0,
--metal				= 10,
	object				= "features/lathan/Tiberium08.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

