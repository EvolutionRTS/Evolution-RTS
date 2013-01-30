-----------------------------------------------------------------------------
-- Tiberium09
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Tiberium09",
	blocking			= true,
	category			= "rocks",
	damage				= 2800,
	description			= "Tiberium Crystal",
	energy = 10,
-- energy				= 450,
	flammable			= 0,
	footprintX			= 2,
	footprintZ			= 2,
	height				= 13,
	hitdensity			= "5",
	indestructible		= true, 
	metal				= 10,
	object				= "features/lathan/Tiberium09.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

