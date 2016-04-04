function widget:GetInfo()
  return {
    name      = "Mouse to Control Victory Points",
    desc      = "Click to make a control points table. Alt+P to toggle. Works with any game.",
    author    = "Google Frog",
    date      = "April 28, 2012",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = false --  loaded by default?
  }
end

include("keysym.h.lua")

local floor = math.floor

------------------------------------------------
-- Variables
------------------------------------------------
local enabled = true
local markers = {}
local cvIndex = 1
local yPosition = 0 -- The gadget sets this, no need to bother setting it to anything other than 0
local handle

------------------------------------------------
-- Press Handling
------------------------------------------------

function widget:KeyPress(key, modifier, isRepeat)
	if modifier.alt then
		if key == KEYSYMS.P then
			enabled = not enabled
		end
	end
end

local function legalPos(pos)
	return pos and pos[1] > 0 and pos[3] > 0 and pos[1] < Game.mapSizeX and pos[3] < Game.mapSizeZ
end

function widget:MousePress(mx, my, button)
	if enabled and (not Spring.IsAboveMiniMap(mx, my)) then
		local _, pos = Spring.TraceScreenRay(mx, my, true)
		if legalPos(pos) then
			if true then
				handle:write("[" .. cvIndex .. "] = {x = " .. floor(pos[1] + 0.5) .. ", y = " .. tostring(yPosition) .. ", z = " .. floor(pos[3] + 0.5) .. "},\n")
				handle:flush()
				markers[#markers + 1] = {pos[1], 0, pos[3]}
				Spring.MarkerAddPoint(pos[1], 0, pos[3], cvIndex)
				cvIndex = cvIndex + 1
			else -- TODO: make right click remove markers
				Spring.MarkerErasePosition (pos[1], 0, pos[3])
			end
		end
	end
end

function widget:Initialize()
	if not Spring.IsCheatingEnabled() then
		Spring.Echo("This widget requires cheats enabled")
		widgetHandler:RemoveWidget()
	end
	handle = io.open("cv_" .. Game.mapName .. ".lua", "w")
	if (handle == nil) then
		widgetHandler:RemoveWidget()
	end
end

function widget:Shutdown()
	for _, i in pairs (markers) do
                Spring.MarkerErasePosition (i[1], i[2], i[3])
	end
	if handle ~= nil then
		io.close(handle)
		Spring.Echo ("Writen Control Victory Points To: " .. "cv_" .. Game.mapName .. ".lua")
	end
end