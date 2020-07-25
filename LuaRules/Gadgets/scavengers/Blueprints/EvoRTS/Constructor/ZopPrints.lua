local UDN = UnitDefNames
local nameSuffix = '_scav'

local function ZopTurret1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 150 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-58), posy, posz+(-128), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-90), posy, posz+(96), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(150), posy, posz+(32), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT0,ZopTurret1)
table.insert(ScavengerConstructorBlueprintsT1,ZopTurret1)
table.insert(ScavengerConstructorBlueprintsT2,ZopTurret1)
table.insert(ScavengerConstructorBlueprintsT3,ZopTurret1)
table.insert(ScavengerConstructorBlueprintsT0Sea,ZopTurret1)
table.insert(ScavengerConstructorBlueprintsT1Sea,ZopTurret1)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopTurret1)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopTurret1)

local function ZopTurret2(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 154 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(6), posy, posz+(-133), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(150), posy, posz+(75), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-154), posy, posz+(59), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT0,ZopTurret2)
table.insert(ScavengerConstructorBlueprintsT1,ZopTurret2)
table.insert(ScavengerConstructorBlueprintsT2,ZopTurret2)
table.insert(ScavengerConstructorBlueprintsT3,ZopTurret2)
table.insert(ScavengerConstructorBlueprintsT0Sea,ZopTurret2)
table.insert(ScavengerConstructorBlueprintsT1Sea,ZopTurret2)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopTurret2)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopTurret2)

local function ZopTurret3(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 208 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-48), posy, posz+(141), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(208), posy, posz+(-3), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-32), posy, posz+(-131), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-160), posy, posz+(-3), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(32), posy, posz+(-3), 1}, {"shift"})
	end
end


table.insert(ScavengerConstructorBlueprintsT2,ZopTurret3)
table.insert(ScavengerConstructorBlueprintsT3,ZopTurret3)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopTurret3)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopTurret3)

local function ZopTurret4(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 121 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.ejammer2_scav.id), {posx+(-9), posy, posz+(13), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-121), posy, posz+(77), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-73), posy, posz+(-83), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(103), posy, posz+(-115), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(103), posy, posz+(109), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopTurret4)
table.insert(ScavengerConstructorBlueprintsT3,ZopTurret4)

local function ZopTurret5(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 144 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-48), posy, posz+(142), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(176), posy, posz+(14), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-128), posy, posz+(46), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(64), posy, posz+(126), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(0), posy, posz+(-18), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-144), posy, posz+(-114), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(80), posy, posz+(-194), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopTurret5)
table.insert(ScavengerConstructorBlueprintsT3,ZopTurret5)

local function ZopTurret6(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 102 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(102), posy, posz+(11), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-26), posy, posz+(59), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-74), posy, posz+(-69), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopTurret6)
table.insert(ScavengerConstructorBlueprintsT3,ZopTurret6)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopTurret6)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopTurret6)

local function ZopTurret7(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 184 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(114), posy, posz+(152), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-110), posy, posz+(8), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-78), posy, posz+(-88), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-78), posy, posz+(88), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(18), posy, posz+(-168), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(146), posy, posz+(-40), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(34), posy, posz+(8), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(82), posy, posz+(-136), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-126), posy, posz+(184), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopTurret7)
table.insert(ScavengerConstructorBlueprintsT3,ZopTurret7)

local function ZopTurret8(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 163 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-141), posy, posz+(-61), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-13), posy, posz+(67), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(147), posy, posz+(115), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-141), posy, posz+(83), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-13), posy, posz+(-45), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(163), posy, posz+(-157), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopTurret8)
table.insert(ScavengerConstructorBlueprintsT3,ZopTurret8)

local function ZopTurret9(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 106 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-80), posy, posz+(-74), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-80), posy, posz+(6), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-80), posy, posz+(86), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(86), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(80), posy, posz+(-106), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(-90), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(80), posy, posz+(86), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(80), posy, posz+(6), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eartyturret_scav.id), {posx+(0), posy, posz+(6), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT3,ZopTurret9)

