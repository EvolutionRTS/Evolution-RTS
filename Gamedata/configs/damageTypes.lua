local damageClasses = {
	-- default class when nothing is specified
	default = "default",
	
	-- classes with armor classes for weapons
	damageTypes = {
		nonexistent	= {
			AIRLIGHT	= 0.1,
			AIRARMORED	= 0.1,
			ARMORED		= 0.1,
			LIGHT		= 0.1,
			BUILDING 	= 0.1,
		},	
		
		pdlaser	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		----------------------------------------------------------------------------			
		-- Overseers with weapons
		ecommanderbattle	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
		-- Overseers with weapons
		ecommandermeteor	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		
		-- Start H-Bots
		ehbotpeewee	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		ehbotthud	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		ehbotsniper	= {
			AIRLIGHT	= 0.5,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.5,
		},
		ehbotrocko	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		ehbotkarganneth	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		
		-- Start Hovers
		eaatank	= {
			AIRLIGHT	= 0.66,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 0.66,
			BUILDING 	= 0.66,
		},
		eartytank	= {
			AIRLIGHT	= 0.25,
			AIRARMORED	= 0.25,
			ARMORED		= 0.25,
			LIGHT		= 0.25,
			BUILDING 	= 1,
		},
		eartytank_saturation	= {
			AIRLIGHT	= 0.25,
			AIRARMORED	= 0.25,
			ARMORED		= 0.25,
			LIGHT		= 0.25,
			BUILDING 	= 1,
		},
		ebomb	= {
			AIRLIGHT	= 0.5,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 0.5,
			BUILDING 	= 1,
		},
		efatso	= {
			AIRLIGHT	= 0.125,
			AIRARMORED	= 0.125,
			ARMORED		= 0.125,
			LIGHT		= 0.125,
			BUILDING 	= 1,
		},
		eflametank	= {
			AIRLIGHT	= 0.5,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 0.5,
			BUILDING 	= 1,
		},
		elighttank3	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.6,
			ARMORED		= 0.6,
			LIGHT		= 0.6,
			BUILDING 	= 1,
		},
		eheavytank3	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.33,
		},
		emediumtank3	= {
			AIRLIGHT	= 0.5,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.5,
		},
		emissiletank	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},	
		eriottank2	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},		
		eriottank2shotgun	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.25,
		},	
		elacerator	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		-- End Hovers
			
		-- Start All Terrains
		eallterrheavy	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eallterrlight	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eallterrmed	= {
			AIRLIGHT	= 0.5,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.5,
		},	
		eallterraa	= {
			AIRLIGHT	= 0.66,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 0.66,
			BUILDING 	= 0.66,
		},
		eallterrriot	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eallterrriotshotgun	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.25,
		},
		eallterrassault	= {
			AIRLIGHT	= 0.25,
			AIRARMORED	= 0.25,
			ARMORED		= 0.25,
			LIGHT		= 0.25,
			BUILDING 	= 1,
		},
		eallterranarchid = {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		eallterranarchidflame = {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		-- End All Terrains
			
		-- Start Amphibs
		eamphibbuggy	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		eamphibriot	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eamphibneedle	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eamphibriotshotgun	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.25,
		},
		eamphibaa	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eamphibmedtank	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		eamphibrock	= {
			AIRLIGHT	= 0.5,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.5,
		},
		eamphibarty	= {
			AIRLIGHT	= 0.25,
			AIRARMORED	= 0.25,
			ARMORED		= 0.25,
			LIGHT		= 0.25,
			BUILDING 	= 1,
		},
		eamphibleveler	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		-- End Amphibs
			
		-- Start Aircraft
		edrone	= {
			AIRLIGHT	= 0.5,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 0.5,
			BUILDING 	= 1,
		},
		eraider	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		efighter	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.25,
			ARMORED		= 0.25,
			LIGHT		= 1,
			BUILDING 	= 0.25,
		},
		egunship2	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.25,
		},	
		egunship2torpedo	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.25,
		},	
		ebomber	= {
			AIRLIGHT	= 0.25,
			AIRARMORED	= 0.25,
			ARMORED		= 0.25,
			LIGHT		= 0.25,
			BUILDING 	= 1,
		},
		ekrow	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		-- End Aircraft
			
		-- Start Experimentals
		eexkrabgroth	= {
			AIRLIGHT	= 0.1,
			AIRARMORED	= 0.1,
			ARMORED		= 0.1,
			LIGHT		= 0.1,
			BUILDING 	= 1,
		},	
		eextankdestroyer	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
		eexnukearty	= {
			AIRLIGHT	= 0.5,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 0.5,
			BUILDING 	= 1,
		},
		-- End Experimentals
			
		-- Start Buildings
		elightturret2	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
		eheavyturret2	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
		elaserbattery	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
		elrpc	= {
			AIRLIGHT	= 0.25,
			AIRARMORED	= 0.25,
			ARMORED		= 0.25,
			LIGHT		= 0.25,
			BUILDING 	= 1,
		},
		euwturret	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},
		emine	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0,
		},
		-- End Buildings
		
		-- Start Zaal
		zlightswarm	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 1,
			BUILDING 	= 0.5,
		},
		zmedswarm	= {
			AIRLIGHT	= 0.5,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 0.5,
			BUILDING 	= 0.5,
		},			
		zskirmisher	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		zpyro	= {
			AIRLIGHT	= 0.5,
			AIRARMORED	= 0.5,
			ARMORED		= 0.5,
			LIGHT		= 0.5,
			BUILDING 	= 1,
		},
		zarty	= {
			AIRLIGHT	= 0,
			AIRARMORED	= 0,
			ARMORED		= 0,
			LIGHT		= 0,
			BUILDING 	= 1,
		},
		zassault	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
		-- End Zaal
		
		-- Start Miscellaneous
		queenbeam	= {
			AIRLIGHT	= 0.1,
			AIRARMORED	= 0.1,
			ARMORED		= 0.1,
			LIGHT		= 0.1,
			BUILDING 	= 1,
		},	
		queenflames	= {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},	
		queencannon = {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 0.1,
		},	
			
			-- End Miscellaneous
		default = {
			AIRLIGHT	= 1,
			AIRARMORED	= 1,
			ARMORED		= 1,
			LIGHT		= 1,
			BUILDING 	= 1,
		},
	},
	
	armorDefs = {
		"AIRLIGHT",
		"AIRARMORED",
		"LIGHT",
		"ARMORED",
		"BUILDING",
	},
} 
return damageClasses;