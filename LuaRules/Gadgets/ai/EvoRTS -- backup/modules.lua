
controlPoints = Spring.GetModOptions().scoremode

if controlPoints == nil then
	controlPoints = "disabled"
end

if controlPoints == "disabled" then
	shard_include( "spothandler" )
	shard_include( "unithandler" )
	shard_include( "attackhandler" )
	shard_include( "placementhandler" )
	shard_include( "sleep" )
	
	modules = { UnitHandler, AttackHandler, MetalSpotHandler, PlacementHandler, Sleep }
else
	shard_include( "spothandler" )
	shard_include( "controlpointhandler" )
	shard_include( "unithandler" )
	shard_include( "attackhandler" )
	shard_include( "placementhandler" )
	shard_include( "sleep" )
	
	modules = { UnitHandler, AttackHandler, ControlPointHandler, MetalSpotHandler, PlacementHandler, Sleep }
end


--shard_include( "spothandler" )
--shard_include( "controlpointhandler" )
--shard_include( "unithandler" )
--shard_include( "attackhandler" )
--shard_include( "sleep" )

--modules = { UnitHandler, AttackHandler, MetalSpotHandler, Sleep }
--modules = { UnitHandler, AttackHandler, ControlPointHandler, MetalSpotHandler, Sleep }
