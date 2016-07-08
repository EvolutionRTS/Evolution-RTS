LowEnergyBehaviour = class(Behaviour)

function LowEnergyBehaviour:Init()
	--
	self.active = false
	self.underfire = false
end

function LowEnergyBehaviour:OwnerIdle()
	if not self:IsActive() then
		res = game:GetResourceByName("energy")
		if res == nil then
			game:SendToConsole("res == nil in LowEnergyBehaviour")
		end
	else
		if res and res.reserves == 0 then
			self.underfire = true
		end
		self.unit:ElectBehaviour()
	end
end

function LowEnergyBehaviour:Update()
	--
end

function LowEnergyBehaviour:Activate()
	self.underfire = false

	local s = self.unit:Internal():Build("esolar2")
	if s then
		self.active = true
	else
		self.unit:ElectBehaviour()
	end
end

function LowEnergyBehaviour:Deactivate()
	self.active = false
	self.underfire = false
end

function LowEnergyBehaviour:Priority()
	if self.underfire == true  then
		return 110
	end
	return 0
end

function LowEnergyBehaviour:OwnerDead()
	--
end

function LowEnergyBehaviour:OwnerDamaged(attacker)

end

