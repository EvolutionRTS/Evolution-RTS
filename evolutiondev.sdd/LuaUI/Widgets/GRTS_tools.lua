Spring.SendCommands({"ctrlpanel " .. LUAUI_DIRNAME .. "panel.txt"})

function widget:GetInfo()
	return {
		name      = "Gundam UI Cleanup",
		desc      = "Kills the Spring ui, allows gundam to use it's own control panel",
		author    = "Smoth",
		date      = "10th February 2008",
		license   = "NONE, Licenses are for gays!",
		layer     = -5,
		enabled   = false  --  loaded by default
	}
end

function ProcessBuild(command, line, words)
	
	if #words == 1 then
	
		Spring.SelectUnitArray({(Spring.GetLocalTeamID() + 1)})
		Spring.SetActiveCommand("buildunit_" .. words[1])
	
	end
	
end

function widget:Initialize()
	
	-- Remove the resource bar, we dont need it
	Spring.SendCommands({ "resbar 0" })

	widgetHandler:AddAction("build", ProcessBuild)

	
end

