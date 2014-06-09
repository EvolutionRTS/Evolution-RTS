local objectname= "CattailSmall" 
local featureDef	=	{
	name			= "CattailSmall",
	world				="allworld",
	description				="Cattails",
	category				="Vegitation",
	object				="features/lathan/CattailSmall.s3o",
	footprintx				=2,
	footprintz				=2,
	height				=27,
	blocking				=false,
	upright				=false,
	hitdensity				=0,
	energy = 10,
-- energy				=180,
	metal = 0,
--metal				=0,
	damage				=90,
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
