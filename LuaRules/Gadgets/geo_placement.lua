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
local mapx, mapz = Game.mapSizeX * 0.5, Game.mapSizeZ * 0.5
-- Params

local size = math.max(mapx, mapz)

--
Spring.Echo("[LuaGeo] Map size is: " .. mapx + mapz)
local players = Spring.GetPlayerList()
local count = 0
for i = 1, #players do
    local playerID = players[i]
    if not select(3, Spring.GetPlayerInfo(playerID)) then
        count = count + 1
    end
end
--Spring.SetGameRulesParam("peopleCount", count)

teamIDCount = Spring.GetGameRulesParam("peopleCount")

Spring.Echo("[LuaGeo] Number of teamIDs in this match: " .. teamIDCount)
--

local numPointsPerSide = 8
local rotation = 3

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
            newPoint[1] = mapx * (distanceFromCorner + width * x * x)
            newPoint[2] = mapz * (distanceFromCorner + length * x)
        else -- 2 or 3
            newPoint[1] = mapx * (distanceFromCorner + length * x)
            newPoint[2] = mapz * (distanceFromCorner + width * x * x)
        end
        if rotation % 2 == 1 then newPoint[2] = mapz - newPoint[2] end -- 1 or 3
        positions[#positions + 1] = {x = newPoint[1], z = newPoint[2]}
        positions[#positions + 1] = {x = mapx - newPoint[1], z = mapz - newPoint[2]}
    end
    return positions
end

local positions = makePositionsForGeoSpots(mapx, mapz, numPointsPerSide, rotation)

if ( positions ) then
	Spring.Echo("I found positions")
	for i,numPointsPerSide in pairs(positions) do
		Spring.Echo("I'm trying to create a feature")
		Spring.CreateFeature('geovent', positions[0], Spring.GetGroundHeight(positions[0],positions[1])+5, positions[1], 0)
	end
end