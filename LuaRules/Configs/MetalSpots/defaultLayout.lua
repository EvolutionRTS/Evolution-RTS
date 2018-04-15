local mapx, mapz = Game.mapSizeX * 0.5, Game.mapSizeZ * 0.5
-- Params

local size = math.max(mapx, mapz)
local r = {size * 0.25, size * 0.5, size * 0.75, size * 0.95}
local pointsPerLayer = {10, 11, 15, 20}
local m = {2, 1.66, 1.33, 1}
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
        local angle = math.pi * 2 * j / pointsPerLayer[i]
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