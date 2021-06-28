--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Automatically generated local definitions
local spGetGameFrame        = Spring.GetGameFrame
local spGetLocalAllyTeamID  = Spring.GetLocalAllyTeamID
local spGetAllyTeamInfo     = Spring.GetAllyTeamInfo
local spGetSelectedUnits    = Spring.GetSelectedUnits
local spGetSpectatingState  = Spring.GetSpectatingState
local spGetUnitAllyTeam     = Spring.GetUnitAllyTeam
local spGetUnitBasePosition = Spring.GetUnitBasePosition
local spGetUnitDefID        = Spring.GetUnitDefID
local spGetUnitHealth       = Spring.GetUnitHealth
local spGetUnitHeight       = Spring.GetUnitHeight
local spGetUnitPosition     = Spring.GetUnitPosition
local spGetUnitTeam         = Spring.GetUnitTeam
local spGetUnitsInCylinder    = Spring.GetUnitsInCylinder
local spSetUnitHealth       = Spring.SetUnitHealth

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
	return {
		name = "Repair",
		desc = "implements repairs",
		author = "KDR_11k (David Becker)",
		date = "2008-06-17",
		license = "Public Domain",
		layer = 1,
		enabled = true
	}
end

local repairUnits= {
	[UnitDefNames.eorb.id] = {radius=1000,strength=1.0},
	[UnitDefNames.eorb_up1.id] = {radius=1000,strength=2.0},
	[UnitDefNames.eorb_up2.id] = {radius=1000,strength=3.0},
	[UnitDefNames.eorb_up3.id] = {radius=1000,strength=4.0},
	[UnitDefNames.ehbotengineer_turret.id] = {radius=1000,strength=2.0},
	[UnitDefNames.ecommanderhealer.id] = {radius=1000,strength=10.0},
	[UnitDefNames.ecommanderbattleai.id] = {radius=1000,strength=5.0},
	[UnitDefNames.ecommanderhealerai.id] = {radius=1000,strength=50.0},
	[UnitDefNames.ecommandershieldai.id] = {radius=1000,strength=10.0},
	[UnitDefNames.ecommandercloakai.id] = {radius=1000,strength=10.0},
	[UnitDefNames.ecommanderbuildai.id] = {radius=1000,strength=20.0},
	[UnitDefNames.ecommanderfactoryai.id] = {radius=1000,strength=20.0},
	[UnitDefNames.zarm.id] = {radius=1000,strength=10.0},
}

local delayAfterHit=150             --Frames after a hit that no repairs will take place in
local regularRepairPerSecond=10    --HP/second restored normally
local loadedRepairPerSecond=.02     --part of maxHP/second restored when loaded

local size = 8 --icon size
local offset = 30 --icon offset

if (gadgetHandler:IsSyncedCode()) then

--SYNCED

local repairers={}
local repairStun={}
local heldBy={}
local repaired={} --just for the displaying

local GetGameFrame=spGetGameFrame
local GetUnitPosition=spGetUnitPosition
local GetUnitTeam=spGetUnitTeam
local GetUnitAllyTeam=spGetUnitAllyTeam
local GetUnitsInCylinder=spGetUnitsInCylinder
local GetUnitHealth = spGetUnitHealth
local SetUnitHealth = spSetUnitHealth
local GetUnitDefID = spGetUnitDefID
local min = math.min

function gadget:UnitFinished(u, ud, team)
	if repairUnits[ud] then
		repairers[u]= {
			holding=nil,
			strength=repairUnits[ud].strength,
			radius=repairUnits[ud].radius,
		}
	end
end

function gadget:UnitDamaged(u, ud, team)
	repairStun[u] = GetGameFrame() + delayAfterHit
end

function gadget:UnitDestroyed(u, ud, team)
	repairers[u]=nil
	repairStun[u]=nil
	repaired[u]=nil
	if heldBy[u] then
		repairers[heldBy[u]].holding=nil
	end
	heldBy[u]=nil
end

function gadget:UnitLoaded(u,ud,team,t)
	if repairers[t] then
		repairers[t].holding=u
	end
end

function gadget:UnitUnloaded(u,ud,team,t)
	if repairers[t] then
		repairers[t].holding=nil
	end
end

function gadget:GameFrame(f)
	if (f+8)%32 < .1 then
		repaired={}
		for u,d in pairs(repairers) do
		
			local x,y,z 		= GetUnitPosition(u)
			local UnitTeam 		= spGetUnitTeam(u)
			local UnitAllyTeam 	= GetUnitAllyTeam(u)
			local inradAllyTeam
			local held 			= d.holding
			local strength		= d.strength
						
			for uis,t in ipairs(GetUnitsInCylinder(x,z,d.radius)) do
				local ud = GetUnitDefID(t)
				if t ~= held and t ~= u then
				
				 	inradAllyTeam = GetUnitAllyTeam(t)					

					
					if ( inradAllyTeam == UnitAllyTeam) then
						-- Spring.Echo("unit can be repaired")
						
						if (not repairStun[t] or repairStun[t]<f) then
							local health, maxHealth=GetUnitHealth(t)
							SetUnitHealth(t,{health=min(health + regularRepairPerSecond * strength *.5, maxHealth)})
							if health < maxHealth then
								repaired[t]=true
								local x,y,z=spGetUnitBasePosition(t)
								if x then
									local h = spGetUnitHeight(t)
									Spring.SpawnCEG("heal", x, y+h, z)
								--	Spring.PlaySoundFile("sounds/miscfx/heal.wav", 0.2, x, y, z) 
								--	Spring.AddTeamResource(UnitTeam,"e",-5)
								end
							end
						end
					-- else
						-- Spring.Echo("unit can not be repaired")
					end
				end
			end
			if held then
				local health, maxHealth=GetUnitHealth(held)
				SetUnitHealth(held,{health=min(health + loadedRepairPerSecond * strength * maxHealth *.5, maxHealth)})
			end
		end
		_G.repaired=repaired
	
	end

	
end

function gadget:Initialize()
	_G.repaired=repaired
end

else

--UNSYNCED

end
