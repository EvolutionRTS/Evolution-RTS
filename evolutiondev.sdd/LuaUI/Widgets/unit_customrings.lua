function widget:GetInfo()
  return {
    name      = "Custom Unit Rings",
    desc      = "Draws rings based upon customparams",
    author    = "Some Asshole",
    date      = "04/05/2012",
    license   = "Public Domain",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

--[[Comments section (using block style comment for attention getter...ness]]--

--[[

Contains 5 variables:

	You can have as many rings as you like, just up the value in the variable (I.e. ring3radius, ring4radius, etc), however (big butt), all variables must be set and they must be sequential (in other words, you can't have ring1 and then ring3).
	
    customParams = {    
		ring1radius = "500", --How large of a radius the ring will cover.
		
		ring1color = "0.5,0,1,0.3", --R,G,B,A on a scale from 0 - 1. A is the opacity with 1 being fully opaque to 0 being fully transparent. Easy and quick color picker here: http://www.dematte.at/colorPicker/  Take 255 divided by the color value you want, and that is it's value on a scale from 0 - 1. 
		
		ring1thickness = "1", --1 is basically 1 pixel thick. It will scale as you zoom in and out. Maximum value seems to be 32.
		
		ring1showselected = "0", --boolean (I.e. 1 = True, 0 = False) If True, ring only shows when the unit is selected, if False, show all the time.
		
		ring1sides = "32", -- Number of sides the ring has. 32 sides means a perfectly smooth ring. Setting to 3 will result in triangle, 4 a diamond, 5 a pentagon, etc (2 or less will not display at all).
	}
            
]]--

-- This function is used for seperating out each r g b a setting of colors due to the fact that unitdef custom parameters can only be strings.
local function explode(div,str)
  if (div=='') then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end

function widget:DrawWorld()
	local units = Spring.GetAllUnits()
	for _,unitID in ipairs(units) do
		local x,y,z = Spring.GetUnitPosition(unitID)
		local unitDefID = Spring.GetUnitDefID(unitID)
		local ud = UnitDefs[unitDefID]
		local customParams = ud.customParams

		if (Spring.IsUnitAllied(unitID)) then
			local c
			local doit
			local ring_number = 1
			while (true) do
				if (customParams["ring"..ring_number.."radius"] == nil) then break end
				doit = true
				if ((tonumber(customParams["ring"..ring_number.."showselected"]) == 1) 
				and (not Spring.IsUnitSelected(unitID))) then
					doit = false
				end
				if (doit) then
					c = explode(',', customParams["ring"..ring_number.."color"])
					gl.Color(tonumber(c[1]),tonumber(c[2]),tonumber(c[3]),tonumber(c[4]))
					gl.LineWidth(tonumber(customParams["ring"..ring_number.."thickness"]))
					gl.DrawGroundCircle(x,y,z, tonumber(customParams["ring"..ring_number.."radius"]),tonumber(customParams["ring"..ring_number.."sides"]))
				end
				ring_number = ring_number + 1
			end
		end
	end			
end