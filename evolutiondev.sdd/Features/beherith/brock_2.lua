local objectname= "brock_2" 
local featureDef	=	{
	name			= "brock_2",
	world				="All Worlds",
	description				="Rock",
	category				="Vegetation",
	object				="features/beherith/brock_2.s3o",
	footprintx				=1,
	footprintz				=1,
	height				=30,
	blocking				=true,
	upright				=false,
	hitdensity				=1,

	metal = 0,
--metal				=5,
	damage				=3000,
	flammable				=false,
	reclaimable				=true,
	autoreclaimable				=true,
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
