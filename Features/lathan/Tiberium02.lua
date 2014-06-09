-----------------------------------------------------------------------------
-- Tiberium02
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Tiberium02",
	blocking			= true,
	category			= "rocks",
	damage				= 2800,
	description			= "Tiberium Crystal",
	energy = 10,
-- energy				= 1450,
	flammable			= 0,
	footprintX			= 2,
	footprintZ			= 2,
	height				= 27,
	hitdensity			= "5",
	indestructible		= true, 
	metal = 0,
--metal				= 100,
	object				= "features/lathan/Tiberium02.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

