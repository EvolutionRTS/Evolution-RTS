LowEnergyBehaviour = class(Behaviour)

function LowEnergyBehaviour:Init()
	--
	self.active = false
	self.underfire = false
end

function LowEnergyBehaviour:UnitCreated(unit)
end

function LowEnergyBehaviour:UnitIdle(unit)
	if unit:Internal():ID() == self.unit:Internal():ID() then

		if not self:IsActive() then
			res = game:GetResourceByName("energy")
			if res == nil then
				game:SendToConsole("res == nil in LowEnergyBehaviour")
		else
			if res.reserves == 0 then
				self.underfire = true
				self.unit:ElectBehaviour()
			end
		end
	else
		self.underfire = false
		self.unit:ElectBehaviour()
	end

	end
	if unit:Internal():ID() == self.unit:Internal():ID() then
		if self:IsActive() then
			self.unit:ElectBehaviour()
		end
	end

end

function LowEnergyBehaviour:Update()
	--
end

function LowEnergyBehaviour:Activate()
	self.underfire = false

	local s = self.unit:Internal():Build("emediumgen")
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

function LowEnergyBehaviour:UnitDead(unit)
	--
end

function LowEnergyBehaviour:UnitDamaged(unit,attacker)

end

