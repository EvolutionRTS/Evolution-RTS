local objectname= "WeedSmall" 
local featureDef	=	{
	name			= "WeedSmall",
	world				="allworld",
	description				="Weeds",
	category				="Vegitation",
	object				="features/lathan/WeedSmall.s3o",
	footprintx				=3,
	footprintz				=2,
	height				=15,
	blocking				=false,
	upright				=false,
	hitdensity				=0,
	energy = 10,
-- energy				=130,
	metal				=0,
	damage				=70,
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
