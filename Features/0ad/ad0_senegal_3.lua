local objectname= "ad0_senegal_3" 
local featureDef	=	{
	name			= "ad0_senegal_3",
	world				="All Worlds",
	description				="Palm Tree",
	category				="Vegetation",
	object				="features/0ad/ad0_senegal_3.s3o",
	footprintx				=2,
	footprintz				=2,
	height				=30,
	blocking				=true,
	upright				=true,
	hitdensity				=0,
	energy = 10,
-- energy				=1,

	damage				=100,
	flammable				=true,
	reclaimable				=true,
	autoreclaimable				=true,
	featurereclamate				="smudge01",
	seqnamereclamate				="tree1reclamate",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
