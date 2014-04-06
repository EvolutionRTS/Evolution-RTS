--example call order
--		local colorSets				= GetColorSets()
--		local pigments, finishes	= BuildPaintBucketsAndFinishes(colorSets)
--		-- add these as reference to the colorset.
--		table.merge(colorSets, pigments)
--		table.merge(colorSets, finishes)
		
--		GG.colors 				= BuildColorSets(colorSets)		
--		GG.bucketSelections 	= SetupBuckets(pigments, finishes)


local spGetTeamList			= Spring.GetTeamList
local spGetPlayerList		= Spring.GetPlayerList
local spGetPlayerInfo		= Spring.GetPlayerInfo

local sideDataFile		= VFS.Include("gamedata/sidedata.lua")
-- look ups for shader
local finishVarients		= { gloss = 1.0, standard = 0.2, matte = 0.01,}

local SWAGTheme				= "default"
local pigmentTypes			= {	"paintR", "paintG", "paintB", "paintA"}
local finishTypes			= {	"sheenR", "sheenG", "sheenB", "sheenA"}
local matrixTypes			= {	"projectionMatrix1", "projectionMatrix2"} 
local projectionTextureTypes	= {	"projectionTexture1", "projectionTexture2",
								"projectionGlmode1", "projectionGlmode2"} 
local bucketTypes			= { "sheenR", "sheenG", "sheenB", "sheenA", 
								"paintR", "paintG", "paintB", "paintA",
								"projectionTexture1", "projectionTexture2",
								"projectionMatrix1", "projectionMatrix2",
								"projectionGlmode1", "projectionGlmode2",}

local playerSchemeSelections = {}

-- prints a copy of a table to chat
local function recursiveTableReader(currTable, dashes)
	dashes = dashes .. dashes
	if type(currTable) == 'table' then
		for k,v in pairs(currTable) do
			if (v ~= nil) then
				Spring.Echo(dashes .. "[" .. tostring(k) .. "]")
				recursiveTableReader(v, dashes)
			end
		end
	else
		if (currTable ~= nil) then
			Spring.Echo(dashes .. tostring(currTable) )
		end
	end
end


function HandleSchemeAssignment(teamID, mergedSchemes, newChoice)
	local currentColorScheme
	local _,playerID,_,isAiTeam = Spring.GetTeamInfo(teamID)
	
	if newChoice then
		schemeSelection = newChoice			
	end
			
	if mergedSchemes[schemeSelection] then
		currentColorScheme = schemeSelection
	else-- we have a selection but it doesn't exist anyway
		currentColorScheme	= SWAGTheme
	end

	return currentColorScheme
end
							
local function AddReverseLookup(tableVariable)
	for k,v in pairs(tableVariable)do
		tableVariable[v]	= k
	end
end

-----------------------------------------------------------
-- Retrieves pigmentTypes table
-----------------------------------------------------------
function GetPigmentTypes()
	return pigmentTypes
end
								
-----------------------------------------------------------
-- Retrieves projectionTextures table
-----------------------------------------------------------
function GetFinishTypes()
	return finishTypes
end

-----------------------------------------------------------
-- Retrieves matrixTypes table
-----------------------------------------------------------
function GetMatrixTypes()
	return matrixTypes
end

-----------------------------------------------------------
-- Retrieves projectionTextureTypes table
-----------------------------------------------------------
function GetprojectionTextureTypes()
	return projectionTextureTypes
end

-----------------------------------------------------------
-- Retrieves theme we all get name
-----------------------------------------------------------
function GetSWAGScheme()
	return SWAGTheme
end

-----------------------------------------------------------
-- Retrieves buckeTypes table
-- has reverse lookup
-----------------------------------------------------------
function GetBucketTypes()
	AddReverseLookup(bucketTypes)
	return bucketTypes
end

-----------------------------------------------------------
-- Retrieves the scheme selections of each player 
-----------------------------------------------------------
function GetPlayerSchemeSelection()
	-- if the list has nothing in it so far, build a list
	if #playerSchemeSelections < 1 then
		for _, teamID in ipairs(spGetTeamList()) do	
			playerSchemeSelections[teamID] = SWAGTheme	
			--Spring.Echo(teamID,  SWAGTheme)
		end
	end
	return playerSchemeSelections
end

-----------------------------------------------------------
-- Retrieves the scheme selections of each player 
-----------------------------------------------------------
function AlterPlayerSchemeSelection(teamID, mergedSchemes, selection)
	selection = HandleSchemeAssignment(teamID, mergedSchemes, selection)
	playerSchemeSelections[teamID] = selection
	return selection
end



