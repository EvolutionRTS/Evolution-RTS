function widget:GetInfo()
	return {
		name      = "modding/debug: unit piece tree",
		desc      = "Developer Debugging - write a tree or list of all the unit pieces in a unit",
		author    = "knorke",
		date      = "2011",
		license   = "do you care?",
		layer     = 0,
		enabled   = false  --  loaded by default?
	}
end


function widget:UnitCreated(unitID, unitDefID, teamID, builderID)	
--	if ( Spring.IsCheatingEnabled() == true ) then
		write_unit_piece_tree (unitID, unitDefID)
--	end
end

function write_unit_piece_tree (unitID, unitDefID)
	local unitDef = UnitDefs[unitDefID]
	Spring.Echo ("*** pieces tree of " .. unitDef.name .. " ***")
	write_children (unitID,1,0)
end

function write_children (unitID, pID, recdeep)	
	PieceInfo = Spring.GetUnitPieceInfo (unitID, pID)
	local pname = PieceInfo.name
	if (recdeep == 0) then Spring.Echo (pname) end
	local pchildren = PieceInfo.children
	for i,cname  in ipairs(pchildren) do
		local cpID = Spring.GetUnitPieceMap(unitID)[cname]		
		local spacing = string.rep("-",recdeep+1)
		Spring.Echo (spacing .. cname)
		write_children (unitID, cpID,recdeep+1)
    end
	return
end

function write_piece_list (unitID)
	local allpieces = Spring.GetUnitPieceList (unitID)
	local piece_n = table.getn (allpieces)
	Spring.Echo ("unit has " .. piece_n  .. " pieces")
	for pID=1, piece_n,1  do		
		Spring.Echo ("pID:" .. pID)
		PieceInfo = Spring.GetUnitPieceInfo (unitID,pID)
		local pname = PieceInfo.name
		local pchildren = PieceInfo.children		
		Spring.Echo (" name:"..pname)
	end
end