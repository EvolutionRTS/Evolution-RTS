
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
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx, posy, posz-200, 0}, {"shift"})
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

local function emines(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
		Spring.GiveOrderToUnit(scav, -(UDN.emine.id), {posx, posy, posz, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine.id), {posx-100, posy, posz, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine.id), {posx+100, posy, posz, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine.id), {posx, posy, posz-100, 0}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine.id), {posx, posy, posz+100, 0}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT0,emines)
table.insert(ScavengerConstructorBlueprintsT1,emines)
table.insert(ScavengerConstructorBlueprintsT2,emines)
table.insert(ScavengerConstructorBlueprintsT3,emines)

local function defenseoutpost(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
	
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(4), posy, posz+(-245), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-12), posy, posz+(219), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-380), posy, posz+(11), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(244), posy, posz+(171), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(276), posy, posz+(283), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-324), posy, posz+(147), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(116), posy, posz+(-405), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(236), posy, posz+(-253), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-108), posy, posz+(-405), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-172), posy, posz+(-101), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(468), posy, posz+(-197), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(252), posy, posz+(3), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(20), posy, posz+(459), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-404), posy, posz+(51), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-444), posy, posz+(-149), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-460), posy, posz+(91), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(220), posy, posz+(259), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-156), posy, posz+(-197), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-220), posy, posz+(-469), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(348), posy, posz+(131), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eradar2_scav.id), {posx+(20), posy, posz+(-5), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ekmar_scav.id), {posx+(20), posy, posz+(-85), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(516), posy, posz+(-5), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-396), posy, posz+(-261), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-212), posy, posz+(-317), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-124), posy, posz+(379), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-316), posy, posz+(331), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-4), posy, posz+(-269), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(28), posy, posz+(323), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(324), posy, posz+(-5), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(404), posy, posz+(59), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(12), posy, posz+(179), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(228), posy, posz+(123), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eshieldgen_scav.id), {posx+(12), posy, posz+(-157), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(372), posy, posz+(-245), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(388), posy, posz+(267), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(364), posy, posz+(-77), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(12), posy, posz+(-349), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-292), posy, posz+(3), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-268), posy, posz+(139), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-212), posy, posz+(259), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-340), posy, posz+(-173), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(276), posy, posz+(-133), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-92), posy, posz+(59), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(20), posy, posz+(363), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-156), posy, posz+(-5), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(244), posy, posz+(-149), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-156), posy, posz+(171), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(164), posy, posz+(395), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-332), posy, posz+(-197), 1}, {"shift"})
		
	end
end

table.insert(ScavengerConstructorBlueprintsT2,defenseoutpost)
table.insert(ScavengerConstructorBlueprintsT3,defenseoutpost)


local function basehbot(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
 
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-183), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-239), posy, posz+(-184), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(313), posy, posz+(144), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(161), posy, posz+(-56), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-295), posy, posz+(-32), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-359), posy, posz+(-80), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(217), posy, posz+(64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-87), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(185), posy, posz+(-192), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-32), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-15), posy, posz+(312), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-87), posy, posz+(-288), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(425), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-135), posy, posz+(-112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-215), posy, posz+(160), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-215), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(425), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(353), posy, posz+(8), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-279), posy, posz+(-384), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ehbotfac_scav.id), {posx+(25), posy, posz+(-64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(73), posy, posz+(-224), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-183), posy, posz+(-48), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(393), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.etech1_scav.id), {posx+(-295), posy, posz+(240), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-215), posy, posz+(-48), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(249), posy, posz+(-144), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.efusion2_scav.id), {posx+(201), posy, posz+(272), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-23), posy, posz+(192), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-127), posy, posz+(-24), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eradar2_scav.id), {posx+(89), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(393), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(0), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(201), posy, posz+(-288), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-128), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(9), posy, posz+(-336), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(137), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(25), posy, posz+(240), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-447), posy, posz+(104), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-87), posy, posz+(80), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-96), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-23), posy, posz+(128), 2}, {"shift"})
 
 	end
end

table.insert(ScavengerConstructorBlueprintsT2,basehbot)
table.insert(ScavengerConstructorBlueprintsT3,basehbot)


