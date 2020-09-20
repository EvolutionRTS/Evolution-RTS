local damageClasses = {
	-- default class when nothing is specified
	default = "default",
	
	-- classes with armor classes for weapons
	damageTypes = {
		light = {
			LIGHT		= 1,
			ARMORED		= 1,
			BUILDING	= 1,
			AIR			= 1,
		},	
		antiarmored = {
			LIGHT		= 1,
			ARMORED		= 2,
			BUILDING	= 1,
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
			BUILDING	= 1,
			AIR			= 2,
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
			BUILDING	= 1,
			AIR			= 2,
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