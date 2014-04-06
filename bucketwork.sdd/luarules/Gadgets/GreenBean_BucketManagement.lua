function gadget:GetInfo()
	return {
		name	= "Bucket Manager",
		desc	= "Manages the bucket settings",
		author	= "Smoth",
		date	= "12-28-2012",
		license = "PD",
		layer	= 0,
		enabled = true
	}
end

VFS.Include('gamedata/libs/ShaderAndColorUtilities.lua')

GG.materialList		= {}
GG.materialNames	= {}
			
local spGetUnitTeam			= Spring.GetUnitTeam
local spGetLocalTeamID		= Spring.GetLocalTeamID
local spGetUnitDefId		= Spring.GetUnitDefID
local colorSets				= GetColorSets()
local bucketTypes			= GetBucketTypes()
local projectionTextureTypes	= GetprojectionTextureTypes()
local currentUnitSelection	= {}

-- reverse look up for bucket types
for k,v in pairs(bucketTypes) do
	bucketTypes[v]=k
end

-- texture that is used when nothing is selected.
local nilTexture			= "notexture.gif"

if gadgetHandler:IsSyncedCode() then
	--SYNCED
	function SetColor(playerID, newColorName, bucketName)
		local unitID		= currentUnitSelection[playerID]
		--Spring.Echo(unitID, playerID, newColorName, bucketName)

		SendToUnsynced("UpdateBucketSettings", currentUnitSelection[playerID], bucketName, newColorName)
	end
	 
	function gadget:RecvLuaMsg(msg, playerID)
		--Spring.Echo("BucketManagement:RecvLuaMsg", msg)
		if (msg:sub(1,15) == 'selectcolorunit') then
			--Spring.Echo("selectcolorunit", msg:sub(16))
			currentUnitSelection[playerID] = tonumber(msg:sub(16))
			SendToUnsynced("sendMaterialSettings", currentUnitSelection[playerID])
		end

		if (msg:sub(1,16) == 'updateunitcolors') then
			local bucketId 			= tonumber(msg:sub(17,17))
			bucketName				= bucketTypes[bucketId]
			newColorName			= msg:sub(18)
			--Spring.Echo("BucketManagement:RecvLuaMsg updateunitcolors", playerID, newColorName, bucketName)
			SetColor(playerID, newColorName, bucketName)
		end
		
		if (msg:sub(1,23) == 'updateprojectionTexture') then
			local bucketId 			= tonumber(msg:sub(24,24))
			bucketName				= bucketTypes[bucketId+8]
			newTextureName			= msg:sub(25)
			SendToUnsynced("UpdateBucketSettings", currentUnitSelection[playerID], bucketName, newTextureName)
		end
		
		if (msg:sub(1,12) == 'selectscheme') then
			local newChoice = msg:sub(13)
			local _,_,_,teamID = Spring.GetPlayerInfo(playerID)

			GG.playerSchemeSelections[teamID] = AlterPlayerSchemeSelection(teamID, GG.mergedSchemes, newChoice)
			SendToUnsynced("sendUpdateScheme", GG.playerSchemeSelections[teamID], teamID)
		end
	end	
	
	function gadget:GameFrame(frameNumber)
		if frameNumber <1 then
			--Spring.Echo("gadget:Initialize", GG.playerSchemeSelections, #GG.playerSchemeSelections)
			for teamID, schemeChoice  in pairs(GG.playerSchemeSelections) do
				if schemeChoice ~= GG.SWAGTheme then
					--Spring.Echo("sendUpdateScheme", schemeChoice, teamID)
					SendToUnsynced("sendUpdateScheme", schemeChoice, teamID)
				end
			end
		end
	end
else
	-- 
	function SettingUpdate(_, currentUnitSelection, bucketName, itemSetting)
		local teamID        = spGetLocalTeamID()
		--Spring.Echo("SettingUpdate()", teamID, currentUnitSelection, bucketName, itemSetting)
		local unitDefID					= spGetUnitDefId(currentUnitSelection)
		local bucketSelection			= GG.bucketSelections[teamID][unitDefID]
		local bucketSelectionByName		= GG.bucketSelectionsByName[teamID][unitDefID]
		local currentMaterialList		= GG.materialList[teamID][unitDefID]
		local bucketId					= bucketTypes[bucketName]
		local colorTable
		
		--Spring.Echo("SettingUpdate()",currentUnitSelection, bucketName, bucketId, bucketId < 4, itemSetting)
		-- if we are a finish
		if bucketId <= 4 then
			colorTable		= GG.finishes[itemSetting]
		-- if we are a color
		elseif bucketId < 9 then
			colorTable		= GG.pigments[itemSetting]
		end

		if colorTable ~= nil then
			--Spring.Echo("SettingUpdate()", bucketName, colorTable, itemSetting)
			bucketSelection[bucketName]			= colorTable
			bucketSelectionByName[bucketName]	= itemSetting
			-- need to update the material list for when I assign a texture
			currentMaterialList[bucketName]		= colorTable
		elseif bucketId <= 10 then -- probably a texture setting
			local bucketSelectionTexture
			if itemSetting == nilTexture then
				bucketSelectionTexture = nil
			else
				bucketSelectionTexture = "bitmaps/detailtextures/" .. itemSetting
			end
			bucketSelection[bucketName] = bucketSelectionTexture
			bucketSelectionByName[bucketName] = bucketSelectionTexture
			
					
			local unitDef				= UnitDefs[unitDefID]
			local materialSelections	= GG.mergedSchemes[GG.playerSchemeSelections[teamID]].values[unitDefID]
			local vals 					= GG.materialList[teamID][unitDefID]
			local texUnitVals			= vals.GetTexUnitValues(unitDef, materialSelections)
							
			GG.unitMaterialInfos[teamID][unitDefID] = nil
			GG.unitMaterialInfos[teamID][unitDefID] = texUnitVals
			GG.materialNames[teamID][unitDefID]		= texUnitVals[1]
			--Spring.Echo(GG.materialNames[teamID][unitDefID], bucketSelection[bucketName],
			--			bucketSelectionByName[bucketName],itemSetting)
		else-- probably a matrix setting
			bucketSelection[bucketName] = itemSetting
			bucketSelectionByName[bucketName] = itemSetting
		end

		--for bucketName, bucketValue in pairs(bucketSelectionByName)do
		--	Spring.Echo("POSToLuaUIColors", bucketName, bucketValue)
		--end
	end
	
	function POSToLuaUIColors(_, currentUnitSelection)
		if (Script.LuaUI('SetUpdateColors')) then
			local teamID			= spGetLocalTeamID()
			local unitDefID			= spGetUnitDefId(currentUnitSelection)
			
			local bucketSelection	= GG.bucketSelectionsByName[teamID][unitDefID]

			
			for bucketName, bucketValue in pairs(bucketSelection)do
				--Spring.Echo("POSToLuaUIColors", bucketName, bucketValue)
				Script.LuaUI.SetUpdateColors(currentUnitSelection, bucketName, bucketValue)
			end	
			
			Script.LuaUI.SetUpdateColors(currentUnitSelection, "1", "done")
		end
	end
	
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

	-----------------------------------------------------------
	-- playerSchemeSelection = color scheme name as string
	-- teamID = team id
	-----------------------------------------------------------	
	function POSToLuaUIScheme(_, playerSchemeSelection, teamID)
		--Spring.Echo("POSToLuaUIScheme playerSchemeSelection", playerSchemeSelection)
		GG.playerSchemeSelections[teamID] = playerSchemeSelection
		local assignedTexUnitValues	= GG.bufMaterials[teamID] -- needed for when we change to/from materials with textures
		-- process each of the units which have
		-- already been assigned colors
		
		local assignedBuckets		= GG.materialList[teamID]
		if  #assignedBuckets  == 0 then
			for unitDefID,v in pairs(UnitDefs) do				
				local unitMat = GG.unitMaterialInfos[teamID][unitDefID]
				if (unitMat) then
					local materialSelections	= GG.mergedSchemes[playerSchemeSelection].values[unitDefID]
					local materialName			= GG.materialNames[teamID][unitDefID]					
					local currentMaterial
					
					if (materialName == nil) then
						materialName = unitMat[1]
					--else
					--	Spring.Echo(UnitDefs[unitDefID].name, "has no scheme setting")		
					end					
					currentMaterial	= GG.materialDefs[materialName]
					
					--Spring.Echo("POSToLuaUIScheme materialName", materialName, currentMaterial, v.name)				
					if (currentMaterial.PrepUnit) then
						GG.materialList[teamID][unitDefID]							= currentMaterial.PrepUnit(unitDefID, teamID)
					end
					
					if (currentMaterial.GetTexUnitValues) then					
						GG.materialList[teamID][unitDefID]["GetTexUnitValues"]		= currentMaterial.GetTexUnitValues
					end
					
					if (currentMaterial.GetMaterialSelections) then					
						GG.materialList[teamID][unitDefID]["GetMaterialSelections"]	= currentMaterial.GetMaterialSelections
					end

				end
			end
		end
		
		--Spring.Echo(#assignedBuckets,#GG.materialList[teamID], "GG.unitMaterialInfos", GG.unitMaterialInfos[teamID])
		for unitDefID,vals in pairs(assignedBuckets) do
			local unitDef	= UnitDefs[unitDefID]
			--Spring.Echo("POSToLuaUIScheme name", unitDef.name)
			local materialSelections	=	vals.GetMaterialSelections(teamID, unitDefID)
			local texUnitVals 			=	vals.GetTexUnitValues(unitDef, materialSelections)
				
			GG.unitMaterialInfos[teamID][unitDefID] = nil
			GG.unitMaterialInfos[teamID][unitDefID] = texUnitVals

			GG.materialNames[teamID][unitDefID]	= texUnitVals[1]
			--Spring.Echo("POSToLuaUIScheme GG.materialNames[teamID][unitDefID]",GG.materialNames[teamID][unitDefID])
		end				
		
		if (Script.LuaUI('sendUpdateScheme')) then
			Script.LuaUI.SetUpdateColors(playerSchemeSelection, teamID)
		end
	end
	 
	function gadget:Initialize()
		gadgetHandler:AddSyncAction("UpdateBucketSettings", SettingUpdate)
		gadgetHandler:AddSyncAction("sendMaterialSettings", POSToLuaUIColors)
		gadgetHandler:AddSyncAction("sendUpdateScheme", POSToLuaUIScheme)
		
	end

end