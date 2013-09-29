local versionNumber = "v1.0_EVO"

local unitlist={--- Human friendly list. Automatically converted to unitdef IDs on init
 -- EVO

{'emetalextractor','euwmetalextractor'},
{'esolar2','euwsolar2'},
{'efusion2','euwfusion2'},
{'estorage','euwstorage'},


}

function widget:GetInfo()
	return {
		name = "Context Build",
		desc = "Toggles buildings between sea and land buildings automagically. " .. versionNumber ,
		author = "dizekat",
		date = "30 July 2009",
		license = "GNU LGPL, v2.1 or later",
		layer = 1,
		enabled = true
	}
end
local TestBuildOrder      = Spring.TestBuildOrder
local GetActiveCommand      = Spring.GetActiveCommand
local SetActiveCommand      = Spring.SetActiveCommand
local GetMouseState      = Spring.GetMouseState
local TraceScreenRay      = Spring.TraceScreenRay
local TestBuildOrder      = Spring.TestBuildOrder

local alternative_units = {}-- unit def id --> list of alternative unit def ids

function widget:Initialize()
	local un_to_ud = {}--- unit name or humanName --> unit def id
	for i,a in ipairs(UnitDefs) do
		un_to_ud[a.name]=i
		-- un_to_ud[a.humanName]=i
	end
	--[[
	for i,a in ipairs(FeatureDefs) do
		un_to_ud[a.name]=i
		un_to_ud[a.humanName]=i
	end
	]]
	for i,a in ipairs(unitlist) do
		local list={}
		for j,b in ipairs(a) do
			local ud=un_to_ud[b]
			if ud then
				table.insert(list,ud)
				alternative_units[ud]=list
			end
		end
	end
end

local initial_id=nil
local current_id=nil

function widget:DrawScreen()
	local _, cmd_id = GetActiveCommand()
	if (not cmd_id) or (cmd_id>=0) then
		initial_id=nil
		current_id=nil
		return 
	end
	local ud_id = -cmd_id
	local alternatives = alternative_units[ud_id]
	if (not alternatives) then
		initial_id=nil
		current_id=nil
		return 
	end
	
	local mx, my = GetMouseState()
	local _, coords = TraceScreenRay(mx, my, true, true)	
	if (not coords) then		
		return 
	end
	if ud_id~=current_id then -- command was changed by user or other widget.
		current_id=ud_id
		initial_id=ud_id
	end
	
	--Spring.Echo('x='..coords[1]..' y='..coords[2]..' z='..coords[3]);
	if initial_id and initial_id ~= current_id then -- if this widget has changed command, always try to revert back to initial.
		if TestBuildOrder(initial_id, coords[1], coords[2], coords[3], 1)~=0 then
			--Spring.Echo('switching to initial');
			--SetActiveCommand(-initial_id) -- does not work
			if SetActiveCommand('buildunit_'..UnitDefs[initial_id].name) then
				current_id=initial_id
				return
			end
		end
	end
	
	if TestBuildOrder(ud_id, coords[1], coords[2], coords[3], 1)==0 then -- cannot build that command
		-- Spring.Echo('cant build, looking for alternatives');
		for i,alt_id in ipairs(alternatives) do --- try all alternatives
			--Spring.Echo('trying alternative '..UnitDefs[alt_id].name);
			if TestBuildOrder(alt_id, coords[1], coords[2], coords[3], 1)~=0 then
				--Spring.Echo('switching to '..UnitDefs[alt_id].name);
				if SetActiveCommand('buildunit_'..UnitDefs[alt_id].name) then
					if not initial_id then
						initial_id=ud_id
					end
					current_id=alt_id
					return
				end
			end
		end
	end
	
end
