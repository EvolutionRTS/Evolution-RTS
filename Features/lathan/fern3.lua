local objectname= "fern3" 
local featureDef	=	{
	name			= "fern3",
	world				="All Worlds",
	description				="Ferns",
	category				="arm_corpses",
	object				="features/lathan/fern3.s3o",
	footprintx				=1,
	footprintz				=1,
	height				=7,
	blocking				=true,
	hitdensity				=1000,
	metal = 0,
--metal				=10,
	damage				=300,
	flammable				=false,
	featurereclamate				="smudge01",
	seqnamereclamate				="tree1reclamate",
	indestructible				="0.0",
	upright				=true,
	energy = 10,
-- energy				=100,
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