local function ZopTurret10(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 202 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-121), posy, posz+(90), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(199), posy, posz+(-182), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(7), posy, posz+(202), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-9), posy, posz+(42), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(-25), posy, posz+(-70), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(119), posy, posz+(74), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-169), posy, posz+(-150), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopTurret10)
table.insert(ScavengerConstructorBlueprintsT3,ZopTurret10)

local function ZopTurret11(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 190 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(164), posy, posz+(-30), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ejammer2_scav.id), {posx+(-12), posy, posz+(18), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(100), posy, posz+(130), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(20), posy, posz+(178), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-140), posy, posz+(18), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-108), posy, posz+(130), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-140), posy, posz+(-126), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-12), posy, posz+(-126), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(132), posy, posz+(-190), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopTurret11)
table.insert(ScavengerConstructorBlueprintsT3,ZopTurret11)

local function ZopTurret12(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 214 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(115), posy, posz+(-214), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-93), posy, posz+(154), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(147), posy, posz+(-22), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eartyturret_scav.id), {posx+(3), posy, posz+(26), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(131), posy, posz+(154), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-173), posy, posz+(26), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-125), posy, posz+(-118), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT3,ZopTurret12)

local function ZopMineStack1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 1 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT0,ZopMineStack1)
table.insert(ScavengerConstructorBlueprintsT1,ZopMineStack1)
table.insert(ScavengerConstructorBlueprintsT2,ZopMineStack1)
table.insert(ScavengerConstructorBlueprintsT3,ZopMineStack1)

local function ZopMineStack2(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 1 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT0,ZopMineStack2)
table.insert(ScavengerConstructorBlueprintsT1,ZopMineStack2)
table.insert(ScavengerConstructorBlueprintsT2,ZopMineStack2)
table.insert(ScavengerConstructorBlueprintsT3,ZopMineStack2)

local function ZopAir1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 252 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.eairplant_scav.id), {posx+(4), posy, posz+(20), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-108), posy, posz+(212), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-172), posy, posz+(-204), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(132), posy, posz+(228), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(148), posy, posz+(-252), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopAir1)
table.insert(ScavengerConstructorBlueprintsT3,ZopAir1)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopAir1)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopAir1)

local function ZopAir2(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 266 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.eairplant_scav.id), {posx+(24), posy, posz+(22), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-88), posy, posz+(214), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(24), posy, posz+(-266), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-152), posy, posz+(-202), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(152), posy, posz+(230), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-168), posy, posz+(6), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(40), posy, posz+(246), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(168), posy, posz+(-250), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopAir2)
table.insert(ScavengerConstructorBlueprintsT3,ZopAir2)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopAir2)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopAir2)

local function ZopAllTer1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 221
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-210), posy, posz+(-205), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(190), posy, posz+(211), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(206), posy, posz+(-205), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-2), posy, posz+(-221), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-194), posy, posz+(211), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(14), posy, posz+(211), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eminifac_scav.id), {posx+(-2), posy, posz+(3), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT1,ZopAllTer1)
table.insert(ScavengerConstructorBlueprintsT2,ZopAllTer1)
table.insert(ScavengerConstructorBlueprintsT3,ZopAllTer1)

local function ZopAllTer2(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 250 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-238), posy, posz+(169), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(226), posy, posz+(169), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-238), posy, posz+(-87), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(98), posy, posz+(-215), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-94), posy, posz+(-183), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-190), posy, posz+(-167), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(194), posy, posz+(249), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(242), posy, posz+(-103), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-14), posy, posz+(-183), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(2), posy, posz+(249), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(210), posy, posz+(-183), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eminifac_scav.id), {posx+(2), posy, posz+(41), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-190), posy, posz+(249), 1}, {"shift"})
	end
end


table.insert(ScavengerConstructorBlueprintsT2,ZopAllTer2)
table.insert(ScavengerConstructorBlueprintsT3,ZopAllTer2)

