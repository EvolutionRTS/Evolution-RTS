function gadget:GetInfo()
	return {
		name      = "LuaGeo",
		desc      = "Spawns GeoVents randomly on the map",
		author    = "Stowtemid, Forboding Angel",
		date      = "",
		license   = "PD",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end

if (Spring.GetGameFrame() >= 1) then
  return false
end

--math.randomseed(Game.GameID) -- This only works in 104+
math.random(); math.random(); math.random()
local mapxFull, mapzFull = Game.mapSizeX, Game.mapSizeZ
local mapx, mapz = Game.mapSizeX, Game.mapSizeZ * 0.5
local size = math.max(mapx, mapz)

local numPointsPerSide = 8
local rotation = 2

function makePositionsForGeoSpots(mapx, mapz, numPointsPerSide, rotation)
    -- Constants
    local distanceFromCorner = 0.15
    local width = 0.25
    local length = 0.6
    
    local positions = {}
    for i = 1, numPointsPerSide do
        local x = (i - 1) / (numPointsPerSide - 1) -- if numPointsPerSide = 4, then x = 0, 0.33, 0.67, 1
        local newPoint = {0, 0}
        if rotation < 2 then -- 0 or 1
            newPoint[1] = mapxFull * (distanceFromCorner + width * x * x)
            newPoint[2] = mapzFull * (distanceFromCorner + length * x)
        else -- 2 or 3
            newPoint[1] = mapxFull * (distanceFromCorner + length * x)
            newPoint[2] = mapzFull * (distanceFromCorner + width * x * x)
        end
        if rotation % 2 == 1 then newPoint[2] = mapzFull - newPoint[2] end -- 1 or 3
        positions[#positions + 1] = {x = newPoint[1], z = newPoint[2]}
        positions[#positions + 1] = {x = mapxFull - newPoint[1], z = mapzFull - newPoint[2]}
    end
    return positions
end

local positions = makePositionsForGeoSpots(mapx, mapz, numPointsPerSide, rotation)

if ( positions ) then
	local gaiaID = Spring.GetGaiaTeamID()
	Spring.Echo("[LuaGeo] I found positions for geovent feature placement!")
	local length = #positions
	for i = 1, length do
		Spring.Echo("[LuaGeo] I'm trying to create a geovent feature at:")
		Spring.Echo("[LuaGeo] x = " .. positions[i].x)
		Spring.Echo("[LuaGeo] z = " .. positions[i].z)
		Spring.CreateFeature('geovent', positions[i].x, Spring.GetGroundHeight(positions[i].x,positions[i].z)+5, positions[i].z, 1, gaiaID)
	end
end