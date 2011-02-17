local objectname= "WeedBig" 
local featureDef	=	{
	name			= "WeedBig",
	world				="allworld",
	description				="Weeds",
	category				="Vegitation",
	object				="features/lathan/WeedBig.s3o",
	footprintx				=4,
	footprintz				=3,
	height				=24,
	blocking				=false,
	upright				=false,
	hitdensity				=0,
	energy				=200,
	metal				=0,
	damage				=110,
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