local function PrepColor(currentTable, currentName, currentColor, nameIsLookUp, topText)
	local displayNameBuilt
	
	if type(topText) ~= "string" then
		displayNameBuilt = currentName
	else			
		displayNameBuilt = topText .. "\n" .. currentName
		currentName		 = topText .. "_" .. currentName
	end
	
	if nameIsLookUp then
		currentTable[currentName]	= currentColor
	else		
		currentTable[#currentTable+1] = { 	name = currentName,
											colors = currentColor,
											displayName = displayNameBuilt,}
	end									
end

-- builds out color pigment types
local function ProcessPigments(colorValues, pigmentTable, nameIsLookUp)
	--Spring.Echo(colorValues.color, colorValues.name)
	currentColor = colorValues.color

	PrepColor(pigmentTable, colorValues.name, currentColor, nameIsLookUp)

end

-- builds out specular finish color types
local function ProcessFinishes(colorValues, finishTable, nameIsLookUp)
	--Spring.Echo(colorValues.color, colorValues.name)
	for finishName, finishIntensity in pairs(finishVarients)do		
		local currentName	= colorValues.name .. "_" .. finishName
		local colorsRGBA	= {	colorValues.color[1],	colorValues.color[2], 
								colorValues.color[3],	finishIntensity,}
		
		PrepColor(finishTable, currentName, colorsRGBA, nameIsLookUp)
	end
end


-- convert to argb with 0-255 instead of 0-1
local function ARGBMe(vals)
	local convertedVals = {}
	
	convertedVals[1] = math.floor(vals[4]*255)
	convertedVals[2] = math.floor(vals[1]*255)
	convertedVals[3] = math.floor(vals[2]*255)
	convertedVals[4] = math.floor(vals[3]*255)
	
	local convertedString = string.char(convertedVals[1], convertedVals[2], 
										convertedVals[3], convertedVals[4])
	--Spring.Echo(convertedString)
	return convertedString
end


-----------------------------------------------------------
-- Retrieve matrix types from config files
--		Builds Matrix Reference table in 
--		col major instead of rowmajor
-----------------------------------------------------------
function ProcessMatrices()
	local matricesRowMajor	= VFS.Include("gamedata/configs/matrices.lua")
	
	local matricesColMajor	= {}
	local matrixTransforms	= {}
	
	for name, vals in pairs(matricesRowMajor)do
	
	matricesColMajor[name]=	{	vals[1],	vals[2],	vals[3],	vals[4], 
								vals[5],	vals[6],	vals[7],	vals[8], 
								vals[9],	vals[10],	vals[11],	vals[12], 
								vals[13],	vals[14],	vals[15],	vals[16],}	
	end
	
	for matrixName,vals in pairs(matricesRowMajor) do
		-- transform from row major to column major for gl
		matrixTransforms[matrixName] = matrixName
	end
	return matricesColMajor, matrixTransforms
end

-----------------------------------------------------------
-- Retrieve colorsets from config files
--		combines colors.lua and custom_colors.lua
-----------------------------------------------------------
function GetColorSets()
	local colors 		= VFS.Include("gamedata/configs/colors.lua")
	-- load custom colors 
	local customColors	= VFS.Include("gamedata/configs/custom_colors.lua")

	local colorCount = #colors
	for id, values	in pairs (customColors) do
		if values.name == nil then
			colors[id]	= {}
			colors[id]	= values
		else
			colorCount = colorCount + 1
			colors[colorCount]	= values	
		end
	end
	return colors
end

--this will be run per scheme
function BuildDefaults(baseScheme)
	local defaultSets	= {}
	defaultSets[SWAGTheme]		= baseScheme.default
	
	for id, sideTable in pairs(sideDataFile) do
		local factionSchemeName = "default_" .. string.lower(sideTable.name)
		if baseScheme[factionSchemeName] ~= nil then
			defaultSets[factionSchemeName]		= baseScheme[factionSchemeName]
		else
			defaultSets[factionSchemeName]		= defaultSets[SWAGTheme]
		end
	end
	return defaultSets
end

