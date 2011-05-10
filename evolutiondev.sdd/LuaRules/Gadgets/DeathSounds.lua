function gadget:GetInfo()
	return 
	{
		name = "Death Sounds",
		desc = "Uses Lua to control death sound behavior.",
		author = "Argh",
		date = "March 16th, 2009",
		license = "Public Domain",
		layer = 1,
		enabled = true
	}
end


local GetUnitDefID = Spring.GetUnitDefID
local math_rand = math.random
local GetUnitPosition = Spring.GetUnitPosition
local PlaySoundFile = Spring.PlaySoundFile

local SoldierDeath = {}
local GenericDeath = {}
local BuildingDeath = {}
local NukeDeath = {}

local randomPick = 1
local x,y,z = 0,0,0

local GetUnitNeutral = Spring.GetUnitNeutral
local Gaia = Spring.GetGaiaTeamID()

if (gadgetHandler:IsSyncedCode()) then
-----------------------------------------------SYNCHED
----------------------------------------------------------------
------------------------------------------------------------------------
function gadget:Initialize()
	for ud,_ in pairs(UnitDefs) do
		if UnitDefs[ud].customParams.death_sounds == 'soldier' then
			table.insert(SoldierDeath,ud,1)
		end
		if UnitDefs[ud].customParams.death_sounds == 'generic' then
			table.insert(GenericDeath,ud,1)
		end
		-- if UnitDefs[ud].customParams.death_sounds == 'building' then
			-- table.insert(BuildingDeath,ud,1)
		-- end
		if UnitDefs[ud].customParams.death_sounds == 'nuke' then
			table.insert(NukeDeath,ud,1)
		end
	end
end




