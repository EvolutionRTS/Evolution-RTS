local objectname= "ammobox" 
local featureDef	=	{
	name			= "ammobox",
	description				=[[Energy Core
	• Can be reclaimed by moving an Overseer or an ORB in range for +5m/+5e
	• Can be converted to MidKnight Gunship Drone by moving an Engineer in range
]],
	object				="ammobox2.s3o",
	footprintx				=1,
	footprintz				=1,
	height				=5,
	blocking				=false,
	hitdensity				=0,
	metal				=5,
	energy				=5,
	damage				=10000,
	reclaimable				=false,
	autoreclaimable				=false,
--	nodrawundergray				="1.0",

  customParams = {
    provide_cover = 0,
  },

} 
return lowerkeys({[objectname] = featureDef}) 
