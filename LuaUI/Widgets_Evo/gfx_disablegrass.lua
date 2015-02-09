function widget:GetInfo()
	return {
		name	= "Disable Grass",
		desc	= "Disables Spring Grass (improves FPS)",
		author	= "Some Loser",
		date	= "2012-08-11",
		license	= "GPL v2 or later",
		layer	= 5,
		enabled	= true
	}
end

function widget:Initialize()
	Spring.SendCommands("grassdetail 0")
end

