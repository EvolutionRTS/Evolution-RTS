local objectname= "SquattyGrass" 
local featureDef	=	{
	name			= "SquattyGrass",
	world				="allworld",
	description				="Grass Tuffs",
	category				="Vegitation",
	object				="features/lathan/SquattyGrass.s3o",
	footprintx				=3,
	footprintz				=2,
	height				=14,
	blocking				=false,
	upright				=false,
	hitdensity				=0,
	energy = 10,
-- energy				=140,
	metal				=0,
	damage				=90,
	flammable				=false,
	indestructible				="1.0",
	reclaimable				=false,
	autoreclaimable				=false,
	featurereclamate				="smudge01",
	seqnamereclamate				="tree1reclamate",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
