
function gadget:GetInfo()
	return {
		name      = "Supply Requirement",
		desc      = "Implements a single supply for each team. Uses supply_cost and supply_granted.",
		author    = "GoogleFrog",
		date      = "Novemember 11 2013",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- synced only
if (not gadgetHandler:IsSyncedCode()) then
	return false
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Localisations

local spGetTeamUnits = Spring.GetTeamUnits
local spGetUnitDefID = Spring.GetUnitDefID
local spFindUnitCmdDesc = Spring.FindUnitCmdDesc
local spEditUnitCmdDesc = Spring.EditUnitCmdDesc
local spGetUnitIsStunned = Spring.GetUnitIsStunned
local spSetTeamRulesParam = Spring.SetTeamRulesParam

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Configuration

local SUPPLY_CAP = 200
local INTRINSIC_SUPPLY = 0

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Find the units that grant or cost supply

local grantUnitDefID = {}
local costUnitDefID = {}
local costUnitList = {} -- Sorted from lowest to highest cost
local costUnitCount = 0

for unitDefID = 1, #UnitDefs do
	local ud = UnitDefs[unitDefID]
	if ud.customParams then
		if ud.customParams.supply_granted then
			grantUnitDefID[unitDefID] = tonumber(ud.customParams.supply_granted)
		end
		if ud.customParams.supply_cost then
			costUnitDefID[unitDefID] = tonumber(ud.customParams.supply_cost)
			costUnitCount = costUnitCount + 1
			costUnitList[costUnitCount] = unitDefID
		end
	end
end

table.sort(costUnitList, function (a,b) return costUnitDefID[a] < costUnitDefID[b] end)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Data

-- Array of supply per teamID
local maxSupply = {} -- This ignores SUPPLY_CAP for convinience
local maxSupplyWithCap = {}
local currentSupply = {}

local lockedUnitsArray = {} -- by teamID then unitDefID

-- Only finished units grant supply, keep track of it here.
local grantingSupply = {} -- by teamID then unitID
local costingSupply = {}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Utility functions for modifying commands and blocking construction.

function EnableUnit(unitDefID, teamID)
	spSetTeamRulesParam(teamID, "disallowed_" .. unitDefID, 0, {private = true})
end

function DisableUnit(unitDefID, teamID)
	spSetTeamRulesParam(teamID, "disallowed_" .. unitDefID, 1, {private = true})
end

local function NewUnitIsAllowed(unitDefID, teamID)
	if costUnitDefID[unitDefID] then
		return not lockedUnitsArray[teamID][unitDefID]
	end
	return true
end

-- Do not block commands because that would make the UI stupid
--function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOpts)
--	return cmdID > 0 or cmdOpts.right or NewUnitIsAllowed(-cmdID, teamID)
--end

-- Block unit creation
function gadget:AllowUnitCreation(unitDefID, builderID, builderTeam, x, y, z)
	return NewUnitIsAllowed(unitDefID, builderTeam)
end

-- Block unit transfer
function gadget:AllowUnitTransfer(unitID, unitDefID, oldTeam, newTeam, capture)
	return NewUnitIsAllowed(unitDefID, newTeam)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Handle updates to supply.

local function updateIncreaseSupplyGap(teamID)
	spSetTeamRulesParam(teamID, "supplyUsed", currentSupply[teamID], {private = true})
	spSetTeamRulesParam(teamID, "supplyMax", maxSupplyWithCap[teamID], {private = true})
	
	local supplyGap = maxSupplyWithCap[teamID] - currentSupply[teamID] 
	local lockedArray = lockedUnitsArray[teamID]
	for i = costUnitCount, 1, -1 do
		local unitDefID = costUnitList[i]
		if not lockedArray[unitDefID] then
			return
		end
		if supplyGap >= costUnitDefID[unitDefID] then
			lockedArray[unitDefID] = false
			EnableUnit(unitDefID, teamID)
		end
	end
end 

local function updateDecreaseSupplyGap(teamID)
	spSetTeamRulesParam(teamID, "supplyUsed", currentSupply[teamID], {private = true})
	spSetTeamRulesParam(teamID, "supplyMax", maxSupplyWithCap[teamID], {private = true})
	
	local supplyGap = maxSupplyWithCap[teamID] - currentSupply[teamID]
	local lockedArray = lockedUnitsArray[teamID]
	for i = 1, costUnitCount do
		local unitDefID = costUnitList[i]
		if lockedArray[unitDefID] then
			return
		end
		if supplyGap < costUnitDefID[unitDefID] then
			lockedArray[unitDefID] = true
			DisableUnit(unitDefID, teamID)
		end
	end
