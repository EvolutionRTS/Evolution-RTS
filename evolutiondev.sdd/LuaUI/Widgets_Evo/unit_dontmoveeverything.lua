--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Don't Move Everything",
    desc      = "Everything.",
    author    = "Google Frog",
    date      = "Jan 8, 2007",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = false  --  loaded by default?
  }
end

local spGiveOrderToUnit = Spring.GiveOrderToUnit
local spGetTeamUnits = Spring.GetTeamUnits
local spGetUnitDefID = Spring.GetUnitDefID

local team = Spring.GetMyTeamID()

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Settings

-- What to hold ground with
local function IsGround(ud)
 return (not ud.canFly)
end

-- Exceptions
local unitArray = { 

  "corap",
  "armap",
  "coraap",
  "armaap",
  
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local unitSet = {}

function widget:Initialize() 

  local Gname = Game.modShortName
  if Gname == 'S44' then
    Spring.Echo("Removed Don't Move Everything")
    widgetHandler:RemoveWidget()
  end

  for i, v in pairs(unitArray) do
    unitSet[v] = true
  end
  
end

--function widget:GameStart()


function widget:GameFrame(n)
  if (n == 1) then
  
    local units = spGetTeamUnits(team)
  
    for i, id in pairs(units) do
      widget:UnitCreated(id, spGetUnitDefID(id), team)
    end
  end
end

local function IsException(ud)
  
  for i, v in pairs(unitSet) do
    if (unitSet[ud.name]) then
	  return false
	end
  end
  
  return true
  
end

function widget:UnitCreated(unitID, unitDefID, unitTeam)
  if (unitTeam == team) then
    
	local ud = UnitDefs[unitDefID]
    if (ud ~= nil) then
  
      if ( IsGround(ud) and IsException(ud) ) then
    
	    spGiveOrderToUnit(unitID, CMD.MOVE_STATE, { 0 }, {})
	  
      end
	
	end
	
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


