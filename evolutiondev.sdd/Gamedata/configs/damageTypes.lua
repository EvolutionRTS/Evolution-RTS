local damageClasses = {
	-- default class when nothing is specified
	default = "default",
	
	-- classes with armor classes for weapons
	damageTypes = {
		nonexistent	= {
			ARMORED		= 0.1,
			LIGHT		= 0.1,
			BUILDING 	= 0.1,
		},	
		----------------------------------------------------------------------------			
			
		-- Start Hovers
		eaatank	= {
			ARMORED		= 1,
			LIGHT		= 0.66,
			BUILDING 	= 0.66,
		},
		eartytank	= {
			ARMORED		= 0.25,
			LIGHT		= 0.25,
			BUILDING 	= 1,
		},
		ebomb	= {
			ARMORED		= 0.5,
			LIGHT		= 0.5,
			BUILDING 	= 1,
		},
		efatso	= {
			ARMORED		= 0.125,
			LIGHT		= 0.125,
			BUILDING 	= 1,
		},
		eflametank	= {
			ARMORED		= 0.25,
			LIGHT		= 0.25,
			BUILDING 	= 1,
		},
		elighttank3	= {
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eheavytank3	= {
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		emediumtank3	= {
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.5,
		},
		emissiletank	= {
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},	
		eriottank2	= {
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		-- End Hovers
			
		-- Start All Terrains
		eallterrheavy	= {
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eallterrlight	= {
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eallterrmed	= {
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.5,
		},	
		eallterraa	= {
			ARMORED		= 1,
			LIGHT		= 0.66,
			BUILDING 	= 0.66,
		},
		eallterrriot	= {
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eallterrassault	= {
			ARMORED		= 0.125,
			LIGHT		= 0.125,
			BUILDING 	= 1,
		},
		-- End All Terrains
			
		-- Start Amphibs
		eamphibbuggy	= {
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eamphibriot	= {
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eamphibmedtank	= {
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eamphibrock	= {
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.5,
		},
		eamphibarty	= {
			ARMORED		= 0.25,
			LIGHT		= 0.25,
			BUILDING 	= 1,
		},
		-- End Amphibs
			
		-- Start Aircraft
		edrone	= {
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		efighter	= {
			ARMORED		= 1,
			LIGHT		= 0.66,
			BUILDING 	= 0.66,
		},
		egunship2	= {
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},	
		ebomber	= {
			ARMORED		= 0.25,
			LIGHT		= 0.25,
			BUILDING 	= 1,
		},
		-- End Aircraft
			
		-- Start Experimentals
		eexkrabgroth	= {
			ARMORED		= 0.1,
			LIGHT		= 0.1,
			BUILDING 	= 1,
		},	
		eextankdestroyer	= {
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
			eexnukearty	= {
			ARMORED		= 0.5,
			LIGHT		= 0.5,
			BUILDING 	= 1,
		},
		-- End Experimentals
			
		-- Start Buildings
		elightturret2	= {
			ARMORED		= 0.25,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
		eheavyturret2	= {
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.1,
		},
		eaaturret	= {
			ARMORED		= 1,
			LIGHT		= 0.66,
			BUILDING 	= 0.66,
		},
		elrpc	= {
			ARMORED		= 0.25,
			LIGHT		= 0.25,
			BUILDING 	= 1,
		},
		euwturret	= {
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
		-- End Buildings
			
		-- Start Miscellaneous
		queenbeam	= {
			ARMORED		= 0.1,
			LIGHT		= 0.1,
			BUILDING 	= 1,
		},	
		queenflames	= {
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
		queencannon = {
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
			-- End Miscellaneous
		default = {
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
	},
	
	armorDefs = {
		"LIGHTARMOR", 
		"MEDIUMARMOR",
		"HEAVYARMOR",
		"BUILDING", 
	},
} 
return damageClasses;