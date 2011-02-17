local objectname= "SnowPipeTBS" 
local featureDef	=	{
	name			= "SnowPipeTBS",
	world				="allworld",
	description				="SnowyPipe",
	category				="SnowyPipes",
	object				="features/lathan/SnowPipeTBS.s3o",
	footprintx				=4,
	footprintz				=8,
	height				=78,
	blocking				=true,
	upright				=true,
	hitdensity				=5,
	energy				=0,
	metal				=220,
	damage				=900,
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
