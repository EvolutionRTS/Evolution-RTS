
function widget:GetInfo()
	return {
		name = "Keep Morpheds Selected",
		desc = "Maintain unit selection through morphing",
		author = "zwzsg",
		version = "1.0",
		date = "August, 5th, 2009",
		license = "Public Domain",
		layer = 0,
		enabled = true,
	}
end

local Createds={}
local Destroyeds={}

function widget:UnitDestroyed(unitID,unitDefID,teamID)
	if Spring.IsUnitSelected(unitID) then
		local x,_,z=Spring.GetUnitPosition(unitID)
		table.insert(Destroyeds,{u=unitID,x=x,z=z,t=teamID})
	end
end

function widget:UnitCreated(unitID,unitDefID,teamID)
	local x,_,z=Spring.GetUnitPosition(unitID)
	table.insert(Createds,{u=unitID,x=x,z=z,t=teamID})
end

function widget:GameFrame(frameNum)
	local ToReSelect={}
	for _,c in ipairs(Createds) do
		for _,d in ipairs(Destroyeds) do
			if c.x==d.x and c.z==d.z and c.t==d.t then
				table.insert(ToReSelect,c.u)
			end
		end
	end
	if #ToReSelect>0 then
		Spring.SelectUnitArray(ToReSelect,true)
	end
	Createds={}
	Destroyeds={}
end

