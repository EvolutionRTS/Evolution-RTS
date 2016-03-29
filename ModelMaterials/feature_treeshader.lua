-- $Id$
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local frameLocID

local function DrawFeature(featureID, material)
  if frameLocID == nil then
    frameLocID = gl.GetUniformLocation(material.shader, "frameLoc")
  end
  local factor = 0.001
  local frame = factor * math.sin(math.fmod(featureID, 10) + Spring.GetGameFrame() / (math.fmod(featureID, 7) + 6))
  gl.Uniform(frameLocID, frame)

  --// engine should still draw it (we just set the uniforms for the shader)
  return false
end

local materials = {
   feature_tree = {
      shader    = include("ModelMaterials/Shaders/feature_treeshader.lua"),
      force     = true, --// always use the shader even when normalmapping is disabled
      usecamera = false,
      culling   = GL.BACK,
      texunits  = {
        [0] = '%%FEATUREDEFID:0',
        [1] = '%%FEATUREDEFID:1',
        [2] = '$shadow',
        [3] = '$specular',
        [4] = '$reflection',
      },
      DrawFeature = DrawFeature,
      feature = true, --// This is used to define that this is a feature shader
   },
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- affected unitdefs

local featureMaterials = {}

-- All feature defs that contain the string in ""s will be affected by it
-- Just to point out that this is a shitty, hacky, gawdawful workaround until I can implement customparam category searching

-- Doing it with a table fail: http://pastebin.com/SxPpP44E
for id, featureDef in pairs(FeatureDefs) do

  if featureDef.name:find("bush") then
    featureMaterials[featureDef.name] = "feature_tree"
  
  elseif featureDef.name:find("tree") then
    featureMaterials[featureDef.name] = "feature_tree"
  
  elseif featureDef.name:find("vegetation") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("baobab") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("aleppo") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("pine") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("senegal") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("palm") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("shrub") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("bloodthorn") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("birch") then
    featureMaterials[featureDef.name] = "feature_tree"

  elseif featureDef.name:find("maple") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("oak") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("fern") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("grass") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("weed") then
    featureMaterials[featureDef.name] = "feature_tree"
	
  elseif featureDef.name:find("plant") then
    featureMaterials[featureDef.name] = "feature_tree"
  
  elseif featureDef.name:find("palmetto") then
    featureMaterials[featureDef.name] = "feature_tree" 
  
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return materials, featureMaterials

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
