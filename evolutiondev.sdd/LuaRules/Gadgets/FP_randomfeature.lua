function gadget:GetInfo()
return {
	name      = "random feature",
	desc      = "Spawns random stuff based on a table.",
	author    = "lurker, smoth",
	date      = "july, 2009",
	license   = "public domain",
	layer     = 0,
	enabled   = true  --  loaded by default?
	}
end

if (gadgetHandler:IsSyncedCode()) then

local spawnertypes ={}
local spawnerDefs = {}
local spawnList = {}

	if VFS.FileExists("LuaRules/Configs/randomfeatures.lua") then
	spawnertypes = VFS.Include("LuaRules/Configs/randomfeatures.lua")
		else
		error("missing file: LuaRules/Configs/randomfeatures.lua")
	end

	for spawnName,spawnDef in pairs(spawnertypes) do
		if UnitDefNames[spawnName] then 
			spawnerDefs[UnitDefNames[spawnName].id] = spawnDef 
		end
	end

	function gadget:UnitFinished(unitID, unitDefID, unitTeam)
		if spawnerDefs[unitDefID] then
			spawnList[unitID] = unitDefID
		end
	end

	function gadget:GameFrame()
	local featurecount
		for unitID,unitDefID in pairs(spawnList) do
		
		featurecount = tonumber(#spawnerDefs[unitDefID]) - 1
		
			local x,y,z		= Spring.GetUnitBasePosition(unitID)
			local selector	= math.random(featurecount) + 1
			local team		= Spring.GetUnitTeam(unitID)
			local wreckName	= spawnerDefs[unitDefID][selector]
			
			--Spring.Echo(wreckName, x, y, z, 0, ally)
			local newGuy = Spring.CreateFeature(wreckName, x, y, z, 0, team)
			Spring.DestroyUnit(unitID, false, true)
		end
		
		spawnList = {}
	end

end