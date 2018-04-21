--math.randomseed(Game.GameID) -- This only works in 104+
math.random(); math.random(); math.random()
local mapx, mapz = Game.mapSizeX * 0.5, Game.mapSizeZ * 0.5
-- Params

local size = math.max(mapx, mapz)

--

local rng = math.random(0,1)

local mexRandomLayout = Spring.GetModOptions().mexrandomlayout or "layout1"

if mexRandomLayout == "layout1" then
	-- most normal layout
	-- max metal ~49.1
	-- Max spots 56
	r = {size * 0.25, size * 0.5, size * 0.75, size * 0.95}
	pointsPerLayer = {10, 11, 15, 20}
	m = {2, 1.66, 1.33, 1.5}
end

if mexRandomLayout == "layout2" then
-- Bit more random/clustered
-- max metal ~50
-- Max spots 56
	r = {size * 0.15, size * 0.33, size * 0.5, size * 0.75, size * 0.85, size * 0.95}
	pointsPerLayer = {3, 6, 8, 10, 14, 15}
	m = {2, 1.75, 1.50, 1.33, 1.25, 2}
end

if mexRandomLayout == "layout3" then
-- The Pitchfork
-- max metal ~51.1
-- Max spots 94
	r = {size * 0.05, size * 0.15, size * 0.25, size * 0.35, size * 0.45, size * 0.55, size * 0.65, size * 0.75, size * 0.85, size * 0.95}
	pointsPerLayer = {3,5,3,9,3,11,13,7,19,21}
	m = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1.2}
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
    for j = 1, pointsPerLayer[i] do
        local angle = math.pi / 4 + math.pi * 2 * j / pointsPerLayer[i]
		results[lengResults] = {x = mapx + r[i] * math.cos(angle) * ratioX, z = mapz + r[i] * math.sin(angle) * ratioZ, metal = m[i]}
        lengResults = lengResults + 1
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