-----------------------------------------------------------
-- Build out color sets in: 
--		ARGB(0-255, 0-255, 0-255) 
--			-- used for chat text
--		RGBA(0-1, 0-1, 0-1)
-- 			-- used for everything else
-----------------------------------------------------------
function BuildColorSets(colors)
	local colorSets				= {}
	colorSets["uiSets_rgba"]	= {}
	colorSets["uiSets_argb"]	= {}

	for id, sideTable in pairs(sideDataFile) do
		local faction	= string.upper(sideTable.name)
		
		local rgbaName	= "uiSets_rgba"
		local argbName	= "uiSets_argb"
		colorSets[rgbaName][faction] = {}
		colorSets[argbName][faction] = {}
			
		for subName,subVals in pairs(sideTable.uiSets) do
			local argbVersion = ARGBMe(subVals)	
			colorSets[rgbaName][faction][subName] = {}
			colorSets[argbName][faction][subName] = {}
				
			colorSets[rgbaName][faction][subName] = subVals
			colorSets[argbName][faction][subName] = argbVersion
		end
	end
	
	for colorSetName,vals in pairs(colors) do
		--Spring.Echo(colorSetName,vals)		
		local rgbaName	=	colorSetName .. "_rgba"
		local argbName	=	colorSetName .. "_argb"
		
		-- we already created this earlier
		if colorSetName ~= "uiSets" then 
			colorSets[rgbaName]	= {}
			colorSets[argbName]	= {}
		end
		
		if (colorSetName == "uiSets") then
			for factionName, subItems in pairs(vals) do
				if colorSets[rgbaName][factionName] == nil then
					colorSets[rgbaName][factionName] = {}
					colorSets[argbName][factionName] = {}
				end
				
				for subName,subVals in pairs(subItems) do
					local argbVersion = ARGBMe(subVals)	

					colorSets[rgbaName][factionName][subName] = {}
					colorSets[argbName][factionName][subName] = {}
					
					colorSets[rgbaName][factionName][subName] = colors[colorSetName][factionName][subName]
					colorSets[argbName][factionName][subName] = argbVersion

				end
			end
		elseif (colorSetName == "resource" or colorSetName == "damageclass") then
			for subName,subVals in pairs(vals) do
				local argbVersion = ARGBMe(subVals)

				colorSets[rgbaName][subName] = {}
				colorSets[argbName][subName] = {}
				
				colorSets[rgbaName][subName] = colors[colorSetName][subName]
				colorSets[argbName][subName] = argbVersion
				
			end
		elseif (vals.name ~= nil) then
			currentColor = vals.color
			--local	argbVersion =						
					colorSets[rgbaName] = nil
					colorSets[argbName] = nil
					rgbaName	=	vals.name .. "_rgba"
					argbName	=	vals.name .. "_argb"
					
			colorSets[rgbaName] = currentColor
			colorSets[argbName] = ARGBMe(currentColor)
		end
	end
	
	return colorSets
end

-- utility functions
-- replace with built in spring code in the untilities.lua of spring.
local function AddSubDir(dir, fileType, files)
	--Spring.Echo(files)
	if fileType ~= nil then
		for _,file in ipairs(VFS.DirList(dir, fileType)) do
			local index = #files + 1
			
			files[index] = {}
			files[index].file = file
			files[index].dir = dir
			
			--Spring.Echo("file found", file, "directory", dir)
		end

		for _,sd in ipairs(VFS.SubDirs(dir)) do
			AddSubDir(sd, fileType, files)
		end
	end	
	return files
end

local function FileSearch(startingDir, fileType)
	files = {}
	files = AddSubDir(startingDir, fileType, files)
	return files
end
		
-- f you lua, this should be a feature.
-- create custom utilities file to supplant spring one
-- add this and recursive table reader.
local function TableCopy(theTable)
	local newTable = {}
	for key, value in pairs(theTable) do
		newTable[key] = value
	end
	return newTable
end
-- end utility functions

-----------------------------------------------------------
-- Sets material for unit
-----------------------------------------------------------
-- old function, may delete later
-- function ProcessBucketSetting(	bucketValue, defaultValue, referenceTable, 
								-- selection, selectionByName, unitName)
	-- colorValue = bucketValue
	-- if colorValue == nil or colorValue == "" then
		-- colorValue = defaultValue
	-- end
	
	-- if referenceTable[colorValue] then
		-- selection			= referenceTable[colorValue]
		-- selectionByName		= colorValue
	-- else
		-- if referenceTable[colorValue] ~= nil then
			-- Spring.Echo("!!WARNING!! " .. name .. " " .. colorValue .. 
						-- " is an invalid color. Replacing it with: " .. 
						-- defaultValue)
		-- end
		-- selection			= referenceTable[defaultValue]
		-- selectionByName		= defaultValue

	-- end

	-- return selection, selectionByName
-- end

