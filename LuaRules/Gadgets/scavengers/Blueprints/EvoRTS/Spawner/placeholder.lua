
-- table.insert(ScavengerBlueprintsT0,FunctionName)
-- table.insert(ScavengerBlueprintsT1,FunctionName)
-- table.insert(ScavengerBlueprintsT2,FunctionName)
-- table.insert(ScavengerBlueprintsT3,FunctionName)

-- example blueprint:
-- local function a(posx, posy, posz, GaiaTeamID, radiusCheck)
-- local posradius = 120
	-- if radiusCheck then
		-- return posradius
	-- else
		-- Spring.CreateUnit("unitname", posx, posy, posz, math.random(0,3),GaiaTeamID) 
		-- Spring.CreateUnit("unitname", posx-100, posy, posz, math.random(0,3),GaiaTeamID) 
		-- Spring.CreateUnit("unitname", posx+100, posy, posz, math.random(0,3),GaiaTeamID) 
		-- Spring.CreateUnit("unitname", posx, posy, posz-100, math.random(0,3),GaiaTeamID) 
		-- Spring.CreateUnit("unitname", posx, posy, posz+100, math.random(0,3),GaiaTeamID) 
	-- end
-- end
-- table.insert(ScavengerBlueprintsT1,a)

local function placeholderradar(posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 30
	if radiusCheck then
		return posradius
	else
		Spring.CreateUnit("eradar2", posx, posy, posz, math.random(0,3),GaiaTeamID) 
	end
end
table.insert(ScavengerBlueprintsT0,placeholderradar)
table.insert(ScavengerBlueprintsT1,placeholderradar)
table.insert(ScavengerBlueprintsT2,placeholderradar)
table.insert(ScavengerBlueprintsT3,placeholderradar)