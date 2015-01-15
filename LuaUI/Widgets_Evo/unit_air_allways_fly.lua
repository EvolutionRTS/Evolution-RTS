--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function widget:GetInfo()
    return {
        name      = "Aircraft plants on Fly",
        desc      = "Setting aircraft plants on Fly mode",
        author    = "[teh]decay",
        date      = "29 sept 2013",
        license   = "GNU GPL, v2 or later",
        version   = 1,
        layer     = 5,
        enabled   = true  --  loaded by default?
    }
end

-- project page on github: https://github.com/jamerlan/unit_air_allways_fly

--Changelog
--

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
        switchAirpadToFlyMode(unitID, unitDefID)
    end
end

function widget:UnitTaken(unitID, unitDefID, unitTeam, newTeam)
    if(newTeam == spGetMyTeamId()) then
        switchAirpadToFlyMode(unitID, unitDefID)
    end
end


function widget:UnitGiven(unitID, unitDefID, unitTeam, oldTeam)
    if(unitTeam == spGetMyTeamId()) then
        switchAirpadToFlyMode(unitID, unitDefID)
    end
end


function switchAirpadToFlyMode(unitID, unitDefID)
    if (unitDefID == UnitDefNames["eairengineer"].id or unitDefID == UnitDefNames["ebomber"].id or unitDefID == UnitDefNames["edrone"].id or unitDefID == UnitDefNames["efighter"].id or unitDefID == UnitDefNames["egunship2"].id or unitDefID == UnitDefNames["escout"].id or unitDefID == UnitDefNames["etransport"].id) then
        spGiveOrderToUnit(unitID, CMD.IDLEMODE, { 0 }, {})
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
        switchAirpadToFlyMode(unitID, spGetUnitDefID(unitID))
    end

    return true
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

