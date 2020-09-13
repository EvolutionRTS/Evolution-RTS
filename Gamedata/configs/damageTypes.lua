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
			ARMORED		= 1.5,
			BUILDING	= 1,
			AIR			= 1,
		},	
		antibuilding = {
			LIGHT		= 1,
			ARMORED		= 1,
			BUILDING	= 1.5,
			AIR			= 1,
		},
		antiair = {
			LIGHT		= 1,
			ARMORED		= 1,
			BUILDING	= 1,
			AIR			= 1.5,
		},
		antiarmoredbuilding = {
			LIGHT		= 1,
			ARMORED		= 1.5,
			BUILDING	= 1.5,
			AIR			= 1,
		},
		antibuildingair = {
			LIGHT		= 1,
			ARMORED		= 1,
			BUILDING	= 1.5,
			AIR			= 1.5,
		},
		antiarmoredair = {
			LIGHT		= 1,
			ARMORED		= 1.5,
			BUILDING	= 1,
			AIR			= 1.5,
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