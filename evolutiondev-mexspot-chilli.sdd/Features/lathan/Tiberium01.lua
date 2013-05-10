-----------------------------------------------------------------------------
-- Tiberium01
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Tiberium01",
	blocking			= true,
	category			= "rocks",
	damage				= 2800,
	description			= "Tiberium Crystal",
	energy = 10,
-- energy				= 1600,
	flammable			= 0,
	footprintX			= 2,
	footprintZ			= 2,
	height				= 27,
	hitdensity			= "5",
	indestructible		= true, 
	metal = 0,
--metal				= 150,
	object				= "features/lathan/Tiberium01.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

