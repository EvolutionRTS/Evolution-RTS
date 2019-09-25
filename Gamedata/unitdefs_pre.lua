Shared.buildList = {
	[[ehbotfac]],
	[[eminifac]],
	[[ebasefactory]],
	[[eamphibfac]],
	[[eairplant]],
	[[etech1]],
	[[emetalextractor]],
	[[esolar2]],
	[[egeothermal]],
	[[efusion2]],
	[[estorage]],
	[[eradar2]],
	[[ejammer2]],
	[[ekmar]],
	[[emine]],
	[[elightturret2]],
	[[eheavyturret2]],
	[[elaserbattery]],
	[[eartyturret]],
	-- [[euwturret]],
	[[eshieldgen]],
	[[esilo]],
	[[escoutdrone]],
	[[ebox]],
	[[ehbotengineer]],
	[[eorb]],
	-- [[ecommander]],
}

Shared.buildListeCommanderFactory = {
	[[ehbotengineer]],
	[[eorb]],
	[[escoutdrone]],
	[[ebox]],
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
	[[efighter]],
	[[egunship2]],
	[[ebomber]],
}

Shared.buildListZaal = {
	[[zlightswarm]],
	[[zmedswarm]],
	[[zskirmisher]],
	[[zpyro]],
	[[zassault]],
	[[zarty]],
	[[zkamikaze]],
	[[zqueen]],
	[[zairscout]],
	[[zairtoairfighter]],
	[[zairtogroundfighter]],
	[[zairbomber]],
}

Shared.buildListZaalArm = {
	[[zhatch]],
	[[zespire1]],
	[[ztiberium]],
}

Shared.buildListZaalTumor = {
	[[ztumor]],
}
	
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
	[[efighter]],
	[[egunship2]],
	[[ebomber]],
}

Shared.buildListFactory = {}
for i = 1, #Shared.buildList do
	Shared.buildListFactory[i] = Shared.buildList[i]
end
for i = 1, #factory do
	Shared.buildListFactory[#Shared.buildListFactory + 1] = factory[i]
end

-- Shared.buildListAIOverseer = {
	-- ------------- Basic
	-- [[ehbotfac]],
	-- [[eminifac]],
	-- [[ebasefactory]],
	-- [[eamphibfac]],
	-- [[eairplant]],
	-- [[etech1]],
	-- [[emetalextractor]],
	-- [[esolar2]],
	-- [[egeothermal]],
	-- [[efusion2]],
	-- [[estorage]],
	-- [[eradar2]],
	-- [[ejammer2]],
	-- [[ekmar]],
	-- [[emine]],
	-- [[elightturret2]],
	-- [[eheavyturret2]],
	-- [[elaserbattery]],
	-- [[eartyturret]],
	-- -- [[euwturret]],
	-- [[eshieldgen]],
	-- [[esilo]],
	-- [[escoutdrone]],
	-- [[ebox]],
	-- [[ehbotengineer]],
	-- [[eorb]],
	-- -- [[ecommander]],
-- }

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

--
--

Shared.buildListAmphibFactory = {
		[[eamphibbuggy]],
		[[eamphibriot]],
		[[eamphibneedle]],
		[[eamphibmedtank]],
		[[eamphibrock]],
		[[eamphibarty]],
		[[eamphibleveler]],
}

Shared.buildListAmphibFactory_up1 = {
		[[eamphibbuggy_up1]],
		[[eamphibriot_up1]],
		[[eamphibneedle_up1]],
		[[eamphibmedtank_up1]],
		[[eamphibrock_up1]],
		[[eamphibarty_up1]],
		[[eamphibleveler_up1]],
}

Shared.buildListAmphibFactory_up2 = {
		[[eamphibbuggy_up2]],
		[[eamphibriot_up2]],
		[[eamphibneedle_up2]],
		[[eamphibmedtank_up2]],
		[[eamphibrock_up2]],
		[[eamphibarty_up2]],
		[[eamphibleveler_up2]],
}

Shared.buildListAmphibFactory_up3 = {
		[[eamphibbuggy_up3]],
		[[eamphibriot_up3]],
		[[eamphibneedle_up3]],
		[[eamphibmedtank_up3]],
		[[eamphibrock_up3]],
		[[eamphibarty_up3]],
		[[eamphibleveler_up3]],
}

--
--

Shared.buildListAllTerrainFactory = {
		[[eallterrlight]],
		[[eallterrriot]],
		[[eallterrmed]],
		[[eallterrheavy]],
		[[eallterrassault]],
		[[eallterrshield]],
		[[eallterranarchid]],
}

Shared.buildListAllTerrainFactory_up1 = {
		[[eallterrlight_up1]],
		[[eallterrriot_up1]],
		[[eallterrmed_up1]],
		[[eallterrheavy_up1]],
		[[eallterrassault_up1]],
		[[eallterrshield_up1]],
		[[eallterranarchid_up1]],
}

Shared.buildListAllTerrainFactory_up2 = {
		[[eallterrlight_up2]],
		[[eallterrriot_up2]],
		[[eallterrmed_up2]],
		[[eallterrheavy_up2]],
		[[eallterrassault_up2]],
		[[eallterrshield_up2]],
		[[eallterranarchid_up2]],
}

Shared.buildListAllTerrainFactory_up3 = {
		[[eallterrlight_up3]],
		[[eallterrriot_up3]],
		[[eallterrmed_up3]],
		[[eallterrheavy_up3]],
		[[eallterrassault_up3]],
		[[eallterrshield_up3]],
		[[eallterranarchid_up3]],
}
--
--
Shared.buildListAirPlant = {
		-- [[edrone]],
		[[efighter]],
		[[egunship2]],
		[[ebomber]],
		[[eairemp]],
		[[etransport]],
		[[ekrow]],		
}
Shared.buildListAirPlant_up1 = {
		-- [[edrone_up1]],
		[[efighter_up1]],
		[[egunship2_up1]],
		[[ebomber_up1]],
		[[eairemp_up1]],
		[[etransport_up1]],
		[[ekrow_up1]],		
}
Shared.buildListAirPlant_up2 = {
		-- [[edrone_up2]],
		[[efighter_up2]],
		[[egunship2_up2]],
		[[ebomber_up2]],
		[[eairemp_up2]],
		[[etransport_up2]],
		[[ekrow_up2]],		
}
Shared.buildListAirPlant_up3 = {
		-- [[edrone_up3]],
		[[efighter_up3]],
		[[egunship2_up3]],
		[[ebomber_up3]],
		[[eairemp_up3]],
		[[etransport_up3]],
		[[ekrow_up3]],		
}
--
--
Shared.buildListHbotFactory = {
		[[ehbotpeewee]],
		[[ehbotthud]],
		[[ehbotsniper]],
		[[ehbotrocko]],
		[[ehbotkarganneth]],
}
Shared.buildListHbotFactory_up1 = {
		[[ehbotpeewee_up1]],
		[[ehbotthud_up1]],
		[[ehbotsniper_up1]],
		[[ehbotrocko_up1]],
		[[ehbotkarganneth_up1]],
}
Shared.buildListHbotFactory_up2 = {
		[[ehbotpeewee_up2]],
		[[ehbotthud_up2]],
		[[ehbotsniper_up2]],
		[[ehbotrocko_up2]],
		[[ehbotkarganneth_up2]],
}
Shared.buildListHbotFactory_up3 = {
		[[ehbotpeewee_up3]],
		[[ehbotthud_up3]],
		[[ehbotsniper_up3]],
		[[ehbotrocko_up3]],
		[[ehbotkarganneth_up3]],
}
