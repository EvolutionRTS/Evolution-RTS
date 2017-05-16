function widget:GetInfo()
	return {
		name	= "Graphics Settings (1 - Ultra Low)",
		desc	= "Sets graphics settings for you to predefined settings",
		author	= "Forboding Angel",
		date	= "01-21-2014",
		license	= "GPL v2 or later",
		layer	= 5,
		enabled	= false
	}
end

function widget:Initialize()
		Spring.SendCommands("advmapshading 0")
		Spring.SendCommands("advmodelshading 0")
		Spring.SendCommands("dynamicsky 0")
		Spring.SendCommands("dynamicsun 0")
		Spring.SendCommands("maxparticles 2000")
		Spring.SendCommands("maxnanoparticles 500")
		Spring.SendCommands("water 0")
		Spring.SendCommands("shadows 0")

		Spring.SetConfigInt("3DTrees",0)
		Spring.SetConfigInt("AdvSky",0)
		Spring.SetConfigString("DynamicSunMinElevation", "0.3")
		Spring.SetConfigInt("FSAALevel",0)
		Spring.SetConfigInt("FeatureDrawDistance",0)
		Spring.SetConfigInt("FeatureFadeDistance",0)
		Spring.SetConfigInt("GrassDetail",0)
		Spring.SetConfigInt("GroundDetail",32)
		Spring.SetConfigInt("MaxSounds",128)
		Spring.SetConfigInt("ScrollWheelSpeed",-25)
		
		widgetHandler:RemoveWidget()
end

