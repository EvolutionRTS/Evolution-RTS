----used custom tags
------in the featureDef: provide_cover (int)
------in the unitDef: need_cover (int)

function gadget:GetInfo()
  return {
    name      = "take cover assheads",
    desc      = "fuck yeah",
    author    = "knorke",
    date      = "now",
    license   = "weeeeeee iam on horse",
    layer     = -3,
    enabled   = true--  loaded by default?
  }
end

if (gadgetHandler:IsSyncedCode()) then ---SYNCHED

local resolution = 100
local updateRate = 30
_G.resolution = resolution
cover = {}
_G.cover = cover
local mapX = Game.mapSizeX+1
local mapZ = Game.mapSizeZ+1	

local needed_cover = {} --[unitID]

--Spring.GetFeatureRadius ( number featureID ) -> nil | number
--Spring.GetFeaturePosition( number featureID ) -> nil | number x, number y, number z

function gadget:Initialize()	
	local all_units = Spring.GetAllUnits ()
	for i in pairs(all_units) do
		--Spring.Echo ("unit " .. all_units[i])
		local ud = UnitDefs[Spring.GetUnitDefID(all_units[i])]
		if (ud) then			
			needed_cover[all_units[i]] = tonumber (ud.customParams.needed_cover) or 999
			--Spring.Echo ("needs a cover of " .. needed_cover[all_units[i]])
		end
	end
	buildCover ()
end

function setcover (x,z, c)
	--Spring.Echo ("x= ".. x .. "    z=" .. z)
	local tx, tz = tcoord (x,z)
	--Spring.Echo ("tx= ".. tx .. "    tz=" .. tz)
	cover[tx][tz] = c
	_G.cover = cover
end

function getcover (x,z)
	if (x > mapX) then return 0 end
	if (x < 0) then return 0 end
	if (z > mapZ) then return 0 end
	if (z < 0) then return 0 end
	local tx, tz = tcoord (x,z)
	return cover[tx][tz] or 0
end

function addcover (x,z, a)
	--Spring.Echo ("adding " .. a .. " cover at " .. x .. ":" .. z)
	local old = getcover (x,z)
	if (old+a < 0) then 
		setcover (x,z, 0)
	else
		setcover (x,z, old+a)
	end	
end

function providedCoverFromFeature (featureID)
	local fd = FeatureDefs[Spring.GetFeatureDefID(featureID)]
	--Spring.Echo (fd.name)
	if (not fd) then return 555 end
	if (not fd.customParams) then return 666 end
	return fd.customParams["provide_cover"] or 0
end


function tcoord (x,z)
	tx=math.floor ((x/resolution)+0.5)
	tz=math.floor ((z/resolution)+0.5)
	return tx,tz
end

function buildCover ()
	local cnt=0
	for x=0, mapX+resolution, resolution do	
		local tx, tz = tcoord (x,666)
		cover[tx]={}
		for z=0 , mapZ+resolution, resolution do		
			cnt=cnt+1
			--Spring.Echo ("BAUE tx= ".. tx .. "    tz=" .. tz)
			local tx, tz = tcoord (x,z)
			cover[tx][tz] = 0		--***wasting memory. who cares?
		end
	end	
	--Spring.Echo ("count=" .. cnt)

	local allF = Spring.GetAllFeatures ()
	for i in pairs(allF) do
		local fi = allF[i]
		local x,y,z = Spring.GetFeaturePosition (fi)
		if(x and z) then	
			--local tx, tz = tcoord (x,z)
			--Spring.MarkerAddPoint (x,y,z, "feature @ " .. tx .. ":" .. tz)
			--addcover (x,z, 1)
			--addcover (x,z, 1)
			addcover (x,z, providedCoverFromFeature (fi))
			--local old = getcover (tx,tz)
			--setcover (x,z, old+a)
		end
	end
end

function updateUnits ()
	local all_units = Spring.GetAllUnits ()
	for i in pairs(all_units) do		
		local x,y,z=Spring.GetUnitPosition (all_units[i])
		if (x and y and z) then		--***why is this needed? sometimes x is nil for some reason?!
			local c = getcover (x,z)
			if (c >= (needed_cover[all_units[i]] or 999)) then
				--Spring.Echo (c)
				hideUnit (all_units[i])
			else
				unhideUnit (all_units[i])
			end
		end

	end
end

--***vielleicht lieber setunitlosstate?
function hideUnit (uID)
	Spring.SetUnitCloak (uID, 2 ,false)
	Spring.SetUnitStealth (uID, true)
end

function unhideUnit (uID)
    Spring.SetUnitCloak (uID, false ,false)
    if not UnitDefs[Spring.GetUnitDefID(uID)].stealth then
        Spring.SetUnitStealth (uID, false)
    end
end


function gadget:GameFrame (f)
	if (f%updateRate ==0) then 
	--Spring.Echo ("running")
	updateUnits ()
	end
end

function gadget:FeatureDestroyed(featureID, allyTeam)
	local x,y,z = Spring.GetFeaturePosition (featureID)
	if(x and z) then	
		addcover (x,z, -providedCoverFromFeature (featureID))
	end
end

function gadget:FeatureCreated(featureID, allyTeam)
	local x,y,z = Spring.GetFeaturePosition (featureID)
	if(x and z) then	
		addcover (x,z, providedCoverFromFeature (featureID))
	end
end

function gadget:UnitFinished(unitID, unitDefID, teamID)
	local cp = UnitDefs[unitDefID].customParams
	if (not cp) then return end		
	needed_cover[unitID] = tonumber (cp.needed_cover) or math.huge
end

function gadget:UnitDestroyed(unitID)
	needed_cover[unitID] = nil
end


-------------------
else ----UNSYNCED--
-------------------

local debugDraw = false
--***how can i avoid having this function twice?
function utcoord (x,z)
	tx=math.floor ((x/SYNCED.resolution)+0.5)
	tz=math.floor ((z/SYNCED.resolution)+0.5)
	return tx,tz
end

function ugetcover (x,z)
	local tx, tz = utcoord (x,z)
	return SYNCED.cover[tx][tz]
end

function gadget:DrawWorldPreUnit()
	if (debugDraw) then 
		--gl.LineWidth(2.0)	
		gl.Color(0, 1, 1, 1)
		local mapX = Game.mapSizeX-1
		local mapZ = Game.mapSizeZ-1	
		for x=1, mapX, SYNCED.resolution do
			for z=1 ,mapZ, SYNCED.resolution do			
					local c = ugetcover (x,z)
					if (c > -1) then
						gl.DrawGroundCircle (x,100,z, SYNCED.resolution/2, 8)
						gl.DrawGroundCircle (x,100,z, (SYNCED.resolution/10)+(c*10), 8)
					end
			end
		end
	end
end

--[[ function gadget:KeyPress(key, mods, isRepeat)	
	if (key == 108 and Spring.IsCheatingEnabled() ) then debugDraw = not debugDraw end --108=L
end ]]--

end