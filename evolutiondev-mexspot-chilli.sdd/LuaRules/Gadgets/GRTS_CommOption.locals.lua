--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Automatically generated local definitions

local spCreateUnit      = Spring.CreateUnit
local spDestroyUnit     = Spring.DestroyUnit
local spGetAllUnits     = Spring.GetAllUnits
local spGetModOptions   = Spring.GetModOptions
local spGetUnitDefID    = Spring.GetUnitDefID
local spGetUnitPosition = Spring.GetUnitPosition
local spGetUnitTeam     = Spring.GetUnitTeam
local spSetUnitLineage  = Spring.SetUnitLineage

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
	return {
		name = "Commander Options",
		desc = "Implements the Commander mod option",
		author = "KDR_11k (David Becker)",
		date = "2007-12-10",
		license = "None",
		layer = 1,
		enabled = true
	}
end

if (gadgetHandler:IsSyncedCode()) then

--SYNCED

function gadget:GameFrame(f)

	local type = "std"
	
	type = spGetModOptions().comm
		
	if type and type ~="std" then 
		for _,u in ipairs(spGetAllUnits()) do
			local x,y,z = spGetUnitPosition(u)
			local team = spGetUnitTeam(u)
			local newUnit

			if spGetUnitDefID(u) == UnitDefNames.ecommander.id then

				if type == "sandbox" then
					newUnit = spCreateUnit("goldtree",x,y,z,0,team)
					newUnit = spCreateUnit("eairengineer",x-180,y,z-180,0,team)
					-- newUnit = spCreateUnit("tinygaw",x+180,y,z+180,0,team)	
				elseif type == "feature" then
					newUnit = spCreateUnit("goldtree",x,y,z,0,team)
					newUnit = spCreateUnit("eairengineer",x-180,y,z-180,0,team)
					-- newUnit = spCreateUnit("tinygaw",x+180,y,z+180,0,team)								
				end

			-- for future commander additions
			-- elseif spGetUnitDefID(u) == UnitDefNames.ecommandfactory.id then

				-- if type == "sandbox" then
					-- newUnit = spCreateUnit("goldtree",x,y,z,0,team)
					-- newUnit = spCreateUnit("eairengineer",x-180,y,z-180,0,team)
					-- newUnit = spCreateUnit("tinygaw",x+180,y,z+180,0,team)	
				-- elseif type == "feature" then
					-- newUnit = spCreateUnit("goldtree",x,y,z,0,team)
					-- newUnit = spCreateUnit("eairengineer",x-180,y,z-180,0,team)	
					-- newUnit = spCreateUnit("tinygaw",x+180,y,z+180,0,team)						
				-- end
			end
			
			--spSetUnitLineage(newUnit, team, true)
			spDestroyUnit(u,false, true)
		end
	end
	gadgetHandler.RemoveGadget(gadget)
end

end
