function widget:GetInfo()
  return {
    name      = "Debug Mouse to Mexes Portable",
    desc      = "Click to make a mex table. Alt+M to toggle. Works with any game.",
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
local enabled = false
local spots = {}

------------------------------------------------
-- Press Handling
------------------------------------------------

function widget:KeyPress(key, modifier, isRepeat)
	if modifier.alt then
		if key == KEYSYMS.M then
			if enabled then
				for i = 1, #spots do
					local spot = spots[i]
					Spring.Echo("{x = " .. floor(spot.x+0.5) .. ", z = " .. floor(spot.z+0.5) .. ", metal = false},")
				end
				spots = {}
			end
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
			spots[#spots+1] = {
				x = pos[1],
				z = pos[3],
			}
			Spring.MarkerAddPoint(pos[1],0,pos[3],#spots)
		end
	end
end