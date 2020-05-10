nameSuffix = "_scav"

local function simplebasehover(posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 500
	if radiusCheck then
		return posradius
	else
		Spring.CreateUnit("estorage"..nameSuffix, posx+(-286), posy, posz+(31), 0,GaiaTeamID)
		Spring.CreateUnit("elightturret2"..nameSuffix, posx+(-302), posy, posz+(-385), 0,GaiaTeamID)
		Spring.CreateUnit("elightturret2"..nameSuffix, posx+(306), posy, posz+(-305), 0,GaiaTeamID)
		Spring.CreateUnit("esolar2"..nameSuffix, posx+(370), posy, posz+(-65), 0,GaiaTeamID)
		Spring.CreateUnit("estorage"..nameSuffix, posx+(-222), posy, posz+(31), 0,GaiaTeamID)
		Spring.CreateUnit("estorage"..nameSuffix, posx+(-286), posy, posz+(-97), 0,GaiaTeamID)
		Spring.CreateUnit("ebasefactory"..nameSuffix, posx+(82), posy, posz+(47), 0,GaiaTeamID)
		Spring.CreateUnit("esolar2"..nameSuffix, posx+(370), posy, posz+(31), 0,GaiaTeamID)
		Spring.CreateUnit("elightturret2"..nameSuffix, posx+(-302), posy, posz+(335), 0,GaiaTeamID)
		Spring.CreateUnit("etech1"..nameSuffix, posx+(50), posy, posz+(-289), 0,GaiaTeamID)
		Spring.CreateUnit("estorage"..nameSuffix, posx+(-222), posy, posz+(-97), 0,GaiaTeamID)
		Spring.CreateUnit("elightturret2"..nameSuffix, posx+(386), posy, posz+(303), 0,GaiaTeamID)
		Spring.CreateUnit("elightturret2"..nameSuffix, posx+(66), posy, posz+(463), 0,GaiaTeamID)
	end
end
table.insert(ScavengerBlueprintsT0,simplebasehover)
table.insert(ScavengerBlueprintsT1,simplebasehover)
table.insert(ScavengerBlueprintsT2,simplebasehover)
table.insert(ScavengerBlueprintsT3,simplebasehover)

local function simplebasehbot(posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 500
	if radiusCheck then
		return posradius
	else
		Spring.CreateUnit("elightturret2"..nameSuffix, posx+(-208), posy, posz+(-350), 0,GaiaTeamID)
		Spring.CreateUnit("estorage"..nameSuffix, posx+(-272), posy, posz+(-174), 0,GaiaTeamID)
		Spring.CreateUnit("elightturret2"..nameSuffix, posx+(32), posy, posz+(450), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(288), posy, posz+(290), 0,GaiaTeamID)
		Spring.CreateUnit("etech1"..nameSuffix, posx+(48), posy, posz+(-270), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(320), posy, posz+(98), 0,GaiaTeamID)
		Spring.CreateUnit("elightturret2"..nameSuffix, posx+(448), posy, posz+(274), 0,GaiaTeamID)
		Spring.CreateUnit("elightturret2"..nameSuffix, posx+(288), posy, posz+(-350), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-144), posy, posz+(-174), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(208), posy, posz+(-158), 0,GaiaTeamID)
		Spring.CreateUnit("elightturret2"..nameSuffix, posx+(-288), posy, posz+(274), 0,GaiaTeamID)
		Spring.CreateUnit("ehbotfac"..nameSuffix, posx+(48), posy, posz+(18), 0,GaiaTeamID)
		Spring.CreateUnit("estorage"..nameSuffix, posx+(-272), posy, posz+(-46), 0,GaiaTeamID)
		Spring.CreateUnit("estorage"..nameSuffix, posx+(-336), posy, posz+(-46), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-176), posy, posz+(98), 0,GaiaTeamID)
		Spring.CreateUnit("estorage"..nameSuffix, posx+(-336), posy, posz+(-174), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-128), posy, posz+(322), 0,GaiaTeamID)
		Spring.CreateUnit("elightturret2"..nameSuffix, posx+(480), posy, posz+(-78), 0,GaiaTeamID)
	end
end
table.insert(ScavengerBlueprintsT0,simplebasehbot)
table.insert(ScavengerBlueprintsT1,simplebasehbot)
table.insert(ScavengerBlueprintsT2,simplebasehbot)
table.insert(ScavengerBlueprintsT3,simplebasehbot)

local function simplebaseair(posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 500
	if radiusCheck then
		return posradius
	else
		Spring.CreateUnit("emine"..nameSuffix, posx+(-520), posy, posz+(-253), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-472), posy, posz+(291), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(392), posy, posz+(131), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(600), posy, posz+(-221), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-152), posy, posz+(-493), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(40), posy, posz+(-285), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-280), posy, posz+(-317), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(104), posy, posz+(-541), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(216), posy, posz+(307), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(296), posy, posz+(-189), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(232), posy, posz+(563), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(504), posy, posz+(323), 0,GaiaTeamID)
		Spring.CreateUnit("elaserbattery"..nameSuffix, posx+(-360), posy, posz+(-45), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-344), posy, posz+(-477), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-168), posy, posz+(579), 0,GaiaTeamID)
		Spring.CreateUnit("eairplant"..nameSuffix, posx+(8), posy, posz+(-13), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-312), posy, posz+(323), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-56), posy, posz+(403), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-232), posy, posz+(-141), 0,GaiaTeamID)
		Spring.CreateUnit("elaserbattery"..nameSuffix, posx+(504), posy, posz+(3), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-456), posy, posz+(163), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-296), posy, posz+(51), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(424), posy, posz+(-381), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(664), posy, posz+(3), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(360), posy, posz+(19), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-200), posy, posz+(211), 0,GaiaTeamID)
		Spring.CreateUnit("emine"..nameSuffix, posx+(-488), posy, posz+(3), 0,GaiaTeamID)
	end
end
table.insert(ScavengerBlueprintsT0,simplebaseair)
table.insert(ScavengerBlueprintsT1,simplebaseair)
table.insert(ScavengerBlueprintsT2,simplebaseair)
table.insert(ScavengerBlueprintsT3,simplebaseair)