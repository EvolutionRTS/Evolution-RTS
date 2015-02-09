--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Supply Bar",
    desc      = "",
    author    = "jK, KingRaptor",
    date      = "2010, 2013",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

include("colors.h.lua")

WG.energyWasted = 0
WG.energyForOverdrive = 0
WG.allies = 1
--[[
WG.windEnergy = 0 
WG.highPriorityBP = 0
WG.lowPriorityBP = 0
--]]

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local abs = math.abs
local echo = Spring.Echo
local GetMyTeamID = Spring.GetMyTeamID
local GetTeamResources = Spring.GetTeamResources
local GetTimer = Spring.GetTimer
local DiffTimers = Spring.DiffTimers
local Chili

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local col_normal = {0.2, 0.8, 0.2, 1}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local window
local bar

local blink = 0
local blink_periode = 2
local blink_alpha = 1
local blink_status = false

local isOverLimit = false

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local builderDefs = {}
for id,ud in pairs(UnitDefs) do
	if (ud.isBuilder) then
		builderDefs[#builderDefs+1] = id
	elseif (ud.buildSpeed > 0) then
		builderDefs[#builderDefs+1] = id
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

options_path = 'Settings/HUD Panels/Resource Bars'

options = { 
  opacity = {
	name = "Opacity",
	type = "number",
	value = 0, min = 0, max = 1, step = 0.01,
	OnChange = function(self) window.color = {1,1,1,self.value}; window:Invalidate() end,
  }
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function CreateWindow()
	
	local screenWidth,screenHeight = Spring.GetWindowGeometry()
	
	--// WINDOW
	window = Chili.Window:New{
		color = {1,1,1,options.opacity.value},
		parent = Chili.Screen0,
		dockable = true,
		name = "supply_info",
		padding = {5,10,10,5},
		right = 0,
		y = 0,
		width = 100,
		clientWidth  = 430,
		clientHeight = 40,
		draggable = false,
		resizable = false,
		tweakDraggable = true,
		tweakResizable = true,
		minimizable = false,
		
		OnMouseDown={ function(self)
			local alt, ctrl, meta, shift = Spring.GetModKeyState()
			if not meta then return false end
			WG.crude.OpenPath(options_path)
			WG.crude.ShowMenu()
			return true
		end },
	}

	Chili.Image:New{
		parent = window,
		height = "100%",
		width  = 25,
		y      = 0,
		right  = 0,
		file   = 'LuaUI/Images/supplyicon.png',	-- FIXME proper supply image
	}

	bar = Chili.Progressbar:New{
		parent = window,
		color  = col_normal,
		height = "100%",
		right  = 30,
                x      = 90,
		caption = "0/0",
		tooltip = [[Supply used/supply available (default 250 maximum). Build more generators to increase available supply.]],
		font   = {color = {1,1,1,1}, outlineColor = {0,0,0,0.7}, },
	}

	-- Activate tooltips for bars, they do not have them in default chili
	function bar:HitTest(x,y) return self	end
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function widget:Update(s)
	blink = (blink+s)%blink_periode
	blink_alpha = math.abs(blink_periode/2 - blink)

	if blink_status then
		bar:SetColor( 255,251/255*blink_alpha,214/119/255,0.65 + 0.3*blink_alpha )
	end
end

function widget:GameFrame(n)
	if (n%15 ~= 2) or not window then 
		return 
	end

	local myTeamID = GetMyTeamID()
	local teamParams = Spring.GetTeamRulesParams(myTeamID)
	
	local supplyUsed = Spring.GetTeamRulesParam(myTeamID, "supplyUsed") or 0
	local supplyMax = Spring.GetTeamRulesParam(myTeamID, "supplyMax") or 0
	
	local supplyFraction = 1
	if supplyMax > 0 then
		supplyFraction = supplyUsed/supplyMax
	end
	
	local wasOverLimit = isOverLimit
	isOverLimit = supplyFraction > 1
	
	bar:SetValue(100*supplyFraction)
	if isOverLimit and (not wasOverLimit) then
		bar.font:SetColor(1, 0.2, 0.2, 1)
	elseif (not isOverLimit) and wasOverLimit then
		bar.font:SetColor(1, 1, 1, 1)
	end
	bar:SetCaption(supplyUsed .. "/" .. supplyMax)
	
	local nearMax = supplyFraction > 0.8
	if nearMax then	-- blink
		blink_status = true
	elseif (blink_status) then
		blink_status = false
		bar:SetColor( col_normal )
	end
end

function widget:Initialize()
	Chili = WG.Chili

	if (not Chili) then
		widgetHandler:RemoveWidget()
		return
	end
	CreateWindow()
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------