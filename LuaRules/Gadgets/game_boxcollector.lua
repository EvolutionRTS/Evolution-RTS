function gadget:GetInfo()
   return {
      name = "Box collector",
      desc = "removes box features and gives resources to collecting player",
      author = "MrSpontaneous (ak Pasha Wrangell) with help from JK; fixed by lurker (Dylan Petonke)",
      date = "Nov 11 2007",
      license = "GPL",
      layer = 1,
      enabled = true
   }
end

if (gadgetHandler:IsSyncedCode()) then
---synced----

	local Box="ammobox"
	local Energycore="energycore"
	local chickenEgg="chicken_egg"
	local chickenEggB="chicken_eggb"
	local chickenEggC="chicken_eggc"
	local chickenEggD="chicken_eggd"
	local BoxId
	local EnergyCoreId
	local eggId
	local eggIdB
	local eggIdC
	local eggIdD
	local BoxesOnMap={}
	local EnergycoresOnMap={}
	local eggsOnMap={}
	local eggsOnMapB={}
	local eggsOnMapC={}
	local eggsOnMapD={}
	local unitInRange={}
	local Resources={}
	local SpawnCEG = Spring.SpawnCEG

	function gadget:Initialize()
	BoxId = FeatureDefNames[Box].id
	EnergycoreId = UnitDefNames[Energycore].id
	eggId = FeatureDefNames["chicken_egg"].id
	eggIdB = FeatureDefNames["chicken_eggb"].id
	eggIdC = FeatureDefNames["chicken_eggc"].id
	eggIdD = FeatureDefNames["chicken_eggd"].id
	--Spring.Echo(Box, BoxId)

		ud = Spring.GetAllFeatures ()
		for n,u in pairs(ud) do
			if Spring.GetFeatureDefID(u) == BoxId then
				BoxesOnMap[u] = 1
			end
			if Spring.GetFeatureDefID(u) == eggId then
				eggsOnMap[u] = 1
			end
			if Spring.GetFeatureDefID(u) == eggIdB then
				eggsOnMapB[u] = 1
			end
			if Spring.GetFeatureDefID(u) == eggIdC then
				eggsOnMapC[u] = 1
			end
			if Spring.GetFeatureDefID(u) == eggIdD then
				eggsOnMapD[u] = 1
			end
		end
	end

	ud = Spring.GetAllUnits ()
	for n,u in pairs(ud) do
		if Spring.GetUnitDefID(u) == EnergycoreId then
			EnergycoresOnMap[u] = 1
		end
	end

	function gadget:GameFrame(f)
	--Spring.Echo(eggsOnMap)
		if f%10 == 1 then
			for box,b in pairs(BoxesOnMap) do
				--Spring.Echo("Box")
				--Spring.Echo(BoxesOnMap)
				local x,y,z = Spring.GetFeaturePosition(box)
				local unitsInRange = Spring.GetUnitsInSphere(x,y,z, 500)--at x , y , z with radius 200
				for _,unit in ipairs(unitsInRange) do
					if UnitDefs[Spring.GetUnitDefID(unit)].customParams.energycorecollect and select(5, Spring.GetUnitHealth(unit)) == 1 then
						--local remM, maxM, remE, maxE, left = Spring.GetFeatureResources(box)   --- [1] is metal, [3] is energy
						Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "m", 5)
						Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "e", 5)
						Spring.DestroyFeature(box)
						local fx, fy, fz = Spring.GetFeaturePosition(box)
						Spring.PlaySoundFile("sounds/miscfx/boxcollection.wav", 1, fx, fy, fz)
						SpawnCEG("sparklegreenplus5", fx, fy, fz)
						BoxesOnMap[box] = nil
						break
					end
					if UnitDefs[Spring.GetUnitDefID(unit)].customParams.energycoredronespawner and select(5, Spring.GetUnitHealth(unit)) == 1 then
						Spring.CreateUnit("edrone", x, y, z, 0, Spring.GetUnitTeam(unit))
						Spring.DestroyFeature(box)
						local fx, fy, fz = Spring.GetFeaturePosition(box)
						Spring.PlaySoundFile("sounds/miscfx/energycoredronespawner.wav", 1, fx, fy, fz)
						SpawnCEG("sparkleorangeplus1drone", fx, fy, fz)
						BoxesOnMap[box] = nil
						break
					end
					-- if (UnitDefs[Spring.GetUnitDefID(unit)].customParams.amphibenergycoredronespawner) then
					-- Spring.CreateUnit("eamphibdrone", x, y, z, 0, Spring.GetUnitTeam(unit))
					-- Spring.DestroyFeature(box)
					-- local fx, fy, fz = Spring.GetFeaturePosition(box)
					-- Spring.PlaySoundFile("sounds/miscfx/boxcollection.wav", 1, fx, fy, fz)
					-- SpawnCEG("sparklegreen", fx, fy, fz)
					-- BoxesOnMap[box] = nil
					-- break
					-- end
				end
			end
			for box,b in pairs(EnergycoresOnMap) do
				--Spring.Echo("Box")
				--Spring.Echo(BoxesOnMap)
				local x,y,z = Spring.GetUnitPosition(box)
				local unitsInRange = Spring.GetUnitsInSphere(x,y,z, 500)--at x , y , z with radius 200
				for _,unit in ipairs(unitsInRange) do
					if UnitDefs[Spring.GetUnitDefID(unit)].customParams.energycorecollect and select(5, Spring.GetUnitHealth(unit)) == 1 then
						--local remM, maxM, remE, maxE, left = Spring.GetUnitResources(box)   --- [1] is metal, [3] is energy
						Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "m", 5)
						Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "e", 5)
						Spring.DestroyUnit(box)
						local fx, fy, fz = Spring.GetUnitPosition(box)
						Spring.PlaySoundFile("sounds/miscfx/boxcollection.wav", 1, fx, fy, fz)
						SpawnCEG("sparklegreenplus5", fx, fy, fz)
						BoxesOnMap[box] = nil
						break
					end
					if UnitDefs[Spring.GetUnitDefID(unit)].customParams.energycoredronespawner and select(5, Spring.GetUnitHealth(unit)) == 1 then
						Spring.CreateUnit("edrone", x, y, z, 0, Spring.GetUnitTeam(unit))
						Spring.DestroyUnit(box)
						local fx, fy, fz = Spring.GetUnitPosition(box)
						Spring.PlaySoundFile("sounds/miscfx/energycoredronespawner.wav", 1, fx, fy, fz)
						SpawnCEG("sparkleorangeplus1drone", fx, fy, fz)
						BoxesOnMap[box] = nil
						break
					end
					-- if (UnitDefs[Spring.GetUnitDefID(unit)].customParams.amphibenergycoredronespawner) then
					-- Spring.CreateUnit("eamphibdrone", x, y, z, 0, Spring.GetUnitTeam(unit))
					-- Spring.DestroyUnit(box)
					-- local fx, fy, fz = Spring.GetUnitPosition(box)
					-- Spring.PlaySoundFile("sounds/miscfx/boxcollection.wav", 1, fx, fy, fz)
					-- SpawnCEG("sparklegreen", fx, fy, fz)
					-- BoxesOnMap[box] = nil
					-- break
					-- end
				end
			end
			for chickenEgg,b in pairs(eggsOnMap) do	
				--Spring.Echo("Egg")
				--Spring.Echo(eggsOnMap)
				local eggx,eggy,eggz = Spring.GetFeaturePosition(chickenEgg)
				local unitsInRange = Spring.GetUnitsInSphere(eggx,eggy,eggz, 500)--at x , y , z with radius 200
				for _,unit in ipairs(unitsInRange) do
					if UnitDefs[Spring.GetUnitDefID(unit)].customParams.energycorecollect and select(5, Spring.GetUnitHealth(unit)) == 1 then
						--local remM, maxM, remE, maxE, left = Spring.GetFeatureResources(chickenEgg)   --- [1] is metal, [3] is energy
						Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "m", 5)
						Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "e", 5) 
						Spring.DestroyFeature(chickenEgg)
						local fx, fy, fz = Spring.GetFeaturePosition(chickenEgg)
						Spring.PlaySoundFile("sounds/miscfx/boxcollection.wav", 1, fx, fy, fz)
						SpawnCEG("sparklegreenplus5", fx, fy, fz)
						eggsOnMap[chickenEgg] = nil
					break
					end
				end
			end
			for chickenEggB,b in pairs(eggsOnMapB) do	
				--Spring.Echo("Egg")
				--Spring.Echo(eggsOnMap)
				local eggx,eggy,eggz = Spring.GetFeaturePosition(chickenEggB)
				local unitsInRange = Spring.GetUnitsInSphere(eggx,eggy,eggz, 500)--at x , y , z with radius 200
				for _,unit in ipairs(unitsInRange) do
					if UnitDefs[Spring.GetUnitDefID(unit)].customParams.energycorecollect and select(5, Spring.GetUnitHealth(unit)) == 1 then
						--local remM, maxM, remE, maxE, left = Spring.GetFeatureResources(chickenEggB)   --- [1] is metal, [3] is energy
						Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "m", 5)
						Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "e", 5) 
						Spring.DestroyFeature(chickenEggB)
						local fx, fy, fz = Spring.GetFeaturePosition(chickenEggB)
						Spring.PlaySoundFile("sounds/miscfx/boxcollection.wav", 1, fx, fy, fz)
						SpawnCEG("sparklegreenplus5", fx, fy, fz)
						eggsOnMapB[chickenEggB] = nil
					break
					end
				end
			end
			for chickenEggC,b in pairs(eggsOnMapC) do	
				--Spring.Echo("Egg")
				--Spring.Echo(eggsOnMap)
				local eggx,eggy,eggz = Spring.GetFeaturePosition(chickenEggC)
				local unitsInRange = Spring.GetUnitsInSphere(eggx,eggy,eggz, 500)--at x , y , z with radius 200
				for _,unit in ipairs(unitsInRange) do
					if UnitDefs[Spring.GetUnitDefID(unit)].customParams.energycorecollect and select(5, Spring.GetUnitHealth(unit)) == 1 then
						--local remM, maxM, remE, maxE, left = Spring.GetFeatureResources(chickenEggC)   --- [1] is metal, [3] is energy
						Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "m", 5)
						Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "e", 5) 
						Spring.DestroyFeature(chickenEggC)
						local fx, fy, fz = Spring.GetFeaturePosition(chickenEggC)
						Spring.PlaySoundFile("sounds/miscfx/boxcollection.wav", 1, fx, fy, fz)
						SpawnCEG("sparklegreenplus5", fx, fy, fz)
						eggsOnMapC[chickenEggC] = nil
					break
					end
				end
			end
			for chickenEggD,b in pairs(eggsOnMapD) do	
				--Spring.Echo("Egg")
				--Spring.Echo(eggsOnMap)
				local eggx,eggy,eggz = Spring.GetFeaturePosition(chickenEggD)
				local unitsInRange = Spring.GetUnitsInSphere(eggx,eggy,eggz, 500)--at x , y , z with radius 200
				for _,unit in ipairs(unitsInRange) do
					if UnitDefs[Spring.GetUnitDefID(unit)].customParams.energycorecollect and select(5, Spring.GetUnitHealth(unit)) == 1 then
						--local remM, maxM, remE, maxE, left = Spring.GetFeatureResources(chickenEggD)   --- [1] is metal, [3] is energy
						Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "m", 5)
						Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "e", 5) 
						Spring.DestroyFeature(chickenEggD)
						local fx, fy, fz = Spring.GetFeaturePosition(chickenEggD)
						Spring.PlaySoundFile("sounds/miscfx/boxcollection.wav", 1, fx, fy, fz)
						SpawnCEG("sparklegreenplus5", fx, fy, fz)
						eggsOnMapD[chickenEggD] = nil
					break
					end
				end
			end
		end
	end
   
	function gadget:FeatureDestroyed(featureID, _)
		if (BoxesOnMap[featureID]) then
			BoxesOnMap[featureID] = nil
		end
		if (eggsOnMap[featureID]) then
			eggsOnMap[featureID] = nil
		end
		if (eggsOnMapB[featureID]) then
			eggsOnMapB[featureID] = nil
		end
		if (eggsOnMapC[featureID]) then
			eggsOnMapC[featureID] = nil
		end
		if (eggsOnMapD[featureID]) then
			eggsOnMapD[featureID] = nil
		end
	end
   
	function gadget:FeatureCreated(featureID, allyTeam)
		if (Spring.GetFeatureDefID(featureID) == BoxId) then
			BoxesOnMap[featureID] = 1
		end
		if (Spring.GetFeatureDefID(featureID) == eggId) then
			eggsOnMap[featureID] = 1
		end
		if (Spring.GetFeatureDefID(featureID) == eggIdB) then
			eggsOnMapB[featureID] = 1
		end
		if (Spring.GetFeatureDefID(featureID) == eggIdC) then
			eggsOnMapC[featureID] = 1
		end
		if (Spring.GetFeatureDefID(featureID) == eggIdD) then
			eggsOnMapD[featureID] = 1
		end
	end


	function gadget:UnitDestroyed(unitID, _)
		if (EnergycoresOnMap[unitID]) then
			EnergycoresOnMap[unitID] = nil
		end
	end

	function gadget:UnitCreated(unitID, unitDefID, allyTeam)
		if (unitDefID == EnergycoreId) then
			EnergycoresOnMap[unitID] = 1
		end
	end
end
