local objectname= "WideLeafPlant" 
local featureDef	=	{
	name			= "WideLeafPlant",
	world				="allworld",
	description				="Plant",
	category				="Vegitation",
	object				="features/lathan/WideLeafPlant.s3o",
	footprintx				=2,
	footprintz				=2,
	height				=30,
	blocking				=false,
	upright				=false,
	hitdensity				=0,
	energy = 10,
-- energy				=240,
	metal				=0,
	damage				=150,
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
