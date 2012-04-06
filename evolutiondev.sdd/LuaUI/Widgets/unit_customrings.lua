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
Contains 4 variables:
        ring1radius
        ring1color
        ring1thickness
        ring1ShowOnlySelected
        
   ***To Be Continued...***     
]]--
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
                
                -- ring 1
                if customParams.ring1radius then
                    gl.Color(explode(',', customParams.ring1color))
                    gl.LineWidth(customParams.ring1thickness)
                   gl.DrawGroundCircle(x,y,z, customParams.ring1radius, 32)
                end
                
                -- ring 2
                if customParams.ring2radius then
                    gl.Color(explode(',', customParams.ring2color))
                    gl.LineWidth(customParams.ring2thickness)
                   gl.DrawGroundCircle(x,y,z,customParams.ring2radius, 32)
               end
			   
			   -- ring 3
                if customParams.ring3radius then
                    gl.Color(explode(',', customParams.ring3color))
                    gl.LineWidth(customParams.ring3thickness)
                   gl.DrawGroundCircle(x,y,z,customParams.ring3radius, 32)
               end
			   
			   -- ring 4
                if customParams.ring4radius then
                    gl.Color(explode(',', customParams.ring4color))
                    gl.LineWidth(customParams.ring4thickness)
                   gl.DrawGroundCircle(x,y,z,customParams.ring4radius, 32)
               end
			   
			   -- ring 5
                if customParams.ring5radius then
                    gl.Color(explode(',', customParams.ring5color))
                    gl.LineWidth(customParams.ring5thickness)
                   gl.DrawGroundCircle(x,y,z,customParams.ring5radius, 32)
               end
			   
			   -- ring 6
                if customParams.ring6radius then
                    gl.Color(explode(',', customParams.ring6color))
                    gl.LineWidth(customParams.ring6thickness)
                   gl.DrawGroundCircle(x,y,z,customParams.ring6radius, 32)
               end
			   
			   -- ring 7
                if customParams.ring7radius then
                    gl.Color(explode(',', customParams.ring7color))
                    gl.LineWidth(customParams.ring7thickness)
                   gl.DrawGroundCircle(x,y,z,customParams.ring7radius, 32)
               end
			   
			   -- ring 8
                if customParams.ring8radius then
                    gl.Color(explode(',', customParams.ring8color))
                    gl.LineWidth(customParams.ring8thickness)
                   gl.DrawGroundCircle(x,y,z,customParams.ring8radius, 32)
               end
			   
			   -- ring 9
                if customParams.ring9radius then
                    gl.Color(explode(',', customParams.ring9color))
                    gl.LineWidth(customParams.ring9thickness)
                   gl.DrawGroundCircle(x,y,z,customParams.ring9radius, 32)
               end
			   
			   -- ring 10
                if customParams.ring10radius then
                    gl.Color(explode(',', customParams.ring10color))
                    gl.LineWidth(customParams.ring10thickness)
                   gl.DrawGroundCircle(x,y,z,customParams.ring10radius, 32)
               end
       end

end
