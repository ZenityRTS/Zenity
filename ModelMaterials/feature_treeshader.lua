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

-- All feature defs that contain the string "aleppo" will be affected by it
for id, featureDef in pairs(FeatureDefs) do
  if featureDef.name:find("aleppo") then
    featureMaterials[featureDef.name] = "feature_tree"
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return materials, featureMaterials

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
