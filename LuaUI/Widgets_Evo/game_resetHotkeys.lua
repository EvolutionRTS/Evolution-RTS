function widget:GetInfo()
  return {
    name      = "Reset Hotkeys",
    desc      = "Sets default hotkeys for common order elements",
    author    = "",
    date      = "",
    license   = "GNU LGPL, v2.1 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

function widget:Initialize()

	-- bind k to cloak
	Spring.SendCommands({
		"unbindkeyset k",
	})
	Spring.SendCommands("bind k wantcloak")

	-- bind sell command
	Spring.SendCommands({
		"unbindkeyset shift+s",
	})
	Spring.SendCommands("bind shift+s sell")

	-- replace guard with area guard
	Spring.SendCommands({
		"unbindkeyset g",
	})
	Spring.SendCommands("bind g areaguard")

	-- replace fps mode bind with capture
	Spring.SendCommands({
		"unbindkeyset c",
	})
	Spring.SendCommands("bind ctrl+c capture")
	
	
	-- set repeat to be bound to q
	Spring.SendCommands({
		"unbindkeyset q",
	})
	Spring.SendCommands("bind q repeat")
	
	
	-- set Priority to be bound to i
	Spring.SendCommands({
		"unbindkeyset i",
	})
	Spring.SendCommands("bind i priority")
	
	if Game.version == "85.0" then
		Spring.SendCommands({"unbindaction specteam"})
	end

end
