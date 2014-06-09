local objectname= "ad0_bushes_m_1" 
local featureDef	=	{
	name			= "ad0_bushes_m_1",
	world				="All Worlds",
	description				="Medium Bush",
	category				="Vegetation",
	object				="features/0ad/bushes/ad0_bushes_m_1.s3o",
	footprintx				=0,
	footprintz				=0,
	height				=30,
	blocking				=false,
	upright				=true,
	hitdensity				=0,
	energy = 10,
-- energy				=1,
	metal = 0,
--metal				=0,
	damage				=40,
	flammable				=false,
	reclaimable				=true,
	autoreclaimable				=true,
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
