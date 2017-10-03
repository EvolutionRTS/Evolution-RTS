EngineerTurretBehaviour = class(Behaviour)

function EngineerTurretBehaviour:Init()
	--
	self.active = true
	self.underfire = false
end

function EngineerTurretBehaviour:UnitCreated(unit)
end

function EngineerTurretBehaviour:UnitIdle(unit)
	if unit:Internal():ID() == self.unit:Internal():ID() then
		if self:IsActive() then
			self.unit:ElectBehaviour()
		end
	end
	
end

function EngineerTurretBehaviour:Update()
	--
end

function EngineerTurretBehaviour:Activate()
	self.underfire = false
	
	local s = self.unit:Internal():Build("emetalextractor")
	if s then
		self.active = true
	else
		self.unit:ElectBehaviour()
	end
end

function EngineerTurretBehaviour:Deactivate()
	self.underfire = false
	
	local s = self.unit:Internal():Build("emetalextractor")
	if s then
		self.active = true
	else
		self.unit:ElectBehaviour()
	end
end

function EngineerTurretBehaviour:Priority()
	if self.underfire == true  then
		return 110
	end
	return 0
end

function EngineerTurretBehaviour:UnitDead(unit)
	--
end

function EngineerTurretBehaviour:UnitDamaged(unit,attacker)
	if unit:Internal():ID() == self.unit:Internal():ID() then
		if not self:IsActive() then
			self.underfire = true
			self.unit:ElectBehaviour()
		end
	end
end

