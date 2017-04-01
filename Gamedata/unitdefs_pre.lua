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
	[[eallterrengineer]],
	[[eorb]],
	[[ebox]],
	[[ecommander]],
}

if Spring.GetModOptions().luamex == "enabled" then
		Shared.buildList [#Shared.buildList + 1] = [[emetalextractor]]
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
	[[ehbotfac]],
	[[eminifac]],
	[[ebasefactory]],
	[[eamphibfac]],
	[[eairplant]],
	[[ehbotpeewee]],
	[[ehbotthud]],
	[[ehbotsniper]],
	[[eallterrlight]],
	[[eallterrriot]],
	[[eallterrheavy]],
	[[elighttank3]],
	[[eriottank2]],
	[[eheavytank3]],
	[[eamphibbuggy]],
	[[eamphibriot]],
	[[eamphibmedtank]],
}

Shared.buildListFactory = {}
for i = 1, #Shared.buildList do
	Shared.buildListFactory[i] = Shared.buildList[i]
end
for i = 1, #factory do
	Shared.buildListFactory[#Shared.buildListFactory + 1] = factory[i]
end