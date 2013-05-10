function widget:GetInfo()
	return {
		name = "Ground Texture Highlight - Frames",
		desc = "Display a multi-frame animated ground texture on selected, pointed, and being placed units",
		author = "zwzsg",
		date = "June 2010",
		license = "For you forby!",
		version = 1,
		layer = 0,
		enabled = true
	}
end

local GrTexSelLst = {}

function widget:Initialize()
	GrTexSelLst = {}
	for id,ud in pairs(UnitDefs) do
		local lst={}
		for name,value in pairs(ud.customParams) do
			local n=string.match(name,"groundtexselectimg%d*")
			if n then
				table.insert(lst,{k=tonumber(n) or -1,v=value})
			end
			table.sort(lst,function(a,b) return a.k<b.k end)
		end
		if #lst>0 then
			GrTexSelLst[id]={}
			for _,v in ipairs(lst) do
				table.insert(GrTexSelLst[id],v.v)
			end
		end
	end
end

local function DrawTexturedGroundQuadFromUdXZ(udid,x,z,f)
	if GrTexSelLst[udid] then
		gl.Color(1,1,1,1)
		gl.Texture(GrTexSelLst[udid][math.floor(widgetHandler:GetHourTimer()*3)%#GrTexSelLst[udid]+1])
		local xs,zs=4*UnitDefs[udid].xsize,4*UnitDefs[udid].zsize
		local cp=UnitDefs[udid].customParams
		if cp.groundtexselectxsize and cp.groundtexselectzsize then
			xs,zs=cp.groundtexselectxsize,cp.groundtexselectzsize
		end
		gl.DrawGroundQuad(x-xs,z-zs,x+xs,z+zs,false,0,0,1,1)
		gl.Texture(false)
	end
end

local function DrawTexturedGroundQuadFromU(u)
	local x,_,z=Spring.GetUnitPosition(u)
	DrawTexturedGroundQuadFromUdXZ(Spring.GetUnitDefID(u),x,z)
end

function widget:DrawWorldPreUnit()

	-- Units being placed
	local _,cmd=Spring.GetActiveCommand()
	if cmd and UnitDefs[-cmd] then
		local mx,my=Spring.GetMouseState()
		local _,pos=Spring.TraceScreenRay(mx,my,true,true)
		if pos then
			local x,_,z=unpack(pos)
			DrawTexturedGroundQuadFromUdXZ(-cmd,x,z)
		end
	end

	-- Selected units
	for _,u in ipairs(Spring.GetSelectedUnits() or {}) do
		DrawTexturedGroundQuadFromU(u)
	end

	-- Mouse-overed unit
	local mx,my=Spring.GetMouseState()
	local kind,u=Spring.TraceScreenRay(mx,my,false,true)
	if kind=="unit" then
		DrawTexturedGroundQuadFromU(u)
	end

end