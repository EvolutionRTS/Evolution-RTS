function widget:GetInfo()
  return {
	name		= "Automatic Fight Command",
	desc		= "Gives select units a fight command after they have been built (because Spring doesn't call unitIdle properly)",
	author		= "Forby",
	date		= "Jan 8, 2007",
	license		= "GNU GPL, v2 or later",
	layer		= 0,
	enabled		= true  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local CMD_FIGHT				= CMD.FIGHT
local spGetMyTeamID			= Spring.GetMyTeamID
local spGetTeamUnits		= Spring.GetTeamUnits
local spGetUnitDefID		= Spring.GetUnitDefID
local spGetUnitPosition		= Spring.GetUnitPosition
local spGiveOrderToUnit		= Spring.GiveOrderToUnit
local spGetSpectatingState	= Spring.GetSpectatingState

local hmsx = Game.mapSizeX/2
local hmsz = Game.mapSizeZ/2


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local targetUnits = {eorb = true, eorb_up1 = true, eorb_up2 = true, eorb_up3 = true, ehbotengineer = true, ehbotengineer_turret = true}

local function IsTargetUnit(ud)
    return ud and targetUnits[ud.name]
end


local function SetupUnit(unitID)
	local x, y, z = spGetUnitPosition(unitID)
	if x and y and z then
	    if (x > hmsx) then -- avoid to issue commands outside map
	      x = x - 50
	    else
	      x = x + 50
	    end
	    if (z > hmsz) then
	      z = z - 50
	    else
	      z = z + 50
	    end	
		-- meta enables reclaim enemy units, alt autoresurrect ( if available )
		spGiveOrderToUnit(unitID, CMD_FIGHT, { x, y, z }, {"meta"})
	end
end

function widget:PlayerChanged()
	if spGetSpectatingState() then
		widgetHandler:RemoveWidget()
	end
end

function widget:Initialize()
	if spGetSpectatingState() then
		widgetHandler:RemoveWidget()
	end
end


function widget:UnitCreated(unitID, unitDefID, unitTeam)
	if unitTeam ~= spGetMyTeamID() then
		return
	end
	if IsTargetUnit(UnitDefs[unitDefID]) then
		SetupUnit(unitID)
	end
end


function widget:UnitGiven(unitID, unitDefID, unitTeam)
	widget:UnitCreated(unitID, unitDefID, unitTeam)
end