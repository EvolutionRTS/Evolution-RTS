
function widget:GetInfo()
	return {
		name = "Keep Morpheds Selected",
		desc = "Maintain unit selection and factory queue (for EvoRTS) through morphing",
		author = "zwzsg, modified by CommonPlayer",
		version = "1.1",
		date = "August, 5th, 2009", --modified by CommonPlayer, May 2018
		license = "Public Domain",
		layer = 0,
		enabled = true,
	}
end

local spGetFullBuildQueue = Spring.GetFullBuildQueue

local Createds={}
local Destroyeds={}

local DestroyedsHasQueue={}

function widget:UnitDestroyed(unitID,unitDefID,teamID)
	local x,_,z=Spring.GetUnitPosition(unitID)
	
	if Spring.IsUnitSelected(unitID) then
		table.insert(Destroyeds,{u=unitID,x=x,z=z,t=teamID})
	end
	
	local queue = spGetFullBuildQueue(unitID)
	if queue[1] and UnitDefs[unitDefID].isFactory then table.insert(DestroyedsHasQueue, {u=unitID,x=x,z=z,t=teamID,queue=queue}) end
end

function widget:UnitCreated(unitID,unitDefID,teamID)
	local x,_,z=Spring.GetUnitPosition(unitID)
	table.insert(Createds,{u=unitID,x=x,z=z,t=teamID})
end

function widget:GameFrame(frameNum)
	local ToReSelect={}
	
	for _,c in ipairs(Createds) do
		--Spring.Echo("#DesQuee" .. #DestroyedsHasQueue)
		for _,d in ipairs(DestroyedsHasQueue) do
			if c.x==d.x and c.z==d.z and c.t==d.t then
				for i = 1, #d.queue do
					for k, v in pairs(d.queue[i]) do
						for _ = 1, v do Spring.GiveOrderToUnit(c.u, -UnitDefs[k].id, {}, 0) end
						
						local oldName = UnitDefs[k].name
						local newName = oldName .. "_up1"
						if oldName:find("_up1") then newName = oldName:gsub("_up1", "_up2")
						elseif oldName:find("_up2") then newName = oldName:gsub("_up2", "_up3") end
						local uDefName = UnitDefNames[newName]
						if uDefName then
							for _ = 1, v do Spring.GiveOrderToUnit(c.u, -uDefName.id, {}, 0) end
							--Spring.Echo(UnitDefs[k].name .. "___" .. v)
							--Spring.Echo(uDefName.id)
						end
					end
				end
			end
		end
	end
		
		
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
	
	DestroyedsHasQueue={}
end
