local versionNumber = "0.7"
local widgetName = "Toggle LOS"

function widget:GetInfo()
	return {
		name      = widgetName,
		desc      = "[v" .. string.format("%s", versionNumber ) .. "] Automatically enables LOS view when the game begins.",
		author    = "very_bad_soldier",
		date      = "17.07.2010",
		license   = "GNU GPL v2",
		layer     = 0,
		enabled   = true
	}
end

-- tweaked by raaar to remove toggling radar and jammer state for spring 99.0 and later

function widget:Initialize()	
	if ( CheckSpecState() == true ) then
		RemoveItself()
	end
end

function widget:GameStart()	
	if (Spring.GetMapDrawMode() ~= "los") then
		Spring.SendCommands("togglelos")
	end
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