local objectname= "artBush1Hi" 
local featureDef	=	{
	name			= "artBush1Hi",
	world				="All Worlds",
	description				="artBush1Hi",
	category				="Vegetation",
	object				="features/artturi/artBush1Hi.s3o",
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
	collisionvolumetype				="box",
	collisionvolumescales				={5, 50, 5},
	collisionvolumeoffsets				={0, 0, 0},
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
