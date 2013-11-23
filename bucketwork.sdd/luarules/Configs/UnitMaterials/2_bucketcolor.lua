-- $Id$
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local GetGameFrame		= Spring.GetGameFrame
local GetUnitHealth		= Spring.GetUnitHealth
local GetUnitTeam		= Spring.GetUnitTeam
local spGetUnitDefID	= Spring.GetUnitDefID

local modulo=math.fmod
local glUniform=gl.Uniform
local glUniformMatrix=gl.UniformMatrix
local sine =math.sin
local maximum=math.max

local GADGET_DIR = "LuaRules/Configs/"

--names of buckets that take in just rgba values
local textureJob	= {}

local paintJob		= {	"paintR",
						"paintG",
						"paintB",
						"paintA",}
				
local paintFinish	= {	"sheenR",
						"sheenG",
						"sheenB",
						"sheenA",}

local projectionTextureInfo	= {	"projectionTexture1", 
								"projectionTexture2",
								"projectionGlmode1", 
								"projectionGlmode2"} 
								
local projectionMatrixInfo	= {	"projectionMatrix1", 
								"projectionMatrix2",}
								
-- Begin: material vars				
-- local baseTexUnits = {	[0] = '%%UNITDEFID:0',
						-- [1] = '%%UNITDEFID:1',
						-- [2] = '$shadow',
						-- [3] = '$specular',
						-- [4] = '$reflection',
						-- [5] = '%NORMALTEX',
						-- [6] = '%BUCKETTEX',}
		
-- local baseShaderDefinitions = {	"#define use_perspective_correct_shadows",
								-- "#define use_normalmapping",
								-- "#define use_buckets",}	
-- end: material vars


