local objectname= "Buds" 
local featureDef	=	{
	name			= "Buds",
	world				="allworld",
	description				="Plant Stems",
	category				="Vegitation",
	object				="features/lathan/Buds.s3o",
	footprintx				=1,
	footprintz				=1,
	height				=8,
	blocking				=false,
	upright				=false,
	hitdensity				=0,
	energy = 10,
-- energy				=50,
	metal = 0,
--metal				=0,
	damage				=50,
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
