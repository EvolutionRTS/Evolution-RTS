-----------------------------------------------------------------------------
-- Tiberium07
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Tiberium07",
	blocking			= true,
	category			= "rocks",
	damage				= 2800,
	description			= "Tiberium Crystal",
	energy = 10,
-- energy				= 650,
	flammable			= 0,
	footprintX			= 2,
	footprintZ			= 2,
	height				= 13,
	hitdensity			= "5",
	indestructible		= true, 
	metal				= 10,
	object				= "features/lathan/Tiberium07.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

