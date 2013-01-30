local objectname= "Fern_Sword" 
local featureDef	=	{
	name			= "Fern_Sword",
	world				="allworld",
	description				="Fern",
	category				="Vegitation",
	object				="features/lathan/Fern_Sword.s3o",
	footprintx				=2,
	footprintz				=2,
	height				=15,
	blocking				=false,
	upright				=false,
	hitdensity				=0,
	energy = 10,
-- energy				=150,
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
