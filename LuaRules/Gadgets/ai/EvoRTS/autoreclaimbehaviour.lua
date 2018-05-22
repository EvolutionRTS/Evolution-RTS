AutoReclaimBehaviour = class(Behaviour)

function AutoReclaimBehaviour:Init()
	--
	self.active = false
end

function AutoReclaimBehaviour:UnitCreated(unit)
end

function AutoReclaimBehaviour:UnitIdle(unit)
	if unit:Internal():ID() == self.unit:Internal():ID() then
		if self:IsActive() then
			self.unit:ElectBehaviour()
		end
	end
	
end

function AutoReclaimBehaviour:Update()
	--self.game:GetMapFeatures()
end

function AutoReclaimBehaviour:Activate()
	self.active = true
	local fcount = self.game.map:GetMapFeatures(self.unit:Internal():GetPosition(),200)
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
	return 49 + self.game.map:GetMapFeatures(self.unit:Internal():GetPosition(),500)
end

function AutoReclaimBehaviour:UnitDead(unit)
	--
end
