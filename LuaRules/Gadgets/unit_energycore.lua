function gadget:GetInfo()
  return {
    name      = "Energy core handler",
    desc      = "",
    author    = "Floris",
    date      = "November 2017",
    license   = "",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end


if (gadgetHandler:IsSyncedCode()) then

    local blockingEnergycores = {}
    local energycoreUnitDefID = UnitDefNames['energycore'].id
    --local gaiaTeam = Spring.GetGaiaTeamID()

    function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID, attackerDefID, attackerTeamID)
        if UnitDefs[unitDefID].customParams ~= nil and UnitDefs[unitDefID].customParams.corpse ~= nil and UnitDefs[unitDefID].customParams.corpse == 'energycore' then
            local x,y,z = Spring.GetUnitPosition(unitID)
            local unitID = Spring.CreateUnit(energycoreUnitDefID, x,y,z, 0, teamID)
        end
    end

    function gadget:UnitCreated(unitID, unitDefID, teamID, attackerID, attackerDefID, attackerTeamID)
        if unitDefID == energycoreUnitDefID then
            blockingEnergycores[unitID] = Spring.GetGameFrame() + 100
            Spring.SetUnitRotation(unitID,0,math.random()*360,0)
            Spring.SetUnitRotation(unitID,1,(math.random()-0.5)*320,0)
            Spring.SetUnitRotation(unitID,0,math.random()*360,1)
            Spring.AddUnitImpulse(unitID, (math.random()-0.5)*1.2, 2.3+(math.random()*1), (math.random()-0.5)*1.2)
            Spring.SetUnitNeutral(unitID, true)
            Spring.SetUnitNoSelect(unitID, true)
            Spring.SetUnitNoMinimap(unitID, true)
            Spring.SetUnitBlocking(unitID, true, true, false, false, false, false, false)
        end
    end

    function gadget:GameFrame(n)
        if n % 30 == 1 then
            for unitID, frame in pairs(blockingEnergycores) do
                if frame < n then
                    Spring.SetUnitBlocking(unitID, false)
                    blockingEnergycores[unitID] = nil
                end
            end
        end
    end

end
