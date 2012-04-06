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
        ring1
        ring1color
        ring1thickness
        ring1ShowOnlySelected
        
   ***To Be Continued...***     
]]--

function widget:drawworld
        local units = Spring.GetAllUnits()
        for _,unitID in ipairs(units) do
                local x,y,z = Spring.GetUnitPosition(unitID)
                local unitDefID = Spring.GetUnitDefid(unitID)
                local ud = UnitDefs[unitDefID]
                local customParams = ud.customparams
                
                -- ring 1
                if customParams.ring1 then
                    gl.Color(customParams.ring1color)
                    gl.LineWidth(customParams.ring1thickness)
                   Spring.DrawGroundCircle(x,z, customParams.ring1, 32)
                end
                
                -- ring 2
                if customParams.ring2 then
                    gl.Color(customParams.ring2color)
                    gl.LineWidth(customParams.ring2thickness)
                   Spring.DrawGroundCircle(x,z,customParams.ring2, 32)
               end
       end

end