end 

local function AddSupplyFromUnit(unitID, unitDefID, teamID, isNanoframe)
	if grantUnitDefID[unitDefID] and not (isNanoframe or grantingSupply[teamID][unitID]) then
		grantingSupply[teamID][unitID] = true
		if maxSupply[teamID] < SUPPLY_CAP then
			maxSupply[teamID] = maxSupply[teamID] + grantUnitDefID[unitDefID]
			maxSupplyWithCap[teamID] = maxSupply[teamID]
			if maxSupplyWithCap[teamID] > SUPPLY_CAP then
				maxSupplyWithCap[teamID] = SUPPLY_CAP
			end
			updateIncreaseSupplyGap(teamID)
		else
			maxSupply[teamID] = maxSupply[teamID] + grantUnitDefID[unitDefID]
		end
	end
	if costUnitDefID[unitDefID] and (not costingSupply[teamID][unitID]) then
		costingSupply[teamID][unitID] = true
		currentSupply[teamID] = currentSupply[teamID] + costUnitDefID[unitDefID]
		updateDecreaseSupplyGap(teamID)
	end
end

local function RemoveSupplyFromUnit(unitID, unitDefID, teamID, justTurnedIntoNanoframe)
	if grantUnitDefID[unitDefID] and grantingSupply[teamID][unitID] then
		grantingSupply[teamID][unitID] = nil
		maxSupply[teamID] = maxSupply[teamID] - grantUnitDefID[unitDefID]
		if maxSupply[teamID] < SUPPLY_CAP then
			maxSupplyWithCap[teamID] = maxSupply[teamID]
			updateDecreaseSupplyGap(teamID)
		end
	end
	if costUnitDefID[unitDefID] and (not justTurnedIntoNanoframe) and costingSupply[teamID][unitID] then
		costingSupply[teamID][unitID] = nil
		currentSupply[teamID] = currentSupply[teamID] - costUnitDefID[unitDefID]
		updateIncreaseSupplyGap(teamID)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Unit creation, destruction, transfer. This part assumes that the action in
-- question has been allowed.

function gadget:UnitFinished(unitID, unitDefID, teamID)
	AddSupplyFromUnit(unitID, unitDefID, teamID, false)
end

function gadget:UnitCreated(unitID, unitDefID, teamID)
	AddSupplyFromUnit(unitID, unitDefID, teamID, true)
end

function gadget:UnitTaken(unitID, unitDefID, oldTeamID, teamID)
	RemoveSupplyFromUnit(unitID, unitDefID, teamID, false)
end

function gadget:UnitGiven(unitID, unitDefID, teamID, oldTeamID)
	local stunned_or_inbuild, stunned, inbuild = spGetUnitIsStunned(unitID)
	AddSupplyFromUnit(unitID, unitDefID, teamID, inbuild)
end

function gadget:UnitDestroyed(unitID, unitDefID, teamID)
	RemoveSupplyFromUnit(unitID, unitDefID, teamID, false)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Initialisation

local function InitializeTeamSupply(teamID)
	maxSupply[teamID] = INTRINSIC_SUPPLY
	maxSupplyWithCap[teamID] = INTRINSIC_SUPPLY
	currentSupply[teamID] = 0
	lockedUnitsArray[teamID] = {}
	grantingSupply[teamID] = {}
	costingSupply[teamID] = {}
	
	-- If no units have been added then we have 0 supply cap so everything is locked
	for i = 1, costUnitCount do
		local unitDefID = costUnitList[i]
		if costUnitDefID[unitDefID] > maxSupplyWithCap[teamID] then
			lockedUnitsArray[teamID][unitDefID] = true
		end
	end
	
	local units = spGetTeamUnits(teamID)
	for i = 1, #units do
		local unitID = units[i]
		local unitDefID = spGetUnitDefID(unitID)
		local stunned_or_inbuild, stunned, inbuild = spGetUnitIsStunned(unitID)
		AddSupplyFromUnit(unitID, unitDefID, teamID, inbuild)
	end
end

function gadget:Initialize()
	local teams = Spring.GetTeamList()
	for _, teamID in ipairs(teams) do
		InitializeTeamSupply(teamID)
	end
end