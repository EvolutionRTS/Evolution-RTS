function widget:GetInfo()
	return {
		name	= "Grabinput",
		desc	= "Enables GrabInput in Windowed mode",
		author	= "abma",
		date	= "2012-08-11",
		license	= "GPL v2 or later",
		layer	= 5,
		enabled	= false
	}
end

function widget:Initialize()
	if Spring.GetConfigInt("GrabInput", 1) == 1 then
		Spring.SendCommands("grabinput 1")
	end
end

