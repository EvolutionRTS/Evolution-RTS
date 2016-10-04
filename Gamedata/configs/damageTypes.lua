local damageClasses = {
	-- default class when nothing is specified
	default = "default",
	
	-- classes with armor classes for weapons
	damageTypes = {
		nonexistent	= {
			SIEGE		= 0.1,
			ARMORED		= 0.1,
			LIGHT		= 0.1,
			BUILDING 	= 0.1,
		},	
		----------------------------------------------------------------------------			
		-- Overseers with weapons
		ecommanderbattle	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		
		-- Start Hovers
		eaatank	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 0.66,
			BUILDING 	= 0.66,
		},
		eartytank	= {
			SIEGE		= 0.50,
			ARMORED		= 0.50,
			LIGHT		= 0.50,
			BUILDING 	= 1,
		},
		ebomb	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 0.5,
			BUILDING 	= 1,
		},
		efatso	= {
			SIEGE		= 0.125,
			ARMORED		= 0.125,
			LIGHT		= 0.125,
			BUILDING 	= 1,
		},
		eflametank	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 0.5,
			BUILDING 	= 1,
		},
		elighttank3	= {
			SIEGE		= 0.75,
			ARMORED		= 0.75,
			LIGHT		= 0.75,
			BUILDING 	= 1,
		},
		eheavytank3	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.33,
		},
		emediumtank3	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.5,
		},
		emissiletank	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},	
		eriottank2	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},		
		eriottank2shotgun	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.25,
		},	
		elacerator	= {
			SIEGE		= 0.33,
			ARMORED		= 0.33,
			LIGHT		= 0.33,
			BUILDING 	= 1,
		},
		-- End Hovers
			
		-- Start All Terrains
		eallterrheavy	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eallterrlight	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eallterrmed	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.5,
		},	
		eallterraa	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 0.66,
			BUILDING 	= 0.66,
		},
		eallterrriot	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eallterrriotshotgun	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.25,
		},
		eallterrassault	= {
			SIEGE		= 0.50,
			ARMORED		= 0.50,
			LIGHT		= 0.50,
			BUILDING 	= 1,
		},
		eallterranarchid = {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 0.5,
			BUILDING 	= 1,
		},
		eallterranarchidflame = {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 0.5,
			BUILDING 	= 1,
		},
		-- End All Terrains
			
		-- Start Amphibs
		eamphibbuggy	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		eamphibriot	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eamphibneedle	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eamphibriotshotgun	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.25,
		},
		eamphibaa	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eamphibmedtank	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eamphibrock	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.5,
		},
		eamphibarty	= {
			SIEGE		= 0.50,
			ARMORED		= 0.50,
			LIGHT		= 0.50,
			BUILDING 	= 1,
		},
		eamphibleveler	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		-- End Amphibs
			
		-- Start Aircraft
		edrone	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		efighter	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.25,
		},
		egunship2	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.25,
		},	
		egunship2torpedo	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.25,
		},	
		ebomber	= {
			SIEGE		= 0.75,
			ARMORED		= 0.75,
			LIGHT		= 0.75,
			BUILDING 	= 1,
		},
		-- End Aircraft
			
		-- Start Experimentals
		eexkrabgroth	= {
			SIEGE		= 0.1,
			ARMORED		= 0.1,
			LIGHT		= 0.1,
			BUILDING 	= 1,
		},	
		eextankdestroyer	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
		eexnukearty	= {
			SIEGE		= 0.5,			
			ARMORED		= 0.5,
			LIGHT		= 0.5,
			BUILDING 	= 1,
		},
		-- End Experimentals
			
		-- Start Buildings
		elightturret2	= {
			SIEGE		= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
		eheavyturret2	= {
			SIEGE		= 0.5,
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.1,
		},
		eaaturret	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 0.66,
			BUILDING 	= 0.66,
		},
		elrpc	= {
			SIEGE		= 0.25,
			ARMORED		= 0.25,
			LIGHT		= 0.25,
			BUILDING 	= 1,
		},
		euwturret	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
		emine	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0,
		},
		-- End Buildings
			
		-- Start Miscellaneous
		queenbeam	= {
			SIEGE		= 0.1,
			ARMORED		= 0.1,
			LIGHT		= 0.1,
			BUILDING 	= 1,
		},	
		queenflames	= {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},	
		queencannon = {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},	
			
			-- End Miscellaneous
		default = {
			SIEGE		= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
	},
	
	armorDefs = {
		"LIGHT", 
		"ARMORED",
		"SIEGE",
		"BUILDING", 
	},
} 
return damageClasses;