AutoReclaimBehaviour = class(Behaviour)

function AutoReclaimBehaviour:Init()
	--
	self.active = false
end

function AutoReclaimBehaviour:UnitCreated(unit)
end

function AutoReclaimBehaviour:OwnerIdle()
	if self:IsActive() then
		self.unit:ElectBehaviour()
	end
end

function AutoReclaimBehaviour:Update()
	--game:GetMapFeatures()
end

function AutoReclaimBehaviour:Activate()
	self.active = true
	local fcount = game.map:GetMapFeatures(self.unit:Internal():GetPosition(),200)
	self.unit:Internal():AreaReclaim(self.unit:Internal():GetPosition(),500)
end

function AutoReclaimBehaviour:Deactivate()
	self.active = false
end

function AutoReclaimBehaviour:Priority()
	--if self.build == true  then
	--	return 100
	--end
	--return 0
	return 49 + game.map:GetMapFeatures(self.unit:Internal():GetPosition(),500)
end

function AutoReclaimBehaviour:OwnerDead()
	--
end
