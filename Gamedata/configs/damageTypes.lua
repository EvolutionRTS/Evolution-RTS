local damageClasses = {
	-- default class when nothing is specified
	default = "default",
	
	-- classes with armor classes for weapons
	damageTypes = {
		--
		light = { -- These values should always mirror antilight and vice versa
			LIGHT		= 1.5,
			ARMORED		= 1,
			BUILDING	= 1,
			AIR			= 1,
		},
		antilight = {
			LIGHT		= 1.5,
			ARMORED		= 1,
			BUILDING	= 1,
			AIR			= 1,
		},
		--
		turretantilight = {
			LIGHT		= 1.5,
			ARMORED		= 1,
			BUILDING	= 0.1,
			AIR			= 1,
		},
		turretantiarmored = {
			LIGHT		= 1,
			ARMORED		= 1.5,
			BUILDING	= 0.1,
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
		antibuildingarty = {
			LIGHT		= 0.25,
			ARMORED		= 0.25,
			BUILDING	= 1.5,
			AIR			= 0.25,
		},
		antiair = {
			LIGHT		= 1,
			ARMORED		= 1,
			BUILDING	= 1,
			AIR			= 1.5,
		},
		antilightarmored = {
			LIGHT		= 1.5,
			ARMORED		= 1.5,
			BUILDING	= 1,
			AIR			= 1,
		},
		antilightbuilding = {
			LIGHT		= 1.5,
			ARMORED		= 1,
			BUILDING	= 1.5,
			AIR			= 1,
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
		turretantilightarmored = {
			LIGHT		= 1.5,
			ARMORED		= 1.5,
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