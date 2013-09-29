local versionNumber = "0.7"
local widgetName = "Toggle LOS"

function widget:GetInfo()
	return {
		name      = widgetName,
		desc      = "[v" .. string.format("%s", versionNumber ) .. "] Automatically enables LOS view and disables radar view when the game begins.",
		author    = "very_bad_soldier",
		date      = "17.07.2010",
		license   = "GNU GPL v2",
		layer     = 0,
		enabled   = true
	}
end

function widget:Initialize()	
	if ( CheckSpecState() == true ) then
		RemoveItself()
	end
end

function widget:GameStart()	
	Spring.SendCommands("togglelos")
	Spring.SendCommands("toggleradarandjammer")
	
	RemoveItself()
end

function RemoveItself()
	widgetHandler:RemoveWidget()
end

function CheckSpecState()
	local playerID = Spring.GetMyPlayerID()
	local _, _, spec, _, _, _, _, _ = Spring.GetPlayerInfo(playerID)
	
	return spec
end