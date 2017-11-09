local unitname = "energycore"
local unitDef	=	{
	name				= "energycore",
	category            = "LIGHT NOTAIR",
	buildCostEnergy     = 0,
	buildCostMetal      = 5,
	buildTime           = 5,
	description			= [[Energy Core
	� Can be reclaimed for 5 Metal and 5 Energy by moving an O.R.B. in range
	
	� Can be converted to MidKnight Gunship Drone by moving a B.O.X. in range
]],
	objectName			= "ammobox2.s3o",		-- for christmas: 'xmasball.3so'
	script 				= 'energycore.lua',		-- for christmas: 'xmasball.lua'
	collisionvolumeoffsets = "0 6 0",
	collisionvolumescales = "12 12 12",
	collisionvolumetype = "Box",
	footprintx			= 1,
	footprintz			= 1,
	height				= 5,
	blocking			= true,
	hitdensity			= 0,
	metal				= 5,
	energy				= 5,
	damage				= 10000,
	canattack			= false,
	canrepeat			= false,
	hidedamage			= true,
	reclaimable			= false,
	repairable			= false,
	autoreclaimable		= false,
	indestructible		= true,
	smokeTime			= 0,
	sightdistance		= 0,
	seismicsignature	= 0,
	stealth				= true,
	sonarStealth		= true,
	capturable			= false,
	canmove				= true,
	maxvelocity			= 1,
	movementclass		= "ALLTERRTANK4",
	usebuildinggrounddecal = false,
--	nodrawundergray		= "1.0",

	customParams = {
		provide_cover = 0,
		nohealthbars = true,
		needed_cover = 99999999,
		cannotcloak = true,
	},

} 
return lowerkeys({[unitname] = unitDef})