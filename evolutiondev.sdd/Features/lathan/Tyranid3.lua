-----------------------------------------------------------------------------
-- Tyranid3
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Tyranid3",
	blocking			= true,
	category			= "Vegitation",
	damage				= 2000,
	description			= "Tyranid Cappilary Tower",
	energy = 10,
-- energy				= 2300,
	flammable			= 0,
	footprintX			= 4,
	footprintZ			= 4,
	height				= 272,
	hitdensity			= "5",
	indestructible		= true, 
	metal = 0,
--metal				= 10,
	object				= "features/lathan/Tyranid3.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

