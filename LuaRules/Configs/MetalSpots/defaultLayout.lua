--math.randomseed(Game.GameID) -- This only works in 104+
math.random(); math.random(); math.random()
local mapx, mapz = Game.mapSizeX * 0.5, Game.mapSizeZ * 0.5
-- Params

local size = math.max(mapx, mapz)

--

local rng = math.random(0,1)

local mexRandomLayout = Spring.GetModOptions().mexrandomlayout or "layout1"

if mexRandomLayout == "" or mexRandomLayout == nil then -- This is just an oshitifukedup protection
	mexRandomLayout = "layout1"
end

if mexRandomLayout == "layout1" then
	-- most normal layout
	-- max metal ~49.1
	-- Max spots 56
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
	r = {0.05, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.95}
	pointsPerLayer = {3,5,3,9,3,11,13,7,19,21}
	angleOffset = {math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4, math.pi / 4}
	pointsBetweenVertices = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	m = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1.2}
end

if mexRandomLayout == "demo" then
	r = {0.25, 0.5, 0.85}
	pointsPerLayer = {3, 4, 8}
	angleOffset = {-math.pi / 2, 0, math.pi / 8}
	pointsBetweenVertices = {1, 0, 2}
	m = {1, 1, 1}
end

--
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
	local currX, currZ = mapx + r[i] * math.cos(angle) * size * ratioX, mapz + r[i] * math.sin(angle) * size * ratioY

	for j = 2, pointsPerLayer[i] + 1 do
		results[lengResults] = {x = currX, z = currZ, metal = m[i]}
		lengResults = lengResults + 1
		
		angle = angleOffset[i] + math.pi * 2 * j / pointsPerLayer[i]
		nextX, nextZ = mapx + r[i] * math.cos(angle) * size * ratioX, mapz + r[i] * math.sin(angle) * size * ratioY
		
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

Spring.Echo("Here are the resulting locations")
for i = 1, lengResults - 1 do
    for k, v in pairs(results[i]) do
        Spring.Echo(i .. "." .. k .. ": " .. v)
    end
end

return {
	spots = results,
}
