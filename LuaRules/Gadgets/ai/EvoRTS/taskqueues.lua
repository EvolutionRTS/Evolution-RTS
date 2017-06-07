--[[
Task Queues!
]]--

math.randomseed( os.time() )
math.random(); math.random(); math.random()

---------------------------------------------RNG Functions for AI

--local function AirOrLand()
	--local r = math.random(0,4)
	--if r == 0 then
			--return "eairplant"
		--elseif r == 1 then
			--return "ebasefactory"
		--elseif r == 2 then
			--return "eamphibfac"
		--elseif r == 3 then
			--return "eminifac"
		--else
			--return "ehbotfac"
	--end
--end

--local function StartFactory()
	--local r = math.random(0,2)
	--if r == 0 then
			--return "eminifac"
		--elseif r == 1 then
			--return "ebasefactory"
		--else
			--return "eamphibfac"
	--end
--end

local function Orb()
	return "eorbai"
end

local function Box()
	return "ebox"
end

local function Scout()
	return "escout"
end

local function Turret()
	return "eaiturret"
end

-------------------------------------------------------- Upgrade 0


local function Raid()
	local r = math.random(0,3)
	if r == 0 then
			return "eallterrlight"
		elseif r == 1 then
			return "eamphibbuggy"
		elseif r == 2 then
			return "ehbotpeewee"
		else
			return "elighttank3"
	end
end

local function EMP()
	local r = math.random(0,3)
	if r == 0 then
			return "eallterrriot"
		elseif r == 1 then
			return "eamphibriot"
		elseif r == 2 then
			return "eriottank2"
		else
			return "eamphibneedle"
	end
end

local function Arty()
	local r = math.random(0,3)
	if r == 0 then
			return "eallterrassault"
		elseif r == 1 then
			return "ehbotthud"
		elseif r == 2 then
			return "eartytank"
		else
			return "eamphibarty"
	end
end

local function Armor()
	local r = math.random(0,3)
	if r == 0 then
			return "eamphibmedtank"
		elseif r == 1 then
			return "eallterrmed"
		elseif r == 2 then
			return "eallterrheavy"
		else
			return "eheavytank3"
	end
end

local function Support()
	local r = math.random(0,4)
	if r == 0 then
			return "emissiletank"
		elseif r == 1 then
			return "ehbotsniper"
		elseif r == 2 then
			return "eamphibrock"
		elseif r == 3 then
			return "ehbotrocko"
		else
			return "eallterrshield"
	end
end

local function End()
	local r = math.random(0,2)
	if r == 0 then
			return "eallterranarchid"
		elseif r == 1 then
			return "eamphibleveler"
		else
			return "elacerator"
	end
end

local function Air()
	local r = math.random(0,2)
	if r == 0 then
			return "ebomber"
		elseif r == 1 then
			return "efighter"
		else
			return "egunship2"
	end
end


--------------------------------------------------- Upgrade 1


local function Raid1()
	local r = math.random(0,2)  --local r = math.random(0,3)
	if r == 0 then
			return "eallterrlight_up1"
		elseif r == 1 then
			return "eamphibbuggy_up1"
		else --if r == 2 then
			return "elighttank3_up1"
		--else
			--return "ehbotpeewee_up1"
	end
end

local function EMP1()
	local r = math.random(0,3)
	if r == 0 then
			return "eallterrriot_up1"
		elseif r == 1 then
			return "eamphibriot_up1"
		elseif r == 2 then
			return "eriottank2_up1"
		else
			return "eamphibneedle_up1"
	end
end

local function Arty1()
	local r = math.random(0,2)  --local r = math.random(0,3)
	if r == 0 then
			return "eallterrassault_up1"
		elseif r == 1 then
			return "eamphibarty_up1"
		else --if r == 2 then
			return "eartytank_up1"
		--else
			--return "ehbotthud_up1"
	end
end

