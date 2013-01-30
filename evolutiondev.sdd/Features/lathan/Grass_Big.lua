local objectname= "Grass_Big" 
local featureDef	=	{
	name			= "Grass_Big",
	world				="allworld",
	description				="Tall Grass",
	category				="Vegitation",
	object				="features/lathan/Grass_Big.s3o",
	footprintx				=4,
	footprintz				=4,
	height				=12,
	blocking				=false,
	upright				=true,
	hitdensity				=0,
	energy = 10,
-- energy				=160,
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
