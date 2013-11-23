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

if gadgetHandler:IsSyncedCode() then
	--SYNCED	
	function SetColor(playerID, newColorName, bucketName)
		local unitID		= currentUnitSelection[playerID]
		local unitDefId		= spGetUnitDefId(unitID)
		local teamID        = spGetUnitTeam(unitID)

		local bucketSelection	= GG.bucketSelections[teamID][unitDefId]
		
		bucketSelection[bucketName] = GG.colors[newColorName]
		SendToUnsynced("UpdateColors", currentUnitSelection[playerID], bucketName, newColorName)
	end
	 
	function gadget:RecvLuaMsg(msg, playerID)
		--Spring.Echo(msg)
		if (msg:sub(1,15) == 'selectcolorunit') then
			--Spring.Echo("selectcolorunit", msg:sub(16))
			currentUnitSelection[playerID] = tonumber(msg:sub(16))
			SendToUnsynced("sendMaterialSettings", currentUnitSelection[playerID])
		end

		if (msg:sub(1,16) == 'updateunitcolors') then
			local bucketId 			= tonumber(msg:sub(17,17))
			bucketName				= bucketTypes[bucketId]
			newColorName			= msg:sub(18)
			
			SetColor(playerID, newColorName, bucketName)
		end
		
		if (msg:sub(1,19) == 'updateprojectionTexture') then
			local bucketId 			= tonumber(msg:sub(20,20))
			projectionTextureName		= bucketTypes[bucketId]
			newTextureName			= msg:sub(21)
		end
		
		if (msg:sub(1,12) == 'selectscheme') then
			local newChoice = msg:sub(13)
			local _,_,_,teamId = Spring.GetPlayerInfo(playerID)

			GG.playerSchemeSelections[teamId] = AlterPlayerSchemeSelection(teamId, GG.mergedSchemes, newChoice)
			SendToUnsynced("sendUpdateScheme", GG.playerSchemeSelections[teamId], teamId)
		end
	end	
else	
	function ColorUpdate(_, currentUnitSelection, bucketName, newColorName)
		--Spring.Echo(currentUnitSelection, bucketName, newColorName)
		local teamID        = spGetLocalTeamID()
		--Spring.Echo(teamID, currentUnitSelection)
		local unitDefId					= spGetUnitDefId(currentUnitSelection)
		local bucketSelection			= GG.bucketSelections[teamID][unitDefId]
		local bucketSelectionByName		= GG.bucketSelectionsByName[teamID][unitDefId]
		local bucketId					= bucketTypes[bucketName]
		local colorTable
		
		if bucketId < 4 then
			colorTable		= GG.finishes[newColorName]
		else
			colorTable		= GG.pigments[newColorName]
		end
		
		if colorTable ~= nil then
			bucketSelection[bucketName] = colorTable
			bucketSelectionByName[bucketName] = newColorName
		else
			Spring.Echo("failed to find color: " .. newColorName)
		end
	end
	
	function POSToLuaUIColors(_, currentUnitSelection)
		if (Script.LuaUI('SetUpdateColors')) then
			local teamID			= spGetLocalTeamID()
			local unitDefId			= spGetUnitDefId(currentUnitSelection)
			
			local bucketSelection	= GG.bucketSelectionsByName[teamID][unitDefId]

			--Spring.Echo(bucketSelection, "bucketSelection")
			for bucketName, bucketValue in pairs(bucketSelection)do
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
	-- teamId = team id
	-----------------------------------------------------------	
	function POSToLuaUIScheme(_, playerSchemeSelection, teamId)
		--Spring.Echo(teamId,playerSchemeSelection)
		GG.playerSchemeSelections[teamId] = playerSchemeSelection
		local assignedTexUnitValues	= GG.bufMaterials[teamId] -- needed for when we change to/from materials with textures
		local assignedBuckets		= GG.materialList[teamId]
		-- process each of the units which have
		-- already been assigned colors

		if assignedBuckets then
			for unitDefId,vals in pairs(assignedBuckets) do
				local unitDef	= UnitDefs[unitDefId]

				local materialSelections	=	vals.GetMaterialSelections(teamId, unitDefId)
				local texUnitVals 			=	vals.GetTexUnitValues(unitDef, materialSelections)
				
				GG.unitMaterialInfos[teamId][unitDefId] = nil
				GG.unitMaterialInfos[teamId][unitDefId] = texUnitVals
	
				GG.materialNames[teamId][unitDefId]	= texUnitVals[1]
			end				
		end
		
		if (Script.LuaUI('sendUpdateScheme')) then
			Script.LuaUI.SetUpdateColors(playerSchemeSelection, teamId)
		end
	end
	 
	function gadget:Initialize()
		gadgetHandler:AddSyncAction("UpdateColors", ColorUpdate)
		gadgetHandler:AddSyncAction("sendMaterialSettings", POSToLuaUIColors)
		gadgetHandler:AddSyncAction("sendUpdateScheme", POSToLuaUIScheme)
		
	end

end