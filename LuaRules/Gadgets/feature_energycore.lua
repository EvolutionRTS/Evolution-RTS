function gadget:GetInfo()
  return {
    name      = "Energy core handler",
    desc      = "",
    author    = "Floris",
    date      = "November 2017",
    license   = "",
    layer     = 0,
    enabled   = false  --  loaded by default?
  }
end


if (gadgetHandler:IsSyncedCode()) then

	local energycoreDefID = FeatureDefNames['ammobox'].id

	function gadget:FeatureCreated(featureID, allyTeamID)
		if Spring.GetFeatureDefID(featureID) == energycoreDefID then
			Spring.SetFeatureRotation(featureID,0,math.random()*360,0)
            Spring.SetFeatureRotation(featureID,1,(math.random()-0.5)*320,0)
            Spring.SetFeatureRotation(featureID,0,math.random()*360,1)			
		end
	end
end