function gadget:UnitDestroyed(u, ud, team)
	if SoldierDeath[ud] and GetUnitNeutral(u) == false then
		randomPick = math_rand(1,32)
		x,y,z = GetUnitPosition(u)
		if randomPick == 1 then
			PlaySoundFile("sounds/unitdeath/e1.wav",15, x, y, z )
		elseif randomPick == 2 then
			PlaySoundFile("sounds/unitdeath/e2.wav",15, x, y, z )
		elseif randomPick == 3 then
			PlaySoundFile("sounds/unitdeath/e3.wav",15, x, y, z )
		elseif randomPick == 4 then
			PlaySoundFile("sounds/unitdeath/e4.wav",15, x, y, z )
		elseif randomPick == 5 then
			PlaySoundFile("sounds/unitdeath/e5.wav",15, x, y, z )
		elseif randomPick == 6 then
			PlaySoundFile("sounds/unitdeath/e6.wav",15, x, y, z )
		elseif randomPick == 7 then
			PlaySoundFile("sounds/unitdeath/e7.wav",15, x, y, z )
		elseif randomPick == 8 then
			PlaySoundFile("sounds/unitdeath/e8.wav",15, x, y, z )
		elseif randomPick == 9 then
			PlaySoundFile("sounds/unitdeath/e9.wav",15, x, y, z )
		elseif randomPick == 10 then
			PlaySoundFile("sounds/unitdeath/e10.wav",15, x, y, z )
		elseif randomPick == 11 then
			PlaySoundFile("sounds/unitdeath/e11.wav",15, x, y, z )
		elseif randomPick == 12 then
			PlaySoundFile("sounds/unitdeath/e12.wav",15, x, y, z )
		elseif randomPick == 13 then
			PlaySoundFile("sounds/unitdeath/e13.wav",15, x, y, z )
		elseif randomPick == 14 then
			PlaySoundFile("sounds/unitdeath/e14.wav",15, x, y, z )
		elseif randomPick == 15 then
			PlaySoundFile("sounds/unitdeath/e15.wav",15, x, y, z )
		elseif randomPick == 16 then
			PlaySoundFile("sounds/unitdeath/e16.wav",15, x, y, z )
		elseif randomPick == 17 then
			PlaySoundFile("sounds/unitdeath/e17.wav",15, x, y, z )
		elseif randomPick == 18 then
			PlaySoundFile("sounds/unitdeath/e18.wav",15, x, y, z )
		elseif randomPick == 19 then
			PlaySoundFile("sounds/unitdeath/e19.wav",15, x, y, z )
		elseif randomPick == 20 then
			PlaySoundFile("sounds/unitdeath/e20.wav",15, x, y, z )
		elseif randomPick == 21 then
			PlaySoundFile("sounds/unitdeath/e21.wav",15, x, y, z )
		elseif randomPick == 22 then
			PlaySoundFile("sounds/unitdeath/e22.wav",15, x, y, z )
		elseif randomPick == 23 then
			PlaySoundFile("sounds/unitdeath/e23.wav",15, x, y, z )
		elseif randomPick == 24 then
			PlaySoundFile("sounds/unitdeath/e24.wav",15, x, y, z )
		elseif randomPick == 25 then
			PlaySoundFile("sounds/unitdeath/e25.wav",15, x, y, z )
		elseif randomPick == 26 then
			PlaySoundFile("sounds/unitdeath/e26.wav",15, x, y, z )
		elseif randomPick == 27 then
			PlaySoundFile("sounds/unitdeath/e27.wav",15, x, y, z )
		elseif randomPick == 28 then
			PlaySoundFile("sounds/unitdeath/e28.wav",15, x, y, z )
		elseif randomPick == 29 then
			PlaySoundFile("sounds/unitdeath/e29.wav",15, x, y, z )
		elseif randomPick == 30 then
			PlaySoundFile("sounds/unitdeath/e30.wav",15, x, y, z )
		elseif randomPick == 31 then
			PlaySoundFile("sounds/unitdeath/e31.wav",15, x, y, z )
		elseif randomPick == 32 then
			PlaySoundFile("sounds/unitdeath/e32.wav",15, x, y, z )
		end
	end

	if GenericDeath[ud] and GetUnitNeutral(u) == false and team ~= Gaia or GenericDeath[ud] and team == Gaia then
		randomPick = math_rand(1,32)
		x,y,z = GetUnitPosition(u)
		if randomPick == 1 then
			PlaySoundFile("sounds/unitdeath/e1.wav",15, x, y, z )
		elseif randomPick == 2 then
			PlaySoundFile("sounds/unitdeath/e2.wav",15, x, y, z )
		elseif randomPick == 3 then
			PlaySoundFile("sounds/unitdeath/e3.wav",15, x, y, z )
		elseif randomPick == 4 then
			PlaySoundFile("sounds/unitdeath/e4.wav",15, x, y, z )
		elseif randomPick == 5 then
			PlaySoundFile("sounds/unitdeath/e5.wav",15, x, y, z )
		elseif randomPick == 6 then
			PlaySoundFile("sounds/unitdeath/e6.wav",15, x, y, z )
		elseif randomPick == 7 then
			PlaySoundFile("sounds/unitdeath/e7.wav",15, x, y, z )
		elseif randomPick == 8 then
			PlaySoundFile("sounds/unitdeath/e8.wav",15, x, y, z )
		elseif randomPick == 9 then
			PlaySoundFile("sounds/unitdeath/e9.wav",15, x, y, z )
		elseif randomPick == 10 then
			PlaySoundFile("sounds/unitdeath/e10.wav",15, x, y, z )
		elseif randomPick == 11 then
			PlaySoundFile("sounds/unitdeath/e11.wav",15, x, y, z )
		elseif randomPick == 12 then
			PlaySoundFile("sounds/unitdeath/e12.wav",15, x, y, z )
		elseif randomPick == 13 then
			PlaySoundFile("sounds/unitdeath/e13.wav",15, x, y, z )
		elseif randomPick == 14 then
			PlaySoundFile("sounds/unitdeath/e14.wav",15, x, y, z )
		elseif randomPick == 15 then
			PlaySoundFile("sounds/unitdeath/e15.wav",15, x, y, z )
		elseif randomPick == 16 then
			PlaySoundFile("sounds/unitdeath/e16.wav",15, x, y, z )
		elseif randomPick == 17 then
			PlaySoundFile("sounds/unitdeath/e17.wav",15, x, y, z )
		elseif randomPick == 18 then
			PlaySoundFile("sounds/unitdeath/e18.wav",15, x, y, z )
		elseif randomPick == 19 then
			PlaySoundFile("sounds/unitdeath/e19.wav",15, x, y, z )
		elseif randomPick == 20 then
			PlaySoundFile("sounds/unitdeath/e20.wav",15, x, y, z )
		elseif randomPick == 21 then
			PlaySoundFile("sounds/unitdeath/e21.wav",15, x, y, z )
		elseif randomPick == 22 then
			PlaySoundFile("sounds/unitdeath/e22.wav",15, x, y, z )
		elseif randomPick == 23 then
			PlaySoundFile("sounds/unitdeath/e23.wav",15, x, y, z )
		elseif randomPick == 24 then
			PlaySoundFile("sounds/unitdeath/e24.wav",15, x, y, z )
		elseif randomPick == 25 then
			PlaySoundFile("sounds/unitdeath/e25.wav",15, x, y, z )
		elseif randomPick == 26 then
			PlaySoundFile("sounds/unitdeath/e26.wav",15, x, y, z )
		elseif randomPick == 27 then
			PlaySoundFile("sounds/unitdeath/e27.wav",15, x, y, z )
		elseif randomPick == 28 then
			PlaySoundFile("sounds/unitdeath/e28.wav",15, x, y, z )
		elseif randomPick == 29 then
			PlaySoundFile("sounds/unitdeath/e29.wav",15, x, y, z )
		elseif randomPick == 30 then
			PlaySoundFile("sounds/unitdeath/e30.wav",15, x, y, z )
		elseif randomPick == 31 then
			PlaySoundFile("sounds/unitdeath/e31.wav",15, x, y, z )
		elseif randomPick == 32 then
			PlaySoundFile("sounds/unitdeath/e32.wav",15, x, y, z )
		end
	end

	-- if BuildingDeath[ud] and GetUnitNeutral(u) == false and team ~= Gaia or GenericDeath[ud] and team == Gaia then
		-- randomPick = math_rand(1,16)
		-- x,y,z = GetUnitPosition(u)
		-- if randomPick == 1 then			
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath1.wav",25, x, y, z )
		-- elseif randomPick == 2 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath2.wav",25, x, y, z )
		-- elseif randomPick == 3 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath3.wav",25, x, y, z )
		-- elseif randomPick == 4 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath4.wav",25, x, y, z )
		-- elseif randomPick == 5 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath5.wav",25, x, y, z )
		-- elseif randomPick == 6 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath6.wav",25, x, y, z )
		-- elseif randomPick == 7 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath7.wav",25, x, y, z )
		-- elseif randomPick == 8 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath8.wav",25, x, y, z )
		-- elseif randomPick == 9 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath9.wav",25, x, y, z )
		-- elseif randomPick == 10 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath10.wav",25, x, y, z )
		-- elseif randomPick == 11 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath11.wav",25, x, y, z )
		-- elseif randomPick == 12 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath12.wav",25, x, y, z )
		-- elseif randomPick == 13 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath13.wav",25, x, y, z )
		-- elseif randomPick == 14 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath14.wav",25, x, y, z )
		-- elseif randomPick == 15 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath15.wav",25, x, y, z )
		-- elseif randomPick == 16 then
			-- PlaySoundFile("sounds/deathsounds/Argh_BuildingDeath16.wav",25, x, y, z )
		-- end
	-- end
	
	if NukeDeath[ud] and GetUnitNeutral(u) == false and team ~= Gaia or GenericDeath[ud] and team == Gaia then
		randomPick = math_rand(1,32)
		x,y,z = GetUnitPosition(u)
		if randomPick == 1 then
			PlaySoundFile("sounds/nuke/nuke1.wav",15, x, y, z )
		elseif randomPick == 2 then
			PlaySoundFile("sounds/nuke/nuke2.wav",15, x, y, z )
		elseif randomPick == 3 then
			PlaySoundFile("sounds/nuke/nuke3.wav",15, x, y, z )
		elseif randomPick == 4 then
			PlaySoundFile("sounds/nuke/nuke4.wav",15, x, y, z )
	end
end
end
end
------------------------------------------------------------------------
----------------------------------------------------------------
-----------------------------------------------END