local objectname= "CattailBig" 
local featureDef	=	{
	name			= "CattailBig",
	world				="allworld",
	description				="Cattails",
	category				="Vegitation",
	object				="features/lathan/CattailBig.s3o",
	footprintx				=3,
	footprintz				=3,
	height				=33,
	blocking				=false,
	upright				=false,
	hitdensity				=0,
	energy = 10,
-- energy				=290,
	metal = 0,
--metal				=0,
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
