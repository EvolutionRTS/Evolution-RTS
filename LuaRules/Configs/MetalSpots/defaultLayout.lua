--math.randomseed(Game.GameID) -- This only works in 104+
math.random(); math.random(); math.random()
local mapx, mapz = Game.mapSizeX * 0.5, Game.mapSizeZ * 0.5
-- Params

local size = math.max(mapx, mapz)

--

local players = Spring.GetPlayerList()
local count = 0
for i = 1, #players do
    local playerID = players[i]
    if not select(3, Spring.GetPlayerInfo(playerID)) then
        count = count + 1
    end
end
Spring.SetGameRulesParam("peopleCount", count)

teamIDCount = Spring.GetGameRulesParam("peopleCount")

Spring.Echo("[Default Mex Layout] Number of teamIDs in this match:")
Spring.Echo(teamIDCount)
--

local placeMexesInWater = Spring.GetModOptions().allowmexesinwater or "enabled"
local maxMexElevationDiff = tonumber(Spring.GetModOptions().maximummexelevationdifference) or 50
local mexSpotsPerSide = tonumber(Spring.GetModOptions().mexspotsperside) or 30
local mexRandomLayout = Spring.GetModOptions().mexrandomlayout or "standard"

if placeMexesInWater == "enabled" or placeMexesInWater == "" or placeMexesInWater == nil then -- This is just an oshitifukedup protection
	allowMexesInWater = true
elseif placeMexesInWater == "disabled" then
	allowMexesInWater = false
end

if maxMexElevationDiff == nil then -- This is just an oshitifukedup protection
	maxMexElevationDiff = 50
end

if mexSpotsPerSide == nil then -- This is just an oshitifukedup protection
	mexSpotsPerSide = 30
end

if mexRandomLayout == "" or mexRandomLayout == nil then -- This is just an oshitifukedup protection
	mexRandomLayout = "standard"
end

Spring.Echo("[Default Mex Layout] Can we put mexes in water?")
Spring.Echo(allowMexesInWater)

local sGetGroundHeight = Spring.GetGroundHeight
local mexSideHalved = 70 -- mex is a square of side 140 units
local slopeCheckMinDistance = 35
local function checkSlope(x, z, tolerance, allowWater)
	local heightMap = {}
	local leng = 0
	for i = -mexSideHalved, mexSideHalved, slopeCheckMinDistance do
		for j = -mexSideHalved, mexSideHalved, slopeCheckMinDistance do
			leng = leng + 1
			heightMap[leng] = sGetGroundHeight(x + i, z + j)
		end
	end
	local highest = math.max(unpack(heightMap))
	local lowest = math.min(unpack(heightMap))
	local result = highest - lowest
	return result <= tolerance and (allowWater or lowest > 0)
end

local function f(x)
	if x < 0.6 then return 0.5 + math.pow((0.6 - x) / 0.6, 2) * 1.5
	elseif x < 0.8 then return (x - 0.6) / 0.4 + 0.5
	elseif x <= 1 then return 1 end
	return 0