local function Armor1()
	local r = math.random(0,3)
	if r == 0 then
			return "eamphibmedtank_up1"
		elseif r == 1 then
			return "eallterrmed_up1"
		elseif r == 2 then
			return "eallterrheavy_up1"
		else
			return "eheavytank3_up1"
	end
end

local function Support1()
	local r = math.random(0,2) --local r = math.random(0,4)
	if r == 0 then
			return "emissiletank_up1"
		elseif r == 1 then
			return "eallterrshield_up1"
		else --if r == 2 then
			return "eamphibrock_up1"
		--elseif r == 3 then
			--return "ehbotrocko_up1"
		--else
			--return "ehbotsniper_up1"
	end
end

local function End1()
	local r = math.random(0,2)
	if r == 0 then
			return "eallterranarchid_up1"
		elseif r == 1 then
			return "eamphibleveler_up1"
		else
			return "elacerator_up1"
	end
end

local function Air1()
	local r = math.random(0,2)
	if r == 0 then
			return "ebomber_up1"
		elseif r == 1 then
			return "efighter_up1"
		else
			return "egunship2_up1"
	end
end


-------------------------------------------------- Upgrade 2


local function Raid2()
	local r = math.random(0,2)  --local r = math.random(0,3)
	if r == 0 then
			return "eallterrlight_up2"
		elseif r == 1 then
			return "eamphibbuggy_up2"
		else --if r == 2 then
			return "elighttank3_up2"
		--else
			--return "ehbotpeewee_up2"
	end
end

local function EMP2()
	local r = math.random(0,3)
	if r == 0 then
			return "eallterrriot_up2"
		elseif r == 1 then
			return "eamphibriot_up2"
		elseif r == 2 then
			return "eriottank2_up2"
		else
			return "eamphibneedle_up2"
	end
end

local function Arty2()
	local r = math.random(0,2)  --local r = math.random(0,3)
	if r == 0 then
			return "eallterrassault_up2"
		elseif r == 1 then
			return "eamphibarty_up2"
		else --if r == 2 then
			return "eartytank_up2"
		--else
			--return "ehbotthud_up2"
	end
end

local function Armor2()
	local r = math.random(0,3)
	if r == 0 then
			return "eamphibmedtank_up2"
		elseif r == 1 then
			return "eallterrmed_up2"
		elseif r == 2 then
			return "eallterrheavy_up2"
		else
			return "eheavytank3_up2"
	end
end

local function Support2()
	local r = math.random(0,2) --local r = math.random(0,4)
	if r == 0 then
			return "emissiletank_up2"
		elseif r == 1 then
			return "eallterrshield_up2"
		else --if r == 2 then
			return "eamphibrock_up2"
		--elseif r == 3 then
			--return "ehbotrocko_up2"
		--else
			--return "ehbotsniper_up2"
	end
end

local function End2()
	local r = math.random(0,2)
	if r == 0 then
			return "eallterranarchid_up2"
		elseif r == 1 then
			return "eamphibleveler_up2"
		else
			return "elacerator_up2"
	end
end

local function Air2()
	local r = math.random(0,2)
	if r == 0 then
			return "ebomber_up2"
		elseif r == 1 then
			return "efighter_up2"
		else
			return "egunship2_up2"
	end
end


------------------------------------------------ Upgrade 3


local function Raid3()
	local r = math.random(0,2)  --local r = math.random(0,3)
	if r == 0 then
			return "eallterrlight_up3"
		elseif r == 1 then
			return "eamphibbuggy_up3"
		else --if r == 2 then
			return "elighttank3_up3"
		--else
			--return "ehbotpeewee_up3"
	end
end

local function EMP3()
	local r = math.random(0,3)
	if r == 0 then
			return "eallterrriot_up3"
		elseif r == 1 then
			return "eamphibriot_up3"
		elseif r == 2 then
			return "eriottank2_up3"
		else
			return "eamphibneedle_up3"
	end
