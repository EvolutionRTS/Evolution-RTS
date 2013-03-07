local objectname= "BushyPlant" 
local featureDef	=	{
	name			= "BushyPlant",
	world				="allworld",
	description				="Bushy Plant",
	category				="Vegitation",
	object				="features/lathan/BushyPlant.s3o",
	footprintx				=2,
	footprintz				=2,
	height				=12,
	blocking				=false,
	upright				=false,
	hitdensity				=0,
	energy = 10,
-- energy				=220,
	metal = 0,
--metal				=0,
	damage				=80,
	flammable				=false,
	reclaimable				=true,
	autoreclaimable				=true,
	featurereclamate				="smudge01",
	seqnamereclamate				="tree1reclamate",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
