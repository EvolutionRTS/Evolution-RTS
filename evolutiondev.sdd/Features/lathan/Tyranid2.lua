-----------------------------------------------------------------------------
-- Tyranid2
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Tyranid2",
	blocking			= true,
	category			= "Vegitation",
	damage				= 6500,
	description			= "Tyranid Cappilary Tower",
	energy = 10,
-- energy				= 2300,
	flammable			= 0,
	footprintX			= 8,
	footprintZ			= 8,
	height				= 357,
	hitdensity			= "5",
	metal = 0,
--metal				= 10,
	object				= "features/lathan/Tyranid2.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

