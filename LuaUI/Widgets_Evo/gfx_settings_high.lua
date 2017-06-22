function widget:GetInfo()
	return {
		name	= "Graphics Settings (4 - High)",
		desc	= "Sets graphics settings for you to predefined settings",
		author	= "Forboding Angel",
		date	= "01-21-2014",
		license	= "GPL v2 or later",
		layer	= 5,
		enabled	= true
	}
end

gfxSetting = tonumber(Spring.GetConfigInt("evo_autogfxsettings"))
if gfxSetting ~= 5 then
	return false
end

function widget:Initialize()
		Spring.Echo([[Graphics Settings set to High]])

		Spring.SendCommands("advmapshading 1")
		Spring.SendCommands("advmodelshading 1")
		Spring.SendCommands("dynamicsky 0")
		Spring.SendCommands("dynamicsun 1")
		Spring.SendCommands("maxparticles 10000")
		Spring.SendCommands("maxnanoparticles 2000")
		Spring.SendCommands("water 3")
		Spring.SendCommands("shadows 2 8192")

		Spring.SetConfigInt("3DTrees",1)
		Spring.SetConfigInt("AdvSky",0)
		Spring.SetConfigString("DynamicSunMinElevation", "0.3")
		Spring.SetConfigInt("FSAALevel",8)
		Spring.SetConfigInt("FeatureDrawDistance",999999)
		Spring.SetConfigInt("FeatureFadeDistance",999999)
		Spring.SetConfigInt("GrassDetail",0)
		Spring.SetConfigInt("GroundDetail",64)
		Spring.SetConfigInt("MaxSounds",128)
		Spring.SetConfigInt("ScrollWheelSpeed",-25)
		
		Spring.SetConfigString("EdgeMoveWidth", "0.005")
		
		widgetHandler:RemoveWidget()
end