end
local function makePositionsRandomMirrored(sizeX, sizeY, padding, pointRadius, extraSeparationBetweenPoints, howManyTriesBeforeGiveUp, numPointsPerSide, includeCentre, method, allowWater)
	--[[
	method 1: object rotated 180 degrees around centre to produce image
	method 2: object mirrored around horizontal line passing through centre to produce image
	method 3: object mirrored around vertical line passing through centre to produce image
	method 4: object mirrored around diagonal line going from NE to SW to produce image
	method 5: object mirrored around diagonal line going from NW to SE to produce image
	]]
	local positions = {}
	--positions[1] = {x = padding, z = padding}
	--positions[2] = {x = sizeX - padding, z = sizeY - padding}
	if includeCentre then positions[#positions + 1] = {x = sizeX * 0.5, z = sizeY * 0.5} end
	for i = 1, numPointsPerSide do
		local newPoint = {0, 0}
		local done = false
		local numIterations = 0
		local minSeparation = pointRadius * 2 + extraSeparationBetweenPoints
		while not done and numIterations < howManyTriesBeforeGiveUp do
			numIterations = numIterations + 1
			done = true
			newPoint[1] = padding + math.random() * (sizeX - padding * 2)
			newPoint[2] = padding + math.random() * (sizeY - padding * 2)
			if method == 1 then
				newPoint[3] = sizeX - newPoint[1]
				newPoint[4] = sizeY - newPoint[2]
			elseif method == 2 then
				newPoint[3] = newPoint[1]
				newPoint[4] = sizeY - newPoint[2]
			elseif method == 3 then
				newPoint[3] = sizeX - newPoint[1]
				newPoint[4] = newPoint[2]
			elseif method == 4 then
				newPoint[3] = sizeX - newPoint[2]
				newPoint[4] = sizeY - newPoint[1]
			elseif method == 5 then
				newPoint[3] = newPoint[2]
				newPoint[4] = newPoint[1]
			end
			-- check slope of new point and mirror
			done = checkSlope(newPoint[1], newPoint[2], maxMexElevationDiff, allowWater)
			done = done and checkSlope(newPoint[3], newPoint[4], maxMexElevationDiff, allowWater)
			for j = 1, #positions do
				-- check new point vs existing points
				local dx = newPoint[1] - positions[j].x
				local dy = newPoint[2] - positions[j].z
				if dx * dx + dy * dy < minSeparation * minSeparation then
					done = false
					--positions[j][4], positions[j][5], logCollisions = positions[j][4] - 48, positions[j][5] - 48, logCollisions + 1
					break
				end
				-- check mirror of new point vs existing points
				dx = newPoint[3] - positions[j].x
				dy = newPoint[4] - positions[j].z
				if dx * dx + dy * dy < minSeparation * minSeparation then
					done = false
					--positions[j][4], positions[j][5], logCollisions = positions[j][4] - 48, positions[j][5] - 48, logCollisions + 1
					break
				end
			end
			-- check new point vs mirror of new point
			local dx = newPoint[1] - newPoint[3]
			local dy = newPoint[2] - newPoint[4]
			if dx * dx + dy * dy < minSeparation * minSeparation then
				done = false
				--logCollisions = logCollisions + 1
			end
		end
		if numIterations == howManyTriesBeforeGiveUp then logFailures = logFailures + 1 end
		positions[#positions + 1] = {x = newPoint[1], z = newPoint[2]}
		positions[#positions + 1] = {x = newPoint[3], z = newPoint[4]}
	end
	--table.remove(positions, 1)
	--table.remove(positions, 1)
	
	local ratioX, ratioY = 1, 1
	if sizeX > sizeY then ratioY = sizeX / sizeY
	elseif sizeY > sizeX then ratioX = sizeY / sizeX end
	local sizeMax = math.max(sizeX, sizeY)
	if teamIDCount > 8 then
		metalMultiplier = 8
	end
	for i = 1, #positions do
		local dx = sizeMax * 0.5 - positions[i].x * ratioX
		local dy = sizeMax * 0.5 - positions[i].z * ratioY
		local r = math.sqrt(dx * dx + dy * dy)
		positions[i].metal = f(r / (sizeX * math.sqrt(2) * (metalMultiplier * 0.5))
	end
	
	return positions
end

if mexRandomLayout == "legacy1" then
	-- most normal layout
	-- max metal ~49.1
	-- Max spots 56
	randomMirrored = false
	r = {0.25, 0.5, 0.75, 0.95}
	pointsPerLayer = {10, 11, 15, 20}
	angleOffset = {math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4}
	pointsBetweenVertices = {0, 0, 0, 0}
	m = {2, 1.66, 1.33, 1.5}
end

if mexRandomLayout == "legacy2" then
-- Bit more random/clustered
-- max metal ~50
-- Max spots 56
	randomMirrored = false
	r = {0.15, 0.33, 0.5, 0.75, 0.85, 0.95}
	pointsPerLayer = {3, 6, 8, 10, 14, 15}
	angleOffset = {math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4}
	pointsBetweenVertices = {0, 0, 0, 0, 0, 0}
	m = {2, 1.75, 1.50, 1.33, 1.25, 2}
end

if mexRandomLayout == "legacy3" then
-- The Pitchfork
-- max metal ~51.1
-- Max spots 94
	randomMirrored = false
	r = {0.05, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.95}
	pointsPerLayer = {3,5,3,9,3,11,13,7,19,21}
	angleOffset = {math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4}
	pointsBetweenVertices = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	m = {2, 1.9, 1.7, 1.5, 1.4, 1, 1.1, 1.25, 1.4, 1.5}
end

if mexRandomLayout == "legacy4" then
	randomMirrored = false
	r = {0.25, 0.5, 0.85}
	pointsPerLayer = {3, 4, 8}
	angleOffset = {-math.pi / 2, 0, math.pi / 8}
	pointsBetweenVertices = {1, 0, 2}
	m = {1, 1, 1}
end

if mexRandomLayout == "standard" then
	randomMirrored = true
	padding = 50
	pointRadius = 100 -- TODO: change this into how big a metal circle is
	extraSeparationBetweenPoints = 50
	howManyTriesBeforeGiveUp = 100
	numPointsPerSide = mexSpotsPerSide
	includeCentre = false
	method = 1
	allowWater = allowMexesInWater
	--metalPerPoint = 1
end

if mexRandomLayout == "ffa" then
	local numVertices = teamIDCount
	if teamIDCount <= 2 then numVertices = 3 end -- can't have a polygon with less than 3 sides
	randomMirrored = false
	r = {0.12, 0.25, 0.50, 0.75, 0.88, 0.88, 0.88}
	pointsPerLayer = {numVertices, numVertices, numVertices, numVertices, numVertices, numVertices, numVertices}
	local theta = -math.pi / 2
	local offset = math.pi / 14
	angleOffset = {theta, theta, theta, theta, theta, theta - offset, theta + offset}
	pointsBetweenVertices = {0, 0, 1, 0, 0, 0, 0}
	m = {2, 1.66, 1.33, 1.25, 1, 1.5, 2}
end

--
local results = {}
if not randomMirrored then
	local lengResults = 1
	local ratioX, ratioZ = 1, 1
	if mapx > mapz then
		ratioZ = mapz / mapx
	elseif mapz > mapx then
		ratioX = mapx / mapz
	end
	for i = 1, #pointsPerLayer do

		local angle = angleOffset[i] + math.pi * 2 * 1 / pointsPerLayer[i]
		local currX, currZ = mapx + r[i] * math.cos(angle) * size * ratioX, mapz + r[i] * math.sin(angle) * size * ratioZ

		for j = 2, pointsPerLayer[i] + 1 do
			results[lengResults] = {x = currX, z = currZ, metal = m[i]}
			lengResults = lengResults + 1
			
			angle = angleOffset[i] + math.pi * 2 * j / pointsPerLayer[i]
			nextX, nextZ = mapx + r[i] * math.cos(angle) * size * ratioX, mapz + r[i] * math.sin(angle) * size * ratioZ
			
			local numParts = pointsBetweenVertices[i] + 1
			for k = 1, pointsBetweenVertices[i] do
				results[lengResults] = {
					x = currX * (numParts - k) / numParts + nextX * k / numParts,
					z = currZ * (numParts - k) / numParts + nextZ * k / numParts,
					metal = m[i]
				}
				lengResults = lengResults + 1
			end
			currX, currZ = nextX, nextZ
		end
	end
else
	results = makePositionsRandomMirrored(Game.mapSizeX, Game.mapSizeZ, padding, pointRadius, extraSeparationBetweenPoints, howManyTriesBeforeGiveUp, numPointsPerSide, includeCentre, method, allowWater)
end

return {
	spots = results,
}
