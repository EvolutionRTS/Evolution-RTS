local objectname= "SnowPipeTPNS" 
local featureDef	=	{
	name			= "SnowPipeTPNS",
	world				="allworld",
	description				="SnowyPipe",
	category				="SnowyPipes",
	object				="features/lathan/SnowPipeTPNS.s3o",
	footprintx				=2,
	footprintz				=7,
	height				=78,
	blocking				=true,
	upright				=true,
	hitdensity				=5,
	energy = 10,
-- energy				=0,
	metal = 0,
--metal				=220,
	damage				=200,
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
