-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "ArmorType Icons",
    desc      = "Shows unit ArmorType",
    author    = "Forbikins",
    date      = "Jan, 2017",
    license   = "GNU GPL, v2 or later",
    layer     = 5,
    enabled   = true  -- loaded by default?
  }
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

function widget:Initialize()
	SetUnitArmortype(unitID)
end

function widget:Shutdown()
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

function SetUnitArmortype(unitID)

	for unitDefID, unitDef in pairs(UnitDefs) do
		if UnitDefs[unitDefID].customParams.armortype then
			armortype = UnitDefs[unitDefID].customParams.armortype

			if (armortype == "armored") then
				DrawUnitArmortype( unitID, {name='armortype', texture='luaui/images/armortype/armored.png'} )
			end
		end
	end
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

function widget:UnitCreated(unitID, unitDefID, unitTeam)
	SetUnitArmortype(unitID)
end


function widget:UnitDestroyed(unitID, unitDefID, unitTeam)
	DrawUnitArmortype( unitID, {name='armortype', texture=nil} )
end


function widget:UnitGiven(unitID, unitDefID, oldTeam, newTeam)
	DrawUnitArmortype( unitID, {name='armortype', texture=nil} )
end

function widget:GameFrame(f)
	if f%(32*5) == 0 then --5 seconds
		SetUnitArmortype(unitID)
	end
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------