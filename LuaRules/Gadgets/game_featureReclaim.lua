function gadget:GetInfo()
  return {
    name      = "Reset Reclaim amounts",
    desc      = "Sets all map features to 10 energy and 0 metal",
    author    = "Tobi and Nemo, based on a bit by lurker, Reformed by Forboding Angel",
    date      = "December, 2008",
    license   = "public domain",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

if gadgetHandler:IsSyncedCode() then
-- SYNCED

	-- The code below mimics Spring's internal reclaiming code, with the major
	-- difference that no resources are ever added to anyone's storage.
	-- Author: Tobi Vollebregt

	local reclaimLeft = {}
	local SpawnCEG = Spring.SpawnCEG
	local GetFeaturePosition = Spring.GetFeaturePosition	

	function gadget:AllowFeatureBuildStep(builderID, builderTeam, featureID, featureDefID, part)
		-- 2009/09/01: 10x faster reclaim (hence 0.1), 110 sec for standard tree seems tad bit much
		reclaimLeft[featureID] = (reclaimLeft[featureID] or 0.1) + part
		if (reclaimLeft[featureID] <= 0) then
			Spring.DestroyFeature(featureID)
			--Spring.AddTeamResource(builderTeam, "e", 10)
			local fx, fy, fz = GetFeaturePosition(featureID)
			Spring.PlaySoundFile("sounds/miscfx/reclaimed.wav", 0.5, fx, fy, fz)
			SpawnCEG("sparklegreenplus10energy", fx, fy, fz)
		end
		return false
	end

	function gadget:FeatureDestroyed(featureID, allyTeam)
		reclaimLeft[featureID] = nil
	end
end