local function basehover(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
 
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-183), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-239), posy, posz+(-184), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(313), posy, posz+(144), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(161), posy, posz+(-56), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-295), posy, posz+(-32), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-359), posy, posz+(-80), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(217), posy, posz+(64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-87), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(185), posy, posz+(-192), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-32), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-15), posy, posz+(312), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-87), posy, posz+(-288), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(425), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-135), posy, posz+(-112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-215), posy, posz+(160), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-215), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(425), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(353), posy, posz+(8), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-279), posy, posz+(-384), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ebasefactory_scav.id), {posx+(25), posy, posz+(-64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(73), posy, posz+(-224), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-183), posy, posz+(-48), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(393), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.etech1_scav.id), {posx+(-295), posy, posz+(240), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-215), posy, posz+(-48), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(249), posy, posz+(-144), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.efusion2_scav.id), {posx+(201), posy, posz+(272), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-23), posy, posz+(192), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-127), posy, posz+(-24), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eradar2_scav.id), {posx+(89), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(393), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(0), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(201), posy, posz+(-288), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-128), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(9), posy, posz+(-336), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(137), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(25), posy, posz+(240), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-447), posy, posz+(104), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-87), posy, posz+(80), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-96), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-23), posy, posz+(128), 2}, {"shift"})
 
 	end
end

table.insert(ScavengerConstructorBlueprintsT2,basehover)
table.insert(ScavengerConstructorBlueprintsT3,basehover)


local function baseallterr(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
 
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-183), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-239), posy, posz+(-184), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(313), posy, posz+(144), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(161), posy, posz+(-56), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-295), posy, posz+(-32), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-359), posy, posz+(-80), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(217), posy, posz+(64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-87), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(185), posy, posz+(-192), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-32), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-15), posy, posz+(312), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-87), posy, posz+(-288), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(425), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-135), posy, posz+(-112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-215), posy, posz+(160), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-215), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(425), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(353), posy, posz+(8), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-279), posy, posz+(-384), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eallterrfac_scav.id), {posx+(25), posy, posz+(-64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(73), posy, posz+(-224), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-183), posy, posz+(-48), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(393), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.etech1_scav.id), {posx+(-295), posy, posz+(240), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-215), posy, posz+(-48), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(249), posy, posz+(-144), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.efusion2_scav.id), {posx+(201), posy, posz+(272), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-23), posy, posz+(192), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-127), posy, posz+(-24), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eradar2_scav.id), {posx+(89), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(393), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(0), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(201), posy, posz+(-288), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-128), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(9), posy, posz+(-336), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(137), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(25), posy, posz+(240), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-447), posy, posz+(104), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-87), posy, posz+(80), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-96), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-23), posy, posz+(128), 2}, {"shift"})
 
 	end
end

table.insert(ScavengerConstructorBlueprintsT2,baseallterr)
table.insert(ScavengerConstructorBlueprintsT3,baseallterr)


local function baseamphib(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
 
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-183), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-239), posy, posz+(-184), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(313), posy, posz+(144), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(161), posy, posz+(-56), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-295), posy, posz+(-32), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-359), posy, posz+(-80), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(217), posy, posz+(64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-87), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(185), posy, posz+(-192), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-32), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-15), posy, posz+(312), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-87), posy, posz+(-288), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(425), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-135), posy, posz+(-112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-215), posy, posz+(160), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-215), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(425), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(353), posy, posz+(8), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-279), posy, posz+(-384), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eamphibfac_scav.id), {posx+(25), posy, posz+(-64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(73), posy, posz+(-224), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-183), posy, posz+(-48), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(393), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.etech1_scav.id), {posx+(-295), posy, posz+(240), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-215), posy, posz+(-48), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(249), posy, posz+(-144), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.efusion2_scav.id), {posx+(201), posy, posz+(272), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-23), posy, posz+(192), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-127), posy, posz+(-24), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eradar2_scav.id), {posx+(89), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(393), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(0), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(201), posy, posz+(-288), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-128), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(9), posy, posz+(-336), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(137), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(25), posy, posz+(240), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-447), posy, posz+(104), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-87), posy, posz+(80), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-96), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-23), posy, posz+(128), 2}, {"shift"})
 
 	end
end

table.insert(ScavengerConstructorBlueprintsT2,baseallterr)
table.insert(ScavengerConstructorBlueprintsT3,baseallterr)


local function baseair(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
 
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-183), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-239), posy, posz+(-184), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(313), posy, posz+(144), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(161), posy, posz+(-56), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-295), posy, posz+(-32), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-359), posy, posz+(-80), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(217), posy, posz+(64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-87), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(185), posy, posz+(-192), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-32), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-15), posy, posz+(312), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-87), posy, posz+(-288), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(425), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-135), posy, posz+(-112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-215), posy, posz+(160), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-215), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(425), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(353), posy, posz+(8), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-279), posy, posz+(-384), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eairplant_scav.id), {posx+(25), posy, posz+(-64), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(73), posy, posz+(-224), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-183), posy, posz+(-48), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(393), posy, posz+(176), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.etech1_scav.id), {posx+(-295), posy, posz+(240), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(-215), posy, posz+(-48), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(249), posy, posz+(-144), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.efusion2_scav.id), {posx+(201), posy, posz+(272), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-23), posy, posz+(192), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-127), posy, posz+(-24), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eradar2_scav.id), {posx+(89), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.estorage_scav.id), {posx+(393), posy, posz+(112), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(0), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(201), posy, posz+(-288), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-128), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(9), posy, posz+(-336), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(137), posy, posz+(16), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(25), posy, posz+(240), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-447), posy, posz+(104), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-87), posy, posz+(80), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-71), posy, posz+(-96), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(-23), posy, posz+(128), 2}, {"shift"})
 
 	end
