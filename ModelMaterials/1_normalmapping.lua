-- $Id$
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function SunChanged(curShaderObj)
	curShaderObj:SetUniformAlways("shadowDensity", gl.GetSun("shadowDensity" ,"unit"))

	curShaderObj:SetUniformAlways("sunAmbient", gl.GetSun("ambient" ,"unit"))
	curShaderObj:SetUniformAlways("sunDiffuse", gl.GetSun("diffuse" ,"unit"))
	curShaderObj:SetUniformAlways("sunSpecular", gl.GetSun("specular" ,"unit"))
	--gl.Uniform(gl.GetUniformLocation(curShader, "sunSpecularExp"), gl.GetSun("specularExponent" ,"unit"))
end



local default_lua = VFS.Include("ModelMaterials/Shaders/default.lua")

local matTemplate = {
		shaderDefinitions = {
			"#define use_normalmapping",
			"#define deferred_mode 0",
			"#define SPECULARMULT 8.0",
		},
		deferredDefinitions = {
			"#define use_normalmapping",
			"#define deferred_mode 1",
			"#define SPECULARMULT 8.0",
		},

		shader    = default_lua,
		deferred  = default_lua,
		usecamera = false,
		culling   = GL.BACK,
		predl  = nil,
		postdl = nil,
		texunits  = {
			[0] = '%%UNITDEFID:0',
			[1] = '%%UNITDEFID:1',
			[2] = '$shadow',
			[4] = '$reflection',
			[5] = '%NORMALTEX',
		},
		-- uniforms = {
		-- }
		--DrawUnit = DrawUnit,
		SunChanged = SunChanged,
}


local materials = {
	normalMappedS3o = Spring.Utilities.CopyTable(matTemplate, true),
	normalMappedS3oFlipped = Spring.Utilities.CopyTable(matTemplate, true),
}

table.insert(materials.normalMappedS3oFlipped.shaderDefinitions, "#define flip_normalmap")
table.insert(materials.normalMappedS3oFlipped.deferredDefinitions, "#define flip_normalmap")

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Automated normalmap detection

local unitMaterials = {}


local function basename(fullpath)
	local _,_,base = fullpath:find("([^\\/:]*)$")
	local _,_,path = fullpath:find("(.*[\\/:])[^\\/:]*$")
	if not path then path = "" end
	if     base then base = base:gsub("%....", "") end
	return base, path
end


local function FindTextureFile(filepath)
	local normaltex

	--// extract basename of a given filepath (e.g. the path of tex1 or tex2)
	local basefilename, basepath = basename(filepath)
	if (tonumber(basefilename:sub(-1,-1))) then
		--// remove trailing numbers (e.g. corcom1.png -> corcom1 -> corcom)
		basefilename = basefilename:sub(1,-2)
	end
	if (basefilename:sub(-1,-1) == "_") then
		--// remove trailing underscores (e.g. corcom_1.png -> corcom_1 -> corcom)
		basefilename = basefilename:sub(1,-2)
	end

	--// check if there is a corresponding _normals.dds file
	for _,dir in ipairs{basepath, "", "unittextures"} do
		local foundFiles = VFS.DirList(dir, basefilename .. "_normals.*")
		if (foundFiles and foundFiles[1]) then
			normaltex = foundFiles[1]
			break
		end
	end

	return normaltex
end


local function FindNormalmapFromModel(modelpath, fileext)
	if not modelpath then
		return
	end

	local normaltex

	if (fileext == "s3o") then
		--// in case of S3O check the model's tex1 & tex2 and use it to find the normalmap
		--// udef.model.textures is empty at gamestart, so read the texture filenames from the s3o directly
		local rawstr  = VFS.LoadFile(modelpath)
		local header  = rawstr:sub(1,60)
		local texPtrs = VFS.UnpackU32(header, 45, 2)

		local tex1,tex2
		if (texPtrs[2] > 0)
			then tex2 = rawstr:sub(texPtrs[2]+1, rawstr:len()-1)
			else texPtrs[2] = rawstr:len() end
		if (texPtrs[1] > 0)
			then tex1 = rawstr:sub(texPtrs[1]+1, texPtrs[2]-1) end

		--// output units without tex2
		if not tex2 then
			Spring.Log(gadget:GetInfo().name, LOG.WARNING, udef.name .. " missing a tex2")
		end

		normaltex = FindTextureFile(tex1) or FindTextureFile(tex2)
	end

	--// all others & fallback use just modelfilename itself to find the normalmap
	return normaltex or FindTextureFile(modelpath)
end





for i=1,#UnitDefs do
	local udef = UnitDefs[i]

	if (udef.customParams.normaltex and VFS.FileExists(udef.customParams.normaltex)) then
		if udef.customParams.normaltex:lower():find(".dds") then
			unitMaterials[udef.name] = {"normalMappedS3o", NORMALTEX = udef.customParams.normaltex}
		else
			unitMaterials[udef.name] = {"normalMappedS3oFlipped", NORMALTEX = udef.customParams.normaltex}
		end

	elseif (udef.model.type ~= "3do") then
		local normaltex = FindNormalmapFromModel(udef.model.path, udef.model.type)
		if normaltex then
			if normaltex:lower():find(".dds") then
				unitMaterials[udef.name] = {"normalMappedS3o", NORMALTEX = normaltex}
			else
				unitMaterials[udef.name] = {"normalMappedS3oFlipped", NORMALTEX = normaltex}
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return materials, unitMaterials

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
