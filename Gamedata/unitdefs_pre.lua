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

if Spring.GetModOptions().luamex ~= "disabled" then
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

-----------------------------
-----------------------------
--Buildlists for factories

Shared.buildListHoverFactory = {
		[[elighttank3]],
		[[eriottank2]],
		[[eheavytank3]],
		[[emissiletank]],
		[[eartytank]],
		[[elacerator]],
}

Shared.buildListHoverFactory_up1 = {
		[[elighttank3_up1]],
		[[eriottank2_up1]],
		[[eheavytank3_up1]],
		[[emissiletank_up1]],
		[[eartytank_up1]],
		[[elacerator_up1]],
}

Shared.buildListHoverFactory_up2 = {
		[[elighttank3_up2]],
		[[eriottank2_up2]],
		[[eheavytank3_up2]],
		[[emissiletank_up2]],
		[[eartytank_up2]],
		[[elacerator_up2]],
}

Shared.buildListHoverFactory_up3 = {
		[[elighttank3_up3]],
		[[eriottank2_up3]],
		[[eheavytank3_up3]],
		[[emissiletank_up3]],
		[[eartytank_up3]],
		[[elacerator_up3]],
}