local function ZopHBot1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 200 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-188), posy, posz+(-185), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-172), posy, posz+(199), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(164), posy, posz+(199), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ehbotfac_scav.id), {posx+(4), posy, posz+(7), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(196), posy, posz+(-217), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT1,ZopHBot1)
table.insert(ScavengerConstructorBlueprintsT2,ZopHBot1)
table.insert(ScavengerConstructorBlueprintsT3,ZopHBot1)
table.insert(ScavengerConstructorBlueprintsT1Sea,ZopHBot1)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopHBot1)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopHBot1)

local function ZopHBot2(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 220 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-166), posy, posz+(4), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-166), posy, posz+(-188), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-150), posy, posz+(196), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(26), posy, posz+(-204), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(186), posy, posz+(196), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ehbotfac_scav.id), {posx+(26), posy, posz+(4), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(26), posy, posz+(212), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(218), posy, posz+(-220), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopHBot2)
table.insert(ScavengerConstructorBlueprintsT3,ZopHBot2)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopHBot2)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopHBot2)

local function ZopHov1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 235 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.ebasefactory_scav.id), {posx+(5), posy, posz+(5), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(5), posy, posz+(-235), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(197), posy, posz+(-203), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(5), posy, posz+(213), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(181), posy, posz+(229), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-187), posy, posz+(197), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-203), posy, posz+(-203), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT1,ZopHov1)
table.insert(ScavengerConstructorBlueprintsT2,ZopHov1)
table.insert(ScavengerConstructorBlueprintsT3,ZopHov1)
table.insert(ScavengerConstructorBlueprintsT1Sea,ZopHov1)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopHov1)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopHov1)

local function ZopHov2(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 274 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.ebasefactory_scav.id), {posx+(2), posy, posz+(45), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(2), posy, posz+(-195), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(98), posy, posz+(-227), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(274), posy, posz+(-115), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(194), posy, posz+(-163), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-238), posy, posz+(157), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(2), posy, posz+(253), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(178), posy, posz+(269), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-238), posy, posz+(-67), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-190), posy, posz+(237), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-206), posy, posz+(-163), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-110), posy, posz+(-195), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(242), posy, posz+(173), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopHov2)
table.insert(ScavengerConstructorBlueprintsT3,ZopHov2)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopHov2)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopHov2)

local function ZopAmph1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 160 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(160), posy, posz+(144), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eamphibfac_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(160), posy, posz+(-144), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-160), posy, posz+(144), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-160), posy, posz+(-144), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT1,ZopAmph1)
table.insert(ScavengerConstructorBlueprintsT2,ZopAmph1)
table.insert(ScavengerConstructorBlueprintsT3,ZopAmph1)
table.insert(ScavengerConstructorBlueprintsT1Sea,ZopAmph1)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopAmph1)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopAmph1)

local function ZopAmph2(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 176 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(160), posy, posz+(144), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eamphibfac_scav.id), {posx+(0), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(0), posy, posz+(176), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(160), posy, posz+(-144), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(0), posy, posz+(-176), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-160), posy, posz+(144), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-160), posy, posz+(-144), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopAmph2)
table.insert(ScavengerConstructorBlueprintsT3,ZopAmph2)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopAmph2)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopAmph2)

local function ZopEng1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 48 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-40), posy, posz+(-48), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(40), posy, posz+(48), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT0,ZopEng1)
table.insert(ScavengerConstructorBlueprintsT1,ZopEng1)
table.insert(ScavengerConstructorBlueprintsT2,ZopEng1)
table.insert(ScavengerConstructorBlueprintsT3,ZopEng1)
table.insert(ScavengerConstructorBlueprintsT0Sea,ZopEng1)
table.insert(ScavengerConstructorBlueprintsT1Sea,ZopEng1)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopEng1)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopEng1)

local function ZopEng2(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 107 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(70), posy, posz+(-85), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-10), posy, posz+(-21), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-58), posy, posz+(107), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT0,ZopEng2)
table.insert(ScavengerConstructorBlueprintsT1,ZopEng2)
table.insert(ScavengerConstructorBlueprintsT2,ZopEng2)
table.insert(ScavengerConstructorBlueprintsT3,ZopEng2)
table.insert(ScavengerConstructorBlueprintsT0Sea,ZopEng2)
table.insert(ScavengerConstructorBlueprintsT1Sea,ZopEng2)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopEng2)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopEng2)

