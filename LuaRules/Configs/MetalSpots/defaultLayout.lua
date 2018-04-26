--math.randomseed(Game.GameID) -- This only works in 104+
math.random(); math.random(); math.random()
local mapx, mapz = Game.mapSizeX * 0.5, Game.mapSizeZ * 0.5
-- Params

local size = math.max(mapx, mapz)

--

function f(x)
	if x < 0.6 then return 0.5 + math.pow((0.6 - x) / 0.6, 2) * 1.5
	elseif x < 0.8 then return (x - 0.6) / 0.4 + 0.5
	elseif x <= 1 then return 1 end
	return 0
end
function makePositionsRandomMirrored(sizeX, sizeY, padding, pointRadius, extraSeparationBetweenPoints, howManyTriesBeforeGiveUp, numPointsPerSide, includeCentre, method)
	--[[
	method 1: object rotated 180 degrees around centre to produce image
	method 2: object mirrored around horizontal line passing through centre to produce image
	method 3: object mirrored around vertical line passing through centre to produce image
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
			end
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
				logCollisions = logCollisions + 1
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
	for i = 1, #positions do
		local dx = sizeMax * 0.5 - positions[i].x * ratioX
		local dy = sizeMax * 0.5 - positions[i].z * ratioY
		local r = math.sqrt(dx * dx + dy * dy)
		positions[i].metal = f(r / (sizeX * math.sqrt(2) / 2))
	end
	
	return positions
end

local rng = math.random(0,1)

local mexRandomLayout = Spring.GetModOptions().mexrandomlayout or "layout1"

if mexRandomLayout == "" or mexRandomLayout == nil then -- This is just an oshitifukedup protection
	mexRandomLayout = "layout1"
end

if mexRandomLayout == "layout1" then
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

if mexRandomLayout == "layout2" then
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

if mexRandomLayout == "layout3" then
-- The Pitchfork
-- max metal ~51.1
-- Max spots 94
	randomMirrored = false
	r = {0.05, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.95}
	pointsPerLayer = {3,5,3,9,3,11,13,7,19,21}
	angleOffset = {math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4}
	pointsBetweenVertices = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	m = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1.2}
end

if mexRandomLayout == "demo" then
	randomMirrored = false
	r = {0.25, 0.5, 0.85}
	pointsPerLayer = {3, 4, 8}
	angleOffset = {-math.pi / 2, 0, math.pi / 8}
	pointsBetweenVertices = {1, 0, 2}
	m = {1, 1, 1}
end

if mexRandomLayout == "demo2" then
	randomMirrored = true
	padding = 50
	pointRadius = 100 -- TODO: change this into how big a metal circle is
	extraSeparationBetweenPoints = 50
	howManyTriesBeforeGiveUp = 100
	numPointsPerSide = 15
	includeCentre = false
	method = 1
	metalPerPoint = 1
end

--
if not randomMirrored then
	local results = {}
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
	results = makePositionsRandomMirrored(Game.mapSizeX, Game.mapSizeZ, padding, pointRadius, extraSeparationBetweenPoints, howManyTriesBeforeGiveUp, numPointsPerSide, includeCentre, method)
end

return {
	spots = results,
}
