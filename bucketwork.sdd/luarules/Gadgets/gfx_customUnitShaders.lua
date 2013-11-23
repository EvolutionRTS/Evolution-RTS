-- $Id$
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 
--	author:	jK
--
--	Copyright (C) 2008,2009,2010.
--	Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
	return {
		name		= "CustomUnitShaders",
		desc		= "allows to override the engine unit shader",
		author		= "jK",
		date		= "2008,2009,2010",
		license		= "GNU GPL, v2 or later",
		layer		= 1,
		enabled		= true	--	loaded by default?
	}
end

VFS.Include('gamedata/libs/ShaderAndColorUtilities.lua')

local spEcho			= Spring.Echo
local spGetUnitDefID	= Spring.GetUnitDefID
local spGetUnitHealth	= Spring.GetUnitHealth


-- prints a copy of a table to chat
local function recursiveTableReader(currTable, dashes)
	dashes = dashes .. "   "
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
	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Synced
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------	
if (gadgetHandler:IsSyncedCode()) then

	function gadget:RecvLuaMsg(msg, playerID)
		if (msg:sub(1,12) == 'selectscheme') then
			local newChoice = msg:sub(13)
			local _,_,_,teamID = Spring.GetPlayerInfo(playerID)
			
			GG.playerSchemeSelections[teamID] = AlterPlayerSchemeSelection(teamID, GG.mergedSchemes, newChoice)
			SendToUnsynced("sendRefreshSchemes", GG.playerSchemeSelections[teamID], teamID)
		end
	end
	
	function gadget:UnitFinished(unitID,unitDefID,teamID)
		SendToUnsynced("unitshaders_finished", unitID, unitDefID,teamID)
	end

	function gadget:UnitDestroyed(unitID,unitDefID,teamID)
		SendToUnsynced("unitshaders_destroyed", unitID, unitDefID,teamID)
	end

	function gadget:UnitReverseBuild(unitID,unitDefID,teamID)
		SendToUnsynced("unitshaders_reverse", unitID, unitDefID,teamID)
	end

	function gadget:UnitGiven(unitID,unitDefID,teamID)
		SendToUnsynced("unitshaders_given", unitID, unitDefID,teamID)
	end

	function gadget:UnitCloaked(unitID,unitDefID,teamID)
		SendToUnsynced("unitshaders_cloak", unitID, unitDefID,teamID)
	end

	function gadget:UnitDecloaked(unitID,unitDefID,teamID)
		SendToUnsynced("unitshaders_decloak", unitID, unitDefID,teamID)
	end

	--// block first try, so we have enough time to disable the lua UnitRendering
	--// else the model would be invisible for 1 gameframe
	local blockFirst = {}
	
	function gadget:AllowUnitBuildStep(builderID, builderTeam, unitID, unitDefID, part)
		if (part < 0) then
			local inbuild = not select(3,Spring.GetUnitIsStunned(unitID))
			if (not inbuild) then
				gadget:UnitReverseBuild(unitID,unitDefID,Spring.GetUnitTeam(unitID))
				if (not blockFirst[unitID]) then
					blockFirst[unitID] = true
					return false
				end
			end
		else
			blockFirst[unitID] = nil
		end
		return true
	end

	function gadget:GameFrame()
		--spEcho("gameframe synced")
		for i,uid in ipairs(Spring.GetAllUnits()) do
			if not select(3,Spring.GetUnitIsStunned(uid)) then --// inbuild?
				gadget:UnitFinished(uid,Spring.GetUnitDefID(uid),Spring.GetUnitTeam(uid))
			end
		end
		gadgetHandler:RemoveCallIn('GameFrame')
	end

