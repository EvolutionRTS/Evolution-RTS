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
     
-- Destroy features in the build rectangle of new units for blocking features
function gadget:UnitCreated(unitID, unitDefID, teamID, builderID)
	if UnitDefs[unitDefID]["canMove"] == false then
		x,y,z=Spring.GetUnitPosition (unitID)
		local footprintx = UnitDefs[unitDefID]["xsize"] * 4
		local footprintz = UnitDefs[unitDefID]["zsize"] * 4
		featuresToKill = Spring.GetFeaturesInRectangle (x-footprintx,z-footprintz, x+footprintx, z+footprintz)
		for i in pairs(featuresToKill) do
			-- Spring.Echo('featuresToKill :'..featuresToKill [i])
			local fx,fy,fz = Spring.GetFeaturePosition(featuresToKill [i])
			local isGeo = FeatureDefs[Spring.GetFeatureDefID(featuresToKill[i])].name == "geovent"
			if featuresToKill [i] ~= 0 and not isGeo then
				Spring.PlaySoundFile("sounds/reclaimed.wav", 1, fx, fy, fz)
				Spring.SpawnCEG("sparklegreen", fx, fy, fz)
				Spring.DestroyFeature (featuresToKill [i])
			end
		end
	end
end 