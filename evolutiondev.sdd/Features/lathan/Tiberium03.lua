-----------------------------------------------------------------------------
-- Tiberium03
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Tiberium03",
	blocking			= true,
	category			= "rocks",
	damage				= 2800,
	description			= "Tiberium Crystal",
	energy				= 1250,
	flammable			= 0,
	footprintX			= 2,
	footprintZ			= 2,
	height				= 27,
	hitdensity			= "5",
	indestructible		= true, 
	metal				= 75,
	object				= "features/lathan/Tiberium03.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