local function ZopEng3(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 144 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(144), posy, posz+(4), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-112), posy, posz+(84), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.egeothermal_scav.id), {posx+(16), posy, posz+(36), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-48), posy, posz+(-124), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopEng3)
table.insert(ScavengerConstructorBlueprintsT3,ZopEng3)
table.insert(ScavengerConstructorBlueprintsT2Sea,ZopEng3)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopEng3)

local function ZopEng4(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 172 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(12), posy, posz+(164), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(172), posy, posz+(-12), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.esolar2_scav.id), {posx+(-180), posy, posz+(-156), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.efusion2_scav.id), {posx+(-4), posy, posz+(4), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT3,ZopEng4)
table.insert(ScavengerConstructorBlueprintsT3Sea,ZopEng4)

local function ZopAntiNuke1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 149 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-149), posy, posz+(-104), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(139), posy, posz+(-8), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ejammer2_scav.id), {posx+(-117), posy, posz+(120), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eshieldgen_scav.id), {posx+(3), posy, posz+(0), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(123), posy, posz+(120), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-133), posy, posz+(8), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(139), posy, posz+(-136), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopAntiNuke1)
table.insert(ScavengerConstructorBlueprintsT3,ZopAntiNuke1)

local function ZopAntiNuke2(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 203 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-21), posy, posz+(-150), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(139), posy, posz+(10), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-133), posy, posz+(-198), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-5), posy, posz+(74), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(107), posy, posz+(-134), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-117), posy, posz+(-38), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(107), posy, posz+(58), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-149), posy, posz+(10), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-149), posy, posz+(-6), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(187), posy, posz+(74), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(107), posy, posz+(58), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-5), posy, posz+(74), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(139), posy, posz+(10), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-133), posy, posz+(-86), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-5), posy, posz+(74), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.emine_scav.id), {posx+(-149), posy, posz+(26), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eshieldgen_scav.id), {posx+(3), posy, posz+(-14), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(11), posy, posz+(154), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-133), posy, posz+(90), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(203), posy, posz+(-86), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopAntiNuke2)
table.insert(ScavengerConstructorBlueprintsT3,ZopAntiNuke2)

local function ZopShield1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 143 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-1), posy, posz+(114), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ekmar_scav.id), {posx+(-9), posy, posz+(26), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-129), posy, posz+(98), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(143), posy, posz+(-94), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elaserbattery_scav.id), {posx+(127), posy, posz+(98), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-1), posy, posz+(-110), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-129), posy, posz+(-126), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT2,ZopShield1)
table.insert(ScavengerConstructorBlueprintsT3,ZopShield1)

local function ZopShield2(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 176 
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.ekmar_scav.id), {posx+(-146), posy, posz+(-96), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ekmar_scav.id), {posx+(174), posy, posz+(-112), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(118), posy, posz+(8), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(86), posy, posz+(-88), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-42), posy, posz+(-104), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eheavyturret2_scav.id), {posx+(-138), posy, posz+(8), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-106), posy, posz+(104), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(86), posy, posz+(104), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.ekmar_scav.id), {posx+(-18), posy, posz+(176), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eartyturret_scav.id), {posx+(-10), posy, posz+(8), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT3,ZopShield2)

local function ZopRadar1(scav, posx, posy, posz, GaiaTeamID, radiusCheck)
local posradius = 228
	 if radiusCheck then
		 return posradius
	 else
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-124), posy, posz+(164), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(-124), posy, posz+(-156), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.elightturret2_scav.id), {posx+(228), posy, posz+(-12), 1}, {"shift"})
		Spring.GiveOrderToUnit(scav, -(UDN.eradar2_scav.id), {posx+(20), posy, posz+(4), 1}, {"shift"})
	end
end

table.insert(ScavengerConstructorBlueprintsT1,ZopRadar1)
table.insert(ScavengerConstructorBlueprintsT2,ZopRadar1)
table.insert(ScavengerConstructorBlueprintsT3,ZopRadar1)

