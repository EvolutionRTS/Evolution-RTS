
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Armor Icons",
    desc      = "Adds an armor icon for armored units (needs Unit Icons)",
    author    = "trepan (idea quantum,jK), CarRepairer tweak, CommonPlayer",
    date      = "Feb, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 5,
    enabled   = true  -- loaded by default?
  }
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- speed-ups
local GetUnitDefID         = Spring.GetUnitDefID
local GetAllUnits          = Spring.GetAllUnits

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

local PWUnits = {}

local myAllyTeamID = 666


local armoredTex = 'luaui/images/armortype/armored.png'

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

function PWCreate(unitID)
  PWUnits[unitID] = true
  SetArmorIcon(unitID)
end

function widget:Initialize()

  widgetHandler:RegisterGlobal("PWCreate", PWCreate)
  
  WG.icons.SetOrder( 'armor', 1 )

  for _,unitID in pairs( GetAllUnits() ) do
    SetArmorIcon(unitID)
  end
end

function widget:Shutdown()
end

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

function SetArmorIcon(unitID)
  local ud = UnitDefs[GetUnitDefID(unitID)]
  if (ud == nil) then
    return
  end
  
  if ud.customParams.armortype then
	armortype = ud.customParams.armortype
	if armortype == "armored" then
		if not PWUnits[unitID] then
			WG.icons.SetUnitIcon( unitID, {name='armor', texture=armoredTex } )
		end
	end
  end
end



-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

function widget:UnitCreated(unitID, unitDefID, unitTeam)
    SetArmorIcon(unitID)
end


function widget:UnitDestroyed(unitID, unitDefID, unitTeam)
  WG.icons.SetUnitIcon( unitID, {name='armor', texture=nil} )
  PWUnits[unitID] = nil
end

--needed if icon widget gets disabled/enabled after this one. find a better way?
function widget:GameFrame(f)
  if f%(32*5) == 0 then --5 seconds
	for _,unitID in pairs( GetAllUnits() ) do
	  SetArmorIcon(unitID)
	end
  end
end
--------------------------------------------------------------------------------
=======
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