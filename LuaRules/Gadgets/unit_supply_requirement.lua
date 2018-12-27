function gadget:GetInfo()
	return {
		name      = "Supply Requirement",
		desc      = "Implements a single supply for each team. Uses supply_cost and supply_granted.",
		author    = "GoogleFrog, modified by CommonPlayer",
		date      = "Novemember 11 2013", --modified by CommonPlayer, Oct 2018
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
local spGetUnitTeam = Spring.GetUnitTeam
local spSetTeamRulesParam = Spring.SetTeamRulesParam

local teamList = Spring.GetTeamList()
local PRIVATE = {private = true}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Configuration

local SUPPLY_CAP = tonumber(Spring.GetModOptions().supplycap) or 400
local INTRINSIC_SUPPLY = tonumber(Spring.GetModOptions().intrinsicsupply) or 10

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

local isTeamSupplyBlocked = {}

local lockedUnitsArray = {} -- by teamID then unitDefID

-- Only finished units grant supply, keep track of it here.
local grantingSupply = {} -- by teamID then unitID
local costingSupply = {}

-- by unitID, if supply cost is not paid for build progress is locked
-- 0 = supply blocked; 1 = paid for
local paidFor = {}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Handle updates to supply.

local function updateIncreaseSupplyGap(teamID)
	spSetTeamRulesParam(teamID, "supplyUsed", currentSupply[teamID], PRIVATE)
	spSetTeamRulesParam(teamID, "supplyMax", maxSupplyWithCap[teamID], PRIVATE)
	
	local supplyGap = maxSupplyWithCap[teamID] - currentSupply[teamID] 
	local lockedArray = lockedUnitsArray[teamID]
	for i = costUnitCount, 1, -1 do
		local unitDefID = costUnitList[i]
		if not lockedArray[unitDefID] then
			return
		end
		if supplyGap >= costUnitDefID[unitDefID] then
			lockedArray[unitDefID] = false
			--EnableUnit(unitDefID, teamID)
		end
	end
end 

local function updateDecreaseSupplyGap(teamID)
	spSetTeamRulesParam(teamID, "supplyUsed", currentSupply[teamID], PRIVATE)
	spSetTeamRulesParam(teamID, "supplyMax", maxSupplyWithCap[teamID], PRIVATE)
	
	local supplyGap = maxSupplyWithCap[teamID] - currentSupply[teamID]
	local lockedArray = lockedUnitsArray[teamID]
	for i = 1, costUnitCount do
		local unitDefID = costUnitList[i]
		if lockedArray[unitDefID] then
			return
		end
		if supplyGap < costUnitDefID[unitDefID] then
			lockedArray[unitDefID] = true
			--DisableUnit(unitDefID, teamID)
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
-- Utility functions for modifying commands and blocking construction.

--[[function EnableUnit(unitDefID, teamID)
	spSetTeamRulesParam(teamID, "disallowed_" .. unitDefID, 0, {private = true})
end
function DisableUnit(unitDefID, teamID)
	spSetTeamRulesParam(teamID, "disallowed_" .. unitDefID, 1, {private = true})
end]]

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

local function AddSupplyBlockedCounter(teamID)
	isTeamSupplyBlocked[teamID] = isTeamSupplyBlocked[teamID] + 1
	if isTeamSupplyBlocked[teamID] == 1 then spSetTeamRulesParam(teamID, "supply_blocked", 1, PRIVATE) end
end
local function SubtractSupplyBlockedCounter(teamID)
	isTeamSupplyBlocked[teamID] = isTeamSupplyBlocked[teamID] - 1
	if isTeamSupplyBlocked[teamID] == 0 then spSetTeamRulesParam(teamID, "supply_blocked", nil, PRIVATE) end
end

function gadget:AllowUnitBuildStep(builderID, builderTeam, unitID, unitDefID, part)
	if part <= 0 or not costUnitDefID[unitDefID] or paidFor[unitID] == 1 then return true end

	local teamID = spGetUnitTeam(unitID)
	if NewUnitIsAllowed(unitDefID, teamID) then
		AddSupplyFromUnit(unitID, unitDefID, teamID, true)
		if paidFor[unitID] == 0 then SubtractSupplyBlockedCounter(teamID) end
		paidFor[unitID] = 1
		return true
	end
	if not paidFor[unitID] then
		paidFor[unitID] = 0
		AddSupplyBlockedCounter(teamID)
	end
	return false
end

-- Block unit creation
--[[function gadget:AllowUnitCreation(unitDefID, builderID, builderTeam, x, y, z)
	return NewUnitIsAllowed(unitDefID, builderTeam)
end]]

-- Block unit transfer
function gadget:AllowUnitTransfer(unitID, unitDefID, oldTeam, newTeam, capture)
	return NewUnitIsAllowed(unitDefID, newTeam)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Unit creation, destruction, transfer. This part assumes that the action in
-- question has been allowed.

function gadget:UnitFinished(unitID, unitDefID, teamID)
	AddSupplyFromUnit(unitID, unitDefID, teamID, false)
end

--[[function gadget:UnitCreated(unitID, unitDefID, teamID)
	AddSupplyFromUnit(unitID, unitDefID, teamID, true)
end]]

function gadget:UnitTaken(unitID, unitDefID, oldTeamID, teamID)
	if paidFor[unitID] == 0 then
		SubtractSupplyBlockedCounter(teamID) -- this unit no longer blocks supply for old team
	end
	RemoveSupplyFromUnit(unitID, unitDefID, teamID, false)
end

function gadget:UnitGiven(unitID, unitDefID, teamID, oldTeamID)
	if paidFor[unitID] == 0 then
		AddSupplyBlockedCounter(teamID) -- this unit now blocks supply for new team
	elseif paidFor[unitID] == 1 then
		local stunned_or_inbuild, stunned, inbuild = spGetUnitIsStunned(unitID)
		AddSupplyFromUnit(unitID, unitDefID, teamID, inbuild)
	end
end

function gadget:UnitDestroyed(unitID, unitDefID, teamID)
	if paidFor[unitID] == 0 then SubtractSupplyBlockedCounter(teamID) end
	RemoveSupplyFromUnit(unitID, unitDefID, teamID, false)
	paidFor[unitID] = nil
end

-- TODO: polling is inferior to events, ideally unit created/destroyed would be used
--[[function gadget:GameFrame(n)
	if n % 30 ~= 28 then
		return
	end

	for i = 1, #teamList do
		local teamID = teamList[i]
		if isTeamSupplyBlocked[teamID] then
			spSetTeamRulesParam(teamID, "supply_blocked", nil, PRIVATE)
			isTeamSupplyBlocked[teamID] = false
		end
	end
end]]

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
	isTeamSupplyBlocked[teamID] = 0
	spSetTeamRulesParam(teamID, "supply_blocked", nil, PRIVATE)
	
	-- If no units have been added then we have 0 supply cap so everything is locked
	for i = 1, costUnitCount do
		local unitDefID = costUnitList[i]
		if costUnitDefID[unitDefID] > maxSupplyWithCap[teamID] then
			lockedUnitsArray[teamID][unitDefID] = true
			--DisableUnit(unitDefID, teamID)
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
	for _, teamID in ipairs(teamList) do
		InitializeTeamSupply(teamID)
	end
end
