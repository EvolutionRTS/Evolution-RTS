function gadget:GetInfo()
return {
		name = "Feature spread",
		desc = "Feature spread",
		author = "smoth",
		date = "2009-06-30",
		license = "Public Domain",
		layer = 20, --must be greater than 10 (specialability.lua's layer)
		enabled = true
	}
end

local spGetFeaturePosition	=	Spring.GetFeaturePosition
local spFindUnitCmdDesc		=	Spring.FindUnitCmdDesc
local spGetUnitCmdDescs		=	Spring.GetUnitCmdDescs
local spGetModOptions		=	Spring.GetModOptions

local featureplacer
local myTeam
local spawnerList = {}
local randSpawnerList = {}

if (not gadgetHandler:IsSyncedCode() and  (spGetModOptions().comm  ~= "sandbox"  or  spGetModOptions().comm  ~= "feature" )) then
	return
end

function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
	--Spring.Echo(UnitDefNames.goldtree.id,unitID,unitDefID)
	if ( unitDefID and UnitDefNames.goldtree.id == unitDefID ) then
		 featureplacer = unitID
	end
	if ( featureplacer and 	UnitDefs[unitDefID].isFeature) then
		local x,y,z			= Spring.GetUnitBasePosition(unitID)
		local CMDID 		= spFindUnitCmdDesc(featureplacer,458234)
		local spreadMode	= tonumber(spGetUnitCmdDescs(featureplacer, CMDID)[1].params[1])
		local featureName	= string.sub(UnitDefs[unitDefID].name,0,-6)
		local featureID		= FeatureDefNames[featureName].id
		local fFootX		= FeatureDefs[featureID].xsize
		local fFootZ		= FeatureDefs[featureID].zsize
		CMDID 				= spFindUnitCmdDesc(featureplacer,458235)
		
		local jitter		= tonumber(spGetUnitCmdDescs(featureplacer, CMDID)[1].params[1])
		
		if fFootZ < 1 then fFootZ = 1 end
		if fFootX < 1 then fFootX = 1 end
	--Spring.Echo(x,y,z,featureplacer,CMDID,spreadMode,unitID, featureName)

		if ( spreadMode and spreadMode > 0) then
			spawnerList[#spawnerList+1] = { x = x, z = z, fFootX = fFootX, fFootZ = fFootZ, jitter = jitter, spreadMode = spreadMode, name = featureName}
		end
	elseif ( featureplacer and builderID ~= nil and UnitDefs[unitDefID].customParams.factionname == "randm") then
		local x,y,z			= Spring.GetUnitBasePosition(unitID)
		local CMDID 		= spFindUnitCmdDesc(featureplacer,458234)
		local spreadMode	= tonumber(spGetUnitCmdDescs(featureplacer, CMDID)[1].params[1])
		CMDID 				= spFindUnitCmdDesc(featureplacer,458235)
		local jitter		= tonumber(spGetUnitCmdDescs(featureplacer, CMDID)[1].params[1])
		local unitName		= UnitDefs[unitDefID].name
		local uFootX		= UnitDefs[unitDefID].xsize
		local uFootZ		= UnitDefs[unitDefID].zsize
		
		if uFootZ < 1 then uFootZ = 1 end
		if uFootX < 1 then uFootX = 1 end
		
		randSpawnerList[#randSpawnerList+1] = { x = x, z = z, uFootX = uFootX, uFootZ = uFootZ, jitter = jitter, spreadMode = spreadMode, name = unitName, unitTeam = unitTeam}
	end
	
end

local function SpawnFeature(fName, jitterVal, posX, posZ, spacingX, spacingZ, X, Y, Z)
	rSpacingX = math.random(spacingX/4, spacingX + jitterVal)
	rSpacingZ = math.random(spacingZ/4, spacingZ + jitterVal)
	Spring.CreateFeature(fName, posX+ rSpacingX*X , 0, posZ + rSpacingZ*Z,0)
end

local function SpawnUnit(uName, unitTeam, jitterVal, posX, posZ, spacingX, spacingZ, X, Y, Z)
	rSpacingX = math.random(spacingX/4, spacingX + jitterVal)
	rSpacingZ = math.random(spacingZ/4, spacingZ + jitterVal)
	Spring.CreateUnit(uName, posX+ rSpacingX*X , 0, posZ + rSpacingZ*Z,0, unitTeam)
end

function gadget:GameFrame()
	for _,fDef in ipairs(spawnerList) do
	local spacingX
	local spacingZ
	local fName		= fDef.name
	local jitter	= fDef.jitter
	local jitterVal = jitter*32
	local posX		= fDef.x
	local posZ		= fDef.z
	local posY		= 0

		if (fDef.spreadMode == 1) then
			spacingX = fDef.fFootX*8
			spacingZ = fDef.fFootZ*8
		elseif (fDef.spreadMode == 2) then
			spacingX = fDef.fFootX*16
			spacingZ = fDef.fFootZ*16
		end
	
		if (fDef.spreadMode > 0 ) then
			if ( jitter > 0 ) then
				SpawnFeature( fName, jitterVal, posX, posZ, spacingX, spacingZ, 1, 0, 1)
				SpawnFeature( fName, jitterVal, posX, posZ, spacingX, spacingZ, -1, 0, -1)
				SpawnFeature( fName, jitterVal, posX, posZ, spacingX, spacingZ, -1, 0, 1)
				SpawnFeature( fName, jitterVal, posX, posZ, spacingX, spacingZ, 1, 0, -1)
				SpawnFeature( fName, jitterVal, posX, posZ, spacingX, 0, 1, 0, -1)
				SpawnFeature( fName, jitterVal, posX, posZ, spacingX, 0, -1, 0, 1)
				SpawnFeature( fName, jitterVal, posX, posZ, 0, spacingZ, 1, 0, -1)
				SpawnFeature( fName, jitterVal, posX, posZ, 0, spacingZ, -1, 0, 1)
			else
				Spring.CreateFeature(fName, posX + spacingX, posY, posZ + spacingZ,0)
				Spring.CreateFeature(fName, posX + spacingX, posY, posZ - spacingZ,0)
				Spring.CreateFeature(fName, posX - spacingX, posY, posZ + spacingZ,0)
				Spring.CreateFeature(fName, posX - spacingX, posY, posZ - spacingZ,0)
				Spring.CreateFeature(fName, posX - spacingX, posY, posZ,0)
				Spring.CreateFeature(fName, posX + spacingX, posY, posZ,0)
				Spring.CreateFeature(fName, posX, posY, posZ + spacingZ,0)
				Spring.CreateFeature(fName, posX, posY, posZ - spacingZ,0)
			end
		end
	end
	spawnerList = {}
	
	for _,uDef in ipairs(randSpawnerList) do
	local spacingX
	local spacingZ
	local uName		= uDef.name
	local jitter	= uDef.jitter
	local jitterVal = jitter*32
	local posX		= uDef.x
	local posZ		= uDef.z
	local unitTeam	= uDef.unitTeam
	local posY		= 0

		if (uDef.spreadMode == 1) then
			spacingX = uDef.uFootX*8
			spacingZ = uDef.uFootZ*8
		elseif (uDef.spreadMode == 2) then
			spacingX = uDef.uFootX*16
			spacingZ = uDef.uFootZ*16
		end
	
		if (uDef.spreadMode > 0 ) then
			if ( jitter > 0 ) then
				SpawnUnit(uName, unitTeam, jitterVal, posX, posZ, spacingX, spacingZ, 1, 0, 1)
				SpawnUnit(uName, unitTeam, jitterVal, posX, posZ, spacingX, spacingZ, -1, 0, -1)
				SpawnUnit(uName, unitTeam, jitterVal, posX, posZ, spacingX, spacingZ, -1, 0, 1)
				SpawnUnit(uName, unitTeam, jitterVal, posX, posZ, spacingX, spacingZ, 1, 0, -1)
				SpawnUnit(uName, unitTeam, jitterVal, posX, posZ, spacingX, 0, 1, 0, -1)
				SpawnUnit(uName, unitTeam, jitterVal, posX, posZ, spacingX, 0, -1, 0, 1)
				SpawnUnit(uName, unitTeam, jitterVal, posX, posZ, 0, spacingZ, 1, 0, -1)
				SpawnUnit(uName, unitTeam, jitterVal, posX, posZ, 0, spacingZ, -1, 0, 1)
			else
				Spring.CreateUnit(uName, posX + spacingX, posY, posZ + spacingZ,0, unitTeam)
				Spring.CreateUnit(uName, posX + spacingX, posY, posZ - spacingZ,0, unitTeam)
				Spring.CreateUnit(uName, posX - spacingX, posY, posZ + spacingZ,0, unitTeam)
				Spring.CreateUnit(uName, posX - spacingX, posY, posZ - spacingZ,0, unitTeam)
				Spring.CreateUnit(uName, posX - spacingX, posY, posZ,0, unitTeam)
				Spring.CreateUnit(uName, posX + spacingX, posY, posZ,0, unitTeam)
				Spring.CreateUnit(uName, posX, posY, posZ + spacingZ,0, unitTeam)
				Spring.CreateUnit(uName, posX, posY, posZ - spacingZ,0, unitTeam)
			end
		end
	end
	randSpawnerList = {}
end