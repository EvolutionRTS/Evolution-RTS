
function widget:GetInfo()
   return {
      name      = "Damage Cursor Tip v2",
      desc      = "Displays selected units damage bonus against a target and damage bonus of target against selected units",
      author    = "Google Frog",
      date      = "4-11-2010",
      license   = "GNU GPL v2",
      layer     = 0,
      enabled   = false
   }
end

local totalDamage = 0
local selectedWD = {}

local selectedHealth = {}

local oldArmourType = false
local oldUD = false
local drawString = false
local attackText = ""
local defendText = ""

local function UpdateSelection(newSelection)
	
	selectedHealth = {}
	
	selectedWD = {}
	totalDamage = 0
	
	oldArmourType = false
	oldUD = false
	
	local selectionCount = #newSelection
	for i = 1, selectionCount do
		local unitID = newSelection[i]
		local unitDefID = Spring.GetUnitDefID(unitID)
		local ud = UnitDefs[unitDefID]
		
		if ud.weapons and #ud.weapons ~= 0 then
			for j = 1, #ud.weapons do
				local wd = WeaponDefs[ud.weapons[j].weaponDef]
				if wd.paralyzer == false and wd.damages[0] ~= 1 then -- assume 1 damage means it is a bogus missile
					totalDamage = totalDamage + wd.damages[0]/wd.reload*wd.salvoSize
					selectedWD[wd] = (selectedWD[wd] or 0) + 1
				end
			end
		end
		
		selectedHealth[ud.armorType] = (selectedHealth[ud.armorType] or 0) + ud.health
	end
	
end

function widget:SelectionChanged(newSelection)
	UpdateSelection(newSelection)
end

function widget:Update(dt)

	local x, y = Spring.GetMouseState()
	local t, unitID = Spring.TraceScreenRay(x, y, false, true)
	
	if t ~= "unit" then
		drawString = false
		return
	end
	
	local unitDefID = Spring.GetUnitDefID(unitID)
	local ud = UnitDefs[unitDefID]
	if not (ud and ud.armorType) then
		drawString = false
		return
	end
	
	drawString = true
	local armourType = ud.armorType
	if not (oldArmourType and oldArmourType == armourType) then
		if totalDamage ~= 0 then
			oldArmourType = armourType
			local modDamage = 0
			for wd, count in pairs(selectedWD) do
				modDamage = modDamage + wd.damages[armourType]*count/wd.reload*wd.salvoSize
			end
		
			attackText = math.floor(modDamage/totalDamage*100+0.5) .. "% Damage Dealt"
		else
			attackText = ""
		end
	end
	
	if not (oldUD and oldUD == ud) then
		
		defendText = ""
		
		oldUD = ud
		local totalTime = 0
		local modTime = 0
		if ud.weapons and #ud.weapons ~= 0 then
			for armour, hp in pairs(selectedHealth) do
				local totalDPS = 0
				local modDPS = 0
				for j = 1, #ud.weapons do
					local wd = WeaponDefs[ud.weapons[j].weaponDef]
					if wd.paralyzer == false and wd.damages[0] ~= 1 then -- assume 1 damage means it is a bogus missile
						modDPS = modDPS + wd.damages[armour]/wd.reload*wd.salvoSize
						totalDPS = totalDPS + wd.damages[0]/wd.reload*wd.salvoSize
					end
				end
				if modDPS ~= 0 then
					totalTime = totalTime + hp/totalDPS
					modTime = modTime + hp/modDPS
				end
			end
		end
		
		if totalTime ~= 0 then
			defendText = math.floor(totalTime/modTime*100+0.5) ..  "% Damage Received"
		end
	end

end

function widget:DrawScreen()
	if drawString then
		local x, y = Spring.GetMouseState()
		gl.Text(attackText .. "\n" .. defendText, x+40, y, 15, "o")
	end
end
