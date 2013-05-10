-----------------------------------------------------------------------------
--  smothoilrig
-----------------------------------------------------------------------------
local featureDef	=	{
	name				= "smothoilrig",
	blocking			= true,
	category			= "Industrial",
	damage				= 10000,
	description			= "sci-fi oilrig",
	energy = 10,
-- energy				= 2000,
	featureDead			= "rubble",
	flammable			= false,
	footprintX			= 30,
	footprintZ			= 30,
	height				= "20",
	hitdensity			= "5",
	metal = 0,
--metal				= 350,
	object				= "features/smoth/smothoilrig.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[featureDef.name] = featureDef})
