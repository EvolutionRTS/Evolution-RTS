   function gadget:GetInfo()
      return {
        name      = "Engine Hotfixes",
        desc      = "Hotfixes for engine behavior",
        author    = "knorke",
        date      = "July 2011",
        license   = "PD",
        layer     = 0,
        enabled   = true,
      }
    end
     
if (gadgetHandler:IsSyncedCode()) then

-- LOCALIZATIONS GO HERE

-- Destroy features in the build rectangle of new units for blocking features
function gadget:UnitCreated(unitID, unitDefID, teamID, builderID)
   if UnitDefs[unitDefID].speed == 0 then -- unit is probably a building
      local x, y, z = Spring.GetUnitPosition (unitID)
      local footprintX = UnitDefs[unitDefID]["xsize"] * 4
      local footprintZ = UnitDefs[unitDefID]["zsize"] * 4
      local featuresToKill = Spring.GetFeaturesInRectangle (x - footprintX, z - footprintZ, x + footprintX, z + footprintZ)
      for _, featureID in pairs(featuresToKill) do
         local featureDef = FeatureDefs[Spring.GetFeatureDefID(featureID)]
         if not featureDef.geovent then
            local fx,fy,fz = Spring.GetFeaturePosition(featureID)
            Spring.PlaySoundFile("sounds/reclaimed.wav", 1, fx, fy, fz)
            Spring.SpawnCEG("sparklegreen", fx, fy, fz)
            Spring.DestroyFeature (featureID)
         end
      end
   end
end