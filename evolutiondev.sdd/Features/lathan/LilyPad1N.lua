local objectname= "LilyPad1N" 
local featureDef	=	{
	name			= "LilyPad1N",
	world				="allworld",
	description				="Lily Pads",
	category				="Vegitation",
	object				="features/lathan/LilyPad1N.s3o",
	footprintx				=4,
	footprintz				=4,
	height				=13,
	blocking				=false,
	upright				=true,
	hitdensity				=0,
	energy				=220,
	metal				=0,
	damage				=120,
	flammable				=false,
	indestructible				="1.0",
	reclaimable				=false,
	autoreclaimable				=false,
	featurereclamate				="smudge01",
	seqnamereclamate				="tree1reclamate",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
