-----------------------------------------------------------------------------
-- Tiberium04
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Tiberium04",
	blocking			= true,
	category			= "rocks",
	damage				= 2800,
	description			= "Tiberium Crystal",
	energy				= 1050,
	flammable			= 0,
	footprintX			= 2,
	footprintZ			= 2,
	height				= 357,
	hitdensity			= "5",
	indestructible		= true, 
	metal				= 60,
	object				= "features/lathan/Tiberium04.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

