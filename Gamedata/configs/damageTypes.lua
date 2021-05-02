local damageClasses = {
	-- default class when nothing is specified
	default = "default",
	
	-- classes with armor classes for weapons
	damageTypes = {
		light = {
			LIGHT		= 2,
			ARMORED		= 1,
			BUILDING	= 0.5,
			AIR			= 1,
		},	
		turretantilight = {
			LIGHT		= 2,
			ARMORED		= 1,
			BUILDING	= 0.1,
			AIR			= 1,
		},
		turretantiarmored = {
			LIGHT		= 1,
			ARMORED		= 2,
			BUILDING	= 0.1,
			AIR			= 1,
		},
		antiarmored = {
			LIGHT		= 1,
			ARMORED		= 2,
			BUILDING	= 0.5,
			AIR			= 1,
		},	
		antibuilding = {
			LIGHT		= 1,
			ARMORED		= 1,
			BUILDING	= 2,
			AIR			= 1,
		},
		antiair = {
			LIGHT		= 1,
			ARMORED		= 1,
			BUILDING	= 0.5,
			AIR			= 2,
		},
		antilightarmored = {
			LIGHT		= 2,
			ARMORED		= 2,
			BUILDING	= 0.5,
			AIR			= 1,
		},
		antiarmoredbuilding = {
			LIGHT		= 1,
			ARMORED		= 2,
			BUILDING	= 2,
			AIR			= 1,
		},
		antibuildingair = {
			LIGHT		= 1,
			ARMORED		= 1,
			BUILDING	= 2,
			AIR			= 2,
		},
		antiarmoredair = {
			LIGHT		= 1,
			ARMORED		= 2,
			BUILDING	= 0.5,
			AIR			= 2,
		},
		turretantilightarmored = {
			LIGHT		= 2,
			ARMORED		= 2,
			BUILDING	= 0.1,
			AIR			= 1,
		},
			-- End Miscellaneous
		default = {
			LIGHT		= 1,
			ARMORED		= 1,
			BUILDING	= 1,
			AIR			= 1,
		},
	},
	
	armorDefs = {
		"LIGHT",
		"ARMORED",
		"BUILDING",
		"AIR",
	},
} 
return damageClasses;