end

local function Arty3()
	local r = math.random(0,2)  --local r = math.random(0,3)
	if r == 0 then
			return "eallterrassault_up3"
		elseif r == 1 then
			return "eamphibarty_up3"
		else --if r == 2 then
			return "eartytank_up3"
		--else
			--return "ehbotthud_up3"
	end
end

local function Armor3()
	local r = math.random(0,3)
	if r == 0 then
			return "eamphibmedtank_up3"
		elseif r == 1 then
			return "eallterrmed_up3"
		elseif r == 2 then
			return "eallterrheavy_up3"
		else
			return "eheavytank3_up3"
	end
end

local function Support3()
	local r = math.random(0,2) --local r = math.random(0,4)
	if r == 0 then
			return "emissiletank_up3"
		elseif r == 1 then
			return "eallterrshield_up3"
		else --if r == 2 then
			return "eamphibrock_up3"
		--elseif r == 3 then
			--return "ehbotrocko_up3"
		--else
			--return "ehbotsniper_up3"
	end
end

local function End3()
	local r = math.random(0,2)
	if r == 0 then
			return "eallterranarchid_up3"
		elseif r == 1 then
			return "eamphibleveler_up3"
		else
			return "elacerator_up3"
	end
end

local function Air3()
	local r = math.random(0,2)
	if r == 0 then
			return "ebomber_up3"
		elseif r == 1 then
			return "efighter_up3"
		else
			return "egunship2_up3"
	end
end

---------------------------------------------------------------- QUEUES

local firstEngineerRaid = {
   Turret,
   Turret,
   Turret,
   Turret,
   Orb,
   Scout,
   Scout,
   Scout,
   Scout,
   Scout,
   Orb,
   Scout,
   Scout,
   Scout,
   Scout,
   Scout,
   Scout,
   Scout,
   Scout,
   Orb,
   Raid,
   Raid,
   Raid,
   Raid,
   Orb,
   Raid,
   Raid,
   Raid,
   Raid,
   Orb,
   Orb,
   Scout,
   Raid,
   Raid,
   Raid,
   Box,
   Orb,
   Raid,
   Raid,
   Raid,
   Raid,
   Raid,
   Box,
   Orb,
   Scout,
   Scout,
   Scout,
   Scout,
   Scout,
   Orb,
   Scout,
   Scout,
   Scout,
   Scout,
   Scout,
   Scout,
   Scout,
   Scout,
   Orb,
   Raid,
   Raid,
   Raid,
   Raid,
   Orb,
   Raid,
   Raid,
   Raid,
   Raid,
   Orb,
   Orb,
   Scout,
   Raid,
   Raid,
   Raid,
   Box,
   Orb,
   Raid,
   Raid,
   Raid,
   Raid,
   Raid,
   Box,
   Orb,
   Turret,
   Turret,
   Scout1,
   Air1,
   Orb,
   Scout1,
   Air1,
   Orb,
   Raid1,
   EMP1,
   Raid1,
   Raid1,
   Orb,
   Raid1,
   EMP1,
   Raid1,
   Raid1,
   Orb,
   Orb,
   Air1,
   Raid1,
   EMP1,
   Raid1,
   Box,
   Orb,
   Raid1,
   EMP1,
   Raid1,
   Raid1,
   EMP1,
   Box,
   Orb,
   Scout1,
   Air1,
   Orb,
   Scout1,
   Air1,
   Orb,
   Raid1,
   EMP1,
   Raid1,
   Raid1,
   Orb,
   Raid1,
   EMP1,
   Raid1,
   Raid1,
   Orb,
   Orb,
   Air1,
   Raid1,
   EMP1,
   Raid1,
   Box,
   Orb,
   Raid1,
   EMP1,
   Raid1,
   Raid1,
   EMP1,
   Box,
   Orb,
   Air2,
   Turret,
   Turret,
   Air2,
   Orb,
   Air2,
   Air2,
   Orb,
   Raid2,
   Air2,
   Arty2,
   Raid2,
   Orb,
   EMP2,
   Raid2,
   Arty2,
   Raid2,
   Orb,
   Orb,
   Scout2,
   Raid2,
   Raid2,
   Arty2,
   Box,
   Orb,
   Raid2,
   EMP2,
   Arty2,
   Raid2,
   Raid2,
   Box,
   Orb,
   Air3,
   Air3,
   Orb,
   Air3,
   Air3,
   Orb,
   Armor3,
   Air3,
   Arty3,
   Armor3,
   Orb,
   EMP3,
   Armor3,
   Arty3,
   Armor3,
   Orb,
   Orb,
   Scout3,
   Armor3,
   Armor3,
   Arty3,
   Box,
   Orb,
   Armor3,
   EMP3,
   Arty3,
   Armor3,
   Armor3,
   Box,
   End3,
   End3,
}

