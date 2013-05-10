local objectname= "SnowPipeTPWE" 
local featureDef	=	{
	name			= "SnowPipeTPWE",
	world				="allworld",
	description				="SnowyPipe",
	category				="SnowyPipes",
	object				="features/lathan/SnowPipeTPWE.s3o",
	footprintx				=7,
	footprintz				=2,
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
