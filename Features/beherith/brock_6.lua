local objectname= "brock_6" 
local featureDef	=	{
	name			= "brock_6",
	world				="All Worlds",
	description				="Rock",
	category				="Vegetation",
	object				="features/beherith/brock_6.s3o",
	footprintx				=3,
	footprintz				=3,
	height				=30,
	blocking				=true,
	upright				=false,
	hitdensity				=1,

	metal = 0,
--metal				=10,
	damage				=3000,
	flammable				=false,
	reclaimable				=true,
	autoreclaimable				=true,
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
