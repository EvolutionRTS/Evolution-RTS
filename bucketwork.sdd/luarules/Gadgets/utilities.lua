function gadget:GetInfo()
	return {
		name			= "Utilities for GG",
		desc			= "",
		author			= "Smoth",
		date			= "2012",
		license		 	= "PD",
		layer		 	= -666,
		experimental	= false,
		enabled	 		= true
	}
end

VFS.Include('gamedata/libs/ShaderAndColorUtilities.lua')

local mFloor = math.floor

-- Jk's function taken from chili\headers\util.lua
function table:merge(table2)
  for i,v in pairs(table2) do
    if (type(v)=='table') then
      local sv = type(self[i])
      if (sv == 'table')or(sv == 'nil') then
        if (sv == 'nil') then self[i] = {} end
        table.merge(self[i],v)
      end
    elseif (self[i] == nil) then
      self[i] = v
    end
  end
end

local function GetSideData()
	local sideDataFile		= VFS.Include("gamedata/sidedata.lua")
	local sideData			= {}
	
	for id, sideTable in pairs(sideDataFile) do
		local factionName	= string.lower(sideTable.name)
		sideData[factionName]	= {}
		sideData[id]			= {}
			--Spring.Echo(factionName)
		for key, value in pairs(sideTable)do
			--Spring.Echo("/t", key, value)
			sideData[factionName][string.lower(key)] = value		
			sideData[id][string.lower(key)] = value	
		end		
	end
	
	return sideData
end

if gadgetHandler:IsSyncedCode() then
	--SYNCED
	local colorSets					= GetColorSets()
	local pigments, finishes		= BuildPaintBucketsAndFinishes(colorSets, true)
	
	local mergedSchemes				= SetupSchemes(pigments, finishes)
	local playerSchemeSelections	= GetPlayerSchemeSelection()
	local bucketSelections, bucketSelectionsByName	= SetupBuckets(mergedSchemes)

	GG.SWAGTheme				= GetSWAGScheme()
	GG.colors 					= BuildColorSets(colorSets)
	GG.bucketSelections			= bucketSelections
	GG.bucketSelectionsByName	= bucketSelectionsByName
	GG.mergedSchemes			= mergedSchemes
	GG.playerSchemeSelections	= playerSchemeSelections
	GG.recursiveTableReader		= recursiveTableReader
	GG.bucketSelections			= bucketSelections
	GG.bucketSelectionsByName	= bucketSelectionsByName
	GG.sideDataTable			= GetSideData()

else
	local colorSets				= GetColorSets()
	local pigments, finishes	= BuildPaintBucketsAndFinishes(colorSets, true)
	
	
	local mergedSchemes								= SetupSchemes(pigments, finishes)
	local playerSchemeSelections					= GetPlayerSchemeSelection()
	local bucketSelections, bucketSelectionsByName	= SetupBuckets(mergedSchemes)
	
	--recursiveTableReader(bucketSelections, "=")
	--recursiveTableReader(bucketSelectionsByName, "-")
	local matrices, matrixTransforms				= ProcessMatrices()	
	GG.SWAGTheme				= GetSWAGScheme()
	GG.pigments					= pigments
	GG.finishes					= finishes
	GG.matrices					= matrices
	GG.bucketSelections			= bucketSelections
	GG.bucketSelectionsByName	= bucketSelectionsByName
	GG.mergedSchemes			= mergedSchemes
	GG.playerSchemeSelections	= playerSchemeSelections
	GG.colors 					= BuildColorSets(colorSets)		
	GG.recursiveTableReader		= recursiveTableReader
	GG.bucketSelections			= bucketSelections
	GG.bucketSelectionsByName	= bucketSelectionsByName
	
	GG.sideDataTable			= GetSideData()
end