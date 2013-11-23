
local colors = {
	-- general use colors
	{	name = "dark_paleblue", 
		color = {0.25, 0.27, 0.38, 1},	},		
		
	{	name = "pale_yelloworange", 
		color = { 1.0, 0.65, 0.2, 1},	},	
		
					
	-- Ui Color Sets
	uiSets = {
		OUTER_COLONIES = {
			Main	= {0.50, 0.50, 0.50, 1},
			Trim	= {1.00, 0.80, 0.00, 1},
			Rank	= {1.00, 0.90, 0.50, 1},
		},
				
		NEUTRAL = {
			Main	= {0.50, 0.50, 0.50, 1},
			Trim	= {1.00, 0.80, 0.00, 1},
			Rank	= {1.00, 0.90, 0.50, 1},
		},
	},
	
	--resource colors
	resource = {	
		exotic	= {0.78, 0.40, 0.78, 1},
		refined	= {1.00, 1.00, 0.30, 1},
		basic	= {1.00, 0.30, 0.30, 1},
		energy	= {0.30, 0.88, 1.00, 1},
	},
	--damage class sets
	damageclass = {	
		explosive	= {1.00, 0.90, 0.03, 1},
		beam		= {1.00, 0.03, 1.00, 1},
		light		= {0.58, 0.58, 1.00, 1},
		medium		= {0.20, 0.90, 0.20, 1},
		heavy		= {0.50, 0.50, 0.50, 1},
		building	= {1.00, 0.10, 0.10, 1},
	},
}

return colors
