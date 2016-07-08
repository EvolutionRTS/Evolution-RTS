EngineerTurretBehaviour = class(Behaviour)

function EngineerTurretBehaviour:Init()
	--
	self.active = false
	self.underfire = false
end

function EngineerTurretBehaviour:OwnerIdle()
	if self:IsActive() then
		self.unit:ElectBehaviour()
	end
end

function EngineerTurretBehaviour:Update()
	--
end

function EngineerTurretBehaviour:Activate()
	self.underfire = false
	
	local s = self.unit:Internal():Build("elightturret2")
	if s then
		self.active = true
	else
		self.unit:ElectBehaviour()
	end
end

function EngineerTurretBehaviour:Deactivate()
	self.active = false
	self.underfire = false
end

function EngineerTurretBehaviour:Priority()
	if self.underfire == true  then
		return 110
	end
	return 0
end

function EngineerTurretBehaviour:OwnerDead()
	--
end

function EngineerTurretBehaviour:OwnerDamaged(attacker)
	if not self:IsActive() then
		self.underfire = true
		self.unit:ElectBehaviour()
	end
end

