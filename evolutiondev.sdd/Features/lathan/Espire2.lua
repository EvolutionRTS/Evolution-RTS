-----------------------------------------------------------------------------
--  Espire2
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "Espire2",
	blocking			= true,
	category			= "rocks",
	damage				= 4000,
	description			= "Energy Spire",
	energy = 10,
-- energy				= 200,
	flammable			= 0,
	footprintX			= 2,
	footprintZ			= 2,
	height				= "20",
	hitdensity			= "5",
	metal				= 10,
	object				= "features/lathan/Espire2.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

