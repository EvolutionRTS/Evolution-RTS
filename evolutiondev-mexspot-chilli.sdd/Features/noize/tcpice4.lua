-----------------------------------------------------------------------------
--  tcpice4
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "tcpice4",
	blocking			= true,
	category			= "Rocks",
	damage				= 1000,
	description			= "Ice Rock",
	energy = 10,
-- energy				= 0,
	flammable			= 0,
	footprintX			= 3,
	footprintZ			= 3,
	height				= "21",
	hitdensity			= "5",
	metal = 0,
--metal				= 10,
	object				= "features/noize/tcpice4.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})

