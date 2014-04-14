--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Automatically generated local definitions

local CMDTYPE_ICON          = CMDTYPE.ICON
local CMD_STOP              = CMD.STOP
local spDestroyUnit         = Spring.DestroyUnit
local spGetGameFrame        = Spring.GetGameFrame
local spGetLocalAllyTeamID  = Spring.GetLocalAllyTeamID
local spGetSpectatingState  = Spring.GetSpectatingState
local spGetUnitAllyTeam     = Spring.GetUnitAllyTeam
local spGetUnitBasePosition = Spring.GetUnitBasePosition
local spGetUnitDefID        = Spring.GetUnitDefID
local spGetUnitHeight       = Spring.GetUnitHeight
local spGetUnitTeam         = Spring.GetUnitTeam
local spInsertUnitCmdDesc   = Spring.InsertUnitCmdDesc

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
	return {
		name = "sell",
		desc = "press buton, reciev moniez",
		author = "KDR_11k (David Becker)",
		date = "2008-06-12",
		license = "Public Domain",
		layer = 300,
		enabled = true
	}
end

local refundFactor = .5 --How much of the original price is returned
local sellFactor = 1 --Factor for the buildtime 
local CMD_SELL = 39867

if (gadgetHandler:IsSyncedCode()) then

--SYNCED

local GetGameFrame = spGetGameFrame
local min = math.min

local sellDesc = {
	name="Sell",
	tooltip="Sell the building for a partial refund",
	action="sell",
	type=CMDTYPE_ICON,
	texture="bitmaps/ui/command_buttons/cmd_sell.png",
	id=CMD_SELL,
}

local saleTime={}

local resources
local unitCost
local capacity
local resCount

function gadget:AllowCommand(u, ud, team, cmd, param, opt)
	if cmd == CMD_SELL then
		if not UnitDefs[ud].customParams.nosale then
			if not saleTime[u] then
				saleTime[u]=GetGameFrame() + UnitDefs[ud].buildTime * 32 * sellFactor
			elseif opt.right then
				saleTime[u]=nil
			end
		end
		return false
	end
	if cmd == CMD_STOP and saleTime[u] then --Let a stop command abort the sale
		saleTime[u]=nil
		return false
	end
	return true
end

function gadget:UnitCreated(u, ud, team)
	if not UnitDefs[ud].customParams.nosale then
		spInsertUnitCmdDesc(u, sellDesc)
	end
end

--function gadget:CommandFallback(u, ud, team, cmd, param, opt)
--	if cmd == CMD_SELL then
--		saleTime[u]=GetGameFrame() + UnitDefs[ud].buildTime * 30
--		return true, true
--	end
--	return false
--end

function gadget:UnitDestroyed(u, ud, team)
	saleTime[u]=nil
end


function gadget:GameFrame(frame)
	if frame % 12 < .1 then
		for unitId, timeLeft in pairs(saleTime) do
			if timeLeft < frame then
				local unitDefId	= spGetUnitDefID(unitId)
				local teamId	= spGetUnitTeam(unitId)
				local ux, uy, uz = Spring.GetUnitPosition(unitId)
				spDestroyUnit(unitId, false, true)
				--Spring.Echo(resCount, type(resCount))
				if resCount and resCount ~= "" then
					for i = 1,resCount do
						resources[teamId][i] = min(resources[teamId][i] + (unitCost[unitDefId][i] or 0) * refundFactor, capacity[teamId][i])
					end
				else
					local currentMetal	= Spring.GetTeamResources(teamId,"metal")			
					local currentEnergy	= Spring.GetTeamResources(teamId,"energy")
					local unitMetal		= (UnitDefs[unitDefId].metalCost or 0) * refundFactor
					local unitEnergy	= (UnitDefs[unitDefId].energyCost or 0) * refundFactor
					
					--Spring.Echo(currentMetal, unitMetal)
					Spring.SetTeamResource(teamId, "m", currentMetal + unitMetal)
					Spring.SetTeamResource(teamId, "e", currentEnergy + unitEnergy)
					Spring.SpawnCEG('salvage', ux, uy, uz)
					Spring.PlaySoundFile('sounds/chaching.wav', 5, ux, uy, uz)
				end
			end
		end
	end
end


function gadget:Initialize()
	resources = GG.resources
	unitCost = GG.unitCost
	capacity = GG.capacities
	resCount = GG.resCount
	_G.unitsBeingSold=saleTime
end

else

--UNSYNCED

local glBillboard           = gl.Billboard
local glColor               = gl.Color
local glPopMatrix           = gl.PopMatrix
local glPushMatrix          = gl.PushMatrix
local glTexRect             = gl.TexRect
local glText                = gl.Text
local glTexture             = gl.Texture
local glTranslate           = gl.Translate

local Texture = glTexture
local PushMatrix = glPushMatrix
local Translate = glTranslate
local Billboard = glBillboard
local TexRect = glTexRect
local PopMatrix = glPopMatrix
local Text = glText
local Color = glColor

local GetUnitAllyTeam = spGetUnitAllyTeam
local GetUnitBasePosition = spGetUnitBasePosition
local GetUnitHeight = spGetUnitHeight
local GetLocalAllyTeamID = spGetLocalAllyTeamID
local GetSpectatingState = spGetSpectatingState
local GetGameFrame = spGetGameFrame
local ceiling = math.ceil

function gadget:DrawWorld()
	local team = GetLocalAllyTeamID()
	local _,_,spec = GetSpectatingState()
	local f = GetGameFrame()
	for u,b in spairs(SYNCED.unitsBeingSold) do
		if GetUnitAllyTeam(u) == team or spec then
				local x,y,z = GetUnitBasePosition(u)
			if x and y and z then
				PushMatrix()
				Translate(x,y + 80 + GetUnitHeight(u),z)
				Billboard()
				Texture("bitmaps/icons/selling.png") --Sale icon goes here
				TexRect(-20,-20,20,20)
				Text(ceiling((b - f)/30.0), 0, -25, 16, "oc")
				PopMatrix()
			end
		end
	end
	Texture(false)
end

end