end

table.insert(ScavengerConstructorBlueprintsT2,baseair)
table.insert(ScavengerConstructorBlueprintsT3,baseair)



local function antinuke(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
 
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(422), posy, posz+(-59), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(326), posy, posz+(101), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eshieldgen_scav.id), {posx+(62), posy, posz+(-99), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-490), posy, posz+(-123), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-298), posy, posz+(-267), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(86), posy, posz+(453), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(30), posy, posz+(-259), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(94), posy, posz+(269), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(342), posy, posz+(-283), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(486), posy, posz+(-235), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(406), posy, posz+(261), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ekmar_scav.id), {posx+(-74), posy, posz+(-27), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-234), posy, posz+(101), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-82), posy, posz+(365), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-226), posy, posz+(-83), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-426), posy, posz+(-251), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(270), posy, posz+(205), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-218), posy, posz+(341), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(278), posy, posz+(-315), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(422), posy, posz+(117), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-98), posy, posz+(-147), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(214), posy, posz+(341), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-282), posy, posz+(437), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-258), posy, posz+(125), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-58), posy, posz+(-363), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(238), posy, posz+(109), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eradar2_scav.id), {posx+(54), posy, posz+(53), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-410), posy, posz+(165), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-26), posy, posz+(-443), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-226), posy, posz+(29), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-394), posy, posz+(-59), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(166), posy, posz+(-251), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-410), posy, posz+(117), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(318), posy, posz+(-83), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ekmar_scav.id), {posx+(166), posy, posz+(-27), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-170), posy, posz+(-187), 2}, {"shift"})
 
 	end
end

table.insert(ScavengerConstructorBlueprintsT3,antinuke)


local function antinuke(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
 
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(422), posy, posz+(-59), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(326), posy, posz+(101), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eshieldgen_scav.id), {posx+(62), posy, posz+(-99), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-490), posy, posz+(-123), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-298), posy, posz+(-267), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(86), posy, posz+(453), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(30), posy, posz+(-259), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(94), posy, posz+(269), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(342), posy, posz+(-283), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(486), posy, posz+(-235), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(406), posy, posz+(261), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ekmar_scav.id), {posx+(-74), posy, posz+(-27), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-234), posy, posz+(101), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-82), posy, posz+(365), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-226), posy, posz+(-83), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-426), posy, posz+(-251), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(270), posy, posz+(205), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-218), posy, posz+(341), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(278), posy, posz+(-315), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(422), posy, posz+(117), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-98), posy, posz+(-147), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(214), posy, posz+(341), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-282), posy, posz+(437), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-258), posy, posz+(125), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-58), posy, posz+(-363), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(238), posy, posz+(109), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eradar2_scav.id), {posx+(54), posy, posz+(53), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-410), posy, posz+(165), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-26), posy, posz+(-443), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-226), posy, posz+(29), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-394), posy, posz+(-59), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(166), posy, posz+(-251), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-410), posy, posz+(117), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(318), posy, posz+(-83), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ekmar_scav.id), {posx+(166), posy, posz+(-27), 2}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-170), posy, posz+(-187), 2}, {"shift"})
 
 	end
end

table.insert(ScavengerConstructorBlueprintsT3,antinuke)


local function nuke(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150
	if radiusCheck then
		return posradius
	else
 
		 Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(92), posy, posz+(184), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-164), posy, posz+(-168), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.ejammer2_scav.id), {posx+(156), posy, posz+(8), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(204), posy, posz+(104), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(204), posy, posz+(24), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-28), posy, posz+(224), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(92), posy, posz+(-168), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.esilo_scav.id), {posx+(-4), posy, posz+(24), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(268), posy, posz+(200), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(204), posy, posz+(-152), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-308), posy, posz+(-232), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(4), posy, posz+(-224), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-100), posy, posz+(184), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(276), posy, posz+(16), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(204), posy, posz+(-56), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-276), posy, posz+(184), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.ejammer2_scav.id), {posx+(-164), posy, posz+(8), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-252), posy, posz+(16), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-36), posy, posz+(-152), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(252), posy, posz+(-216), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-212), posy, posz+(184), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-212), posy, posz+(-72), 2}, {"shift"})
		 Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-196), posy, posz+(88), 2}, {"shift"})
 
 	end
end

table.insert(ScavengerConstructorBlueprintsT3,nuke)