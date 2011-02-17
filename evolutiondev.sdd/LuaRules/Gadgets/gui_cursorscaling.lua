function gadget:GetInfo()
	return {
	name      = "Cursor Autoscale", --v2
	desc      = "Scales cursor according to resolution",
	author    = "Regret",
	date      = "August 19, 2009",
	license   = "Public Domain",
	layer     = -999999,
	enabled   = true,
	handler   = true,
	}
end

	if not gadgetHandler:IsSyncedCode() then
	local normalresolution_y = 1500 --when cursor size == texture size

	local sGetMouseCursor = Spring.GetMouseCursor
	local sSetMouseCursor = Spring.SetMouseCursor

	--hijack spring functions
	local SetCursor = {}
	local function fakeSetMouseCursor(name,scale)
		SetCursor.name = name
		SetCursor.scale = scale
	end
	local GetCursor = {name = "cursornormal", scale = 1}

	local function fakeGetMouseCursor()
		return GetCursor.name,GetCursor.scale
	end
	function gadget:Initialize()
		Spring.GetMouseCursor = fakeGetMouseCursor
		Spring.SetMouseCursor = fakeSetMouseCursor
		
		SetCursor.name = nil
		SetCursor.scale = nil
	end
	function gadget:Shutdown()
		Spring.GetMouseCursor = sGetMouseCursor --restore spring functions
		Spring.SetMouseCursor = sSetMouseCursor
	end
	-----

	local vsx,vsy = gadgetHandler:GetViewSizes()
	if (vsx == 1) then --hax for windowed mode
		vsx,vsy = Spring.GetWindowGeometry()
	end
	function gadget:ViewResize(viewSizeX, viewSizeY)
		vsx,vsy = gadgetHandler:GetViewSizes()
	end

	function gadget:DrawScreen()
		local cursor = sGetMouseCursor()
		local scale = vsy/normalresolution_y
		
		if (SetCursor.name) then
			cursor = SetCursor.name
		end
		if (SetCursor.scale) then
			scale = SetCursor.scale
		end
		
		sSetMouseCursor(cursor,scale)
		
		SetCursor.name = nil
		SetCursor.scale = nil
		
		GetCursor.name = cursor
		GetCursor.scale = scale
	end
end