-- utility functions
-- replace with built in spring code in the untilities.lua of spring.
local function AddSubDir(dir, fileType)
	local files = {}
	if fileType ~= nil then
		for _,file in ipairs(VFS.DirList(dir, fileType)) do
			files[#files + 1] = file
			--Spring.Echo("file found", file)
		end

		for _,sd in ipairs(VFS.SubDirs(dir)) do
			AddSubDir(sd)
		end
	end	
	return files
end

local function FileSearch(startingDir, fileType)
	local files = {}
  
	files = AddSubDir(startingDir, fileType)
  
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

-- get my paint buckets
local paintBucketFileLocation	= "gamedata/configs/paintbuckets/"
local paintBucketFiles			= FileSearch(paintBucketFileLocation, '*.lua') 
local allPaintBucketSelections	= {}

for _, fullPath in pairs(paintBucketFiles) do
	local fileName = string.gsub(fullPath, paintBucketFileLocation, "")
	
	fileName = string.gsub(fileName, ".lua", "")
	fileName = string.lower(fileName)
	local currentPaintBucket = VFS.Include(fullPath)	
	allPaintBucketSelections[string.lower(fileName)] = currentPaintBucket
	--Spring.Echo(allPaintBucketSelections[fileName], "fileName var", fileName)
end
--end get paint buckets

function SetUniforms(color, materialSelection, material)
	if color then
		--Spring.Echo(color, materialSelection, material)
		--Spring.Echo(color[1], color[2], color[3], color[4])
		glUniform(material[materialSelection], color[1], color[2], color[3], color[4])
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

local function GetTexUnitValues(unitDef, unitMaterialSetting)
	local texture		= {}
	local textureRValid = {}
	local glMode		= {}
	local material		= {} 
	
	material["NORMALTEX"] = unitDef.customParams.normalstex
	material["BUCKETTEX"] = unitDef.customParams.buckettex
					
	texture[1]	= unitMaterialSetting["projectionTexture1"]
	texture[2]	= unitMaterialSetting["projectionTexture2"]	
	glMode[1]	= unitMaterialSetting["projectionGlmode1"]
	glMode[2]	= unitMaterialSetting["projectionGlmode2"]
	
	for k,v in pairs(glMode)do
		if v == nil or  v == "" then v = ":n:" end
	end
	
	for k,v in pairs(texture)do
		if v == nil then v = "" end
	end
	
	if (texture[1] ~= "" and texture[2] ~= "") and (texture[1] and texture[2]) then
		material[1]					=	"TR_TG_CB_CA"
		material["PROJECTIONTEX1"]	=	glMode[1] .. texture[1]
		material["PROJECTIONTEX2"]	=	glMode[2] .. texture[2]
	elseif texture[1] ~= "" and texture[1] then
		material[1]					=	"TR_CG_CB_CA"
		material["PROJECTIONTEX1"]	=	glMode[1] .. texture[1]
	elseif texture[2] ~= "" and texture[2] then
		material[1]					=	"CR_TG_CB_CA"
		material["PROJECTIONTEX2"]	=	glMode[2] .. texture[2]
	else
		material[1]					=	"CR_CG_CB_CA"	
	end
	--Spring.Echo("GetTexUnitValues",unitDef,"Material setting: ", material[1])
	return material
end

local function GetMaterialSelections(teamId, unitDefId)
	local materialSetting 	= {}
	local schemeSelection	= GG.playerSchemeSelections[teamId]
	if schemeSelection then
		local myScheme		= GG.mergedSchemes[schemeSelection]

		if schemeSelection ~= "default" and myScheme.values[unitDefId] then
			--Spring.Echo("Current Scheme specified: " .. schemeSelection)
			materialSetting	= myScheme.values[unitDefId]
		else
			materialSetting	= GG.bucketSelections[teamId][unitDefId]
			--Spring.Echo("No color scheme specified using: default")	
		end
		--recursiveTableReader(materialSetting," ")
	end
	return materialSetting
end

local function PrepUnit(unitDefId, teamId)	
	local paint
	local finish
	local currentSelections 	=	{}	
	local materialSelections	=	GetMaterialSelections(teamId, unitDefId)

	if materialSelections then
		for i = 1, 4 do
			paint = paintJob[i]
			finish = paintFinish[i]
			texture = projectionTextureInfo[i]

			currentSelections[paint]	=	materialSelections[paint]
			currentSelections[finish]	=	materialSelections[finish]
			currentSelections[texture]	=	materialSelections[texture]
		end
		-- Spring.Echo(materialSelections["projectionMatrix1"], 
					-- GG.matrices, 
					-- GG.matrices[materialSelections["projectionMatrix1"]])
		for key, value in pairs(projectionMatrixInfo)do
			--Spring.Echo(value, materialSelections[value])
			currentSelections[value]	=	GG.matrices[materialSelections[value]]
		end
	end
	
	
	return currentSelections
end

function SetMatrix(material, materialSettings, name)
	--Spring.Echo(projectionTextureInfo[name], name)
	local vals	=	materialSettings[name]
	
	-- Spring.Echo(material[name],	name,
				-- vals[01], vals[02], vals[03], vals[04], 
				-- vals[05], vals[06], vals[07], vals[08], 
				-- vals[09], vals[10], vals[11], vals[12], 
				-- vals[13], vals[14], vals[15], vals[16])
	if vals then
		glUniformMatrix(material[name],	
						vals[01], vals[02], vals[03], vals[04], 
						vals[05], vals[06], vals[07], vals[08], 
						vals[09], vals[10], vals[11], vals[12], 
						vals[13], vals[14], vals[15], vals[16])
	end
end

local function DrawUnit(unitID, material, DrawMode, teamId, materialSettings)
	if (DrawMode~=0 and DrawMode~=2) then
		for i = 1, 4 do
			SetUniforms(materialSettings[paintJob[i]], paintJob[i], material)
			SetUniforms(materialSettings[paintFinish[i]], paintFinish[i], material)
		end
		--recursiveTableReader(material, " ")
		--local matrix = material["shaderSource"]["uniformMatrix"]
		
		SetMatrix(material, materialSettings, "projectionMatrix1")
		SetMatrix(material, materialSettings, "projectionMatrix2")
	end
	--// engine should still draw it (we just set the uniforms for the shader)
	return false
end

--build materials function until I writing something better.
local function BuildMaterials(material, bucketShaderDefinition)
	local newMaterial	 		=	{}
	
	local newTexUnits			= {	[0] = '%%UNITDEFID:0',
									[1] = '%%UNITDEFID:1',
									[2] = '$shadow',
									[3] = '$specular',
									[4] = '$reflection',
									[5] = '%NORMALTEX',
									[6] = '%BUCKETTEX',}	

	local newShaderDefinitions	= {	"#define use_perspective_correct_shadows",
									"#define use_normalmapping",
									--"#define flip_normalmap",
									"#define use_buckets",}
	
	--TableCopy(baseShaderDefinitions)		
	
	newMaterial["shader"]		= bucketShaderDefinition
	newMaterial["usecamera"]	= false
	newMaterial["culling"]		= GL.BACK
	newMaterial["DrawUnit"]		= DrawUnit
	newMaterial["PrepUnit"]		= PrepUnit
	newMaterial["GetTexUnitValues"]				= GetTexUnitValues
	newMaterial["GetMaterialSelections"]		= GetMaterialSelections
	
	if material == "TR_TG_CB_CA" then
		newShaderDefinitions[#newShaderDefinitions+1] = "#define bucket_1_texture"
		newShaderDefinitions[#newShaderDefinitions+1] = "#define bucket_1_modelcoords"
		newShaderDefinitions[#newShaderDefinitions+1] = "#define bucket_2_texture"
		newShaderDefinitions[#newShaderDefinitions+1] = "#define bucket_2_modelcoords"
		newTexUnits[7] = '%PROJECTIONTEX1'
		newTexUnits[8] = '%PROJECTIONTEX2'
	elseif material == "TR_CG_CB_CA" then
		newShaderDefinitions[#newShaderDefinitions+1] = "#define bucket_1_texture"
		newShaderDefinitions[#newShaderDefinitions+1] = "#define bucket_1_modelcoords"
		newTexUnits[7] = '%PROJECTIONTEX1'
	elseif material == "CR_TG_CB_CA" then
		newShaderDefinitions[#newShaderDefinitions+1] = "#define bucket_2_texture"
		newShaderDefinitions[#newShaderDefinitions+1] = "#define bucket_2_modelcoords"
		newTexUnits[7] = '%PROJECTIONTEX1'
		newTexUnits[8] = '%PROJECTIONTEX2'
	end
	
	newMaterial["texunits"]				= newTexUnits
	newMaterial["shaderDefinitions"]	= newShaderDefinitions
	return newMaterial
end

local bucketShaderDefinition	= include(GADGET_DIR .. "UnitMaterials/Shaders/bucketcolor.lua")	
		
local materials = {	
	CR_CG_CB_CA = BuildMaterials("CR_CG_CB_CA", bucketShaderDefinition),
	TR_CG_CB_CA = BuildMaterials("TR_CG_CB_CA", bucketShaderDefinition),
	CR_TG_CB_CA = BuildMaterials("CR_TG_CB_CA", bucketShaderDefinition),
	TR_TG_CB_CA = BuildMaterials("TR_TG_CB_CA", bucketShaderDefinition),
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Automated normalmap detection

local unitMaterials = {}
for _, teamId in ipairs(Spring.GetTeamList())do
	unitMaterials[teamId] = {}
	for unitDefId, unitDef in pairs(UnitDefs) do
		local schemeSelection	= GG.playerSchemeSelections[teamId]
		--Spring.Echo(unitDef.name,unitDefId)
		--recursiveTableReader(unitDef, "_")
		
		local hasTexture			= false					
		local unitMaterialSetting	= GetMaterialSelections(teamId, unitDefId)

		
		if (unitMaterialSetting and unitDef.customParams.buckettex)then
			if VFS.FileExists(unitDef.customParams.normalstex) and VFS.FileExists(unitDef.customParams.buckettex) then		
				materialDefinition	= GetTexUnitValues(unitDef, unitMaterialSetting)
				
				unitMaterials[teamId][unitDef.name] = materialDefinition
				--Spring.Echo('BUCKETmapping added to unit:' .. unitDef.name)
			else
				if VFS.FileExists(unitDef.customParams.normalstex) == false then
					Spring.Echo('BUCKETmapping could not be added to unit: ' .. unitDef.name)
					Spring.Echo('Normal map texture is missing')
				end
				if VFS.FileExists(unitDef.customParams.buckettex) == false then
					Spring.Echo('BUCKETmapping could not be added to unit: ' .. unitDef.name)
					Spring.Echo('Bucket map texture is missing')
				end
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return materials, unitMaterials

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
