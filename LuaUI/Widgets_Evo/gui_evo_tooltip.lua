function widget:GetInfo()
	return {
		name      = "Evo Tooltip",
		desc      = "overrides default tooltip, shows shield and weapon info",
		author    = "CommonPlayer, raaar, based on a Kernel Panic widget by zwszg",
		date      = "September 2012",
		license   = "GNU GPL v2",
		layer     = 0,
		enabled   = true
	}
end

local ui_opacity = tonumber(Spring.GetConfigFloat("ui_opacity",0.66) or 0.66)

local fontfile = LUAUI_DIRNAME .. "fonts/" .. Spring.GetConfigString("ui_font", "JosefinSans-SemiBold.ttf")
local vsx,vsy = Spring.GetViewGeometry()
local fontfileScale = (0.5 + (vsx*vsy / 5700000))
local fontfileSize = 25
local fontfileOutlineSize = 4.5
local fontfileOutlineStrength = 1.8
local font = gl.LoadFont(fontfile, fontfileSize*fontfileScale, fontfileOutlineSize*fontfileScale, fontfileOutlineStrength)

local barTexture = LUAUI_DIRNAME.."Images/resbar.dds"
local bgcorner = ":n:"..LUAUI_DIRNAME.."Images/bgcorner.png"
local function DrawRectRound(px,py,sx,sy,cs, tl,tr,br,bl ,vsx,vsy)
	gl.TexCoord(0.8,0.8)
	gl.Vertex(px+cs, py, 0)
	gl.Vertex(sx-cs, py, 0)
	gl.Vertex(sx-cs, sy, 0)
	gl.Vertex(px+cs, sy, 0)

	gl.Vertex(px, py+cs, 0)
	gl.Vertex(px+cs, py+cs, 0)
	gl.Vertex(px+cs, sy-cs, 0)
	gl.Vertex(px, sy-cs, 0)

	gl.Vertex(sx, py+cs, 0)
	gl.Vertex(sx-cs, py+cs, 0)
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.Vertex(sx, sy-cs, 0)

	local offset = 0.07		-- texture offset, because else gaps could show
	local o = offset

	-- bottom left
	if ((py <= 0 or px <= 0)  or (bl ~= nil and bl == 0)) and bl ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(px, py, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(px+cs, py, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(px+cs, py+cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(px, py+cs, 0)
	-- bottom right
	if ((py <= 0 or sx >= vsx) or (br ~= nil and br == 0)) and br ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(sx, py, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(sx-cs, py, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(sx-cs, py+cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(sx, py+cs, 0)
	-- top left
	if ((sy >= vsy or px <= 0) or (tl ~= nil and tl == 0)) and tl ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(px, sy, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(px+cs, sy, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(px+cs, sy-cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(px, sy-cs, 0)
	-- top right
	if ((sy >= vsy or sx >= vsx)  or (tr ~= nil and tr == 0)) and tr ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(sx, sy, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(sx-cs, sy, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(sx, sy-cs, 0)
end
function RectRound(px,py,sx,sy,cs, tl,tr,br,bl, vsx,vsy)		-- (coordinates work differently than the RectRound func in other widgets)
	gl.Texture(bgcorner)
	gl.BeginEnd(GL.QUADS, DrawRectRound, px,py,sx,sy,cs, tl,tr,br,bl, vsx,vsy)
	gl.Texture(false)
end

-- icons
local useEnergyTexture = "ENERGY_TEXTURE"
local useMetalTexture = "METAL_TEXTURE"
local useSupplyTexture = "SUPPLY_TEXTURE"
local drawIcons = {
	ENERGY_TEXTURE = LUAUI_DIRNAME.."Images/energy2.png",
	METAL_TEXTURE = LUAUI_DIRNAME.."Images/metal.png",
	SUPPLY_TEXTURE = LUAUI_DIRNAME.."Images/supply.png",
}
local function stringSplitIcons(str, convertIconStr, ...)
	--[[ Usage notes:
	returns a table in the format of { text, icon, text, ... }
	length is always an odd number and there can be empty text
	if convertIconStr is set to true, it converts strings meant for accessing icons like "SOME_ICON" into "someIcon"
	]]
	local result = {}
	local lengResult = 0
	local icons = {...}
	local lengIcons = #icons
	local i = 1
	local lengStr = #str
	while true do
		local minPos = math.huge
		local lengChosenIcon = 0
		for j = 1, lengIcons do
			local pos = str:find(icons[j], i) or math.huge
			if minPos > pos then minPos, lengChosenIcon = pos, #icons[j] end
		end
		if minPos == math.huge then
			lengResult = lengResult + 1
			result[lengResult] = str:sub(i, #str)
			return result
		else
			lengResult = lengResult + 1
			result[lengResult] = str:sub(i, minPos - 1)
			lengResult = lengResult + 1
			local iconStr = str:sub(minPos, minPos + lengChosenIcon - 1)
			result[lengResult] = convertIconStr and iconStr:lower():gsub("_%a", function(input) return input:sub(2, 2):upper() end) or iconStr
			i = minPos + lengChosenIcon
		end
	end
end
--

local TechColour = {"\255\0\205\255", "\255\255\0\255", "\255\0\255\0", "\255\255\0\0"}
local TechToStr = {TechColour[1].."Mark II", TechColour[2].."Mark III", TechColour[3].."Mark IV", TechColour[4].."Hive"}

-- colours
local supplyColour = "\255\255\128\0"
local energyColour = "\255\255\255\1"
local metalColour = "\255\136\197\226"
local white = "\255\255\255\255"
local generateResColour = "\255\0\255\0"
local useResColour = "\255\255\0\0"
local weaponDamageColour = "\255\255\100\100"
local weaponParalyzeColour = "\255\100\255\255"
--

-- Hotkeys
VFS.Include("luaui/configs/evo_buildHotkeysConfig.lua")

local sGetKeySymbol = Spring.GetKeySymbol
local function getKeySymbol(k)
    if k >= 97 and k <= 122 then return string.char(k):upper() end
    -- basically unused
	local keySymbol = sGetKeySymbol(k)
	return keySymbol:sub(1, 1):upper() .. keySymbol:sub(2)
end
local humanNameToKeySymbols = {}
for unitDefID = 1, #UnitDefs do
	local ud = UnitDefs[unitDefID]
	local name = ud.name
	if name:find("_up", -5) then name = name:sub(1, -5) end
	if nameToKeyCode[name] then
		local str = ""
		local leng = #nameToKeyCode[name]
		for i = 1, leng do
			str = str .. getKeySymbol(nameToKeyCode[name][i])
			if i < leng then str = str .. " + " end
		end
		humanNameToKeySymbols[ud.humanName] = str
	end
end
--

local weaponTypeToStr = { "Armored", "Building", "Light" }

local frameSkip = 4       -- draw once every frameSkip+1 frames 
local counter = 0
--[[local xpArr = {
"",
"\255\255\100\0I",
"\255\255\120\50II",
"\255\240\140\75III",
"\255\220\150\100IV",
"\255\200\200\200V",
"\255\210\210\200VI",
"\255\220\220\200VII",
"\255\230\230\200VIII",
"\255\240\240\200IX",
"\255\255\255\200X"
}]]
local tempTooltip = nil
local min = math.min
local floor = math.floor
local ceil = math.ceil
local modf = math.modf
local GetMouseState = Spring.GetMouseState
local TraceScreenRay = Spring.TraceScreenRay
local spGetSelectedUnitsCount = Spring.GetSelectedUnitsCount
local spGetSelectedUnits = Spring.GetSelectedUnits
local spGetUnitIsCloaked = Spring.GetUnitIsCloaked
local spGetUnitExperience = Spring.GetUnitExperience
local spGetUnitVelocity = Spring.GetUnitVelocity
local spGetUnitRulesParam = Spring.GetUnitRulesParam
local spGetTeamRulesParam = Spring.GetTeamRulesParam
local spGetUnitTeam = Spring.GetUnitTeam

--local TRANSPORT_MASS_LIMIT_LIGHT = 1200
--local TRANSPORT_MASS_LIMIT_HEAVY = 3000  

local ONCE_RELOAD_THRESHOLD = 999

function widget:Initialize()
	Spring.SendCommands({"tooltip 0"})
	
	Spring.SetDrawSelectionInfo(false)
	
	-- find shield weapon and its max power
	for _,ud in pairs(UnitDefs) do
		ud.shieldPower   = 0;
		local shieldDefID = ud.shieldWeaponDef
		ud.shieldPower = ((shieldDefID)and(WeaponDefs[shieldDefID].shieldPower))or(-1)
	end
end

local FontSize = math.max(8,3+vsy/80)
function widget:ViewResize(x,y)
	vsx,vsy = Spring.GetViewGeometry()

	FontSize = math.max(8,3+vsy/80)

	local newFontfileScale = (0.5 + (vsx*vsy / 5700000))
	if (fontfileScale ~= newFontfileScale) then
		fontfileScale = newFontfileScale
		font = gl.LoadFont(fontfile, fontfileSize*fontfileScale, fontfileOutlineSize*fontfileScale, fontfileOutlineStrength)
	end
end

function widget:Shutdown()
	Spring.SendCommands({"tooltip 1"})
	gl.DeleteFont(font)
end
  
-- format number  
-- TODO put this on a lib
function FormatNbr(x,digits)
	if x then
		local ret=string.format("%."..(digits or 0).."f",x)
		if digits and digits>0 then
			while true do
				local last = string.sub(ret,string.len(ret))
				if last=="0" or last=="." then
					ret = string.sub(ret,1,string.len(ret)-1)
				end
				if last~="0" then
					break
				end
			end
		end
		return ret
	else
		return ""
	end
end

-- generates upgrade data string for player
--[[function GetTooltipUpgradeData(teamId)
	local NewTooltip = ""
	
	-- get upgrades for team
	local statusStr = spGetTeamRulesParam(teamId,"upgrade_status")
	local listStr = spGetTeamRulesParam(teamId,"upgrade_list")
	local modStr = spGetTeamRulesParam(teamId,"upgrade_modifiers")
	
	if (statusStr) then
		NewTooltip = NewTooltip..statusStr.."\n"
	end
	if (listStr) then
		NewTooltip = NewTooltip..listStr.."\n"
	end
	if (modStr) then
		NewTooltip = NewTooltip.." \nEFFECTS\n"..modStr
	end
			
	return NewTooltip
end]]


-- generates upgrade summary string for player
--[[function GetTooltipUpgradeLabel(teamId)
	local NewTooltip = ""
	
	-- get upgrades for team
	local labelStr = spGetTeamRulesParam(teamId,"upgrade_label")
	
	if (labelStr) then
		NewTooltip = NewTooltip..labelStr
	else
		NewTooltip = NewTooltip.."Upgrades: \255\130\130\130[0]  [0]  [0]"
	end
			
	return NewTooltip
end]]

-- generates weapon data string for unit
local function GetUnitTotalDamageEnergyMaxRange(ud)
	local damages, paralyzeDamages = { 0, 0, 0 }, { 0, 0, 0 }
	damages[0], paralyzeDamages[0] = 0, 0
	local hasDamage, hasParalyzDamage = false, false
	local maxRange, totalEnergyCost = 0, 0
	--if ud.weapons and ud.weapons[1] and ud.weapons[1].weaponDef then
		for _,w in pairs(ud.weapons) do
			local weap=WeaponDefs[w.weaponDef]
		    if weap.isShield == false and weap.description ~= "No Weapon" then
				local reloadTime = weap.reload
				local dpsConversion = (weap.projectiles*weap.salvoSize) / weap.reload
				local energyPerSecond = weap.energyCost * dpsConversion
				local isDisruptor = weap.damages and weap.damages.paralyzeDamageTime and weap.damages.paralyzeDamageTime>0
				
				maxRange = maxRange < weap.range and weap.range or maxRange
				totalEnergyCost = totalEnergyCost + energyPerSecond
				for i = 0, #weap.damages do -- don't even bother asking exactly what attributes "damages" hold
					if isDisruptor then
						paralyzeDamages[i] = paralyzeDamages[i] + weap.damages[i] * dpsConversion
						hasParalyzDamage = true
					else
						damages[i] = damages[i] + weap.damages[i] * dpsConversion
						hasDamage = true
					end
				end
			end
		end
	--end
	return damages, paralyzeDamages, hasDamage, hasParalyzDamage, maxRange, totalEnergyCost -- 0 = default, 1, ... = damage types
end
function GetTooltipWeaponData(ud)
	local NewTooltip = ""
	
	local xpMod, rangeMod, dmgMod = 1, 1, 1
	--[[if not rangeMod then
		rangeMod = 1
	end
	if not dmgMod then
		dmgMod = 1
	end]]
	
	if ud.canKamikaze then
	    local weapname=ud.selfDExplosion
	    local weap=nil
	    for wid,weaponDef in pairs(WeaponDefs) do
	        if weaponDef.name==weapname then
	        	weap=WeaponDefs[wid]
	        end
	    end
	    if weap then
	        local weapon_action="Damage"
	        if weap.damages and weap.damages.paralyzeDamageTime and weap.damages.paralyzeDamageTime>0 then
	                weapon_action="Paralyze"
	        end
	        NewTooltip = NewTooltip.."\n\255\255\213\213Damage: \255\255\170\170"..FormatNbr(dmgMod * weap.damages[Game.armorTypes.default],2).."/once"
	    end
    elseif ud.weapons and ud.weapons[1] and ud.weapons[1].weaponDef then
		local damages, paralyzeDamages, hasDamage, hasParalyzDamage, maxRange, totalEnergyCost = GetUnitTotalDamageEnergyMaxRange(ud)
		--NewTooltip = NewTooltip .. "\n"
		if hasDamage then
			NewTooltip = NewTooltip .. white .. "Damage/s: "
			for i = 1, #damages do -- actually ignore default
				local reorder = (i + 1) % 3 + 1
				if damages[reorder] > 0 then NewTooltip = NewTooltip .. weaponDamageColour .. FormatNbr(damages[reorder], 1) .. white .. " (" .. weaponTypeToStr[reorder] .. ") / " end
			end
			NewTooltip = NewTooltip:sub(1, -4)
		end
		if hasParalyzDamage then
			NewTooltip = NewTooltip .. white .. "Paralyze/s: "
			for i = 1, #paralyzeDamages do -- actually ignore default
				local reorder = (i + 1) % 3 + 1
				if paralyzeDamages[reorder] > 0 then NewTooltip = NewTooltip .. weaponParalyzeColour .. FormatNbr(paralyzeDamages[reorder], 1) .. white .. " (" .. weaponTypeToStr[reorder] .. ") / " end
			end
			NewTooltip = NewTooltip:sub(1, -4)
		end
		if hasDamage or hasParalyzDamage then
			NewTooltip = "\n" .. NewTooltip
			NewTooltip = NewTooltip .. "     Range: " .. FormatNbr(maxRange, 2)
			--totalEnergyCost = 12
			if totalEnergyCost > 0 then NewTooltip = NewTooltip .. "     " .. useEnergyTexture .. useResColour .. " -" .. FormatNbr(totalEnergyCost, 1) end
		end
		--[[for _,w in pairs(ud.weapons) do
			local weap=WeaponDefs[w.weaponDef]
			--Spring.Echo(weap.damages[0],weap.damages[1],weap.damages[2],weap.damages[3]) -- default, armored, building, light
		    if weap.isShield == false and weap.description ~= "No Weapon" then
				local weapon_action="Dmg/s"
				local reloadTime = weap.reload / xpMod
				local isBeamLaser = weap.type == "BeamLaser"
				local damage = dmgMod * (weap.damages[Game.armorTypes.default] * (weap.projectiles*weap.salvoSize)) 
				local dps = damage / reloadTime
				local energyPerSecond = (weap.energyCost * (weap.projectiles*weap.salvoSize)) / reloadTime
				local isDisruptor = false
				local actionStr = ""

				if weap.damages and weap.damages.paralyzeDamageTime and weap.damages.paralyzeDamageTime>0 then
                   weapon_action="Paralyze/s"
                   isDisruptor = true
                end
				if (reloadTime > 5) then
					actionStr = weapon_action..": \255\255\255\255"..(isDisruptor and "\255\100\255\255" or "")..FormatNbr(damage,0).."\255\255\255\255"..(reloadTime >= ONCE_RELOAD_THRESHOLD and " once" or ("/"..FormatNbr(reloadTime,2).."s"))
				else 
					actionStr = weapon_action..": \255\255\255\255"..(isDisruptor and "\255\100\255\255" or "")..FormatNbr(dps,1).."\255\255\255\255"
				end

                local range = weap.range * rangeMod
                local hitpower = "L"
                
                if ( weap.damages[Game.armorTypes.default] == weap.damages[Game.armorTypes.armor_heavy] ) then
                	hitpower = "H"
                elseif ( weap.damages[Game.armorTypes.default] == weap.damages[Game.armorTypes.armor_medium] ) then
                	hitpower = "M"
                end
                
       
                NewTooltip = NewTooltip.."\n\255\255\255\255"..weap.description.."    "..actionStr.."("..hitpower..")     Range: "..FormatNbr(range,2)

                if energyPerSecond  > 0 then
                   NewTooltip = NewTooltip.."     \255\255\255\0E/s: "..FormatNbr(energyPerSecond,1)
                end
                
                if weap.waterWeapon then
                	 NewTooltip = NewTooltip.."    \255\64\64\255WATER"
                end
		    end
		end]]
    end
    
    return NewTooltip
end
 
-- generates build power string in m/s as a function of build speed
function GetTooltipBuildPower(buildSpeed)
	
	-- time is 11 * weighted_cost_metal
	-- time = 11 * (m + e/60) / spd
	-- m + e/60 = time * spd / 11
	-- non-aircraft have 5x e cost as metal, so
	-- m + 5m/60 = time * spd / 11
	-- 13m/12 = time * spd / 11
	-- m/time = 12*spd / (11*13) 
	
	--return "\255\255\255\150Build Power: ".. FormatNbr(12 * buildSpeed / (11*13),1).." metal/s"
	return "\255\255\255\150Build Power: ".. FormatNbr(buildSpeed * 4,1).." metal/s"
end

-- get tooltip mass/transportability label
function GetTooltipTransportability(ud)
	--[[if ud.speed > 0 then
		local transpStr = ""
		if ud.mass < TRANSPORT_MASS_LIMIT_LIGHT then
			transpStr = "light"
		elseif ud.mass < TRANSPORT_MASS_LIMIT_HEAVY then
			transpStr = "heavy"
		else 
			transpStr = "no transport"
		end
	
		return "     \255\200\200\200Mass: ".. FormatNbr(ud.mass,0).." ("..transpStr..")"
	else
		return ""
	end	]]
	if ud.canFly or ud.customParams.armortype == "building" or not ud.customParams.canbetransported then return "" end
	--return "     \255\200\200\200Transportable"
	return ""
end

-- get tooltip: supply energy metal cost
local function GetTooltipCost(sUse, sGive, e, m)
	sUse, sGive = tonumber(sUse), tonumber(sGive)
	local supplyStr = ""
	--[[local sNet = sGive - sUse
	local supplyStr = ""
	if sNet > 0 then supplyStr = "Gives "..useSupplyTexture..supplyColour.." "..sNet..white.."   "
	elseif sNet < 0 then supplyStr = "Uses "..useSupplyTexture..supplyColour.." "..(-sNet)..white.."   " end]]
	if sGive > 0 then supplyStr = supplyStr .. "Gives "..useSupplyTexture..supplyColour.." "..sGive..white.."   " end
	if sUse > 0 then supplyStr = supplyStr .. "Uses "..useSupplyTexture..supplyColour.." "..sUse..white.."   " end
	local costStr = "Cost: " ..
		useEnergyTexture..energyColour.." "..e..white.." / "..
		useMetalTexture..metalColour.." "..m
	return supplyStr .. costStr
end
-- get tooltip for armor
local function GetTooltipArmor(ud)
	-- TODO replace text with icons
	local str = ud.customParams.armortype
	if str == "light" then return "Light"
	elseif str == "armored" then return "Armored"
	elseif str == "building" then return "Building" end
	return "Default"
end
-- get tooltip for resource upkeeps
local function GetTooltipUpkeep(eMake, eUse, mMake, mUse)
	return
		useEnergyTexture..generateResColour.." +"..FormatNbr(eMake, 1)..white.." / "..useResColour..FormatNbr(-eUse, 1).."    "..
		useMetalTexture..generateResColour.." +"..FormatNbr(mMake, 1)..white.." / "..useResColour..FormatNbr(-mUse, 1)
end
-- get tooltip for one unit
local function GetTooltipUnit(id)
	local result = ""
	local u=id
	local ud=UnitDefs[Spring.GetUnitDefID(u)]
	
	local metalMake,metalUse,energyMake,energyUse = Spring.GetUnitResources(u)
	local isFriendly = metalMake ~= nil       -- assume only friendly units have this info
	
	-- build progress, health and shield
	local health,maxHealth,paralyzeDamage,captureProgress,buildProgress = Spring.GetUnitHealth(u)
	stunned_or_beingbuilt, stunned, beingbuilt = Spring.GetUnitIsStunned(u)
	result = result.."\n"..ud.humanName.." ("..ud.tooltip..")"
	--[[local hpMod = spGetUnitRulesParam(u,"upgrade_hp")
	if not hpMod then
		hpMod = 1
	else
		hpMod = 1 + hpMod
	end
	health = health * hpMod
	maxHealth = maxHealth * hpMod]]
	--[[
	-- experience
	local xp = spGetUnitExperience(u)
	local xpMod = 1
	if xp and xp>0 then
		local xpIndex = math.min(10,math.max(floor(11*xp/(xp+1)),0))+1
		xpMod = 1+0.35*(xp/(xp+1))
		if(xpIndex > 1) then
			result = result.."\255\255\255\255    Experience: "..xpArr[xpIndex]
		end
	end
	]]
	--[[
	local dmgMod = spGetUnitRulesParam(u,"upgrade_damage")
	if not dmgMod then
		dmgMod = 1
	else
		dmgMod = 1 + dmgMod
	end
	local rangeMod = spGetUnitRulesParam(u,"upgrade_range")
	if not rangeMod then
		rangeMod = 1
	else
		rangeMod = 1 + rangeMod
	end
	]]
										
										
	-- paralysis
	if stunned then
		result = result.."\255\194\173\255   PARALYZED"
	end
	-- cloaking
	if spGetUnitIsCloaked(u) then
		result = result.."\255\170\170\170   CLOAKED"
	end        
	-- alliance                
	if isFriendly == false then
		result = result.."   \255\255\0\0ENEMY"	
	end
	result = result.."\n"
	if buildProgress and buildProgress<1 then
		result = result.."\255\213\213\255".."Build progress: ".."\255\170\170\255"..FormatNbr(100*buildProgress).."%\n"
	end

	-- cost
	--result = result.."\255\200\200\200Metal: "..ud.metalCost.."    \255\255\255\0Energy: "..ud.energyCost.."    "..GetTooltipTransportability(ud).."\n"
	local unitsupplycost = ud.customParams.supply_cost or 0
	local unitsupplygive = ud.customParams.supply_granted or 0
	result = result..GetTooltipCost(unitsupplycost, unitsupplygive, ud.energyCost, ud.metalCost).."    "..GetTooltipTransportability(ud).."\n"


	--[[local armorTypeStr= "L"
	if ( Game.armorTypes[ud.armorType] == "armor_heavy" ) then armorTypeStr = "H"
	elseif ( Game.armorTypes[ud.armorType] == "armor_medium" ) then armorTypeStr = "M" end]]
	local armorTypeStr = GetTooltipArmor(ud)

	local hasShield, ShieldPower=Spring.GetUnitShieldState(id)
	local maxShieldPower = ud.shieldPower
	if (health ~= nil) then
		result = result.."\255\200\200\200Health: ".."\255\200\200\200"..floor(health).."\255\200\200\200/\255\200\200\200"..floor(maxHealth).." ("..armorTypeStr..")"
		if hasShield then result=result.."\255\135\135\255      Shield: "..FormatNbr(math.min(ShieldPower,maxShieldPower)).."/"..FormatNbr(maxShieldPower) end
	end
	
	-- energy and metal upkeep
	if isFriendly then
		--result = result.."    \255\200\200\200Metal: \255\0\255\0+"..FormatNbr(metalMake,1).."\255\255\255\255/\255\255\0\0"..FormatNbr(-metalUse,1)
		--result = result.."    \255\255\255\0Energy: \255\0\255\0+"..FormatNbr(energyMake,1).."\255\255\255\255/\255\255\0\0"..FormatNbr(-energyUse,1)
		-- result=result.."\255\255\255\0     +E/M ratio: "..FormatNbr(energyMake / ud.metalCost,4).."\n"
		local upkeepStr = GetTooltipUpkeep(energyMake, energyUse, metalMake, metalUse)
		result = result.."    "..upkeepStr
	end

	-- weapons
	result = result..GetTooltipWeaponData(ud).."\n"
  
	-- build power
	if ud.buildSpeed and ud.buildSpeed > 0 then
		result = result.."\n"..GetTooltipBuildPower(ud.buildSpeed)..  "\255\255\255\255\n"
	end
				
	-- upgrades (upgrade centers only)
	--[[local isUpgradeCenter = string.find(ud.name, "upgrade_center")
	local teamId = spGetUnitTeam(u)
	if isUpgradeCenter then
		result = result..GetTooltipUpgradeData(teamId).."\n\n"
	end]]
				
	-- speed
	if ud.speed and ud.speed>0 then
		--[[local speedMod = spGetUnitRulesParam(u,"upgrade_speed")
		if not speedMod then
			speedMod = 1
		else
			speedMod = 1 + speedMod
		end]]
		local speedMod = 1
		
		local vx,vy,vz = spGetUnitVelocity(u)
		local speed = 30*math.sqrt(vx*vx+vz*vz)
		result = result.."\255\193\255\187Speed: \255\134\255\121"..FormatNbr(speed).."\255\193\255\187/\255\134\255\121"..FormatNbr(ud.speed*speedMod,2).."\255\255\255\255      "
	end

	--[[if ud.transportCapacity>0 and ud.transportMass>0 and isFriendly then
		local currentCapacityUsage = 0 
		local currentMassUsage = 0
		
		-- get sum of mass and size for all transported units                                
		for _,tUnit in pairs(Spring.GetUnitIsTransporting(u)) do
			local tUd=UnitDefs[Spring.GetUnitDefID(tUnit)]
			currentCapacityUsage = currentCapacityUsage + tUd.xsize 
			currentMassUsage = currentMassUsage + tUd.mass
		end
		 
		result = result.."\255\255\255\255Transport: "..FormatNbr(min(2,(currentCapacityUsage/ud.transportCapacity))*50,0).."% / "..FormatNbr((currentMassUsage/ud.transportMass)*100,0).."%      "
	end]]

	-- upgrade summary
	--[[if not isUpgradeCenter then
		result = result..GetTooltipUpgradeLabel(spGetUnitTeam(u))
	end]]
				
	--[[if ud.customParams.tip then
		result = result.."\n\255\180\180\180"..ud.customParams.tip.."\255\255\255\255\n"
	end]]
	return result
end
	
-- generates new tooltip 
function GenerateNewTooltip()
	local CurrentTooltip = Spring.GetCurrentTooltip()
 
	if tempTooltip and frameSkip > 0 then
		counter = counter +1
		if (counter % (frameSkip+1) ~= 0) then
			return tempTooltip
		end
	end
 
	local NewTooltip = ""
	local HotkeyTooltip = ""
	local FoundTooltipType = nil
	local mx,my,gx,gy,gz,id
 
	mx,my = GetMouseState()
	if mx and my then
		local _,pos = TraceScreenRay(mx,my,true,true)
		if pos then
			gx,gy,gz=unpack(pos)
		end
		local kind,var1 = TraceScreenRay(mx,my,false,true)
		if kind=="unit" then
			id = var1
		end
	end
 
        
	if spGetSelectedUnitsCount()>1 then
		NewTooltip=NewTooltip.."\255\255\255\255"..spGetSelectedUnitsCount().."\255\255\255\255 units selected\255\255\255\255\n"
	end
        
	 
	local TerrainType = string.match(CurrentTooltip,"Terrain type: (.+)\nSpeeds T/K/H/S ")
	local TerrainSpeeds = string.match(CurrentTooltip,"Speeds T/K/H/S (.+)\nHardness")
	if TerrainType~=nil then
		NewTooltip=NewTooltip.."\255\255\255\64"..TerrainType
		if TerrainSpeeds~=nil then
			TerrainSpeedList={}
			for Speed in string.gmatch(TerrainSpeeds,"[0-7]+.[0-7]+") do
				table.insert(TerrainSpeedList,Speed)
			end
			if #TerrainSpeedList>=1 then
				local DiffSpeed = false
				for _,Speeds in pairs(TerrainSpeedList) do
					if Speeds~=TerrainSpeedList[1] then
						DiffSpeed = true
					end
				end
				for i=1,#TerrainSpeedList do
					while true do
						local last = string.sub(TerrainSpeedList[i],string.len(TerrainSpeedList[i]))
						if last=="0" or last=="." then
							TerrainSpeedList[i] = string.sub(TerrainSpeedList[i],1,string.len(TerrainSpeedList[i])-1)
						end
						if last~="0" then
							break
						end
					end
				end
				if DiffSpeed then
					--NewTooltip=NewTooltip.."\nSpeeds x "..TerrainSpeeds
				else
					--NewTooltip=NewTooltip.."\nSpeed x"..TerrainSpeedList[1]
				end
			end
		end
		if gx and gz then
			--NewTooltip=NewTooltip.."\n\n("..(32)*floor((gx+16)/32)..","..(32)*floor((gz+16)/32)..")"
			NewTooltip=NewTooltip.."\n\n("..floor(gx+0.5)..","..floor(gz+0.5)..")"
			
			local h = Spring.GetGroundHeight(gx,gz)
			local airMeshH = Spring.GetSmoothMeshHeight(gx,gz) 
			NewTooltip=NewTooltip.."\n\nAltitude "..floor(h).."\n\nAir Mesh Altitude "..floor(airMeshH)
		end
		FoundTooltipType="terrain"
	end
 
	local buildpower = 1
	
	-- compute total buildpower of units selected 
	if spGetSelectedUnitsCount() >= 1 then
		for _,u in pairs(spGetSelectedUnits()) do
			local def=UnitDefs[Spring.GetUnitDefID(u)]
			buildpower = buildpower + def.buildSpeed
		end
	end   

	-- selecting units to build
	local unitpre = string.match(CurrentTooltip,"(.-)\nBuild:") or string.match(CurrentTooltip,"(.-)\n\255\255\255\255Build:") or ""
	--local unitname = string.match(CurrentTooltip,"Build: (.+) %- ")
	local unitname = string.match(CurrentTooltip,"Build: (.-) %- ")
	local unitdesc = string.match(CurrentTooltip," %- (.+)\nHealth ")
	local unithealth = string.match(CurrentTooltip,"Health (.+)\nMetal") or string.match(CurrentTooltip,"Health (.+)\nBuild time ")
	local unitbuildtime = string.match(CurrentTooltip.."\n","Build time (.-)\n")
	local unitmetalcost = string.match(CurrentTooltip,"Metal cost (.-)\nEnergy cost ")
	local unitenergycost = string.match(CurrentTooltip,"\nEnergy cost (.-).Build time ")

	if unitname and unitdesc and unithealth and unitbuildtime then
		local fud = nil
		--local collisions = 0
		for _,ud in pairs(UnitDefs) do
			--[[
			Spring.Echo("ud.humanName=",ud.humanName)
			Spring.Echo("ud.tooltip=",ud.tooltip)
			Spring.Echo("ud.health=",ud.health)
			Spring.Echo("ud.buildTime=",ud.buildTime)
			]]--
			-- Note: used approximately equal to because Evo fucking sucks
			if ud.humanName==unitname and ud.tooltip==unitdesc and math.abs(ud.health-tonumber(unithealth))<=1 then
				--and ""..ud.buildTime==unitbuildtime then
				fud=ud
				break
			end
			--[[if ud.humanName==unitname or ud.tooltip==unitdesc then
				Spring.Echo(ud.humanName,unitname,ud.humanName==unitname)
				Spring.Echo(ud.tooltip,unitdesc,ud.tooltip==unitdesc)
				Spring.Echo(ud.health,unithealth,ud.health==unithealth)
				Spring.Echo(ud.buildTime,unitbuildtime)
				--collisions = collisions + 1
			end]]
		end
		if fud then
			--[[local armorTypeStr= "L"
			if ( Game.armorTypes[fud.armorType] == "armor_heavy" ) then armorTypeStr = "H"
			elseif ( Game.armorTypes[fud.armorType] == "armor_medium" ) then armorTypeStr = "M" end]]
			
			--[[NewTooltip = NewTooltip.."\n"..unitpre.."\n"..fud.humanName.." ("..fud.tooltip..")\n"..
				"\255\200\200\200Metal: "..unitmetalcost.."    \255\255\255\0Energy: "..unitenergycost..""..
				"\255\213\213\255".."    Build time: ".."\255\170\170\255"..
				floor((29+floor(31+fud.buildTime/(buildpower/32)))/30).."s".."    "..GetTooltipTransportability(fud).."\n"..
				"\255\200\200\200Health: ".."\255\200\200\200"..fud.health.."("..armorTypeStr..")"
				if fud.shieldPower > 0 then NewTooltip=NewTooltip.."\255\135\135\255     Shield: "..FormatNbr(fud.shieldPower) end]]
			
			local hotkeyStr = ""
			if humanNameToKeySymbols[unitname] then
				hotkeyStr = " (" .. "\255\170\255\170" .. "Hotkey: " .. humanNameToKeySymbols[unitname] .. white .. ")"
			end
			
			if unitpre ~= "" then
				local techText = unitpre:sub(22, 22)
				if techText == "0" or techText == nil then
					unitpre = ""
				else 
					-- unitpre = unitpre:sub(1, 13) .. TechColour[tonumber(techText)] .. "Tech " .. techText
				end
			end
			
			local unitsupplycost = fud.customParams.supply_cost or 0
			local unitsupplygive = fud.customParams.supply_granted or 0
			local costStr = GetTooltipCost(unitsupplycost, unitsupplygive, unitenergycost or fud.energyCost, unitmetalcost or fud.metalCost)
			local armorTypeStr = GetTooltipArmor(fud)
			NewTooltip = NewTooltip.."\n"..unitpre.."\n"..fud.humanName..hotkeyStr.." ("..fud.tooltip..")\n"..
				costStr.."\255\213\213\255".."    Build time: ".."\255\170\170\255"..
				floor((29+floor(31+fud.buildTime/(buildpower/32)))/30).."s".."    "..GetTooltipTransportability(fud).."\n"..
				"\255\200\200\200Health: ".."\255\200\200\200"..fud.health.." ("..armorTypeStr..")"
				if fud.shieldPower > 0 then NewTooltip=NewTooltip.."\255\135\135\255     Shield: "..FormatNbr(fud.shieldPower) end
					
			-- weapons
			if fud.weapons and fud.weapons[1] and fud.weapons[1].weaponDef then
				NewTooltip = NewTooltip..GetTooltipWeaponData(fud)
			end
			
			-- build power
			if fud.buildSpeed and fud.buildSpeed > 0 then
				NewTooltip = NewTooltip.."\n"..GetTooltipBuildPower(fud.buildSpeed).."\255\255\255\255"
			end
			
			-- speed
			NewTooltip = NewTooltip.."\255\255\255\255\n"
			if fud.speed and fud.speed>0 then
				NewTooltip = NewTooltip.."\255\193\255\187Speed: \255\134\255\121"..FormatNbr(fud.speed,2).."\255\255\255\255"
			end
			FoundTooltipType="knownbuildbutton"
			
			if fud.windGenerator > 1 then
			   	local minWindE = FormatNbr((fud.windGenerator/25)*Game.windMin,0)
				local maxWindE = FormatNbr((fud.windGenerator/25)*Game.windMax,0)
				NewTooltip = NewTooltip.."Generates \255\255\255\0"..minWindE.."-"..maxWindE.." E/s\255\255\255\255 (up to +20% on higher ground) \n"
			elseif fud.tidalGenerator == 1 then
				NewTooltip = NewTooltip.."Generates \255\255\255\0"..Game.tidal.." E/s\255\255\255\255\n"
			end
			
			--[[if fud.customParams.tip then
				NewTooltip = NewTooltip.."\n\255\180\180\180"..fud.customParams.tip.."\255\255\255\255\n"
			end]]
		else
		    NewTooltip = NewTooltip.."\n"..unitpre.."\n"..unitname.." ("..unitdesc..")\n"..
		            "\255\255\213\213Health: ".."\255\255\170\170"..unithealth..
		            "\n\255\213\213\255Build time: ".."\255\170\170\255"..
		            floor((29+floor(31+unitbuildtime/(buildpower/32)))/30).."s"..
		            "\255\255\255\255\n"
			--NewTooltip = "WTF IS THIS " .. unitname
			--Spring.Echo("collisions",collisions)
		    FoundTooltipType="unknownbuildbutton"
		end
	end
 
	local isItLiveUnitTooltip = string.match(CurrentTooltip,"Experience (.+) Cost ")
	if isItLiveUnitTooltip or CurrentTooltip=="" then

		-- id being calculated way above
		--[[if not id and spGetSelectedUnitsCount()>=1 then
			id = spGetSelectedUnits()[spGetSelectedUnitsCount()]
		end]]
                
		-- many units
		--if id and spGetSelectedUnitsCount()>1 then
		if spGetSelectedUnitsCount()>1 then
			
			if id then NewTooltip = NewTooltip .. GetTooltipUnit(id)
			else
				local totalMetalMake = 0
				local totalMetalUse = 0 
				local totalEnergyMake = 0
				local totalEnergyUse = 0
				local totalHealth = 0
				local totalMaxHealth = 0
				local totalShieldPower = 0
				local totalMaxShieldPower = 0
				local totalEnergyCost = 0
				local totalMetalCost = 0
				local totalSupplyCost = 0
				local totalSupplyGive = 0
				local anyShield = false
				local highestTech = 0
						
				for _,u in pairs(spGetSelectedUnits()) do
				
					--[[local hpMod = spGetUnitRulesParam(u,"upgrade_hp")
					if not hpMod then
						hpMod = 1
					else
						hpMod = 1 + hpMod
					end]]
					local ud=UnitDefs[Spring.GetUnitDefID(u)]
					local metalMake,metalUse,energyMake,energyUse = Spring.GetUnitResources(u)
					local health,maxHealth,paralyzeDamage,captureProgress,buildProgress = Spring.GetUnitHealth(u)						
					--[[health = health * hpMod
					maxHealth = maxHealth * hpMod]]
					health = health
					maxHealth = maxHealth
					local hasShield, ShieldPower=Spring.GetUnitShieldState(u)
					local maxShieldPower = ud.shieldPower
					if(hasShield) then
						anyShield = true
					end
					
					-- energy and metal cost
					totalEnergyCost = totalEnergyCost + ud.energyCost
					totalMetalCost = totalMetalCost + ud.metalCost
					totalSupplyCost = totalSupplyCost + (ud.customParams.supply_cost or 0)
					totalSupplyGive = totalSupplyGive + (ud.customParams.supply_granted or 0)
					
					-- Evo: upgrade levels
					local upgradeLevel = ud.name:find("_up", -5) and tonumber(ud.name:sub(-1, -1)) or 0
					highestTech = highestTech < upgradeLevel and upgradeLevel or highestTech
											
					if (health and maxHealth) then
						totalHealth = totalHealth + health
						totalMaxHealth = totalMaxHealth + maxHealth
					end
					if (hasShield) then
						totalShieldPower = totalShieldPower + ShieldPower
						totalMaxShieldPower = totalMaxShieldPower + maxShieldPower
					end
					
					-- energy and metal upkeep
					if( metalMake and metalUse and energyMake and energyUse) then
						totalMetalMake = totalMetalMake + metalMake
						totalMetalUse = totalMetalUse + metalUse
						totalEnergyMake = totalEnergyMake + energyMake
						totalEnergyUse = totalEnergyUse + energyUse							
					end
				end
				
				-- Evo: upgrade levels
				local techStr = ""
				if highestTech > 0 then techStr = white .. "   Highest upgrade: " .. TechToStr[highestTech] end
						
				-- cost
				--NewTooltip = NewTooltip.."\255\200\200\200Metal: "..totalMetalCost.."    \255\255\255\0Energy: "..totalEnergyCost.."\n"
				NewTooltip = NewTooltip..GetTooltipCost(totalSupplyCost, totalSupplyGive, totalEnergyCost, totalMetalCost)..techStr.."\n"
				
				-- health totals					
				NewTooltip = NewTooltip.."\255\200\200\200Health: ".."\255\200\200\200"..floor(totalHealth).."\255\200\200\200/\255\200\200\200"..floor(totalMaxHealth)
				if anyShield then NewTooltip=NewTooltip.."\255\135\135\255      Shield: "..FormatNbr(math.min(totalShieldPower,totalMaxShieldPower)).."/"..FormatNbr(totalMaxShieldPower) end
				
				-- energy and metal upkeep totals
				if true then
					--NewTooltip = NewTooltip.."\n\255\200\200\200Metal: \255\0\255\0+"..FormatNbr(totalMetalMake,1).."\255\255\255\255/\255\255\0\0"..FormatNbr(-totalMetalUse,1)
					--NewTooltip = NewTooltip.."    \255\255\255\0Energy: \255\0\255\0+"..FormatNbr(totalEnergyMake,1).."\255\255\255\255/\255\255\0\0"..FormatNbr(-totalEnergyUse,1)
					local upkeepStr = GetTooltipUpkeep(totalEnergyMake, totalEnergyUse, totalMetalMake, totalMetalUse)
					NewTooltip = NewTooltip.."\n"..upkeepStr
				end
			end
			
			FoundTooltipType="liveunit"

		-- one unit
		elseif id or spGetSelectedUnitsCount()==1 then
			if not id then id = spGetSelectedUnits()[1] end
			NewTooltip = NewTooltip .. GetTooltipUnit(id)
 
			FoundTooltipType="liveunit"
		end
	end
 
	local hotkeys = string.match(CurrentTooltip.."\n","Hotkeys: (.-)\n")
	if hotkeys then
		HotkeyTooltip = "\n\255\255\196\128Hotkeys: ".."\255\255\128\001"..hotkeys.."\255\255\255\255"
		CurrentTooltip=string.gsub(CurrentTooltip.."\n","Hotkeys: .-\n","")
		NewTooltip=NewTooltip..HotkeyTooltip
		CurrentTooltip=CurrentTooltip..HotkeyTooltip
	end
	
	-- default resource color (a,r,g,b) = (255, 255, 80, 1)
	local _, metal = CurrentTooltip:find("Metal: ")
	local _, energy = CurrentTooltip:find("Energy: ")
	if metal and energy then
		-- bad solution
		local featureName = CurrentTooltip:match("(.+)\n")
		local metalValue, _, energyValue = CurrentTooltip:match("(%d+)(.-)(%d+)")
		if metalValue == "0" and energyValue == "0" then
			CurrentTooltip = featureName
		else
			CurrentTooltip = CurrentTooltip:gsub("(%d+)(.-)(%d+)", "%3%2%1", 1) -- first swap metal and energy values for Evo (Supply, Energy, Metal)
			CurrentTooltip = CurrentTooltip:sub(1, energy) .. CurrentTooltip:sub(energy + 5) -- remove default resource color
			CurrentTooltip = CurrentTooltip:sub(1, metal) .. CurrentTooltip:sub(metal + 5) -- ditto
			CurrentTooltip = CurrentTooltip:gsub("Metal: ", useEnergyTexture .. " " .. energyColour) -- swap the metal and energy strings to fit the values
			CurrentTooltip = CurrentTooltip:gsub("Energy: ", useMetalTexture .. " " .. metalColour)
		end
	else
		if CurrentTooltip == "Repair: Repairs another unit" then
			CurrentTooltip = "Build: Builds unfinished structures" -- hack for Evo (no repair after construction completed)
		end
		
		-- ignore sell command as well
		if not CurrentTooltip:find("Refund amount") and not CurrentTooltip:find("Evolve into") then
			-- Evo's Evolve tooltip is too cancer
			--if CurrentTooltip:find("Evolve into") and not CurrentTooltip:find("turret") then CurrentTooltip = CurrentTooltip:sub(5) end
			CurrentTooltip = CurrentTooltip:gsub("(.-: )", "\255\170\255\170%1"..white, 1)
		end
	 
		--[[local action = string.match(CurrentTooltip,"(.-)\n")
		if action then
			action = string.match(action,"(.-): ")
			if action then
				CurrentTooltip=string.gsub(CurrentTooltip,"(.-): ","",1)
				CurrentTooltip="\255\170\255\170"..action..":\255\255\255\255 "..CurrentTooltip
			end
		end]]
	end
	
	if FoundTooltipType ~= "liveunit" then
		if WG.smartSelectTooltip and WG.smartSelectTooltip.active then
			local tooltipOverride = WG.smartSelectTooltip.unitCount .. " unit" .. (WG.smartSelectTooltip.unitCount > 1 and "s" or "") .. " selected\n"
			tooltipOverride = tooltipOverride .. GetTooltipCost(WG.smartSelectTooltip.totalSupplyCost, WG.smartSelectTooltip.totalSupplyGive, WG.smartSelectTooltip.totalEnergyCost, WG.smartSelectTooltip.totalMetalCost)
			if WG.smartSelectTooltip.highestTech ~= 0 then tooltipOverride = tooltipOverride .. white .. "   Highest upgrade: " .. TechToStr[WG.smartSelectTooltip.highestTech] end
			tempTooltip = tooltipOverride
			return tempTooltip
		end
	end
  
  --Spring.Echo(FoundTooltipType)
	if FoundTooltipType then
		tempTooltip = NewTooltip
		return NewTooltip
	else
		tempTooltip = CurrentTooltip
		return CurrentTooltip
	end
end
 

local xTooltipSize = 0
local yTooltipSize = 0
local tooltipX, tooltipY = 0, 0
local bgmargin = 4
 
function widget:RecvLuaMsg(msg, playerID)
	if msg:sub(1,18) == 'LobbyOverlayActive' then
		chobbyInterface = (msg:sub(1,19) == 'LobbyOverlayActive1')
	end
end

function widget:DrawScreen()
	if chobbyInterface then return end
		-- KP_ToolTip is probably deprecated
        --WG.KP_ToolTip=nil
        if Spring.IsGUIHidden() then
                return
		end

		if WG['topbar'] and WG['topbar'].showingQuit() then
			return
		end
 
        local nttString = GenerateNewTooltip()
        local nttList = {}
		local lengNttList = 0
        local maxWidth = 0
        for line in string.gmatch(nttString,"[^\r\n]+") do
                --table.insert(nttList,"\255\255\255\255"..line)
				lengNttList = lengNttList + 1
				nttList[lengNttList] = stringSplitIcons("\255\255\255\255"..line, false, useMetalTexture, useEnergyTexture, useSupplyTexture)
				local width = FontSize * font:GetTextWidth(line)
				for i = 2, #nttList[lengNttList], 2 do
					width = width - FontSize * font:GetTextWidth(nttList[lengNttList][i]) + FontSize
				end
                if width > maxWidth then
                        maxWidth = width
                end
        end

        --xTooltipSize = FontSize*(1+maxWidth)
		xTooltipSize = maxWidth + FontSize
        yTooltipSize = FontSize*(1+lengNttList)
 
        -- Bottom left position by default
        local x1,y1,x2,y2= tooltipX, tooltipY, tooltipX + xTooltipSize, tooltipY + yTooltipSize
 
        -- Note: this line is done even if the KP_ToolTip is devoid of text
        -- The only case where KP_ToolTip is nil are when the widget is off or the GUI is hidden
        --WG.KP_ToolTip={x1=x1,y1=y1,x2=x2,y2=y2,xSize=xTooltipSize,ySize=yTooltipSize,FontSize=FontSize}


        gl.Blending(GL.SRC_ALPHA,GL.ONE_MINUS_SRC_ALPHA) -- default
        if WG.MidKnightBG then
            gl.Color(1,1,1,1)
            gl.Texture("bitmaps/tooltipbg.png")
            gl.TexRect(x1,y1,x2*1.2,y2*1.2,0.01,0.99,0.99,0.01)
            gl.Texture(false)
        else
			local tl, tr, br, bl = (y2 >= vsy or x1 <= 0) and 0 or 1, (y2 >= vsy or x2 >= vsx) and 0 or 1, (y1 <= 0 or x2 >= vsx) and 0 or 1, (y1 <= 0 or x1 <= 0) and 0 or 1
            gl.Color(0.0,0.0,0.0,ui_opacity)  --background
			RectRound(x1, y1, x2, y2, 15,tl, tr, br, bl,vsx,vsy)
            gl.Color(0.33,0.33,0.33,0.1*ui_opacity)
			RectRound(x1 + bgmargin, y1 + bgmargin, x2 - bgmargin, y2 - bgmargin, 10,tl, tr, br, bl,vsx,vsy)
            --[[gl.Rect(x1,y1,x2,y2)
            gl.Color(0.0,0.0,0.0,1)  --border
            gl.LineWidth(1)
            gl.Shape(GL.LINE_LOOP,{
                    {v={x1,y2}},{v={x2,y2}},
                    {v={x2,y1}},{v={x1,y1}},})
					]]
            gl.Color(1,1,1,1)

			if (WG['guishader'] ~= nil) then
				guishaderEnabled = true
				WG['guishader'].InsertRect(x1, y1, x2, y2, 'evo_tooltip')
			end
		end
		font:Begin()
        for i = 1, lengNttList do
			local iconStr = nttList[i]
			local currX, currY = x1 + FontSize / 2, y1 + FontSize * (lengNttList + 0.5 - i)
			for j = 1, #iconStr do
				if j % 2 == 1 then
					font:Print(iconStr[j], currX, currY, FontSize, 'o')
					currX = currX + FontSize * font:GetTextWidth(iconStr[j])
				else
					gl.Texture(drawIcons[iconStr[j]])
					-- Icon size = font size
					gl.TexRect(currX, currY - FontSize * 0.2, currX + FontSize, currY - FontSize * 0.2 + FontSize, 0.2, 0.8, 0.8, 0.2)
					currX = currX + FontSize
				end
			end
			--font:Print(nttList[i], currX, currY, FontSize, 'o')
        end
		gl.Texture(false)
        font:Print("\255\255\255\255 ",0,0,FontSize,'o') -- Reset color to white for other widgets using gl.Text
	font:End()
end


local uiOpacitySec = 0
function widget:Update(dt)
	uiOpacitySec = uiOpacitySec + dt
	if uiOpacitySec>0.5 then
		uiOpacitySec = 0
		if ui_opacity ~= Spring.GetConfigFloat("ui_opacity",0.66) then
			ui_opacity = Spring.GetConfigFloat("ui_opacity",0.66)
		end
	end
end


--[[
-- tweaking UI position with ctrl+f11
local widgetScale = 1 -- potential TODO
local tweakStartX, tweakStartY = 0, 0
function widget:TweakMousePress(x, y, button)
	local posxScaled = posx - (bgmargin*widgetScale) - ((vsx - posx) * (widgetScale-1))
	local posyScaled = posy - (bgmargin*widgetScale) - ((vsy - posy) * (widgetScale-1))
  if x >= posxScaled and x < posxScaled + ((width+bgmargin+bgmargin)*widgetScale) and y >= posyScaled and y < posyScaled + ((height+bgmargin+bgmargin)*widgetScale) then
		tweakStartX = x - posx
		tweakStartY = y - posy
    return true
  end
end

function widget:TweakMouseMove(x, y, dx, dy, button)
	posx = x - tweakStartX
	posy = y - tweakStartY
	if posx < 0 then
		posx = 0
	end
	if posx > vsx - width then
		posx = vsx - width
	end
	if posy < 0 then
		posy = 0
	end
	if posy > vsy - height then
		posy = vsy - height
	end
	generateDisplayList()
	generateDisplayList3()
end

-- save and load
function widget:GetConfigData(data)
	return {
		posx = posx,
		posy = posy,
	}
end

function widget:SetConfigData(data)
	posx = data.posx or posx
	posy = data.posy or posy
	generateDisplayList()	
	generateDisplayList3()	
end
 ]]
 
--function widget:MouseWheel(up,value)
--        local xMouse,yMouse = GetMouseState()
--        if xMouse < xTooltipSize and yMouse < yTooltipSize and not Spring.IsGUIHidden() then
--                if up then
--                        FontSize = math.max(FontSize - 1,2)
--                else
--                        FontSize = FontSize + 1
--                end
--                return true
--        end
--        return false
--end
