local objectname= "PosionIvy" 
local featureDef	=	{
	name			= "PosionIvy",
	world				="allworld",
	description				="Posion Ivy",
	category				="Vegitation",
	object				="features/lathan/PosionIvy.s3o",
	footprintx				=1,
	footprintz				=1,
	height				=46,
	blocking				=false,
	upright				=true,
	hitdensity				=0,
	energy = 10,
-- energy				=140,
	metal				=0,
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