else	
	-- Unsynced

	VFS.Include("LuaRules/UnitRendering.lua")

	if (not gl.CreateShader) then
		Spring.Echo('Your system does not support Lua Unit Shaders, missing gl.CreateShader')
		return false
	end
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	local shadows = false
	local advShading = false
	local normalmapping = false
	
	local unitMaterialInfos,bufMaterials = {},{}
	local materialDefs		= {}
	local loadedTextures	= {}
	local drawUnitList		= {}
	local materialList		= {}
	local materialNames		= {}
	
	GG.bufMaterials			= bufMaterials
	GG.unitMaterialInfos	= unitMaterialInfos
	GG.materialDefs			= materialDefs
	GG.loadedTextures		= loadedTextures
	GG.drawUnitList			= drawUnitList
	GG.materialList			= materialList
	GG.materialNames		= materialNames
	
	--so I don't have to query for unit team each draw frame

	local unitTeamLookUp	= {}

	-- used for later quick lookup on scheme change. 
	-- otherwise we would have to itterate through all existing units
	local teamUnitLookUp	= {}

	
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	local _plugins = nil
	local function InsertPlugin(str)
		--str = str:upper()
		return (_plugins and _plugins[str]) or ""
	end


	local function CompileShader(shader, definitions, plugins)
		shader.vertexOrig	 = shader.vertex
		shader.fragmentOrig = shader.fragment
		shader.geometryOrig = shader.geometry

		--// insert small pieces of code named `plugins`
		--// this way we can use a basic shader and add some simple vertex animations etc.
		do
			if (plugins) then
				_plugins = plugins
			end

			if (shader.vertex)
				then shader.vertex	 = shader.vertex:gsub("%%%%([%a_]+)%%%%", InsertPlugin); end
			if (shader.fragment)
				then shader.fragment = shader.fragment:gsub("%%%%([%a_]+)%%%%", InsertPlugin); end
			if (shader.geometry)
				then shader.geometry = shader.geometry:gsub("%%%%([%a_]+)%%%%", InsertPlugin); end

			_plugins = nil
		end

		--// append definitions at top of the shader code
		--// (this way we can modularize a shader and enable/disable features in it)
		if (definitions or shadows) then
			definitions = definitions or {}
			definitions = table.concat(definitions, "\n")
			if (shadows) then
				definitions = definitions .. "\n" .. "#define use_shadows" .. "\n"
			end
			if (shader.vertex)
				then shader.vertex = definitions .. shader.vertex; end
			if (shader.fragment)
				then shader.fragment = definitions .. shader.fragment; end
			if (shader.geometry)
				then shader.geometry = definitions .. shader.geometry; end
		end

		local GLSLshader = gl.CreateShader(shader)
		local errorLog = gl.GetShaderLog()
		if (errorLog and errorLog~= "") then
			Spring.Echo("Custom Unit Shaders:", errorLog)
		end

		shader.vertex	 = shader.vertexOrig
		shader.fragment = shader.fragmentOrig
		shader.geometry = shader.geometryOrig

		return GLSLshader
	end


	local function CompileMaterialShaders()
		for _,mat_src in pairs(materialDefs) do
			if (mat_src.shaderSource) then
				local GLSLshader = CompileShader(mat_src.shaderSource, mat_src.shaderDefinitions, mat_src.shaderPlugins)

				if (GLSLshader) then
					if (mat_src.shader) then
						gl.DeleteShader(mat_src.shader)
					end
					--FOR THE LOVE OF GOD DO THIS BETTER
					mat_src.shader					= GLSLshader
					mat_src.cameraLoc				= gl.GetUniformLocation(GLSLshader,"camera")
					mat_src.cameraInvLoc			= gl.GetUniformLocation(GLSLshader,"cameraInv")
					mat_src.cameraPosLoc			= gl.GetUniformLocation(GLSLshader,"cameraPos")
					mat_src.shadowMatrixLoc			= gl.GetUniformLocation(GLSLshader,"shadowMatrix")
					mat_src.shadowParamsLoc			= gl.GetUniformLocation(GLSLshader,"shadowParams")
					--SS sonPos but no sunDiffuse? why?
					mat_src.sunLoc					= gl.GetUniformLocation(GLSLshader,"sunPos")
					--SS color system uniforms
					mat_src.paintR					= gl.GetUniformLocation(GLSLshader,"paintR")
					mat_src.paintG					= gl.GetUniformLocation(GLSLshader,"paintG")
					mat_src.paintB					= gl.GetUniformLocation(GLSLshader,"paintB")
					mat_src.paintA					= gl.GetUniformLocation(GLSLshader,"paintA")
					mat_src.sheenR					= gl.GetUniformLocation(GLSLshader,"sheenR")
					mat_src.sheenG					= gl.GetUniformLocation(GLSLshader,"sheenG")
					mat_src.sheenB					= gl.GetUniformLocation(GLSLshader,"sheenB")
					mat_src.sheenA					= gl.GetUniformLocation(GLSLshader,"sheenA")
					mat_src.projectionMatrix1		= gl.GetUniformLocation(GLSLshader,"projectionMatrix1")
					mat_src.projectionMatrix2		= gl.GetUniformLocation(GLSLshader,"projectionMatrix2")
					--SERIOUSLY, FUCK EVERYTHING ABOUT THIS
				end
			end
		end
	end


	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	function GetUnitMaterial(matInfo, materialName, unitDefID, teamID)
		local mat = bufMaterials[teamID][unitDefID]

		if (mat) then
			--Spring.Echo("unit has material")
			return mat
		end
		--Spring.Echo("GetUnitMaterial materialName", matInfo[1])
		mat 				= materialDefs[materialName]
		matInfo.UNITDEFID	= unitDefID
		

		--// find unitdef tex keyword and replace it
		--// (a shader can be just for multiple unitdefs, so we support this keywords)
		local texUnits = {}
		for texid,tex in pairs(mat.texunits or {}) do
			local tex_ = tex
			for varname,value in pairs(matInfo) do
				tex_ = tex_:gsub("%%"..tostring(varname),value)
			end
			texUnits[texid] = {tex=tex_, enable=false}
			--Spring.Echo('TexUnits',to_string(tex_))
		end

		--// materials don't load those textures themselves
		if (texUnits[1]) then
			local texdl = gl.CreateList(function()
				for _,tex in pairs(texUnits) do
					local prefix = tex.tex:sub(1,1)
					if	 (prefix~="%") 
						and(prefix~="#")
						and(prefix~="!")
						and(prefix~="$")
					then
						gl.Texture(tex.tex)
						loadedTextures[#loadedTextures+1] = tex.tex
					end
				end
				end)
			gl.DeleteList(texdl)
		end

		local luaMat = Spring.UnitRendering.GetMaterial("opaque",{
										 shader				= mat.shader,
										 cameraposloc		= mat.cameraPosLoc,
										 cameraloc			= mat.cameraLoc,
										 camerainvloc		= mat.cameraInvLoc,
										 shadowloc			= mat.shadowMatrixLoc,
										 shadowparamsloc	= mat.shadowParamsLoc,
										 usecamera			= mat.usecamera,
										 culling			= mat.culling,
										 texunits			= texUnits,
										 prelist			= mat.predl,
										 postlist			= mat.postdl,
									 })

		bufMaterials[teamID][unitDefID] = luaMat

		return luaMat
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	function ToggleShadows()
		shadows = Spring.HaveShadows()

		CompileMaterialShaders()

		bufMaterials = {}

		local units = Spring.GetAllUnits()
		for _,unitID in pairs(units) do
			local unitDefID = Spring.GetUnitDefID(unitID)
			local teamID		= Spring.GetUnitTeam(unitID)
			UnitDestroyed(nil,unitID)
			Spring.UnitRendering.DeactivateMaterial(unitID,3)
			if not select(3,Spring.GetUnitIsStunned(unitID)) then --// inbuild?
				UnitFinished(nil,unitID,unitDefID,teamID)
			end
		end
	end


	function ToggleAdvShading()
		advShading = Spring.HaveAdvShading()

		if (not advShading) then
			--// unload all materials
			drawUnitList = {}

			local units = Spring.GetAllUnits()
			for _,unitID in pairs(units) do
				Spring.UnitRendering.DeactivateMaterial(unitID,3)
			end
		elseif (normalmapping) then
			--// reinitializes all shaders
			ToggleShadows()
		end
	end


	function ToggleNormalmapping(_,_,_, playerID)
		if (playerID ~= Spring.GetMyPlayerID()) then
			return
		end

		normalmapping = not normalmapping
		Spring.SetConfigInt("NormalMapping", (normalmapping and 1) or 0)
		Spring.Echo("Set NormalMapping to " .. tostring((normalmapping and 1) or 0))

		
		if (not normalmapping) then
			--// unload normalmapped materials
			local units = Spring.GetAllUnits()
			for _,unitID in pairs(units) do
				local unitDefID = Spring.GetUnitDefID(unitID)
				local unitMat = unitMaterialInfos[teamID][unitDefID]
				if (unitMat) then
					local mat = materialDefs[unitMat[1]]
					if (not mat.force) then
						gadget:UnitDestroyed(unitID,unitDefID)
					end
				end
			end
		elseif (advShading) then
			--// reinitializes all shaders
			ToggleShadows()
		end
	end


	local n = -1
	function gadget:Update()
		--spEcho('gfx_gadget:Update()')
		if (n<Spring.GetDrawFrame()) then
			n = Spring.GetDrawFrame() + Spring.GetFPS()

			if (advShading ~= Spring.HaveAdvShading()) then
				ToggleAdvShading()
			elseif (advShading)and(normalmapping)and(shadows ~= Spring.HaveShadows()) then
				ToggleShadows()
			end
		end
	end 

	function ProcessUnitMaterial(unitID, unitDefID, teamID)
		local unitDef	= UnitDefs[unitDefID]

		local unitMat = unitMaterialInfos[teamID][unitDefID]
		if (unitMat) then
			unitTeamLookUp[unitID] = teamID
			teamUnitLookUp[teamID][unitID] = true
			
			local materialName = materialNames[teamID][unitDefID] 
			-- if we do NOT have a material name already stored, set the default.
			if (materialName == nil) then
				materialName = unitMat[1]
			end

			--Spring.Echo("ProcessUnitMaterial materialName", materialName)
			local currentMaterial = materialDefs[materialName]		

			if (normalmapping or currentMaterial.force) then
				-- various settings and utility functions related to the material
				local unitMaterialList	=	materialList[teamID][unitDefID]
				-- current scheme selected by the player. 
				local schemeSelection	=	GG.playerSchemeSelections[teamID]
				-- userdata table preped by GetMaterial
				local processedMaterial	=	GetUnitMaterial(unitMat,materialName,unitDefID,teamID)
				
				Spring.UnitRendering.ActivateMaterial(unitID,3)
				Spring.UnitRendering.SetMaterial(unitID,3,"opaque",processedMaterial)
				for pieceID in ipairs(Spring.GetUnitPieceList(unitID) or {}) do
					Spring.UnitRendering.SetPieceList(unitID,3,pieceID)
				end

				if (currentMaterial.PrepUnit) then
					materialList[teamID][unitDefID]	= currentMaterial.PrepUnit(unitDefID, teamID)
				end
				
				if (currentMaterial.GetTexUnitValues) then					
					materialList[teamID][unitDefID]["GetTexUnitValues"]			= currentMaterial.GetTexUnitValues
				end
				
				if (currentMaterial.GetMaterialSelections) then					
					materialList[teamID][unitDefID]["GetMaterialSelections"]	= currentMaterial.GetMaterialSelections
				end
				
				if (currentMaterial.DrawUnit) then
					local materialSelections 
					materialSelections	= GG.mergedSchemes[schemeSelection].values[unitDefID]
					--Spring.Echo("Setting unit material for: ", unitID, mat)
					Spring.UnitRendering.SetUnitLuaDraw(unitID,true)
					drawUnitList[unitID] = currentMaterial
				end

				if (currentMaterial.UnitCreated) then
					currentMaterial.UnitCreated(unitID, currentMaterial, 3)
				end
			end
		end
	end
	
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------							
	function gadget:UnitFinished(unitID,unitDefID,teamID)
		
		if	unitTeamLookUp[unitID] then
			local oldTeamID	= unitTeamLookUp[unitID]
			-- remove the old entry
			teamUnitLookUp[oldTeamID][unitID] = nil
			-- clear this guy out
			removeUnitMaterials(unitID)
			-- process material
			ProcessUnitMaterial(unitID, unitDefID, teamID)
		else
			-- brand new unit at brand new id~
			ProcessUnitMaterial(unitID, unitDefID, teamID)
		end
	end
	
	function removeUnitMaterials(unitID) 
		Spring.UnitRendering.DeactivateMaterial(unitID,3) 

		local mat = drawUnitList[unitID]
		--Spring.Echo("removing unit material for: ", unitID, mat)
		if (mat) then
			local teamID = unitTeamLookUp[unitID]
			if (mat.UnitDestroyed) then
				mat.UnitDestroyed(unitID, 3)
			end
			drawUnitList[unitID] = nil
			teamUnitLookUp[teamID][unitID] = nil
		end

	end
	
	function gadget:UnitDestroyed(unitID,unitDefID)
	--	removeUnitMaterials(unitID)
	end


	function gadget:DrawUnit(unitID, DrawMode)
		local mat				= drawUnitList[unitID]
		local teamID			= unitTeamLookUp[unitID]
		local unitDefID			= spGetUnitDefID(unitID)
		local materialSettings	= materialList[teamID][unitDefID]

		if (mat) then
			--Spring.Echo("drawing unit material for: ", unitID, mat)			
			return mat.DrawUnit(unitID, mat, DrawMode, teamID, materialSettings)
		end
	end

	gadget.UnitReverseBuild = gadget.UnitDestroyed
	gadget.UnitCloaked	 = gadget.UnitDestroyed
	gadget.UnitDecloaked = gadget.UnitFinished

	function gadget:UnitGiven(...)
		gadget:UnitDestroyed(...)
		gadget:UnitFinished(...)
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	local function tmerge(tout,tin)
		for i,v in pairs(tin) do
			if (not tout[i]) then
				tout[i] = v
			end
		end
	end

	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	--// Workaround: unsynced LuaRules doesn't receive Shutdown events
	Shutdown = Script.CreateScream()
	Shutdown.func = function()
		--// unload textures, so the user can do a `/luarules reload` to reload the normalmaps
		for i=1,#loadedTextures do
			gl.DeleteTexture(loadedTextures[i])
		end
	end

	function RefreshUnitSchemes(_, playerSchemeSelection, teamID)
		for unitID,v in pairs(teamUnitLookUp[teamID])do
			if v then
				local unitDefID = spGetUnitDefID(unitID)

				if bufMaterials[teamID][unitDefID] then
					bufMaterials[teamID][unitDefID] = nil
				end
				ProcessUnitMaterial(unitID, unitDefID, teamID)
			end
		end
		
	end

	function gadget:Initialize()
		--spEcho("gameframe unsyncd init")
		--// check user configs

		gadgetHandler:AddSyncAction("sendRefreshSchemes", RefreshUnitSchemes)
		shadows = Spring.HaveShadows()
		advShading = Spring.HaveAdvShading()
		normalmapping = (Spring.GetConfigInt("NormalMapping", 1)>0)

		--// load the materials config files
		local unitMaterialDefs = {}
		do
			local GADGET_DIR = "LuaRules/Configs/"
			local MATERIALS_DIR = GADGET_DIR .. "UnitMaterials/"

			local files = VFS.DirList(MATERIALS_DIR)
			table.sort(files)

			for i=1,#files do
				local mats, unitMats = VFS.Include(files[i])
				tmerge(materialDefs, mats)
				tmerge(unitMaterialDefs, unitMats)
			end
		end

		--// process the materials (compile shaders, load textures, ...)
		do
			for materialName, materialTable in pairs(materialDefs) do
				--Spring.Echo("material process ----------------- " .. materialName)
				if (materialTable.shader)and (materialTable.shader ~= "3do")and(materialTable.shader ~= "s3o") then
					materialTable.shaderSource = materialTable.shader 
					materialTable.shader = nil
				end
			end

			CompileMaterialShaders()
			for _, teamID in ipairs(Spring.GetTeamList())do
				unitMaterialInfos[teamID]	= {}
				materialList[teamID]	= {}
				materialNames[teamID]	= {}
				bufMaterials[teamID]	= {}

				teamUnitLookUp[teamID]	= {}
				local currentTeamDefs	= unitMaterialDefs[teamID]
				for unitName,materialInfo in pairs(currentTeamDefs) do
				--Spring.Echo("material def process -----------------")
					if (type(materialInfo) ~= "table") then
						materialInfo = {materialInfo}
					end
					unitMaterialInfos[teamID][(UnitDefNames[unitName] or {id=-1}).id] = materialInfo
				end
			end
		end
		--// Initialize the trim colors for each team
		
		--Spring.Echo(to_string(Spring.GetPlayerList()))
		pl=Spring.GetPlayerList()

		--// insert synced actions
		gadgetHandler:AddSyncAction("unitshaders_finished", UnitFinished)
		gadgetHandler:AddSyncAction("unitshaders_destroyed", UnitDestroyed)
		gadgetHandler:AddSyncAction("unitshaders_reverse", UnitReverseBuild)
		gadgetHandler:AddSyncAction("unitshaders_given", UnitGiven)
		gadgetHandler:AddSyncAction("unitshaders_cloak", UnitCloaked)
		gadgetHandler:AddSyncAction("unitshaders_decloak", UnitDecloaked)
		gadgetHandler:AddChatAction("normalmapping", ToggleNormalmapping)
	end

	function to_string(data, indent)
			local str = ""

			if(indent == nil) then
					indent = 0
			end

			-- Check the type
			if(type(data) == "string") then
				str = str .. ("	"):rep(indent) .. data .. "\n"
			elseif(type(data) == "number") then
				str = str .. ("	"):rep(indent) .. data .. "\n"
			elseif(type(data) == "boolean") then
				if(data == true) then
					str = str .. "true"
				else
					str = str .. "false"
				end
			elseif(type(data) == "table") then
				local i, v
				for i, v in pairs(data) do
					-- Check for a table in a table
					if(type(v) == "table") then
						str = str .. ("	"):rep(indent) .. i .. ":\n"
						str = str .. to_string(v, indent + 2)
					else
						str = str .. ("	"):rep(indent) .. i .. ": " .. to_string(v, 0)
					end
				end
			elseif 
				(data ==nil) 
			then
			str=str..'nil'
		else
			--print_debug(1, "Error: unknown data type: %s", type(data))
			str=str.. "Error: unknown data type:" .. type(data)
			Spring.Echo('X data type')
		end

		return str
	end
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
end
