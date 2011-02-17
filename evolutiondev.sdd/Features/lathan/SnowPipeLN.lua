local objectname= "SnowPipeLN" 
local featureDef	=	{
	name			= "SnowPipeLN",
	world				="allworld",
	description				="SnowyPipe",
	category				="SnowyPipes",
	object				="features/lathan/SnowPipeLN.s3o",
	footprintx				=5,
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
