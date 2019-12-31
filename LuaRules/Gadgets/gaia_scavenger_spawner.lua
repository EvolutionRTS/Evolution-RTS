function gadget:GetInfo()
  return {
    name      = "gaia scavenger unit spawner",
    desc      = "Spawner of units",
    author    = "Damgam",
    date      = "2019",
    layer     = -100,
    enabled   = true,
	}
end

local devswitch = 0

-- synced only
if (not gadgetHandler:IsSyncedCode()) then
	return false
end


ScavengerBlueprintsT0 = {}
ScavengerBlueprintsT1 = {}
ScavengerBlueprintsT2 = {}
ScavengerBlueprintsT3 = {}

ConfigsList = VFS.DirList('LuaRules/Configs/ScavengerBlueprints/','*.lua')
for i = 1,#ConfigsList do
	VFS.Include(ConfigsList[i])
	Spring.Echo("Direction: " ..ConfigsList[i])
end

------------------------------------------------------------------------

local GaiaTeamID  = Spring.GetGaiaTeamID()
local _,_,_,_,_,GaiaAllyTeamID = Spring.GetTeamInfo(GaiaTeamID)
local teamcount = #Spring.GetTeamList() - 2
local mapsizeX = Game.mapSizeX
local mapsizeZ = Game.mapSizeZ
local deathwater = Game.waterDamage
--local spawnmultiplier = 1
local spawnmultiplier = tonumber(Spring.GetModOptions().scavengers) or 1
if devswitch == 1 then
	spawnmultiplier = 1
end
local failcounter = 0
--local discoscavengers = tonumber(Spring.GetModOptions().discoscavengers) or 0

local BonusUnits = {"eorb", "ehbotengineer", "ebox", "escoutdrone", "eallterrshield", "zairscout",}

local T0Units = {
-- Z
"zlightswarm",
"zmedswarm",
"zpyro",
-- AllTerr
"eallterrlight",
"eallterrassault",
"eallterrriot",
"eallterrriot_shotgun",
-- Amphib
"eamphibarty",
"eamphibbuggy",
"eamphibneedle",
"eamphibriot",
"eamphibriot_shotgun",
-- Hbot
"ehbotpeewee",
"ehbotthud",
-- Hover
"eartytank",
"elighttank3",
"eriottank2",
"eriottank2_shotgun",

}

local T1Units = {
-- Z
"zlightswarm",
"zmedswarm",
"zpyro",
-- AllTerr
"eallterrlight_up1",
"eallterrassault_up1",
"eallterrriot_up1",
"eallterrriot_shotgun_up1",
-- Amphib
"eamphibarty_up1",
"eamphibbuggy_up1",
"eamphibneedle_up1",
"eamphibriot_up1",
"eamphibriot_shotgun_up1",
-- Hbot
"ehbotpeewee_up1",
"ehbotthud_up1",
-- Hover
"eartytank_up1",
"elighttank3_up1",
"eriottank2_up1",
"eriottank2_shotgun_up1",
}

local T2Units = {
-- Z
"zlightswarm",
"zmedswarm",
"zpyro",
"zairbomber",
"zairtoairfighter",
"zairtogroundfighter",
"zskirmisher",
-- Air
"efighter_up2",
"egunship2_up2",
"ebomber2_up2",
-- AllTerr
"eallterrlight_up2",
"eallterrassault_up2",
"eallterrriot_up2",
"eallterrriot_shotgun_up2",
"eallterrmed_up2",
"eallterrheavy_up2",
-- Amphib
"eamphibarty_up2",
"eamphibbuggy_up2",
"eamphibneedle_up2",
"eamphibriot_up2",
"eamphibriot_shotgun_up2",
"eamphibmedtank_up2",
"eamphibrock_up2",
-- Hbot
"ehbotpeewee_up2",
"ehbotthud_up2",
"ehbotsniper_up2",
"ehbotrocko_up2",
-- Hover
"eartytank_up2",
"eartytank_saturation_up2",
"elighttank3_up2",
"eriottank2_up2",
"eriottank2_shotgun_up2",
"eheavytank3_up2",
"emissiletank_up2",
}

