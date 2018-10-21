--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function widget:GetInfo()
    return {
        name      = "Set Unit to Hold Fire",
        desc      = "Sets certain units to Hold Fire automagically",
        author    = "[teh]decay",
        date      = "29 sept 2013",
        license   = "GNU GPL, v2 or later",
        version   = 1,
        layer     = 5,
        enabled   = true  --  loaded by default?
    }
end

-------------------------------

local spGiveOrderToUnit = Spring.GiveOrderToUnit
local spGetMyTeamId = Spring.GetMyTeamID
local spGetTeamUnits = Spring.GetTeamUnits
local spGetUnitDefID = Spring.GetUnitDefID
--------------------------------------------------------------------------------


function widget:Update()

end

function widget:UnitCreated(unitID, unitDefID, teamID, builderID)
    if(teamID == spGetMyTeamId()) then
        switchUnitToHoldFire(unitID, unitDefID)
    end
end

function widget:UnitTaken(unitID, unitDefID, unitTeam, newTeam)
    if(newTeam == spGetMyTeamId()) then
        switchUnitToHoldFire(unitID, unitDefID)
    end
end


function widget:UnitGiven(unitID, unitDefID, unitTeam, oldTeam)
    if(unitTeam == spGetMyTeamId()) then
        switchUnitToHoldFire(unitID, unitDefID)
    end
end


function switchUnitToHoldFire(unitID, unitDefID)
    if (unitDefID == UnitDefNames["ecommandermeteor"].id) then
        spGiveOrderToUnit(unitID, CMD.FIRE_STATE, { 0 }, {})
     end
end

function widget:PlayerChanged(playerID)
    local _, _, spec = Spring.GetPlayerInfo(Spring.GetMyPlayerID())
    if spec then
        widgetHandler:RemoveWidget()
        return false
    end
end


function widget:Initialize()
    local _, _, spec, teamId = Spring.GetPlayerInfo(Spring.GetMyPlayerID())
    if spec then
        widgetHandler:RemoveWidget()
        return false
    end

    for _, unitID in ipairs(spGetTeamUnits(teamId)) do  -- init existing labs
        switchUnitToHoldFire(unitID, spGetUnitDefID(unitID))
    end

    return true
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

