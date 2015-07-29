
local featureDef	=	{
	alwaysvisible		= true,
	name				= "Crystal Ring",
	blocking			= false,
	category			= "mexspot",
	damage				= 10000,
	description			= "Indicates metal deposit",
	energy				= 0,
	flammable			= 0,
	footprintX			= 0,
	footprintZ			= 0,
	height				= "8",
	hitdensity			= "0",
	metal				= 0,
	object				= "features/anarchid/mexes/crystal.dae",
	reclaimable			= false,
	autoreclaimable		= false,
	indestructible		= true, 	
	world				= "All Worlds",
}
return lowerkeys({crystalring = featureDef})