local firstEngineerTechPush = {
   Turret,
   Turret,
   Turret,
   Turret,
   Orb,
   Orb,
   Raid,
   Raid,
   Raid,
   Raid,
   Orb,
   Raid,
   Raid,
   Raid,
   Raid,
   Box,
   Orb,
   Orb,
   Raid,
   Raid,
   Raid,
   Raid,
   Orb,
   Raid,
   Raid,
   Raid,
   Raid,
   Box,
   Raid1,
   Raid1,
   Raid1,
   EMP1,
   Arty1,
   Orb,
   Orb,
   Armor1,
   Armor1,
   Raid2,
   Raid2,
   Armor1,
   Armor1,
   Raid1,
   Armor1,
   Box,
   Raid1,
   Raid1,
   Raid1,
   EMP1,
   Arty1,
   Orb,
   Orb,
   Armor1,
   Armor1,
   Raid2,
   Raid2,
   Armor1,
   Armor1,
   Raid1,
   Armor1,
   Box,
   Armor2,
   Orb,
   Armor2,
   Armor2,
   Armor2,
   Orb,
   Armor2,
   Support2,
   Arty2,
   Armor2,
   Orb,
   Armor2,
   Orb,
   Armor3,
   Armor2,
   Orb,
   Armor3,
   Support3,
   Arty3,
   Orb,
}

local firstEngineerAir = {
   Turret,
   Turret,
   Turret,
   Turret,
   Orb,
   Orb,
   Scout,
   Scout,
   Scout,
   Scout,
   Air,
   Scout,
   Scout,
   Scout,
   Orb,
   Scout,
   Box,
   Scout,
   Orb,
   Scout,
   Scout,
   Air,
   Air,
   Air,
   Orb,
   Air,
   Air,
   Box,
   Orb,
   Orb,
   Scout,
   Scout,
   Scout,
   Scout,
   Air,
   Scout,
   Scout,
   Orb,
   Scout,
   Scout,
   Box,
   Scout,
   Orb,
   Scout,
   Scout,
   Air,
   Air,
   Air,
   Air,
   Air,
   Box,
   Air,
   Air,
   Air,
   Air,
   Air,
   Orb,
   Orb,
   Air1,
   Turret,
   Turret,
   Air1,
   Orb,
   Air1,
   Air1,
   Orb,
   Air1,
   Orb,
   Air1,
   Air1,
   Air1,
   Box,
   Air,
   Air,
   Air,
   Air,
   Air,
   Orb,
   Orb,
   Air1,
   Air1,
   Air1,
   Orb,
   Air1,
   Air1,
   Orb,
   Air1,
   Air1,
   Air1,
   Box,
   Air2,
   Orb,
   Air2,
   Air2,
   Air2,
   Orb,
   Air2,
   Air2,
   Air2,
   Air2,
   Orb,
   Air2,
   Air3,
   Orb,
   Air2,
   Air3,
   Air3,
   Air3,
}

