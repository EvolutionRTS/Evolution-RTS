MissingFactoryBehaviour = class(Behaviour)

function MissingFactoryBehaviour:Init()
	--
	self.active = false
	self.building = false
	self.build = false
end

function MissingFactoryBehaviour:UnitCreated(unit)
end

function MissingFactoryBehaviour:UnitIdle(unit)
	if unit:Internal():ID() == self.unit:Internal():ID() then
		self.building = false
		if self:IsActive() then
			self.unit:ElectBehaviour()
		end
	end
end

function MissingFactoryBehaviour:Update()
	--
end

function MissingFactoryBehaviour:Activate()
	self.build = false
	
	local s = self.unit:Internal():Build("ebasefactory")
	if s then
		self.active = true
		self.building = true
	else
		self.unit:ElectBehaviour()
	end
end

function MissingFactoryBehaviour:Deactivate()
	self.active = false
	self.building = false
	self.build = false
end

function MissingFactoryBehaviour:Priority()
	if self.build == true  then
		return 100
	end
	return 0
end

function MissingFactoryBehaviour:UnitDead(unit)
	if unit:Internal():Name() == "ebasefactory" then
		self.build = true
		--game:SendToConsole("missingfactory activated")
	elseif unit:Internal():Name() == "ebasefactory" then
		self.build = true
		--game:SendToConsole("missingfactory activated")
	end
end