local T3Units = {
-- Z
"zlightswarm",
"zmedswarm",
"zpyro",
"zairbomber",
"zairtoairfighter",
"zairtogroundfighter",
"zskirmisher",
"zassault",
"zkamikaze",
"zqueen",
-- Air
"efighter_up3",
"egunship2_up3",
"ebomber2_up3",
"eairemp_up3",
"ekrow_up3",
-- AllTerr
"eallterrlight_up3",
"eallterrassault_up3",
"eallterrriot_up3",
"eallterrriot_shotgun_up3",
"eallterrmed_up3",
"eallterrheavy_up3",
"eallterranarchid_up3",
-- Amphib
"eamphibarty_up3",
"eamphibbuggy_up3",
"eamphibneedle_up3",
"eamphibriot_up3",
"eamphibriot_shotgun_up3",
"eamphibmedtank_up3",
"eamphibrock_up3",
"eamphibleveler_up3",
-- Hbot
"ehbotpeewee_up3",
"ehbotthud_up3",
"ehbotsniper_up3",
"ehbotrocko_up3",
"ehbotkarganneth_up3",
-- Hover
"eartytank_up3",
"eartytank_saturation_up3",
"elighttank3_up3",
"eriottank2_up3",
"eriottank2_shotgun_up3",
"eheavytank3_up3",
"emissiletank_up3",
"elacerator_up3",
}

--local timer = Spring.GetGameSeconds()

local dx = {}
local dy = {}
local dz = {}
local olddx = {}
local olddy = {}
local olddz = {}
local selfdestructcounter = 0
local posx = 0
local posy = 0
local posz = 0
local posradius = 0
local canSpawnHere = false
local canBuildHere = false
local blueprint = 0
local radiusCheck = false



------------------------------------------------------------------------

function gadget:Initialize()
	-- local mo = Spring.GetModOptions()
	-- if mo and tonumber(mo.scavengers)==0 then
		-- Spring.Echo("[scavengers] Disabled via ModOption")
		-- gadgetHandler:RemoveGadget(self)
	-- end

end

local function posCheck(posx, posy, posz, posradius)
	-- if true then can spawn
	local testpos1 = Spring.GetGroundHeight((posx + posradius), (posz + posradius) )
	local testpos2 = Spring.GetGroundHeight((posx + posradius), (posz - posradius) )
	local testpos3 = Spring.GetGroundHeight((posx - posradius), (posz + posradius) )
	local testpos4 = Spring.GetGroundHeight((posx - posradius), (posz - posradius) )
	local testpos5 = Spring.GetGroundHeight((posx + posradius), posz )
	local testpos6 = Spring.GetGroundHeight(posx, (posz + posradius) )
	local testpos7 = Spring.GetGroundHeight((posx - posradius), posz )
	local testpos8 = Spring.GetGroundHeight(posx, (posz - posradius) )
	if deathwater > 0 and posy <= 0 then
		return false
	elseif testpos1 < posy - 50 or testpos1 > posy + 50 then
		return false
	elseif testpos2 < posy - 50 or testpos2 > posy + 50 then
		return false
	elseif testpos3 < posy - 50 or testpos3 > posy + 50 then
		return false
	elseif testpos4 < posy - 50 or testpos4 > posy + 50 then
		return false
	elseif testpos5 < posy - 50 or testpos5 > posy + 50 then
		return false
	elseif testpos6 < posy - 50 or testpos6 > posy + 50 then
		return false
	elseif testpos7 < posy - 50 or testpos7 > posy + 50 then
		return false
	elseif testpos8 < posy - 50 or testpos8 > posy + 50 then
		return false
	else
		return true
	end
end

local function posOccupied(posx, posy, posz, posradius)
	-- if true then can spawn
	local unitcount = #Spring.GetUnitsInRectangle(posx-posradius, posz-posradius, posx+posradius, posz+posradius)
	if unitcount > 0 then
		return false
	else
		return true
	end
end

