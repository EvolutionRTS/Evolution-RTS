function widget:GetInfo()
	return {
		name	= "Fix Camera Zoom",
		desc	= "Inverts the default spring camera zooming",
		author	= "Some Loser",
		date	= "2012-08-11",
		license	= "GPL v2 or later",
		layer	= 5,
		enabled	= true
	}
end

function widget:Initialize()
	Spring.SetConfigInt("ScrollWheelSpeed",-25)
end

