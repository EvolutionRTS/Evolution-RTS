
controlPoints = Spring.GetModOptions().controlvictoryoptions

if controlPoints == nil then
	controlPoints = "disabled"
end

if controlPoints == "disabled" then
	shard_include(  "taskqueues" )
	shard_include(  "taskqueuebehaviour" )
	shard_include(  "attackerbehaviour" )
	shard_include(  "bootbehaviour" )
	else
	shard_include(  "taskqueues" )
	shard_include(  "taskqueuebehaviour" )
	shard_include(  "attackerbehaviour" )
	shard_include(  "bootbehaviour" )
	shard_include(  "capturerbehaviour" )
end

behaviours = { }

function defaultBehaviours(unit)
	b = {}
	u = unit:Internal()
	table.insert(b, BootBehaviour )
	if u:CanBuild() then
		table.insert(b,TaskQueueBehaviour)
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