local engineersTechPush = {
	Turret,
	Orb,
	Armor3,
	Support3,
	Armor3,
	End3,
	Armor3,
	Armor3,
	Box,
	Armor3,
	Support3,
	Armor3,
	End3,
	Armor3,
	Armor3,
	Orb,
	Orb,
	Orb,
}

local engineersRaid = {
	Turret,
	Orb,
	Arty3,
    Arty3,
    Arty3,
	Orb,
    Arty3,
    Arty3,
	Arty3,
	Arty3,
	Box,
	Arty3,
   Orb,
	Arty3,
	Arty3,
   Orb,
	Arty3,
	Orb,
	Arty3,
	Arty3,
	Arty3,
    Orb,
	Air3,
	Air3,
	Air3,
	Air3,
    Air3,
	Air3,
	Orb,
	Air3,
	Air3,
	Orb,
	Armor3,
	Turret,
    Armor3,
    Armor3,
	Orb,
    Armor3,
    Armor3,
	Armor3,
	Armor3,
	Box,
	Armor3,
	Armor3,
	Armor3,
	Armor3,
	Orb,
	Armor3,
	Armor3,
	Armor3,
    Orb,
	Support3,
	Support3,
	Support3,
	Support3,
    Support3,
	Support3,
	Orb,
	Support3,
	Support3,
	Orb,
	Armor3,
    Support3,
    Arty3,
	Orb,
    Armor3,
    Armor3,
	Support3,
	Armor3,
	Box,
	Armor3,
	Arty3,
	Armor3,
	Armor3,
	Orb,
	Armor3,
	Support3,
	Armor3,
    Orb,
	End3,
	End3,
	End3,
	End3,
    End3,
	End3,
	Orb,
	End3,
	End3,
}

local engineersAir = {
	Turret,
	Orb,
	Air3,
	Air3,
   	Orb,
	Air3,
	End3,
	Air3,
	Air3,
	Box,
	Air3,
	Air3,
  	 Orb,
	Air3,
	End3,
	Air3,
	Air3,
	Orb,
	Orb,
	Orb,
}

local idlelist = {
  { action = "wait", frames = 3000},
}

--local factory = {
--}

--local airplant = {
--}

--local amphibfactory = {
--}

--local allterrfactory = {
--

--local orbs = {
	--{ action = "moverelative", position = {x = math.random(-200, 200), y = math.random(-200, 200), z = math.random(-200, 200)} },
	--{ action = "moverelative", position = {x = math.random(-200, 200), y = math.random(-200, 200), z = math.random(-200, 200)} },
	--{ action = "moverelative", position = {x = math.random(-200, 200), y = math.random(-200, 200), z = math.random(-200, 200)} },
	--{ action = "moverelative", position = {x = math.random(-200, 200), y = math.random(-200, 200), z = math.random(-200, 200)} },
--}


local function engineerlist(beh)
   local r = math.random(0,2)
	  if r == 0 then
		if ai.engineerfirst == true then
			return engineersRaid
			else
			ai.engineerfirst = true
			return firstEngineerRaid
			end
		elseif r == 1 then
			if ai.engineerfirst == true then
			return engineersTechPush
			else
			ai.engineerfirst = true
			return firstEngineerTechPush
			end
		else
			if ai.engineerfirst == true then
			return engineersAir
			else
			ai.engineerfirst = true
			return firstEngineerAir
			end
		end
end

	--local function orblist(brr)
    --return orbs
--end
	
	taskqueues = {
   ecommanderbattleai = engineerlist,
   eaiturret = idlelist
   --ebasefactory = factory,
   --eengineer5 = engineerlist,
   eallterrengineer = engineerlist,
   --eamphibengineer = engineerlist,
   --eairengineer = engineerlist,
   --eairplant = airplant,
   --eamphibfac = amphibfactory,
   --eminifac = allterrfactory,
   --eorb = orblist,
	}
