
shard_include(  "taskqueues" )
shard_include(  "taskqueuebehaviour" )
shard_include(  "attackerbehaviour" )
shard_include(  "capturerbehaviour" )
shard_include(  "bootbehaviour" )

behaviours = { }

function defaultBehaviours(unit)
	b = {}
	u = unit:Internal()
	table.insert(b, BootBehaviour )
	if u:CanBuild() then
		table.insert(b,TaskQueueBehaviour)
	else
		if IsCapturer(unit) then
			table.insert(b,CapturerBehaviour)
		end
		if IsAttacker(unit) then
			table.insert(b,AttackerBehaviour)
		end
	end
	return b
end
