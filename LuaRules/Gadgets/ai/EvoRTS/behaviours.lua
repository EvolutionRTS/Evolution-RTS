
controlPoints = Spring.GetModOptions().scoremode

if controlPoints == nil then
	controlPoints = "disabled"
end

if controlPoints == "disabled" then
	shard_include(  "taskqueues" )
	shard_include(  "taskqueuebehaviour" )
	shard_include(  "attackerbehaviour" )
	shard_include(  "bootbehaviour" )
	shard_include(  "nukebehaviour" )
	--shard_include(	"morphbehaviour"	)
	--shard_include(  "engineerturretbehaviour"  )
	else
	shard_include(  "taskqueues" )
	shard_include(  "taskqueuebehaviour" )
	shard_include(  "attackerbehaviour" )
	shard_include(  "bootbehaviour" )
	shard_include(  "capturerbehaviour" )
	shard_include(  "nukebehaviour" )
	--shard_include(	"morphbehaviour"	)
	--shard_include(  "engineerturretbehaviour"  )
end

behaviours = {
	xklab = {
		TaskQueueBehaviour,
	},
	zarm = {
		TaskQueueBehaviour,
	},
	zespire1 = {
		TaskQueueBehaviour,
	},
	zespire4 = {
		TaskQueueBehaviour,
	},
	zhive = {
		TaskQueueBehaviour,
	},
	esilo = {
		NukeBehaviour,
	},
	eorb = {
		AttackerBehaviour,
	},
	eorb_up1 = {
		AttackerBehaviour,
	},
	eorb_up2 = {
		AttackerBehaviour,
	},
	eorb_up3 = {
		AttackerBehaviour,
	},
	
	ebasefactory = {
		TaskQueueBehaviour,
	},
	eairplant = {
		TaskQueueBehaviour,
	},
	eamphibfac = {
		TaskQueueBehaviour,
	},
	eminifac = {
		TaskQueueBehaviour,
	},
	ehbotfac = {
		TaskQueueBehaviour,
	},
	ebasefactory_up1 = {
		TaskQueueBehaviour,
	},
	eairplant_up1 = {
		TaskQueueBehaviour,
	},
	eamphibfac_up1 = {
		TaskQueueBehaviour,
	},
	eminifac_up1 = {
		TaskQueueBehaviour,
	},
	ehbotfac_up1 = {
		TaskQueueBehaviour,
	},
	ebasefactory_up2 = {
		TaskQueueBehaviour,
	},
	eairplant_up2 = {
		TaskQueueBehaviour,
	},
	eamphibfac_up2 = {
		TaskQueueBehaviour,
	},
	eminifac_up2 = {
		TaskQueueBehaviour,
	},
	ehbotfac_up2 = {
		TaskQueueBehaviour,
	},
	ebasefactory_up3 = {
		TaskQueueBehaviour,
	},
	eairplant_up3 = {
		TaskQueueBehaviour,
	},
	eamphibfac_up3 = {
		TaskQueueBehaviour,
	},
	eminifac_up3 = {
		TaskQueueBehaviour,
	},
	ehbotfac_up3 = {
		TaskQueueBehaviour,
	},
	
	eartyturret = {
		AttackerBehaviour,
	},
	eartyturret_up1 = {
		AttackerBehaviour,
	},
	eartyturret_up2 = {
		AttackerBehaviour,
	},
	eartyturret_up3 = {
		AttackerBehaviour,
	},
	
	ecommanderbattleai = {
		TaskQueueBehaviour,
	},
	
	eengineer5 = {
		TaskQueueBehaviour,
	},
	
	eamphibengineer = {
		TaskQueueBehaviour,
	},
	
	eairengineer = {
		TaskQueueBehaviour,
	},
	
	eallterrengineer = {
		TaskQueueBehaviour,
	},
	--eaimexer = {
		--EngineerTurretBehaviour,
	--},
	
	-- zlightswarm = {
		-- AttackerBehaviour,
	-- },
	-- zairscout = {
		-- AttackerBehaviour,
	-- },
}

function defaultBehaviours(unit)
	b = {}
	
	u = unit:Internal()
	--table.insert(b,MorphBehaviour)
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
		if controlPoints == "disabled" then
			if IsAttacker(unit) then
				table.insert(b,AttackerBehaviour)
			end
		else
			if IsAttacker(unit) then
				table.insert(b,AttackerBehaviour)
			end
			if IsCapturer(unit) then
				table.insert(b,CapturerBehaviour)
			end
		end
	end
	
	return b
end