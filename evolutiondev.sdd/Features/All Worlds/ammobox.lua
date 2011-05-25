local objectname= "ammobox" 
local featureDef	=	{
	name			= "ammobox",
	description				="Energy Core",
	object				="ammobox2.s3o",
	footprintx				=1,
	footprintz				=1,
	height				=5,
	blocking				=false,
	hitdensity				=0,
	metal				=5,
	energy				=5,
	damage				=10000,
	reclaimable				=true,
	autoreclaimable				=true,
--	nodrawundergray				="1.0",

  customParams = {
    provide_cover = 0,
  },

} 
return lowerkeys({[objectname] = featureDef}) 
