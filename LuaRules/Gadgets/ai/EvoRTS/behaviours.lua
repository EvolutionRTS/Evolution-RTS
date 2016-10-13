
shard_include "taskqueues"
shard_include "taskqueuebehaviour"
shard_include "attackerbehaviour"
shard_include "capturerbehaviour"
--require "missingfactorybehaviour"
--require "engineerturretbehaviour"
--require "autoreclaimbehaviour"
--shard_include "lowenergybehaviour"
--require "factoryregisterbehaviour"

behaviours = {
	--eorb = {
	--	AutoReclaimBehaviour,
	--},
	ebasefactory = {
		TaskQueueBehaviour,
		--FactoryRegisterBehaviour,
	},
	eairplant = {
		TaskQueueBehaviour,
		--FactoryRegisterBehaviour,
	},
	eamphibfac = {
		TaskQueueBehaviour,
		--FactoryRegisterBehaviour,
	},
	eminifac = {
		TaskQueueBehaviour,
		--FactoryRegisterBehaviour,
	},
	ecommanderai = {
		TaskQueueBehaviour,
		--LowEnergyBehaviour,
		--EngineerTurretBehaviour,
	},
	eengineer5 = {
		TaskQueueBehaviour,
		--MissingFactoryBehaviour,
		--EngineerTurretBehaviour,
		--LowEnergyBehaviour,
	},
	eamphibengineer = {
		TaskQueueBehaviour,
		--MissingFactoryBehaviour,
		--EngineerTurretBehaviour,
		--LowEnergyBehaviour,
	},
	eairengineer = {
		TaskQueueBehaviour,
		--MissingFactoryBehaviour,
		--EngineerTurretBehaviour,
		--LowEnergyBehaviour,
	},
	eallterrengineer = {
		TaskQueueBehaviour,
		--MissingFactoryBehaviour,
		--EngineerTurretBehaviour,
		--LowEnergyBehaviour,
	},
}

function defaultBehaviours(unit)
	b = {}
	
	u = unit:Internal()
	if u:CanBuild() then
		table.insert(b,TaskQueueBehaviour)
		if u:CanMove() then
			local utype = game:GetTypeByName("ebasefactory")
			if u:CanBuild(utype) then
				table.insert(b,MissingFactoryBehaviour)
			end
			utype = game:GetTypeByName("elightturret2")
			if u:CanBuild(utype) then
				table.insert(b,EngineerTurretBehaviour)
			end
		end
	else
		if IsAttacker(unit) then
			table.insert(b,AttackerBehaviour)
		end
		if IsCapturer(unit) then
			table.insert(b,CapturerBehaviour)
		end
	end
	
	return b
end
