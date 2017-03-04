Shared.buildList = {
	[[ehbotfac]],
	[[eminifac]],
	[[ebasefactory]],
	[[eamphibfac]],
	[[eairplant]],
	[[etech1]],
	[[esolar2]],
	[[egeothermal]],
	[[efusion2]],
	[[estorage]],
	[[eradar2]],
	[[ejammer2]],
	[[ekmar]],
	[[elightturret2]],
	[[eheavyturret2]],
	[[eartyturret]],
	[[euwturret]],
	[[eshieldgen]],
	[[esilo]],
	[[emine]],
	[[eorb]],
	[[ebox]],
}

if Spring.GetModOptions ~= nil then
	if Spring.GetModOptions().luamex == "enabled" then
		Shared.buildList [#Shared.buildList + 1] = [[emetalextractor]]
	end
end
	
local turrets = {
	[[ehbotpeewee_turret]],
	[[ehbotthud_turret]],
	[[ehbotsniper_turret]],
	[[ehbotrocko_turret]],
}

Shared.buildListTurret = {}
for i = 1, #Shared.buildList do
	Shared.buildListTurret[i] = Shared.buildList[i]
end
for i = 1, #turrets do
	Shared.buildListTurret[#Shared.buildListTurret + 1] = turrets[i]
end

local factory = {
	[[ehbotpeewee_turret]],
	[[ehbotthud_turret]],
	[[ehbotsniper_turret]],
	[[eallterrlight_t2]],
	[[eallterrriot_t2]],
	[[eallterrheavy_t2]],
	[[elighttank3_t2]],
	[[eriottank2_t2]],
	[[eheavytank3_t2]],
	[[eamphibbuggy_t2]],
	[[eamphibriot_t2]],
	[[eamphibmedtank_t2]],
}

Shared.buildListFactory = {}
for i = 1, #Shared.buildList do
	Shared.buildListFactory[i] = Shared.buildList[i]
end
for i = 1, #factory do
	Shared.buildListFactory[#Shared.buildListFactory + 1] = factory[i]
end