--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Two Key Build",
    desc      = "v0.04 Build structures using two hotkeys.",
    author    = "CarRepairer",
    date      = "2011-01-25",
    license   = "GNU GPL, v2 or later",
    layer     = 1,
    enabled	  = true,
 }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

include("keysym.h.lua")

local echo = Spring.Echo
local buildMode = false


options_path = 'Game/Hotkeys/Units'
--options_order = {'enterbuild', 'lbl_sep', }
options = {

	--lbl_sep = { type = 'label', name = '' },
	enterbuild = { type = 'button',
	    name = 'Enter 2Key Buildmode',
		hotkey = { key= 'b', mod='' },
	    OnChange = function()
			echo 'Buildmode Entered'
			Spring.PlaySoundFile("sounds/buildmodeclick1.wav", 1)
			buildMode = true
	    end,
	},
}




local sortedUnits = {}
local fullname_shortname = {}
local twokhotkeys = {}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:Initialize()

	for udid,ud in pairs(UnitDefs) do
		--[[
		options[ 'build_' .. ud.name ] = { type = 'button',
			name = '2Key Build ' .. ud.humanName,
			OnChange = function(self)
				if buildMode then
					Spring.SetActiveCommand("buildunit_" .. ud.name)
					buildMode = false
				end
			end,
		}
		sortedUnits[#sortedUnits+1] = ud.humanName
		fullname_shortname[ud.humanName] = ud.name
		--]]
		local goodkeyname = ud.customParams and ud.customParams.twokhotkey and ud.customParams.twokhotkey:upper()
		local keysymname = goodkeyname and KEYSYMS[ goodkeyname ] or false
		if keysymname then
			if not twokhotkeys[keysymname]  then
			twokhotkeys[keysymname] = {}
			end
			--table.insert(twokhotkeys[keysymname], ud.name)
			twokhotkeys[keysymname][ ud.id ] = ud.name 
		end
	end
end

--[[
table.sort(sortedUnits)
for i,fullname in ipairs(sortedUnits) do
	options_order[#options_order +1] = 'build_' .. fullname_shortname[fullname]
end
--]]


function widget:KeyPress(k)
	if not buildMode then return end
	
	local units_tobuild = twokhotkeys[k]
	if units_tobuild  then
		echo 'Buildmode Exited'
		
		local selUnits = Spring.GetSelectedUnits()
		
		for _, unitID in ipairs(selUnits) do
		    local udid = Spring.GetUnitDefID(unitID)
		    local ud = UnitDefs[udid]
		    for i, option in ipairs(ud.buildOptions) do
			local unit_tobuild = units_tobuild[option]
			if unit_tobuild then
			    Spring.PlaySoundFile("sounds/buildmodeclick2.wav", 1)
			    Spring.SetActiveCommand("buildunit_" .. unit_tobuild )
			    buildMode = false
			    -- Spring.PlaySoundFile("sounds/buildmodeclickselect.wav", 1)
			    -- echo 'Play a sound'
			    return true
			end
		    end
		end
	end
	
end









