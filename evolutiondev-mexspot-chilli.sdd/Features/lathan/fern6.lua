local objectname= "fern6" 
local featureDef	=	{
	name			= "fern6",
	world				="All Worlds",
	description				="Ferns",
	category				="arm_corpses",
	object				="features/lathan/fern6.s3o",
	footprintx				=1,
	footprintz				=1,
	height				=7,
	blocking				=true,
	hitdensity				=2000,
	metal = 0,
--metal				=5,
	damage				=10000,
	flammable				=false,
	featurereclamate				="smudge01",
	seqnamereclamate				="tree1reclamate",
	indestructible				="0.0",
	upright				=true,
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
