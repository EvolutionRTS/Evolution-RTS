
local colors = {
	-- general use colors
	{	name = "white", 
		color = { 1, 1, 1, 1}, },

	{	name = "grey_80", 
		notfinish = true, 
		color = { 0.80, 0.80, 0.80, 1}, },

	{	name = "grey_70", 
		notfinish = true,
		color = { 0.70, 0.70, 0.70, 1}, },

	{	name = "grey", 
		color = { 0.50, 0.50, 0.50, 1}, },

	{	name = "grey_40", 
		notfinish = true, 
		color = { 0.40, 0.40, 0.40, 1}, },

	{	name = "grey_30",  
		notfinish = true,
		color = { 0.30, 0.30, 0.30, 1}, },

	{	name = "grey_20", 
		notfinish = true, 
		color = { 0.20, 0.20, 0.20, 1}, },

	{	name = "grey_10", 
		notfinish = true, 
		color = { 0.10, 0.10, 0.10, 1}, },

	{	name = "black", 
		color = { 0, 0, 0, 1}, },

	{	name = "light_brown",  
		notfinish = true,
		color = { 0.60, 0.40, 0.20, 1}, },

	{	name = "brown", 
		color = { 0.40, 0.20, 0, 1}, },

	{	name = "bronze", 
		color = { 0.80, 0.5, 0, 1}, },

	{	name = "gold", 
		color = { 1, 0.80, 0.20, 1}, },

	{	name = "light_midnightblue",  
		notfinish = true,
		color = { 0.29, 0.29, 0.63, 1}, },

	{	name = "midnightblue", 
		color = { 0.090, 0.090, 0.43, 1}, },
		
	{	name = "blue", 
		color = { 0, 0, 1, 1}, },

	{	name = "electricblue", 
		color = { 0.18, 0.46, 1, 1}, },

	{	name = "dark_skyblue",  
		notfinish = true,
		color = { 0.30, 0.60, 0.69, 1}, },
		
	{	name = "dark_silver",  
		notfinish = true,
		color = { 0.5, 0.69, 0.80, 1}, },	
		
	{	name = "skyblue", 
		color = { 0.5, 0.80, 0.89, 1}, },

	{	name = "silver", 
		color = { 0.69, 0.89, 1, 1}, },

	{	name = "pink", 
		color = { 1, 0.69, 0.89, 1}, },

	{	name = "dark_pink",  
		notfinish = true,
		color = { 0.80, 0.5, 0.69, 1}, },

	{	name = "fuschia", 
		color = { 1, 0, 1, 1}, },

	{	name = "light_purple",  
		notfinish = true,
		color = { 0.80, 0.20, 0.80, 1}, },

	{	name = "purple", 
		color = { 0.60, 0, 0.60, 1}, },

	{	name = "light_maroon",  
		notfinish = true,
		color = { 0.69, 0.20, 0.20, 1}, },

	{	name = "maroon", 
		color = { 0.5, 0, 0, 1}, },

	{	name = "red", 
		color = { 1, 0, 0, 1}, },

	{	name = "safetyorange", 
		color = { 1, 0.30, 0, 1}, },

	{	name = "orange", 
		color = { 1, 0.5, 0, 1}, },

	{	name = "yellow", 
		color = { 1, 1, 0, 1}, },

	{	name = "limegreen", 
		color = { 0.70, 1, 0, 1}, },

	{	name = "neongreen", 
		color = { 0, 1, 0, 1}, },

	{	name = "light_green",  
		notfinish = true,
		color = { 0.0, 0.80, 0.0, 1}, },

	{	name = "green", 
		color = { 0, 0.60, 0, 1}, },

	{	name = "dark_green", 
		color = { 0, 0.40, 0, 1}, },
		
	{	name = "light_pinegreen",  
		notfinish = true,
		color = { 0.40, 0.55, 0.5, 1}, },

	{	name = "pinegreen", 
		color = { 0.20, 0.34, 0.30, 1}, },

	{	name = "light_olivedrab",  
		notfinish = true,
		color = { 0.5, 0.55, 0.35, 1}, },

	{	name = "olivedrab", 
		color = { 0.30, 0.34, 0.15, 1}, },

	{	name = "light_sicklybrown",  
		notfinish = true,
		color = { 0.5, 0.44, 0.20, 1}, },

	{	name = "sicklybrown", 
		color = { 0.30, 0.25, 0, 1}, },

	{	name = "light_taupe", 
		color = { 0.48, 0.43, 0.40, 1}, },

	{	name = "taupe", 
		color = { 0.28, 0.23, 0.20, 1}, },

	{	name = "tan", 
		color = { 1, 0.89, 0.60, 1}, },
		
	{	name = "dark_tan",  
		notfinish = true,
		color = { 0.80, 0.69, 0.40, 1}, },

	{	name = "light_khaki", 
		color = { 0.8, 0.7, 0.57, 1}, },

	{	name = "khaki", 
		color = { 0.6, 0.5, 0.37, 1}, },

	{	name = "dark_khaki",  
		notfinish = true,
		color = { 0.4, 0.3, 0.17, 1}, },

	{	name = "salmon", 
		color = { 1, 0.5, 0.40, 1}, },

	{	name = "dark_salmon",  
		notfinish = true,
		color = { 0.80, 0.30, 0.20, 1}, },

	{	name = "light_caputmortuum",  
		notfinish = true,
		color = { 0.55, 0.35, 0.3, 1}, },

	{	name = "caputmortuum", 
		color = { 0.34, 0.15, 0.12, 1}, },

	{	name = "light_imperialpurple",  
		notfinish = true,
		color = { 0.60, 0.21, 0.43, 1}, },

	{	name = "imperialpurple", 
		color = { 0.40, 0.0099, 0.23, 1}, },

	{	name = "light_royalpurple",  
		notfinish = true,
		color = { 0.62, 0.44, 0.8, 1}, },

	{	name = "royalpurple", 
		color = { 0.41, 0.25, 0.62, 1}, },

	{	name = "lavender", 
		color = { 0.58, 0.50, 0.93, 1}, },

	{	name = "dark_lavender",  
		notfinish = true,
		color = { 0.38, 0.31, 0.73, 1}, },

	{	name = "aqua", 
		color = { 0, 1, 1, 1}, },

	{	name = "turquoise", 
		color = { 0.25, 0.87, 0.64, 1}, },

	{	name = "light_mint",  
		notfinish = true,
		color = { 0.43, 0.9, 0.74, 1}, },

	{	name = "mint", 
		color = { 0.23, 0.70, 0.54, 1}, },

	{	name = "light_midnightgreen",  
		notfinish = true,
		color = { 0.20, 0.49, 0.53, 1}, },

	{	name = "midnightgreen", 
		color = { 0, 0.28, 0.33, 1}, },		
}

return colors