-----------------------------------------------------------
-- Sets material for unit
-- returns table[bucketname][values,names]
-----------------------------------------------------------
function ProcessBucketSetting(	name, baseScheme, defaultScheme, 
								bucketName, referenceTableList, bucketTypeID)
	--Spring.Echo(name, baseScheme, defaultScheme, 
	--			bucketName, referenceTable)
	--Spring.Echo(name, bucketName)
	
	-- Specify that this bucketName will be a table
	local bucketValue		= baseScheme[bucketName]
	local defaultValue		= defaultScheme[bucketName]
	local referenceTable	= referenceTableList[bucketTypeID]
	local massagedValues	= {}
	local massagedName		= {}
	
	--Spring.Echo(bucketTypeID)
	-- pull current bucketName from baseScheme if nil then default will be used
	if referenceTable ~= nil then
		if (bucketValue == nil or referenceTable[bucketValue] == nil) then 
			bucketValue = {}
			bucketValue = defaultValue
		end

		if referenceTable[bucketValue] == nil and defaultValue ~= nil then
			--Spring.Echo("    defaultValue", defaultValue, "referenceTable", referenceTable[bucketValue])

			--Spring.Echo("!!WARNING!! " .. name .. ", setting: " .. bucketValue .. 
			--			" is an invalid. Replacing it with, setting: " .. 
			--			defaultValue)
			bucketValue = defaultValue
		end
		--Spring.Echo(bucketName, bucketValue, referenceTable[bucketValue])
		massagedValues	= referenceTable[bucketValue]
		massagedName	= bucketValue
	else
		if (bucketValue == nil) then 
			bucketValue = {}
			bucketValue = defaultValue
		end
		massagedValues	= bucketValue
		massagedName	= bucketValue
	end

	--recursiveTableReader(massagedValues, " ")
	--Spring.Echo(massagedName, massagedValues)
	return massagedName, massagedValues 
end

function BuildPaintSchemes(pigments, finishes, matrixTransforms, referenceTableList, bucketTypesList)
	--recursiveTableReader(referenceTableList, "*")

	--table to hold the loaded scheme information
	local paintSchemes	= {}
	--table to hold the new merged scheme information
	local mergedSchemes	= {}	
	
	local paintJobFilesLocation	= "gamedata/configs/paintjobs/"
	local paintJobFiles			= FileSearch(paintJobFilesLocation, '*.lua') 
	
	-- create defaultPaintJob Table from paintSchemes.currentColorScheme.default. table
	-- use in storing the default values for the paintjobs
	local defaultPaintJob = {}

	--capture each file in allPaintJobSelections
	for _, fullPath in pairs(paintJobFiles) do
		local fileName	= string.gsub(fullPath.file, fullPath.dir, "")
		local skinSet	=  string.gsub(string.gsub(fullPath.dir, paintJobFilesLocation, ""), "/", "")
		fileName = string.gsub(fileName, ".lua", "")
		fileName = string.lower(fileName)
		local currentPaintJob = VFS.Include(fullPath.file)
		
		--make sure we created a table for this skinset
		if paintSchemes[skinSet] == nil then
			paintSchemes[skinSet]	= {}
		end
		
		paintSchemes[skinSet][string.lower(fileName)] = currentPaintJob
	end	
	
	for schemeSet, paintJobName in	pairs(paintSchemes)do
		if schemeSet ~= "" then
			--create empty scheme table
			local baseScheme			= paintSchemes[schemeSet]
			mergedSchemes[schemeSet]		= {	["values"]		= {},
												["names"]		= {},
												["defaults"]	= {}, }		
			-- defaults stuff											
			mergedSchemes[schemeSet]["defaults"] = BuildDefaults(baseScheme)
			local defaultScheme = {}	
			
			-- build each scheme for each unit
			for unitDefId, untDefsTable in pairs(UnitDefs) do	
				-- make sure I have a bucket tex
				if (untDefsTable.customParams and untDefsTable.customParams.buckettex)then					
					local factionName		= nil
					local schemeDefault		= baseScheme.default
					--add subtable for unitDefId
					local unitName			= untDefsTable.name						
					
					mergedSchemes[schemeSet].names[unitDefId]		= {}				
					mergedSchemes[schemeSet].values[unitDefId]	= {}
					
					--add sub tables for all bucket types
					for bucketTypeID, bucketTypes in pairs (bucketTypesList) do
						for _, bucketName in pairs (bucketTypes) do
							mergedSchemes[schemeSet].names[unitDefId][bucketName]		= {}				
							mergedSchemes[schemeSet].values[unitDefId][bucketName]	= {}
						end
					end
					-- if the unit is assigned to a faction, it may have a faction default
					factionName = untDefsTable.customParams.factionname
					
					-- set the faction default where available
					if factionName ~= nil and baseScheme["default_" .. factionName] then
						defaultScheme	= baseScheme["default_" .. factionName]
					else
						defaultScheme	= schemeDefault
					end
		
					-- if we have a scheme for the unit, lets assign any missing values 
					-- and validate the scheme selections	
					for bucketTypeID, bucketTypes in pairs (bucketTypesList) do
						--itterate through the different buckettypes
		
						--local referenceTable = referenceTableList[bucketTypeID]

						for _, bucketName in pairs (bucketTypes) do
							-- shortcut to current unit
							local unitSchemeValues	= mergedSchemes[schemeSet].names[unitDefId][bucketName]
							local unitSchemeNames	= mergedSchemes[schemeSet].values[unitDefId][bucketName]
							if baseScheme[unitName] ~= nil then
								mergedSchemes[schemeSet].names[unitDefId][bucketName], 
								mergedSchemes[schemeSet].values[unitDefId][bucketName] = 
								ProcessBucketSetting(	unitName, baseScheme[unitName], defaultScheme, 
														bucketName, referenceTableList, bucketTypeID)
							else
								mergedSchemes[schemeSet].names[unitDefId][bucketName], 
								mergedSchemes[schemeSet].values[unitDefId][bucketName] = 
								ProcessBucketSetting(	unitName, defaultScheme, defaultScheme, 
														bucketName, referenceTableList, bucketTypeID)	
							end
						end
					end	
				end
			end
		end
	end

	--recursiveTableReader(mergedSchemes, " ")
	return mergedSchemes
