local objectname= "metal" 
local featureDef	=	{
	name			= "metal",
	world				="allworld",
	description				="Metal Patch",
	category				="Resource",
	object				="metal.s3o",
	footprintx				=4,
	footprintz				=4,
	height				=5,
	blocking				=false,
	hitdensity				=0,
	energy				=0,
	metal				=0,
	damage				=9999999999,
	flammable				=false,
	reclaimable				=false,
	autoreclaimable				=false,
	indestructible				=true,
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
