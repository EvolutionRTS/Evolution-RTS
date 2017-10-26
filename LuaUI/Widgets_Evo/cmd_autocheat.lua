function widget:GetInfo()
	return {
		name	= "Auto Cheat and Globallos",
		desc	= "Sends cheat and globallos so I don't have to",
		author	= "Forboding Angel",
		date	= "01-21-2014",
		license	= "GPL v2 or later",
		layer	= 5,
		enabled	= false
	}
end

function widget:Initialize()
		Spring.Echo([[I'm a filthy cheater]])

		Spring.SendCommands("cheat")
		Spring.SendCommands("globallos")

		widgetHandler:RemoveWidget()
end