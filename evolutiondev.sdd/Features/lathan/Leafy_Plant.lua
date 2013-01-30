local objectname= "Leafy_Plant" 
local featureDef	=	{
	name			= "Leafy_Plant",
	world				="allworld",
	description				="Orange Mushrooms",
	category				="Vegitation",
	object				="features/lathan/Leafy_Plant.s3o",
	footprintx				=2,
	footprintz				=2,
	height				=49,
	blocking				=false,
	upright				=true,
	hitdensity				=0,
	energy = 10,
-- energy				=200,
	metal				=0,
	damage				=120,
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
