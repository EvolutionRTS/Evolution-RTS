
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

local UDN = UnitDefNames

local function placeholderradar1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
		Spring.GiveOrderToUnit(scav, -(UDN.eradar2_scav.id), {posx, posy, posz, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx-200, posy, posz, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+200, posy, posz, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ejammer2_scav.id), {posx, posy, posz-200, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx, posy, posz+200, 0}, {"shift"})
	end
end
table.insert(ScavengerConstructorBlueprintsT0,placeholderradar1)
table.insert(ScavengerConstructorBlueprintsT1,placeholderradar1)
table.insert(ScavengerConstructorBlueprintsT2,placeholderradar1)
table.insert(ScavengerConstructorBlueprintsT3,placeholderradar1)

local function placeholderradar2(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
		Spring.GiveOrderToUnit(scav, -(UDN.eradar2_up1_scav.id), {posx, posy, posz, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx-200, posy, posz, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+200, posy, posz, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx, posy, posz-200, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx, posy, posz+200, 0}, {"shift"})
	end
end
table.insert(ScavengerConstructorBlueprintsT2,placeholderradar2)
table.insert(ScavengerConstructorBlueprintsT3,placeholderradar2)

local function placeholderradar1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx, posy, posz, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx-100, posy, posz, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+100, posy, posz, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx, posy, posz-100, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx, posy, posz+100, 0}, {"shift"})
	end
end
table.insert(ScavengerConstructorBlueprintsT0,placeholderradar1)
table.insert(ScavengerConstructorBlueprintsT1,placeholderradar1)
table.insert(ScavengerConstructorBlueprintsT2,placeholderradar1)
table.insert(ScavengerConstructorBlueprintsT3,placeholderradar1)