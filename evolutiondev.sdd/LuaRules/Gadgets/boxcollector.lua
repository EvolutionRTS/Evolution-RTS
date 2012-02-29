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
   local BoxId
   local BoxesOnMap={}
   local unitInRange={}
   local Resources={}
   local SpawnCEG = Spring.SpawnCEG

   function gadget:Initialize()
      BoxId = FeatureDefNames[Box].id
     Spring.Echo(Box, BoxId)
      ud = Spring.GetAllFeatures ()
      for n,u in pairs(ud) do
         if Spring.GetFeatureDefID(u) == BoxId then
           BoxesOnMap[u] = 1
        end
      end
   end

   function gadget:GameFrame(f)
      if f%10 == 1 then
         for box,b in pairs(BoxesOnMap) do
            local x,y,z = Spring.GetFeaturePosition(box)
            local unitsInRange = Spring.GetUnitsInSphere(x,y,z, 200)--at x , y , z with radius 200
          for _,unit in ipairs(unitsInRange) do
               if (UnitDefs[Spring.GetUnitDefID(unit)].customParams.cancollect) then
                  local remM, maxM, remE, maxE, left = Spring.GetFeatureResources(box)   --- [1] is metal, [3] is energy
                  Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "m", remM)
                  Spring.AddTeamResource(Spring.GetUnitTeam(unit) , "e", remE) 
                  Spring.DestroyFeature(box)
				  local fx, fy, fz = Spring.GetFeaturePosition(box)
				  Spring.PlaySoundFile("sounds/boxcollection.wav", 1, fx, fy, fz)
				  SpawnCEG("sparklegreen", fx, fy, fz)
                  BoxesOnMap[box] = nil
              break
            end
               if (UnitDefs[Spring.GetUnitDefID(unit)].customParams.dronespawner) then
                  Spring.CreateUnit("edrone", x, y, z, 0, Spring.GetUnitTeam(unit))
                  Spring.DestroyFeature(box)
				  local fx, fy, fz = Spring.GetFeaturePosition(box)
				  Spring.PlaySoundFile("sounds/dronespawner.wav", 1, fx, fy, fz)
				  SpawnCEG("sparkleorange", fx, fy, fz)
                  BoxesOnMap[box] = nil
              break
            end
               -- if (UnitDefs[Spring.GetUnitDefID(unit)].customParams.amphibdronespawner) then
                  -- Spring.CreateUnit("eamphibdrone", x, y, z, 0, Spring.GetUnitTeam(unit))
                  -- Spring.DestroyFeature(box)
				  -- local fx, fy, fz = Spring.GetFeaturePosition(box)
				  -- Spring.PlaySoundFile("sounds/boxcollection.wav", 1, fx, fy, fz)
				  -- SpawnCEG("sparklegreen", fx, fy, fz)
                  -- BoxesOnMap[box] = nil
              -- break
            -- end
          end
         end
      end
   end
   
   function gadget:FeatureDestroyed(featureID, _)
      if (BoxesOnMap[featureID]) then
         BoxesOnMap[featureID] = nil
      end
   end
   
   function gadget:FeatureCreated(featureID, allyTeam)
      if (Spring.GetFeatureDefID(featureID) == BoxId) then
         BoxesOnMap[featureID] = 1
      end
   end
   
end