end

-----------------------------------------------------------
-- Store material data on a per-unitdef basis
--		sets bucket values for:
--			color pigment
--			specular finish
--			texture
--			transformation matrices
-----------------------------------------------------------
function SetupSchemes(pigments, finishes)

	local _,matrixTransforms		= ProcessMatrices()
	local bucketTypesList			= {	pigmentTypes, finishTypes,
										projectionTextureTypes,	matrixTypes,}

	local referenceTableList		= {	pigments, finishes, }
										--matrixTransforms,}
									
	--get our paintjob settings.
	mergedSchemes 			= BuildPaintSchemes(pigments, finishes, matrixTransforms, 
													referenceTableList, bucketTypesList)
	return mergedSchemes 
end
-----------------------------------------------------------
-- Store material data on a per-unitdef basis
--		sets bucket values for:
--			color pigment
--			specular finish
--			texture
--			transformation matrices
-----------------------------------------------------------
function SetupBuckets(mergedSchemes, schemeTable)

	local selectionsCollection		= {}	
	local selectionsByName			= {}
	
	local currentColorScheme	= SWAGTheme
	
	for _, teamID in ipairs(spGetTeamList()) do	
		currentColorScheme = HandleSchemeAssignment(teamID, mergedSchemes)
		--Spring.Echo(currentColorScheme)
		selectionsCollection[teamID]	= {}
		selectionsByName[teamID]		= {}
		local selectedScheme = mergedSchemes[currentColorScheme]
		
		-- itterate through all units for this player.
		-- Note: don't limit it to only units for that player's faction only, 
		-- player may .take units at a later time. You want to opimize this, DON'T!
		for unitDefId, untDefsTable in pairs(UnitDefs) do
			-- if the current unit has a scheme let's set that puppy!
			local unitName = untDefsTable.name
			if selectedScheme and selectedScheme.values[unitDefId] ~= nil then
				selectionsCollection[teamID][unitDefId]	= {}
				selectionsByName[teamID][unitDefId]		= {}
				
				local	bucketPaintjob	= {}
				
				-- create shortcut to current table entry
				selectionsCollection[teamID][unitDefId] = selectedScheme.values[unitDefId]
				selectionsByName[teamID][unitDefId] = selectedScheme.names[unitDefId]
			end
		end
	end
	--recursiveTableReader(selectionsCollection, "+")
	return selectionsCollection, selectionsByName
end

-----------------------------------------------------------
-- builds out tables for color pigment and specular finish
--		
-----------------------------------------------------------
function BuildPaintBucketsAndFinishes(colors, nameIsLookUp)
	local pigments			= {}
	local finishes			= {}
	for colorSetName,vals in pairs(colors) do

		if vals.name ~= nil then
			ProcessPigments(colors[colorSetName], pigments, nameIsLookUp)
			if vals.notfinish ~= true then
				ProcessFinishes(colors[colorSetName], finishes, nameIsLookUp)
			end
		end
	end
	return pigments, finishes
end


function CreateColorLookup(colorTable)
	local lookupTable	= {}
	
	for tableId, tableValues in pairs(colorTable)do
		lookupTable[tableValues.name]	= tableId
	end
	
	return lookupTable
end