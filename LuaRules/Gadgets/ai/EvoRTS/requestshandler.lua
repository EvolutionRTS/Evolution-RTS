RequestsHandler = class(Module)

function RequestsHandler:Name()
	return "RequestsHandler"
end

function RequestsHandler:internalName()
	return "requestshandler"
end

function RequestsHandler:Init()
	self.requests = {}
end

local UDC = Spring.GetTeamUnitDefCount
local UDN = UnitDefNames

function RequestsHandler:Update()

end

function RequestsHandler:AddRequest(priority, requestedTask, commrequired)
	if commrequired == true then
		requestedTask.needCom = true
	end
	if not self.requests[1] then
		self.requests[1] = requestedTask
		return
	end
	if priority == true then
		for i = #self.requests,1, -1 do
			if self.requests[i] then
				self.requests[i + 1] = self.requests[i]
			end
		end
		self.requests[1] = requestedTask
	else
		self.requests[#self.requests+1] = requestedTask
	end
	-- if priority == true and commrequired == true then
		-- local comms = Spring.GetTeamUnitsByDefs(self.ai.id, {UnitDefNames.ecommanderbattleai.id})
		-- for ct, unitID in pairs(comms) do
			-- Spring.GiveOrderToUnit(unitID, CMD.STOP, {}, {})
		-- end
	-- end
end

function RequestsHandler:RemoveRequest(n)
	for i = n, #self.requests - 1 do
		self.requests[i] = self.requests[i + 1]
	end
	self.requests[#self.requests] = nil
end

function RequestsHandler:GetRequestedTask(unit)
	if self.requests[1] then
		if self.requests[1].needCom == true and (not (unit:Name() == "ecommanderbattleai")) then 
			return {action = "nexttask"} 
		end
		local task = self.requests[1]
		self:RemoveRequest(1)
		return task
	else
		return {action = "nexttask"}
	end
end
