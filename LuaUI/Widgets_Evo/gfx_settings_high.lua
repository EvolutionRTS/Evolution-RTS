function widget:GetInfo()
	return {
		name	= "Graphics Settings (4 - High)",
		desc	= "Sets graphics settings for you to predefined settings",
		author	= "Forboding Angel",
		date	= "01-21-2014",
		license	= "GPL v2 or later",
		layer	= 5,
		enabled	= false
	}
end

function widget:Initialize()
		Spring.SendCommands("advmapshading 1")
		Spring.SendCommands("advmodelshading 1")
		Spring.SendCommands("dynamicsky 0")
		Spring.SendCommands("dynamicsun 0")
		Spring.SendCommands("maxparticles 5000")
		Spring.SendCommands("maxnanoparticles 2000")
		Spring.SendCommands("water 3")
		Spring.SendCommands("shadows 2 8192")

		Spring.SetConfigInt("3DTrees",1)
		Spring.SetConfigInt("AdvSky",0)
		Spring.SetConfigInt("DynamicSunMinElevation",0.3)
		Spring.SetConfigInt("FSAALevel",2)
		Spring.SetConfigInt("FeatureDrawDistance",999999)
		Spring.SetConfigInt("FeatureFadeDistance",999999)
		Spring.SetConfigInt("GrassDetail",0)
		Spring.SetConfigInt("GroundDetail",64)
		Spring.SetConfigInt("MaxSounds",128)
		
		widgetHandler:RemoveWidget()
end

