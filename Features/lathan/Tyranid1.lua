-----------------------------------------------------------------------------
-- Tyranid1
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Tyranid1",
	blocking			= true,
	category			= "Vegitation",
	damage				= 2800,
	description			= "Tyranid Cappilary Tower",
	energy = 10,
-- energy				= 2300,
	flammable			= 0,
	footprintX			= 11,
	footprintZ			= 7,
	height				= 357,
	hitdensity			= "5",
	indestructible		= true, 
	metal = 0,
--metal				= 10,
	object				= "features/lathan/Tyranid1.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