local function posLosCheck(posx, posy, posz, posradius)
	-- if true then can spawn
	for _,allyTeamID in ipairs(Spring.GetAllyTeamList()) do
		if allyTeamID ~= GaiaAllyTeamID then
			if Spring.IsPosInLos(posx, posy, posz, allyTeamID) == true or
			Spring.IsPosInLos(posx + posradius, posy, posz + posradius, allyTeamID) == true or
			Spring.IsPosInLos(posx + posradius, posy, posz - posradius, allyTeamID) == true or
			Spring.IsPosInLos(posx - posradius, posy, posz + posradius, allyTeamID) == true or
			Spring.IsPosInLos(posx - posradius, posy, posz - posradius, allyTeamID) == true or
			Spring.IsPosInRadar(posx, posy, posz, allyTeamID) == true or
			Spring.IsPosInRadar(posx + posradius, posy, posz + posradius, allyTeamID) == true or
			Spring.IsPosInRadar(posx + posradius, posy, posz - posradius, allyTeamID) == true or
			Spring.IsPosInRadar(posx - posradius, posy, posz + posradius, allyTeamID) == true or
			Spring.IsPosInRadar(posx - posradius, posy, posz - posradius, allyTeamID) == true or
			Spring.IsPosInAirLos(posx, posy, posz, allyTeamID) == true or
			Spring.IsPosInAirLos(posx + posradius, posy, posz + posradius, allyTeamID) == true or
			Spring.IsPosInAirLos(posx + posradius, posy, posz - posradius, allyTeamID) == true or
			Spring.IsPosInAirLos(posx - posradius, posy, posz + posradius, allyTeamID) == true or
			Spring.IsPosInAirLos(posx - posradius, posy, posz - posradius, allyTeamID) == true then
				return false
			end
		end
	end
	return true
end

--local function buildBlueprint(blueprint)
	--blueprint
--end

