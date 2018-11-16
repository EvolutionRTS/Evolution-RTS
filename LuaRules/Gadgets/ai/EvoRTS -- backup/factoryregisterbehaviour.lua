FactoryRegisterBehaviour = class(Behaviour)

function FactoryRegisterBehaviour:Init()
	--
end

function FactoryRegisterBehaviour:UnitFinished(unit)
    if ai.factories ~= nil then
		ai.factories = ai.factories + 1
	else
		ai.factories = 1
	end
end

function FactoryRegisterBehaviour:UnitIdle(unit)

end

function FactoryRegisterBehaviour:Update()
	--
end

function FactoryRegisterBehaviour:Activate()
	self.unit:ElectBehaviour()
end

function FactoryRegisterBehaviour:Deactivate()
end

function FactoryRegisterBehaviour:Priority()
	return 0
end

function FactoryRegisterBehaviour:UnitDead(unit)
	if ai.factories ~= nil then
		ai.factories = ai.factories - 1
	else
		ai.factories = 0
	end
end
