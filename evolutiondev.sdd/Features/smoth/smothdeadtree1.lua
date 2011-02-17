-----------------------------------------------------------------------------
--  smothdeadtree1
-----------------------------------------------------------------------------

local featureDef = {

	name				= "smothdeadtree1",
	blocking			= true,
	category			= "Trees",
	damage				= 100,
	description			= "Dead Tree",
	energy				= 1,
	featuredead			= "smothtree123dead",	
	flammable			= 1,
	footprintX			= 1,
	footprintZ			= 1,
	height				= "36",
	hitdensity			= "5",
	object				= "features/smoth/smothdeadtree1.s3o",
	reclaimable			= true,
	autoreclaimable		= true, 	
	world				= "All Worlds",
	customparams = { 
		randomrotate		= "true", 
	}, 
}

return lowerkeys({[featureDef.name] = featureDef})


	