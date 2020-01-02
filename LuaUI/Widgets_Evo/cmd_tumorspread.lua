function widget:GetInfo()
	return {
		name	= "Automatic Tumor Spread",
		desc	= "AAAAAAAAAAAAAA",
		author	= "Damgam",
		date	= "2020",
		license	= "nobody cares",
		layer	= 5,
		enabled	= true
	}
end

--local tumortype = game:GetTypeByName("ztumor")
function widget:GameFrame(n)

    if n == 1 then
        myTeamID = Spring.GetMyTeamID()
        myFaction = Spring.GetTeamRulesParam(myTeamID, "faction", playerFaction)
        --Spring.Echo("[Ambient Background Sound Player] Player faction is " .. myFaction)
		
		if myFaction ~= "zaal" then
			widgetHandler:RemoveWidget(self)
		end
    end
	

end

function widget:Initialize()

end

function widget:UnitFinished(unitID, unitDefID, unitTeam)
	if myTeamID == unitTeam and UnitDefs[unitDefID].name == "ztumor" then
		local builderX, builderY, builderZ = Spring.GetUnitPosition(unitID)
		local buildpos1X = builderX - 296
		local buildpos2X = builderX + 296
		local buildpos3X = builderX
		local buildpos4X = builderX
		local buildpos1Z = builderZ
		local buildpos2Z = builderZ
		local buildpos3Z = builderZ + 296
		local buildpos4Z = builderZ - 296
		local buildpos1Y = Spring.GetGroundHeight(buildpos1X, buildpos1Z)
		local buildpos2Y = Spring.GetGroundHeight(buildpos2X, buildpos2Z)
		local buildpos3Y = Spring.GetGroundHeight(buildpos3X, buildpos3Z)
		local buildpos4Y = Spring.GetGroundHeight(buildpos4X, buildpos4Z)
		if #Spring.GetUnitsInCylinder(buildpos1X,buildpos1Z,250) < 1 then
			Spring.GiveOrderToUnit(unitID, -unitDefID , {buildpos1X, buildpos1Y, buildpos1Z, 0}, {"shift"})
		end
		if #Spring.GetUnitsInCylinder(buildpos2X,buildpos2Z,250) < 1 then
			Spring.GiveOrderToUnit(unitID, -unitDefID , {buildpos2X, buildpos2Y, buildpos2Z, 0}, {"shift"})
		end
		if #Spring.GetUnitsInCylinder(buildpos3X,buildpos3Z,250) < 1 then
			Spring.GiveOrderToUnit(unitID, -unitDefID , {buildpos3X, buildpos3Y, buildpos3Z, 0}, {"shift"})
		end
		if #Spring.GetUnitsInCylinder(buildpos4X,buildpos4Z,250) < 1 then
			Spring.GiveOrderToUnit(unitID, -unitDefID , {buildpos4X, buildpos4Y, buildpos4Z, 0}, {"shift"})
		end
	end
end