function gadget:GameFrame(n)
	if spawnmultiplier > 0 then
		if n%10 == 0 and n > 3000 then
			Spring.SetTeamColor(GaiaTeamID, math.random(0,255)/255, math.random(0,255)/255, math.random(0,255)/255)
		end
		if n == 100 then
			Spring.SetTeamResource(GaiaTeamID, "ms", 100000)
			Spring.SetTeamResource(GaiaTeamID, "es", 100000)
			Spring.SetGlobalLos(GaiaAllyTeamID, false)
		end
		if n%3000 == 0 then
			Spring.SetTeamResource(GaiaTeamID, "m", 100000)
			Spring.SetTeamResource(GaiaTeamID, "e", 100000)
		end
		if n%90 == 0 and n > 3000 then
			local gaiaUnitCount = Spring.GetTeamUnitCount(GaiaTeamID)
			local spawnchance = math.random(0,20)
			if spawnchance == 0 or canBuildHere == false then
				posx = math.random(200,mapsizeX-200)
				posz = math.random(200,mapsizeZ-200)
				posy = Spring.GetGroundHeight(posx, posz)
				--blueprint = ScavengerBlueprintsStart[math.random(1,#ScavengerBlueprintsStart)]
				if n > 54000 then
					local r = math.random(0,1)
					if r == 0 then
						blueprint = ScavengerBlueprintsT3[math.random(1,#ScavengerBlueprintsT3)]
					else
						blueprint = ScavengerBlueprintsT2[math.random(1,#ScavengerBlueprintsT2)]
					end
				elseif n > 36000 then
					local r = math.random(0,2)
					if r == 0 then
						blueprint = ScavengerBlueprintsT2[math.random(1,#ScavengerBlueprintsT2)]
					elseif r == 1 then
						blueprint = ScavengerBlueprintsT1[math.random(1,#ScavengerBlueprintsT1)]
					else
						blueprint = ScavengerBlueprintsT0[math.random(1,#ScavengerBlueprintsT0)]
					end
				elseif n > 18000 then
					local r = math.random(0,1)
					if r == 0 then
						blueprint = ScavengerBlueprintsT1[math.random(1,#ScavengerBlueprintsT1)]
					else
						blueprint = ScavengerBlueprintsT0[math.random(1,#ScavengerBlueprintsT0)]
					end
				else
					blueprint = ScavengerBlueprintsT0[math.random(1,#ScavengerBlueprintsT0)]
				end
				posradius = blueprint(posx, posy, posz, GaiaTeamID, true)
				canBuildHere = posLosCheck(posx, posy, posz, posradius)
				if canBuildHere then
					canBuildHere = posOccupied(posx, posy, posz, posradius)
				end
				if canBuildHere then
					canBuildHere = posCheck(posx, posy, posz, posradius)
				end
			
				if canBuildHere then
					-- let's do this shit
					blueprint(posx, 5000, posz, GaiaTeamID, false)
				end
			end
		end
			
		if n%30 == 0 and n > 5400 then
			local gaiaUnitCount = Spring.GetTeamUnitCount(GaiaTeamID)
			local spawnchance = math.random(0,math.ceil((((gaiaUnitCount)/teamcount)+2)*(#Spring.GetAllyTeamList() - 1)/spawnmultiplier))
			--local spawnchance = 0 -- dev purpose
			if spawnchance == 0 or canSpawnHere == false then
				-- check positions
				local posx = math.random(200,mapsizeX-200)
				local posz = math.random(200,mapsizeZ-200)
				local posy = Spring.GetGroundHeight(posx, posz)
				local posradius = 200
				canSpawnHere = posCheck(posx, posy, posz, posradius)
				if canSpawnHere then
					canSpawnHere = posLosCheck(posx, posy, posz,posradius)
				end
				if canSpawnHere then
					canSpawnHere = posOccupied(posx, posy, posz, posradius)
				end
				--spawn units
				if canSpawnHere then
					Spring.Echo("Spawning Scav Group")
					local groupsize = (((n)+#Spring.GetAllUnits())*spawnmultiplier*teamcount)/(#Spring.GetAllyTeamList())
					if Spring.GetGameSeconds() < 450 then
						spawnunit = T0Units[math.random(1,#T0Units)]
					elseif Spring.GetGameSeconds() >= 450 and Spring.GetGameSeconds() < 900 then
						spawnunit = T1Units[math.random(1,#T1Units)]
					elseif Spring.GetGameSeconds() >= 900 and Spring.GetGameSeconds() < 1800 then
						spawnunit = T2Units[math.random(1,#T2Units)]
					elseif Spring.GetGameSeconds() >= 1800 then
						spawnunit = T3Units[math.random(1,#T3Units)]
					end
					
					local cost = UnitDefNames[spawnunit].metalCost*40
					local groupsize = math.ceil(groupsize/cost)
					Spring.CreateUnit(BonusUnits[math.random(1,#BonusUnits)], posx+math.random(-groupsize*10,groupsize*10), posy, posz+math.random(-groupsize*10,groupsize*10), math.random(0,3),GaiaTeamID)
					for i=1, groupsize do
						Spring.CreateUnit(spawnunit, posx+math.random(-groupsize*10,groupsize*10), posy, posz+math.random(-groupsize*10,groupsize*10), math.random(0,3),GaiaTeamID)
					end
					if devswitch == 1 then
						Spring.Echo("Spawned Scavenger group: " ..groupsize.. " " ..UnitDefNames[spawnunit].humanName.. "s")
					end
				end
			end
			--move idle units
			local scavengerunits = Spring.GetTeamUnits(GaiaTeamID)
			if scavengerunits then
				for i = 1,#scavengerunits do
					local scav = scavengerunits[i]
					local scavDef = Spring.GetUnitDefID(scav)
					local scavStructure = UnitDefs[scavDef].isBuilding
					-- if UnitDefs[scavDef].name == "cormaw" or UnitDefs[scavDef].name == "armclaw" or UnitDefs[scavDef].name == "cornanotc" or UnitDefs[scavDef].name == "armnanotc" then
						-- scavStructure = true
					-- end
					if not scavStructure and n%900 == 0 then
						if dx[scav] then
							olddx[scav] = dx[scav]
						end
						if dy[scav] then
							olddy[scav] = dy[scav]
						end
						if dz[scav] then
							olddz[scav] = dz[scav]
						end
						dx[scav],dy[scav],dz[scav] = Spring.GetUnitPosition(scav)
						if (olddx[scav] and olddy[scav] and olddz[scav]) and (olddx[scav] > dx[scav]-10 and olddx[scav] < dx[scav]+10) and (olddy[scav] > dy[scav]-10 and olddy[scav] < dy[scav]+10) and (olddz[scav] > dz[scav]-10 and olddz[scav] < dz[scav]+10) then
							Spring.DestroyUnit(scav, true, false)
							selfdestructcounter = selfdestructcounter + 1
						end
					end
					if not scavStructure and Spring.GetCommandQueue(scav, 0) <= 1 then
						local nearest = Spring.GetUnitNearestEnemy(scav, 200000, false)
						local x,y,z = Spring.GetUnitPosition(nearest)
						local x = x + math.random(-50,50)
						local z = z + math.random(-50,50)
						Spring.GiveOrderToUnit(scav, CMD.FIGHT,{x,y,z}, {})
					end
				end
				if selfdestructcounter and selfdestructcounter > 0 and devswitch == 1 then
					Spring.Echo("Self Destructed "..selfdestructcounter.." Scavenger units.")
					selfdestructcounter = 0
				end
			end
		end
	end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
	if unitTeam == GaiaTeamID then
		dx[unitID] = nil
		dy[unitID] = nil
		dz[unitID] = nil
		olddx[unitID] = nil
		olddy[unitID] = nil
		olddz[unitID] = nil
	end
end
