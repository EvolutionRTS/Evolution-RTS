function widget:GetInfo()
  return {
    name      = "Start Point Remover",
    desc      = "Deletes your teams start points once the game begins",
    author    = "TheFatController",
    date      = "April 03, 2007",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

function widget:Initialize()
  local _, _, spec = Spring.GetPlayerInfo(Spring.GetMyPlayerID())
  if spec then
    widgetHandler:RemoveWidget()
    return false
  end
end

function widget:Update()
  if (Spring.GetGameSeconds() > 0) then
    local allyList = Spring.GetTeamList(Spring.GetMyAllyTeamID())
    for _,allyID in ipairs(allyList) do
      local unitList = Spring.GetTeamUnits(allyID)
      for _,unitID in ipairs(unitList) do
        local unitDefID = Spring.GetUnitDefID(unitID)
        local unitDefList = UnitDefs[unitDefID]
        if (unitDefList.isCommander) then
          local x, y, z = Spring.GetUnitPosition(unitID)
          Spring.MarkerErasePosition(x, y, z)
        end
      end
    end
    widgetHandler:RemoveWidget()
  end
end