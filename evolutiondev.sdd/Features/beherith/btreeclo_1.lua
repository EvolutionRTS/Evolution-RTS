local objectname= "btreeclo_1" 
local featureDef	=	{
	name			= "btreeclo_1",
	world				="All Worlds",
	description				="Cedar Tree",
	category				="Vegetation",
	object				="features/beherith/btreeclo_1.s3o",
	footprintx				=3,
	footprintz				=3,
	height				=30,
	blocking				=true,
	upright				=true,
	hitdensity				=50,
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
