local objectname= "Grass_Small" 
local featureDef	=	{
	name			= "Grass_Small",
	world				="allworld",
	description				="Tall Grass",
	category				="Vegitation",
	object				="features/lathan/Grass_Small.s3o",
	footprintx				=2,
	footprintz				=2,
	height				=12,
	blocking				=false,
	upright				=false,
	hitdensity				=0,
	energy = 10,
-- energy				=80,
	metal = 0,
--metal				=0,
	damage				=75,
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
