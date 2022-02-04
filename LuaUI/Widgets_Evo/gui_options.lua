
function widget:GetInfo()
return {
	name    = "Options",
	desc    = "",
	author  = "Floris",
	date    = "September 2016",
	layer   = 20000,
	enabled = true,
	handler = true,
}
end

--[[
--   Add option, at:
--   function init
--
--   Apply new option value:
--   function applyOptionValue
--
--	 Load widget data (to get settings for when widget is disabled):
--   function loadAllWidgetData
--
]]--

local cameraTransitionTime = 0.2
local cameraPanTransitionTime = 0.03

local playSounds = true
local buttonclick = 'LuaUI/Sounds/tock.wav'
local paginatorclick = 'LuaUI/Sounds/buildbar_waypoint.wav'
local sliderdrag = 'LuaUI/Sounds/buildbar_rem.wav'
local selectclick = 'LuaUI/Sounds/buildbar_click.wav'
local selectunfoldclick = 'LuaUI/Sounds/buildbar_hover.wav'
local selecthoverclick = 'LuaUI/Sounds/hover.wav'
local toggleonclick = 'LuaUI/Sounds/switchon.wav'
local toggleoffclick = 'LuaUI/Sounds/switchoff.wav'

local fontfile = LUAUI_DIRNAME .. "fonts/" .. Spring.GetConfigString("ui_font", "JosefinSans-SemiBold.ttf")
local vsx,vsy = Spring.GetViewGeometry()
local fontfileScale = (0.5 + (vsx*vsy / 5700000))
local fontfileSize = 25
local fontfileOutlineSize = 6
local fontfileOutlineStrength = 1.4
local font = gl.LoadFont(fontfile, fontfileSize*fontfileScale, fontfileOutlineSize*fontfileScale, fontfileOutlineStrength)
local fontfileScale2 = fontfileScale * 1.2
local fontfile2 = LUAUI_DIRNAME .. "fonts/" .. Spring.GetConfigString("ui_font2", "JosefinSans-Bold.ttf")
local font2 = gl.LoadFont(fontfile2, fontfileSize*fontfileScale2, fontfileOutlineSize*fontfileScale2, fontfileOutlineStrength)

local bgcorner = "LuaUI/Images/bgcorner.png"
local backwardTex = "LuaUI/Images/backward.dds"
local forwardTex = "LuaUI/Images/forward.dds"
local glowTex = "LuaUI/Images/glow2.dds"

local bgMargin = 6

local closeButtonSize = 30
local screenHeight = 520-bgMargin-bgMargin
local screenWidth = 1050-bgMargin-bgMargin

local changesRequireRestart = false
local textareaMinLines = 10		-- wont scroll down more, will show at least this amount of lines

local customScale = 1

local startLine = 1

local customMapSunPos = {}

local screenX = (vsx*0.5) - (screenWidth/2)
local screenY = (vsy*0.5) + (screenHeight/2)

local wsx,wsy,wpx,wpy = Spring.GetWindowGeometry()
local ssx,ssy,spx,spy = Spring.GetScreenGeometry()

local spIsGUIHidden = Spring.IsGUIHidden

local glColor = gl.Color
local glLineWidth = gl.LineWidth
local glPolygonMode = gl.PolygonMode
local glRect = gl.Rect
local glTexRect = gl.TexRect
local glRotate = gl.Rotate
local glTexture = gl.Texture
local glText = gl.Text
local glShape = gl.Shape

local bgColorMultiplier = 0

local glCreateList = gl.CreateList
local glCallList = gl.CallList
local glDeleteList = gl.DeleteList

local glPopMatrix = gl.PopMatrix
local glPushMatrix = gl.PushMatrix
local glTranslate = gl.Translate
local glScale = gl.Scale

local GL_FILL = GL.FILL
local GL_FRONT_AND_BACK = GL.FRONT_AND_BACK
local GL_LINE_STRIP = GL.LINE_STRIP

local vsx, vsy = Spring.GetViewGeometry()
local widgetScale = (0.5 + (vsx*vsy / 5700000)) * customScale
WG.uiScale = widgetScale
local resolutionX, resolutionY = Spring.GetScreenGeometry()


local myTeamID = Spring.GetMyTeamID()
local amNewbie = (Spring.GetTeamRulesParam(myTeamID, 'isNewbie') == 1)

local defaultMapSunPos = {gl.GetSun("pos")}

local options = {}
local optionGroups = {}
local optionButtons = {}
local optionHover = {}
local optionSelect = {}

local widgetOptionColor = '\255\160\160\160'

local luaShaders = tonumber(Spring.GetConfigInt("ForceShaders",1) or 0)

local presetNames = {'lowest','low','medium','high','ultra'}	-- defined so these get listed in the right order
local presets = {
	lowest = {
		msaa = 0,
		bloom = false,
		bloomhighlights = false,
		ssao = false,
		water = 1,
		mapedgeextension = false,
		lighteffects = false,
		lups = false,
		snow = false,
		xrayshader = false,
		particles = 5000,
		nanoparticles = 500,
		grassdetail = 0,
		treeradius = 0,
		advsky = false,
		timecyclesweathereffects = false,
		outline = false,
		guishader = false,
		shadows = false,
		advmapshading = false,
		advmodelshading = false,
		decals = 0,
		grounddetail = 64,
		darkenmap_darkenfeatures = false,
		enemyspotter_highlight = false,
	},
	low = {
		msaa = 2,
		bloom = false,
		bloomhighlights = false,
		ssao = false,
		water = 2,
		mapedgeextension = false,
		lighteffects = false,
		lups = true,
		snow = false,
		xrayshader = false,
		particles = 10000,
		nanoparticles = 800,
		grassdetail = 0,
		treeradius = 200,
		advsky = false,
		timecyclesweathereffects = false,
		outline = false,
		guishader = false,
		shadows = false,
		advmapshading = true,
		advmodelshading = true,
		decals = 0,
		grounddetail = 64,
		darkenmap_darkenfeatures = false,
		enemyspotter_highlight = false,
	},
	medium = {
		msaa = 4,
		bloom = true,
		bloomhighlights = false,
		ssao = false,
		water = 3,
		mapedgeextension = true,
		lighteffects = true,
		lups = true,
		snow = true,
		xrayshader = false,
		particles = 15000,
		nanoparticles = 1200,
		grassdetail = 0,
		treeradius = 400,
		advsky = false,
		timecyclesweathereffects = false,
		outline = false,
		guishader = false,
		shadows = true,
		advmapshading = true,
		advmodelshading = true,
		decals = 1,
		grounddetail = 64,
		darkenmap_darkenfeatures = false,
		enemyspotter_highlight = false,
	},
	high = {
		msaa = 8,
		bloom = true,
		bloomhighlights = false,
		ssao = true,
		water = 3,
		mapedgeextension = true,
		lighteffects = true,
		lups = true,
		snow = true,
		xrayshader = false,
		particles = 20000,
		nanoparticles = 2000,
		grassdetail = 0,
		treeradius = 800,
		advsky = true,
		timecyclesweathereffects = false,
		outline = true,
		guishader = true,
		shadows = true,
		advmapshading = true,
		advmodelshading = true,
		decals = 2,
		grounddetail = 64,
		darkenmap_darkenfeatures = false,
		enemyspotter_highlight = false,
	},
	ultra = {
		msaa = 16,
		bloom = true,
		bloomhighlights = true,
		ssao = true,
		water = 3,
		mapedgeextension = true,
		lighteffects = true,
		lups = true,
		snow = true,
		xrayshader = false,
		particles = 25000,
		nanoparticles = 5000,
		grassdetail = 0,
		treeradius = 800,
		advsky = true,
		timecyclesweathereffects = false,
		outline = true,
		guishader = true,
		shadows = true,
		advmapshading = true,
		advmodelshading = true,
		decals = 3,
		grounddetail = 64,
		darkenmap_darkenfeatures = true,
		enemyspotter_highlight = true,
	},
}
local customPresets = {}

--if VFS.FileExists("LuaUI/configs/options.lua",VFS.ZIP) then
----if io.open("LuaUI/configs/options.lua",'r') ~= nil then -- file exists?
--	Spring.Echo("Options: loading external options config")
--	include("configs/options.lua")
--end

function widget:ViewResize()
  vsx,vsy = Spring.GetViewGeometry()
  screenX = (vsx*0.5) - (screenWidth/2)
  screenY = (vsy*0.5) + (screenHeight/2)
  widgetScale = (0.5 + (vsx*vsy / 5700000)) * customScale
  WG.uiScale = widgetScale
	local newFontfileScale = (0.5 + (vsx*vsy / 5700000))
	if (fontfileScale ~= newFontfileScale) then
		fontfileScale = newFontfileScale
		fontfileScale2 = fontfileScale * 1.2
		font = gl.LoadFont(fontfile, fontfileSize*fontfileScale, fontfileOutlineSize*fontfileScale, fontfileOutlineStrength)
		font2 = gl.LoadFont(fontfile2, fontfileSize*fontfileScale2, fontfileOutlineSize*fontfileScale2, fontfileOutlineStrength)
	end
  if windowList then gl.DeleteList(windowList) end
  windowList = gl.CreateList(DrawWindow)
end

local showOnceMore = false		-- used because of GUI shader delay

local showOptionsToggleButton = false
local textSize		= 1
local textMargin	= 0.25
local lineWidth		= 0.0625

local posX = 0.947
local posY = 0.965
local buttonGL
local startPosX = posX


local engineVersion = 100 -- just filled this in here incorrectly but old engines arent used anyway
if Engine and Engine.version then
	local function Split(s, separator)
		local results = {}
		for part in s:gmatch("[^"..separator.."]+") do
			results[#results + 1] = part
		end
		return results
	end
	engineVersion = Split(Engine.version, '-')
	if engineVersion[2] ~= nil and engineVersion[3] ~= nil then
		engineVersion = tonumber(string.gsub(engineVersion[1], '%.', '')..engineVersion[2])
	else
		engineVersion = tonumber(Engine.version)
	end
elseif Game and Game.version then
	engineVersion = tonumber(Game.version)
end


local function DrawRectRound(px,py,sx,sy,cs, tl,tr,br,bl)
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
	
	-- bottom left
	if ((py <= 0 or px <= 0)  or (bl ~= nil and bl == 0)) and bl ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(px, py, 0)
	gl.TexCoord(o,1-offset)
	gl.Vertex(px+cs, py, 0)
	gl.TexCoord(1-offset,1-offset)
	gl.Vertex(px+cs, py+cs, 0)
	gl.TexCoord(1-offset,o)
	gl.Vertex(px, py+cs, 0)
	-- bottom right
	if ((py <= 0 or sx >= vsx) or (br ~= nil and br == 0)) and br ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(sx, py, 0)
	gl.TexCoord(o,1-offset)
	gl.Vertex(sx-cs, py, 0)
	gl.TexCoord(1-offset,1-offset)
	gl.Vertex(sx-cs, py+cs, 0)
	gl.TexCoord(1-offset,o)
	gl.Vertex(sx, py+cs, 0)
	-- top left
	if ((sy >= vsy or px <= 0) or (tl ~= nil and tl == 0)) and tl ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(px, sy, 0)
	gl.TexCoord(o,1-offset)
	gl.Vertex(px+cs, sy, 0)
	gl.TexCoord(1-offset,1-offset)
	gl.Vertex(px+cs, sy-cs, 0)
	gl.TexCoord(1-offset,o)
	gl.Vertex(px, sy-cs, 0)
	-- top right
	if ((sy >= vsy or sx >= vsx)  or (tr ~= nil and tr == 0)) and tr ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(sx, sy, 0)
	gl.TexCoord(o,1-offset)
	gl.Vertex(sx-cs, sy, 0)
	gl.TexCoord(1-offset,1-offset)
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.TexCoord(1-offset,o)
	gl.Vertex(sx, sy-cs, 0)
end
function RectRound(px,py,sx,sy,cs, tl,tr,br,bl)		-- (coordinates work differently than the RectRound func in other widgets)
	gl.Texture(bgcorner)
	gl.BeginEnd(GL.QUADS, DrawRectRound, px,py,sx,sy,cs, tl,tr,br,bl)
	gl.Texture(false)
end

function lines(str)
  local t = {}
  local function helper(line) t[#t+1]=line return "" end
  helper((str:gsub("(.-)\r?\n", helper)))
  return t
end

function tableMerge(t1, t2)
	for k,v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k] or false) == "table" then
				tableMerge(t1[k] or {}, t2[k] or {})
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end
	return t1
end

function deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[deepcopy(orig_key)] = deepcopy(orig_value)
		end
		setmetatable(copy, deepcopy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

function getOptionByID(id)
	for i, option in pairs(options) do
		if option.id == id then
			return i
		end
	end
	return false
end


function orderOptions()
	local groupOptions = {}
	for id,group in pairs(optionGroups) do
		groupOptions[group.id] = {}
	end
	for oid,option in pairs(options) do
		if option.type ~= 'label' then
			groupOptions[option.group][#groupOptions[option.group]+1] = option
		end
	end
	local newOptions = {}
	local newOptionsCount = 0
	for id,group in pairs(optionGroups) do
		grOptions = groupOptions[group.id]
		if #grOptions > 0 then
			local name = group.name
			if group.id == 'gfx' then
				name = group.name..'                                          \255\130\130\130'..vsx..' x '..vsy
			end
			newOptionsCount = newOptionsCount +1
			newOptions[newOptionsCount] = {id="group_"..group.id, name=name, type="label"}
		end
		for oid,option in pairs(grOptions) do
			newOptionsCount = newOptionsCount +1
			newOptions[newOptionsCount] = option
		end
	end
	options = deepcopy(newOptions)
end


function mouseoverGroupTab(id)
	if optionGroups[id].id == currentGroupTab then return end

	local tabFontSize = 16
	local groupMargin = bgMargin/1.7
	gl.Color(0.4,0.4,0.4,0.3)
	RectRound(groupRect[id][1]+groupMargin, groupRect[id][2], groupRect[id][3]-groupMargin, groupRect[id][4]-groupMargin, groupMargin*1.8, 1,1,0,0)
	font2:Begin()
	font2:SetTextColor(1,0.85,0.55,1)
	font2:SetOutlineColor(0.4,0.3,0.15,0.4)
	font2:Print(optionGroups[id].name, groupRect[id][1]+((groupRect[id][3]-groupRect[id][1])/2), screenY+bgMargin+8, tabFontSize, "con")
	font2:End()
end

local startColumn = 1		-- used for navigation
local maxShownColumns = 3
local maxColumnRows = 0 	-- gets calculated
local totalColumns = 0 		-- gets calculated
function DrawWindow()

	orderOptions()

	local x = screenX --rightwards
	local y = screenY --upwards
	-- background
	if WG['guishader'] then
		gl.Color(0,0,0,0.8)
	else
		gl.Color(0,0,0,0.85)
	end
	RectRound(x-bgMargin,y-screenHeight-bgMargin,x+screenWidth+bgMargin,y+bgMargin,8, 0,1,1,1)
	-- content area
	if currentGroupTab then
		gl.Color(0.4,0.4,0.4,0.15)
	else
		gl.Color(0.33,0.33,0.33,0.15)
	end
	RectRound(x,y-screenHeight,x+screenWidth,y,6)
	
	--[[ close button
	local size = closeButtonSize*0.7
	local width = size*0.055
  gl.Color(1,1,1,1)
	gl.PushMatrix()
		gl.Translate(screenX+screenWidth-(closeButtonSize/2),screenY-(closeButtonSize/2),0)
  	gl.Rotate(-45,0,0,1)
  	gl.Rect(-width,size/2,width,-size/2)
  	gl.Rotate(90,0,0,1)
  	gl.Rect(-width,size/2,width,-size/2)
	gl.PopMatrix()]]--

	-- title
	local title = "Settings"
	local titleFontSize = 18
	titleRect = {x-bgMargin, y+bgMargin, x+(font2:GetTextWidth(title)*titleFontSize)+27-bgMargin, y+37 }

	-- group tabs
	local tabFontSize = 16
	local xpos = titleRect[3]
	local groupMargin = bgMargin/1.7
	groupRect = {}
	for id,group in pairs(optionGroups) do
		groupRect[id] = {xpos, y+(bgMargin/2), xpos+(font2:GetTextWidth(group.name)*tabFontSize)+27, y+37}
		xpos = groupRect[id][3]
		if currentGroupTab == nil or currentGroupTab ~= group.id then
			if WG['guishader'] then
				gl.Color(0,0,0,0.8)
			else
				gl.Color(0,0,0,0.85)
			end
			RectRound(groupRect[id][1], groupRect[id][2]+(bgMargin/2), groupRect[id][3], groupRect[id][4], 8, 1,1,0,0)
			gl.Color(0.62,0.5,0.22,0.18)
			RectRound(groupRect[id][1]+groupMargin, groupRect[id][2], groupRect[id][3]-groupMargin, groupRect[id][4]-groupMargin, groupMargin*1.8, 1,1,0,0)
			font2:Begin()
			font2:SetTextColor(0.6,0.51,0.38,1)
			font2:SetOutlineColor(0,0,0,0.4)
			font2:Print(group.name, groupRect[id][1]+((groupRect[id][3]-groupRect[id][1])/2), y+bgMargin+8, tabFontSize, "con")
			font2:End()
		else
			if WG['guishader'] then
				gl.Color(0,0,0,0.8)
			else
				gl.Color(0,0,0,0.85)
			end
			RectRound(groupRect[id][1], groupRect[id][2]+(bgMargin/2), groupRect[id][3], groupRect[id][4], 8, 1,1,0,0)
			gl.Color(0.4,0.4,0.4,0.15)
			RectRound(groupRect[id][1]+groupMargin, groupRect[id][2]+(bgMargin/2)-bgMargin, groupRect[id][3]-groupMargin, groupRect[id][4]-groupMargin, groupMargin*1.8, 1,1,0,0)
			font2:Begin()
			font2:SetTextColor(1,0.75,0.4,1)
			font2:SetOutlineColor(0,0,0,0.4)
			font2:Print(group.name, groupRect[id][1]+((groupRect[id][3]-groupRect[id][1])/2), y+bgMargin+8, tabFontSize, "con")
			font2:End()
		end
	end

	-- title drawing
	if WG['guishader'] then
		gl.Color(0,0,0,0.8)
	else
		gl.Color(0,0,0,0.85)
	end
	RectRound(titleRect[1], titleRect[2], titleRect[3], titleRect[4], 8, 1,1,0,0)

	font2:Begin()
	font2:SetTextColor(1,1,1,1)
	font2:SetOutlineColor(0,0,0,0.4)
	font2:Print(title, x-bgMargin+(titleFontSize*0.75), y+bgMargin+8, titleFontSize, "on")
	font2:End()

	font:Begin()
	local width = screenWidth/3
	--gl.Color(0.66,0.66,0.66,0.08)
	--RectRound(x+width+width+6,y-screenHeight,x+width+width+width,y,6)

	-- description background
	--gl.Color(0.55,0.48,0.22,0.14)
	gl.Color(1,0.85,0.55,0.04)
	RectRound(x,y-screenHeight,x+width+width,y-screenHeight+90,6)

	-- draw options
	local oHeight = 15
	local oPadding = 6
	y = y - oPadding - 11
	local oWidth = (screenWidth/3)-oPadding-oPadding
	local yHeight = screenHeight-102-oPadding
	local xPos = x + oPadding + 5
	local xPosMax = xPos + oWidth - oPadding - oPadding
	local yPosMax = y-yHeight
	local boolPadding = 3.5
	local boolWidth = 40
	local sliderWidth = 110
	local selectWidth = 140
	local i = 0
	local rows = 0
	local column = 1
	local drawColumnPos = 1

	maxColumnRows = math.floor((y-yPosMax+oPadding) / (oHeight+oPadding+oPadding))
	local numOptions = #options
	if currentGroupTab ~= nil then
		numOptions = 0
		for oid,option in pairs(options) do
			if option.group == currentGroupTab then
				numOptions = numOptions + 1
			end
		end
	end
	totalColumns = math.ceil(numOptions / maxColumnRows)

	optionButtons = {}
	optionHover = {}


	-- draw navigation... backward/forward
	if totalColumns > maxShownColumns then
		local buttonSize = 52
		local buttonMargin = 18
		local startX = x+screenWidth
		local startY = screenY-screenHeight+buttonMargin

		glColor(1,1,1,1)

		if (startColumn-1) + maxShownColumns  <  totalColumns then
			optionButtonForward = {startX-buttonSize-buttonMargin, startY, startX-buttonMargin, startY+buttonSize}
			glColor(1,1,1,1)
			glTexture(forwardTex)
			glTexRect(optionButtonForward[1], optionButtonForward[2], optionButtonForward[3], optionButtonForward[4])
		else
			optionButtonForward = nil
		end

		font:SetTextColor(1,1,1,0.4)
		font:Print(math.ceil(startColumn/maxShownColumns)..' / '..math.ceil(totalColumns/maxShownColumns), startX-(buttonSize*2.6)-buttonMargin, startY+buttonSize/2.6, buttonSize/2.9, "rn")
		if startColumn > 1 then
			if optionButtonForward == nil then
				optionButtonBackward = {startX-buttonSize-buttonMargin, startY, startX-buttonMargin, startY+buttonSize }
			else
				optionButtonBackward = {startX-(buttonSize*2)-buttonMargin-(buttonMargin/1.5), startY, startX-(buttonSize*1)-buttonMargin-(buttonMargin/1.5), startY+buttonSize}
			end
			glColor(1,1,1,1)
			glTexture(backwardTex)
			glTexRect(optionButtonBackward[1], optionButtonBackward[2], optionButtonBackward[3], optionButtonBackward[4])
		else
			optionButtonBackward = nil
		end
	end

	-- require restart notification
	if changesRequireRestart then
		font:SetTextColor(1,0.35,0.35,1)
		font:SetOutlineColor(0,0,0,0.4)
		font:Print("...made changes that require restart", x+screenWidth-3, screenY-screenHeight+3, 15, "rn")
	end

	-- draw options
	for oid,option in pairs(options) do
		if currentGroupTab == nil or option.group == currentGroupTab then
			yPos = y-(((oHeight+oPadding+oPadding)*i)-oPadding)
			if yPos-oHeight < yPosMax then
				i = 0
				column = column + 1
				if column >= startColumn and rows > 0 then
					drawColumnPos = drawColumnPos + 1
				end
				if drawColumnPos > 3 then
					break
				end
				if rows > 0 then
					xPos = x + (( (screenWidth/3))*(drawColumnPos-1))
					xPosMax = xPos + oWidth
				end
				yPos = y-(((oHeight+oPadding+oPadding)*i)-oPadding)
			end

			if column >= startColumn then
				rows = rows + 1
				--option name
				color = '\255\225\225\225  '
				if option.type == 'label' then
					color = '\255\235\200\125'
				end

				font:SetTextColor(1,1,1,1)
				font:Print(color..option.name, xPos+(oPadding/2), yPos-(oHeight/3)-oPadding, oHeight, "no")

				-- define hover area
				optionHover[oid] = {xPos, yPos-oHeight-oPadding, xPosMax, yPos+oPadding}

				-- option controller
				local rightPadding = 4
				if option.type == 'bool' then
					optionButtons[oid] = {}
					optionButtons[oid] = {xPosMax-boolWidth-rightPadding, yPos-oHeight, xPosMax-rightPadding, yPos}
					glColor(1,1,1,0.11)
					RectRound(xPosMax-boolWidth-rightPadding, yPos-oHeight, xPosMax-rightPadding, yPos, 2)
					if option.value == true then
						glColor(0.66,0.92,0.66,1)
						RectRound(xPosMax-oHeight+boolPadding-rightPadding, yPos-oHeight+boolPadding, xPosMax-boolPadding-rightPadding, yPos-boolPadding, 1)
						local boolGlow = boolPadding*3.5
						glColor(0.66,1,0.66,0.5)
						glTexture(glowTex)
						glTexRect(xPosMax-oHeight+boolPadding-rightPadding-boolGlow, yPos-oHeight+boolPadding-boolGlow, xPosMax-boolPadding-rightPadding+boolGlow, yPos-boolPadding+boolGlow)
						glColor(0.55,1,0.55,0.09)
						glTexture(glowTex)
						glTexRect(xPosMax-oHeight+boolPadding-rightPadding-(boolGlow*3), yPos-oHeight+boolPadding-(boolGlow*3), xPosMax-boolPadding-rightPadding+(boolGlow*3), yPos-boolPadding+(boolGlow*3))
					elseif option.value == 0.5 then
						glColor(0.91,0.82,0.66,1)
						RectRound(xPosMax-(boolWidth/1.9)+boolPadding-rightPadding, yPos-oHeight+boolPadding, xPosMax-(boolWidth/1.9)+oHeight-boolPadding-rightPadding, yPos-boolPadding, 1)
					else
						glColor(0.9,0.66,0.66,1)
						RectRound(xPosMax-boolWidth+boolPadding-rightPadding, yPos-oHeight+boolPadding, xPosMax-boolWidth+oHeight-boolPadding-rightPadding, yPos-boolPadding, 1)
				   end

				elseif option.type == 'slider' then
					local sliderSize = oHeight*0.75
					local sliderPos = 0
					if option.steps then
						local min, max = option.steps[1], option.steps[1]
						for k, v in ipairs(option.steps) do
							if v > max then max = v end
							if v < min then min = v end
						end
						sliderPos = (option.value-min) / (max-min)
					else
						sliderPos = (option.value-option.min) / (option.max-option.min)
					end
					glColor(1,1,1,0.11)
					RectRound(xPosMax-(sliderSize/2)-sliderWidth-rightPadding, yPos-((oHeight/7)*4.2), xPosMax-(sliderSize/2)-rightPadding, yPos-((oHeight/7)*2.8), 1)
					glColor(0.8,0.8,0.8,1)
					RectRound(xPosMax-(sliderSize/2)-sliderWidth+(sliderWidth*sliderPos)-(sliderSize/2)-rightPadding, yPos-oHeight+((oHeight-sliderSize)/2), xPosMax-(sliderSize/2)-sliderWidth+(sliderWidth*sliderPos)+(sliderSize/2)-rightPadding, yPos-((oHeight-sliderSize)/2), 1)
					optionButtons[oid] = {xPosMax-(sliderSize/2)-sliderWidth+(sliderWidth*sliderPos)-(sliderSize/2)-rightPadding, yPos-oHeight+((oHeight-sliderSize)/2), xPosMax-(sliderSize/2)-sliderWidth+(sliderWidth*sliderPos)+(sliderSize/2)-rightPadding, yPos-((oHeight-sliderSize)/2)}
					optionButtons[oid].sliderXpos = {xPosMax-(sliderSize/2)-sliderWidth-rightPadding, xPosMax-(sliderSize/2)-rightPadding}

				elseif option.type == 'select' then
					optionButtons[oid] = {xPosMax-selectWidth-rightPadding, yPos-oHeight, xPosMax-rightPadding, yPos}
					glColor(1,1,1,0.11)
					RectRound(xPosMax-selectWidth-rightPadding, yPos-oHeight, xPosMax-rightPadding, yPos, 2)
					if option.options[tonumber(option.value)] ~= nil then
						if option.id == 'font2' then
							font:End()
							font2:Begin()
							font2:SetTextColor(1,1,1,1)
							font2:Print(option.options[tonumber(option.value)], xPosMax-selectWidth+5-rightPadding, yPos-(oHeight/3)-oPadding, oHeight*0.85, "no")
							font2:End()
							font:Begin()
						else
							font:SetTextColor(1,1,1,1)
							font:Print(option.options[tonumber(option.value)], xPosMax-selectWidth+5-rightPadding, yPos-(oHeight/3)-oPadding, oHeight*0.85, "no")
						end
					end
					glColor(1,1,1,0.11)
					RectRound(xPosMax-oHeight-rightPadding, yPos-oHeight, xPosMax-rightPadding, yPos, 1)
					glColor(1,1,1,0.16)
					glTexture(bgcorner)
					glPushMatrix()
					glTranslate(xPosMax-(oHeight*0.5)-rightPadding, yPos-(oHeight*0.33), 0)
						glRotate(-45,0,0,1)
						glTexRect(-(oHeight*0.25),-(oHeight*0.25),(oHeight*0.25),(oHeight*0.25))
					glPopMatrix()
				end
			end
			i = i + 1
		end
	end
	font:End()
end


function correctMouseForScaling(x,y)
	local interfaceScreenCenterPosX = (screenX+(screenWidth/2))/vsx
	local interfaceScreenCenterPosY = (screenY-(screenHeight/2))/vsy
	x = x - (((x/vsx)-interfaceScreenCenterPosX) * vsx)*((widgetScale-1)/widgetScale)
	y = y - (((y/vsy)-interfaceScreenCenterPosY) * vsy)*((widgetScale-1)/widgetScale)
	return x,y
end

local sec = 0
local lastUpdate = 0
function widget:Update(dt)
	if WG['advplayerlist_api'] and not WG['advplayerlist_api'].GetLockPlayerID() then
		--if select(7, Spring.GetMouseState()) then	-- when camera panning
		--	Spring.SetCameraState(Spring.GetCameraState(), cameraPanTransitionTime)
		--else
			Spring.SetCameraState(Spring.GetCameraState(), cameraTransitionTime)
		--end
	end
	sec = sec + dt
	if show and (sec > lastUpdate + 0.5 or forceUpdate) then
		forceUpdate = nil
		lastUpdate = sec
		local changes = true
		for i, option in ipairs(options) do
			if options[i].widget ~= nil and options[i].type == 'bool' and options[i].value ~= GetWidgetToggleValue(options[i].widget) then
				options[i].value = GetWidgetToggleValue(options[i].widget)
				changes = true
			end
		end
		if changes then
			if windowList then
				gl.DeleteList(windowList)
			end
			windowList = gl.CreateList(DrawWindow)
		end
		--options[getOptionByID('sndvolmaster')].value = tonumber(Spring.GetConfigInt("snd_volmaster",40) or 40)	-- update value because other widgets can adjust this too
		--if getOptionByID('sndvolmusic') then
		--	if WG['music'] and WG['music'].GetMusicVolume then
		--		options[getOptionByID('sndvolmusic')].value = WG['music'].GetMusicVolume()
		--	else
		--		options[getOptionByID('sndvolmusic')].value = tonumber(Spring.GetConfigInt("snd_volmusic",20) or 20)
		--	end
		--end
	end
end

function widget:CommandNotify(cmdID, cmdParams, cmdOptions)
	if show then
		--on window
		local rectX1 = ((screenX-bgMargin) * widgetScale) - ((vsx * (widgetScale-1))/2)
		local rectY1 = ((screenY+bgMargin) * widgetScale) - ((vsy * (widgetScale-1))/2)
		local rectX2 = ((screenX+screenWidth+bgMargin) * widgetScale) - ((vsx * (widgetScale-1))/2)
		local rectY2 = ((screenY-screenHeight-bgMargin) * widgetScale) - ((vsy * (widgetScale-1))/2)
		local x,y,ml = Spring.GetMouseState()
		local cx, cy = correctMouseForScaling(x,y)
		if IsOnRect(x, y, rectX1, rectY2, rectX2, rectY1) then
			return true
		elseif groupRect ~= nil then
			for id,group in pairs(optionGroups) do
				if IsOnRect(cx, cy, groupRect[id][1], groupRect[id][2], groupRect[id][3], groupRect[id][4]) then
					return true
				end
			end
		end
	end
end

function widget:RecvLuaMsg(msg, playerID)
	if msg:sub(1,18) == 'LobbyOverlayActive' then
		chobbyInterface = (msg:sub(1,19) == 'LobbyOverlayActive1')
	end
end

function widget:DrawScreen()
	if chobbyInterface then return end

  if spIsGUIHidden() then return end

  if showOptionsToggleButton then
	  glPushMatrix()
		glTranslate(posX*vsx, posY*vsy, 0)
		glScale(17*widgetScale, 17*widgetScale, 1)
		glColor(0, 0, 0, (0.3*bgColorMultiplier))
		glCallList(buttonGL)
	  glPopMatrix()
  end

  -- draw the window
  if not windowList then
    --windowList = gl.CreateList(DrawWindow)
  end
  
  -- update new slider value
	if sliderValueChanged then
		gl.DeleteList(windowList)
		windowList = gl.CreateList(DrawWindow)
		sliderValueChanged = nil
  end
  
  if selectOptionsList then
  	if WG['guishader'] then
  		WG['guishader'].RemoveScreenRect('options_select')
  		WG['guishader'].removeRenderDlist(selectOptionsList)
  	end
  	glDeleteList(selectOptionsList)
  	selectOptionsList = nil
  end

  if show or showOnceMore then

	  --on window
	  local rectX1 = ((screenX-bgMargin) * widgetScale) - ((vsx * (widgetScale-1))/2)
	  local rectY1 = ((screenY+bgMargin) * widgetScale) - ((vsy * (widgetScale-1))/2)
	  local rectX2 = ((screenX+screenWidth+bgMargin) * widgetScale) - ((vsx * (widgetScale-1))/2)
	  local rectY2 = ((screenY-screenHeight-bgMargin) * widgetScale) - ((vsy * (widgetScale-1))/2)
	  local x,y,ml = Spring.GetMouseState()
	  local cx, cy = correctMouseForScaling(x,y)
	  if IsOnRect(x, y, rectX1, rectY2, rectX2, rectY1) then
	  	Spring.SetMouseCursor('cursornormal')
	  elseif groupRect ~= nil then
		  for id,group in pairs(optionGroups) do
			  if IsOnRect(cx, cy, groupRect[id][1], groupRect[id][2], groupRect[id][3], groupRect[id][4]) then
				  Spring.SetMouseCursor('cursornormal')
				  break
			  end
		  end
	  elseif titleRect ~= nil and IsOnRect(cx, cy, titleRect[1], titleRect[2], titleRect[3], titleRect[4]) then
		  Spring.SetMouseCursor('cursornormal')
	  end
		-- draw the options panel
		glPushMatrix()
			glTranslate(-(vsx * (widgetScale-1))/2, -(vsy * (widgetScale-1))/2, 0)
			glScale(widgetScale, widgetScale, 1)
			glCallList(windowList)
			if WG['guishader'] then
				local rectX1 = ((screenX-bgMargin) * widgetScale) - ((vsx * (widgetScale-1))/2)
				local rectY1 = ((screenY+bgMargin) * widgetScale) - ((vsy * (widgetScale-1))/2)
				local rectX2 = ((screenX+screenWidth+bgMargin) * widgetScale) - ((vsx * (widgetScale-1))/2)
				local rectY2 = ((screenY-screenHeight-bgMargin) * widgetScale) - ((vsy * (widgetScale-1))/2)
				if backgroundGuishader ~= nil then
					glDeleteList(backgroundGuishader)
				end
				backgroundGuishader = glCreateList( function()
					-- background
					RectRound(rectX1, rectY2, rectX2, rectY1, 9*widgetScale, 0,1,1,1)
					-- title
					rectX1 = (titleRect[1] * widgetScale) - ((vsx * (widgetScale-1))/2)
					rectY1 = (titleRect[2] * widgetScale) - ((vsy * (widgetScale-1))/2)
					rectX2 = (titleRect[3] * widgetScale) - ((vsx * (widgetScale-1))/2)
					rectY2 = (titleRect[4] * widgetScale) - ((vsy * (widgetScale-1))/2)
					RectRound(rectX1, rectY1, rectX2, rectY2, 9*widgetScale, 1,1,0,0)
					-- tabs
					for id,group in pairs(optionGroups) do
						if groupRect[id] then
							rectX1 = (groupRect[id][1] * widgetScale) - ((vsx * (widgetScale-1))/2)
							rectY1 = (groupRect[id][2] * widgetScale) - ((vsy * (widgetScale-1))/2)
							rectX2 = (groupRect[id][3] * widgetScale) - ((vsx * (widgetScale-1))/2)
							rectY2 = (groupRect[id][4] * widgetScale) - ((vsy * (widgetScale-1))/2)
							RectRound(rectX1, rectY1, rectX2, rectY2, 9*widgetScale, 1,1,0,0)
						end
					end
				end)
				WG['guishader'].InsertDlist(backgroundGuishader, 'options')
			end
			showOnceMore = false
			
			-- draw button hover
			local usedScreenX = (vsx*0.5) - ((screenWidth/2)*widgetScale)
			local usedScreenY = (vsy*0.5) + ((screenHeight/2)*widgetScale)
			
			-- mouseover (highlight and tooltip)

		  	local description = ''
			local x,y,ml = Spring.GetMouseState()
			local cx, cy = correctMouseForScaling(x,y)

			if groupRect ~= nil then
				for id,group in pairs(optionGroups) do
					if IsOnRect(cx, cy, groupRect[id][1], groupRect[id][2], groupRect[id][3], groupRect[id][4]) then
						  mouseoverGroupTab(id)
					end
				end
			end
			if optionButtonForward ~= nil and IsOnRect(cx, cy, optionButtonForward[1], optionButtonForward[2], optionButtonForward[3], optionButtonForward[4]) then
				if ml then
					glColor(1,0.91,0.66,0.36)
				else
					glColor(1,1,1,0.14)
				end
				RectRound(optionButtonForward[1], optionButtonForward[2], optionButtonForward[3], optionButtonForward[4], (optionButtonForward[4]-optionButtonForward[2])/12)
			end
			if optionButtonBackward ~= nil and IsOnRect(cx, cy, optionButtonBackward[1], optionButtonBackward[2], optionButtonBackward[3], optionButtonBackward[4]) then
				if ml then
					glColor(1,0.91,0.66,0.36)
				else
					glColor(1,1,1,0.14)
				end
				RectRound(optionButtonBackward[1], optionButtonBackward[2], optionButtonBackward[3], optionButtonBackward[4], (optionButtonBackward[4]-optionButtonBackward[2])/12)
			end

			if not showSelectOptions then
				for i, o in pairs(optionHover) do
					if IsOnRect(cx, cy, o[1], o[2], o[3], o[4]) and options[i].type ~= 'label' then
						glColor(1,1,1,0.055)
						RectRound(o[1]-4, o[2], o[3]+4, o[4], 2)
						font:Begin()
						if options[i].description ~= nil then
							description = options[i].description
							font:Print('\255\235\190\122'..options[i].description, screenX+15, screenY-screenHeight+64.5, 16, "no")
						end
						font:SetTextColor(0.46,0.4,0.3,0.45)
						font:Print('/option '..options[i].id, screenX+screenWidth*0.659, screenY-screenHeight+8, 14, "nr")
						font:End()
					end
				end
				for i, o in pairs(optionButtons) do
					if IsOnRect(cx, cy, o[1], o[2], o[3], o[4]) then
						gl.Color(0,0,0,0.08)
						RectRound(o[1], o[2], o[3], o[4], 1)
						if WG['tooltip'] ~= nil and options[i].type == 'slider' then
							local value = options[i].value
							if options[i].steps then
								value = NearestValue(options[i].steps, value)
							else
								local decimalValue, floatValue = math.modf(options[i].step)
								if floatValue ~= 0 then
									value = string.format("%."..string.len(string.sub(''..options[i].step, 3)).."f", value)	-- do rounding via a string because floats show rounding errors at times
								end
							end
							WG['tooltip'].ShowTooltip('options_showvalue', value)
						end
					end
				end
			end

			-- draw select options
			if showSelectOptions ~= nil then

				-- highlight all that are affected by presets
				if options[showSelectOptions].id == 'preset' then
					glColor(1,1,1,0.07)
					for optionID, _ in pairs(presets['lowest']) do
						optionKey = getOptionByID(optionID)
						if optionHover[optionKey] ~= nil then
							RectRound(optionHover[optionKey][1], optionHover[optionKey][2]+1.33, optionHover[optionKey][3], optionHover[optionKey][4]-1.33, 1)
						end
					end
				end

				local oHeight = optionButtons[showSelectOptions][4] - optionButtons[showSelectOptions][2]
				local oPadding = 4
				y = optionButtons[showSelectOptions][4] -oPadding
				local yPos = y
				--Spring.Echo(oHeight)
				optionSelect = {}
				for i, option in pairs(options[showSelectOptions].options) do
					yPos = y-(((oHeight+oPadding+oPadding)*i)-oPadding)
				end

				selectOptionsList = glCreateList(function()
					if WG['guishader'] then
						glPushMatrix()
						glTranslate(-(vsx * (widgetScale-1))/2, -(vsy * (widgetScale-1))/2, 0)
						glScale(widgetScale, widgetScale, 1)
                        glColor(0.25,0.25,0.25,0.7)
                    else
                        glColor(0.25,0.25,0.25,0.85)
                    end
					RectRound(optionButtons[showSelectOptions][1], yPos-oHeight-oPadding, optionButtons[showSelectOptions][3], optionButtons[showSelectOptions][4], 2)
					glColor(1,1,1,0.07)
					RectRound(optionButtons[showSelectOptions][1], optionButtons[showSelectOptions][2], optionButtons[showSelectOptions][3], optionButtons[showSelectOptions][4], 2)
					for i, option in pairs(options[showSelectOptions].options) do
						yPos = y-(((oHeight+oPadding+oPadding)*i)-oPadding)
						if IsOnRect(cx, cy, optionButtons[showSelectOptions][1], yPos-oHeight-oPadding, optionButtons[showSelectOptions][3], yPos+oPadding) then
							glColor(1,1,1,0.18)
							RectRound(optionButtons[showSelectOptions][1], yPos-oHeight-oPadding, optionButtons[showSelectOptions][3], yPos+oPadding, 2)
							if playSounds and (prevSelectHover == nil or prevSelectHover ~= i) then
								Spring.PlaySoundFile(selecthoverclick, 0.04, 'ui')
							end
							prevSelectHover = i
						end
						optionSelect[#optionSelect+1] = {optionButtons[showSelectOptions][1], yPos-oHeight-oPadding, optionButtons[showSelectOptions][3], yPos+oPadding, i }

						if options[showSelectOptions].optionsFont and fontOption then
							fontOption[i]:Begin()
							fontOption[i]:Print('\255\255\255\255'..option, optionButtons[showSelectOptions][1]+7, yPos-(oHeight/2.25)-oPadding, oHeight*0.85, "no")
							fontOption[i]:End()
						else
							font:Begin()
							font:Print('\255\255\255\255'..option, optionButtons[showSelectOptions][1]+7, yPos-(oHeight/2.25)-oPadding, oHeight*0.85, "no")
							font:End()
						end
					end
					if WG['guishader'] then
						glPopMatrix()
					end
				end)
				if WG['guishader'] then
					local interfaceScreenCenterPosX = (screenX+(screenWidth/2))/vsx
					local interfaceScreenCenterPosY = (screenY-(screenHeight/2))/vsy

					-- translate coordinates to actual screen coords (because we applied glscale/gltranlate above)
					local x1 = (vsx*interfaceScreenCenterPosX) - (((vsx/2) - optionButtons[showSelectOptions][1]) * widgetScale)
					local x2 = (vsx*interfaceScreenCenterPosX) - (((vsx/2) - optionButtons[showSelectOptions][3]) * widgetScale)
					local y1 = (vsy*interfaceScreenCenterPosY) - (((vsy/2) - (yPos-oHeight-oPadding)) * widgetScale)
					local y2 = (vsy*interfaceScreenCenterPosY) - (((vsy/2) - optionButtons[showSelectOptions][4]) * widgetScale)
					WG['guishader'].InsertScreenRect(x1, y1, x2, y2, 'options_select')
					WG['guishader'].insertRenderDlist(selectOptionsList)
				else
					glCallList(selectOptionsList)
				end
			elseif prevSelectHover ~= nil then
				prevSelectHover = nil
			end
	  glPopMatrix()
	else
		if WG['guishader'] then
			WG['guishader'].DeleteDlist('options')

		end
  end
	if checkedWidgetDataChanges == nil then
		checkedWidgetDataChanges = true
		loadAllWidgetData()
	end
end

function saveOptionValue(widgetName, widgetApiName, widgetApiFunction, configVar, configValue)
	if widgetHandler.configData[widgetName] == nil then
		widgetHandler.configData[widgetName] = {}
	end
	if widgetHandler.configData[widgetName][configVar[1]] == nil then
		widgetHandler.configData[widgetName][configVar[1]] = {}
	end
	if configVar[2] ~= nil and widgetHandler.configData[widgetName][configVar[1]][configVar[2]] == nil then
		widgetHandler.configData[widgetName][configVar[1]][configVar[2]] = {}
	end
	if configVar[2] ~= nil then
		if configVar[3] ~= nil then
			widgetHandler.configData[widgetName][configVar[1]][configVar[2]][configVar[3]] = configValue
		else
			widgetHandler.configData[widgetName][configVar[1]][configVar[2]] = configValue
		end
	else
		widgetHandler.configData[widgetName][configVar[1]] = configValue
	end
	if widgetApiName ~= nil and WG[widgetApiName] ~= nil and WG[widgetApiName][widgetApiFunction] ~= nil then
		WG[widgetApiName][widgetApiFunction](configValue)
	end
end

function applyOptionValue(i, skipRedrawWindow)
	if options[i] == nil then return end

	if options[i].restart then
		changesRequireRestart = true
	end

	local id = options[i].id
	if options[i].type == 'bool' then
		local value = 0
		if options[i].value then
			value = 1
		end
		if id == 'advmapshading' then
			Spring.SendCommands("AdvMapShading "..value)
			Spring.SetConfigInt("AdvMapShading",value)

		elseif id == 'advmodelshading' then
			Spring.SendCommands("AdvModelShading "..value)
			Spring.SetConfigInt("AdvModelShading",value)
		elseif id == 'normalmapping' then
			Spring.SendCommands("luarules normalmapping "..value)
			Spring.SetConfigInt("NormalMapping",value)
		elseif id == 'lupsdynamic' then
			Spring.SetConfigInt("DynamicLups",value)
		elseif id == 'lupsreflectionrefraction' then
			Spring.SetConfigInt("lupsreflectionrefraction",value)
		elseif id == 'treewind' then
			Spring.SendCommands("luarules treewind "..value)
			Spring.SetConfigInt("TreeWind",value)
		elseif id == 'advsky' then
			Spring.SetConfigInt("AdvSky",value)
		elseif id == 'timecyclesweathereffects' then
			Spring.SetConfigInt("evo_timecyclesweathereffects",value)
			Spring.SendCommands("luarules reloadluaui")
		elseif id == 'shadows' then
			Spring.SendCommands("Shadows "..value)
		elseif id == 'vsync' then
			Spring.SendCommands("Vsync "..value)
			Spring.SetConfigInt("VSync",value)
		elseif id == 'fullscreen' then
			if value == 1 then
				options[getOptionByID('borderless')].value = false
				applyOptionValue(getOptionByID('borderless'))
				local xres = tonumber(Spring.GetConfigInt('XResolutionWindowed',ssx))
				local yres = tonumber(Spring.GetConfigInt('YResolutionWindowed',ssy))
				Spring.SetConfigInt("XResolution", xres)
				Spring.SetConfigInt("YResolution", yres)
			else
				local xres = tonumber(Spring.GetConfigInt('XResolution',ssx))
				local yres = tonumber(Spring.GetConfigInt('YResolution',ssy))
				Spring.SetConfigInt("XResolutionWindowed", xres)
				Spring.SetConfigInt("YResolutionWindowed", yres)
			end
			Spring.SendCommands("Fullscreen "..value)
			Spring.SetConfigInt("Fullscreen",value)
		elseif id == 'borderless' then
			Spring.SetConfigInt("WindowBorderless",value)
			if value == 1 then
				options[getOptionByID('fullscreen')].value = false
				applyOptionValue(getOptionByID('fullscreen'))
				Spring.SetConfigInt("WindowPosX",0)
				Spring.SetConfigInt("WindowPosY",0)
				Spring.SetConfigInt("WindowState",0)
			else
				Spring.SetConfigInt("WindowPosX",0)
				Spring.SetConfigInt("WindowPosY",0)
				Spring.SetConfigInt("WindowState",1)
			end
		elseif id == 'screenedgemove' then
			Spring.SetConfigInt("FullscreenEdgeMove",value)
			Spring.SetConfigInt("WindowedEdgeMove",value)
		elseif id == 'scrollinverse' then
			if value == 1 then
				Spring.SetConfigInt("ScrollWheelSpeed",-options[getOptionByID('scrollspeed')].value)
			else
				Spring.SetConfigInt("ScrollWheelSpeed",options[getOptionByID('scrollspeed')].value)
			end
		elseif id == 'simpleminimapcolors' then
			Spring.SendCommands("minimap simplecolors  "..value)
			Spring.SetConfigInt("SimpleMiniMapColors",value)
		elseif id == 'hwcursor' then
			Spring.SendCommands("HardwareCursor "..value)
			Spring.SetConfigInt("HardwareCursor",value)
		elseif id == 'fpstimespeed' then
			Spring.SendCommands("fps "..value)
			Spring.SendCommands("clock "..value)
			Spring.SendCommands("speed "..value)

		elseif id == 'resourcebarcoloring' then
			saveOptionValue('Top Bar', 'topbar', 'setResourceBgTint', {'resourcebarBgTint'}, options[i].value)
		elseif id == 'playerlistcollapse' then
			saveOptionValue('AdvPlayersList', 'advplayerlist_api', 'SetCollapsable', {'collapsable'}, options[i].value)
		elseif id == 'lockcamera_hideenemies' then
			saveOptionValue('AdvPlayersList', 'advplayerlist_api', 'SetLockHideEnemies', {'lockcameraHideEnemies'}, options[i].value)
		elseif id == 'lockcamera_los' then
			saveOptionValue('AdvPlayersList', 'advplayerlist_api', 'SetLockLos', {'lockcameraLos'}, options[i].value)
		elseif id == 'allyselunits_select' then
			saveOptionValue('Ally Selected Units', 'allyselectedunits', 'setSelectPlayerUnits', {'selectPlayerUnits'}, options[i].value)
		elseif id == 'voicenotifs_playtrackedplayernotifs' then
			saveOptionValue('Voice Notifs', 'voicenotifs', 'setPlayTrackedPlayerNotifs', {'playTrackedPlayerNotifs'}, options[i].value)
		elseif id == 'buildmenushortcuts' then
			saveOptionValue('Red Build/Order Menu', 'red_buildmenu', 'setConfigShortcutsInfo', {'shortcutsInfo'}, options[i].value)
		elseif id == 'buildmenuprices' then
			saveOptionValue('Red Build/Order Menu', 'red_buildmenu', 'setConfigUnitPrice', {'drawPrice'}, options[i].value)
		elseif id == 'buildmenuradaricons' then
			saveOptionValue('Red Build/Order Menu', 'red_buildmenu', 'setConfigUnitRadaricon', {'drawRadaricon'}, options[i].value)
		elseif id == 'buildmenusounds' then
			saveOptionValue('Red Build/Order Menu', 'red_buildmenu', 'setConfigPlaySounds', {'playSounds'}, options[i].value)
		elseif id == 'buildmenutooltip' then
			saveOptionValue('Red Build/Order Menu', 'red_buildmenu', 'setConfigUnitTooltip', {'drawTooltip'}, options[i].value)
		elseif id == 'buildmenubigtooltip' then
			saveOptionValue('Red Build/Order Menu', 'red_buildmenu', 'setConfigUnitBigTooltip', {'drawBigTooltip'}, options[i].value)
		elseif id == 'buildmenulargeicons' then
			saveOptionValue('Red Build/Order Menu', 'red_buildmenu', 'setConfigLargeUnitIcons', {'largeUnitIons'}, options[i].value)
		elseif id == 'nametags_icon' then
			saveOptionValue('Commander Name Tags', 'nametags', 'setDrawForIcon', {'drawForIcon'}, options[i].value)
		elseif id == 'sameteamcolors' then
			saveOptionValue('Player Color Palette', 'playercolorpalette', 'setSameTeamColors', {'useSameTeamColors'}, options[i].value)
		elseif id == 'commandsfxfilterai' then
			saveOptionValue('Commands FX', 'commandsfx', 'setFilterAI', {'filterAIteams'}, options[i].value)
		elseif id == 'snowmap' then
			saveOptionValue('Snow', 'snow', 'setSnowMap', {'snowMaps',Game.mapName:lower()}, options[i].value)
		elseif id == 'snowautoreduce' then
			saveOptionValue('Snow', 'snow', 'setAutoReduce', {'autoReduce'}, options[i].value)
		elseif id == 'dof_highquality' then
			saveOptionValue('Depth of Field', 'dof', 'setHighQuality', {'highQuality'}, options[i].value)
		elseif id == 'dof_autofocus' then
			saveOptionValue('Depth of Field', 'dof', 'setAutofocus', {'autofocus'}, options[i].value)
		elseif id == 'sun_reset' then
            options[getOptionByID('sun_x')].value = defaultMapSunPos[1]
            options[getOptionByID('sun_y')].value = defaultMapSunPos[2]
            options[getOptionByID('sun_z')].value = defaultMapSunPos[3]
            options[getOptionByID('sun_reset')].value = false
            Spring.SetSunDirection(defaultMapSunPos[1],defaultMapSunPos[2],defaultMapSunPos[3])
            -- just so that map/model lighting gets updated
            Spring.SetSunLighting({groundShadowDensity = gl.GetSun("shadowDensity"), modelShadowDensity = gl.GetSun("shadowDensity")})
            Spring.Echo('resetted map sun defaults')
            customMapSunPos[Game.mapName] = nil
		elseif id == 'darkenmap_darkenfeatures' then
			saveOptionValue('Darken map', 'darkenmap', 'setDarkenFeatures', {'darkenFeatures'}, options[i].value)
		elseif id == 'teamplatter_skipownteam' then
			saveOptionValue('TeamPlatter', 'teamplatter', 'setSkipOwnTeam', {'skipOwnTeam'}, options[i].value)
		elseif id == 'enemyspotter_highlight' then
			saveOptionValue('EnemySpotter', 'enemyspotter', 'setHighlight', {'useXrayHighlight'}, options[i].value)
		elseif id == 'underconstructiongfx_shader' then
			saveOptionValue('Highlight Selected Units', 'underconstructiongfx', 'setShader', {'useHighlightShader'}, options[i].value)
        elseif id == 'highlightselunits_shader' then
			saveOptionValue('Highlight Selected Units', 'highlightselunits', 'setShader', {'useHighlightShader'}, options[i].value)
		elseif id == 'highlightselunits_teamcolor' then
			saveOptionValue('Highlight Selected Units', 'highlightselunits', 'setTeamcolor', {'useTeamcolor'}, options[i].value)
		elseif id == 'fancyselectedunits_secondline' then
			saveOptionValue('Fancy Selected Units', 'fancyselectedunits', 'setSecondLine', {'showSecondLine'}, options[i].value)
		elseif id == 'lighteffects_heatdistortion' then
			saveOptionValue('Light Effects', 'lighteffects', 'setHeatDistortion', {'enableHeatDistortion'}, options[i].value)
		elseif id == 'lighteffects_deferred' then
			saveOptionValue('Light Effects', 'lighteffects', 'setDeferred', {'enableDeferred'}, options[i].value)
		elseif id == 'highlightselunits_shader' then
			if widgetHandler.configData["Highlight Selected Units"] == nil then
				widgetHandler.configData["Highlight Selected Units"] = {}
			end
			widgetHandler.configData["Highlight Selected Units"].useShader = options[i].value
			if WG['highlightselunits'] ~= nil then
				WG['highlightselunits'].setShader(options[i].value)
			end
		elseif id == 'smartselect_includebuildings' then
			saveOptionValue('SmartSelect', 'smartselect', 'setIncludeBuildings', {'selectBuildingsWithMobile'}, options[i].value)
		elseif id == 'smartselect_includebuilders' then
			saveOptionValue('SmartSelect', 'smartselect', 'setIncludeBuilders', {'includeBuilders'}, options[i].value)
		elseif id == 'lighteffects' then
			if value ~= 0 then
				if widgetHandler.orderList["Deferred rendering"] ~= nil then
					widgetHandler:EnableWidget("Deferred rendering")
				end
				widgetHandler:EnableWidget("Light Effects")
			else
				if widgetHandler.orderList["Deferred rendering"] ~= nil then
					widgetHandler:DisableWidget("Deferred rendering")
				end
				widgetHandler:DisableWidget("Light Effects")
			end
		elseif id == 'autogroup_immediate' then
			if widgetHandler.configData["Auto Group"] == nil then
				widgetHandler.configData["Auto Group"] = {}
			end
			if widgetHandler.configData["Auto Group"].config == nil then
				widgetHandler.configData["Auto Group"].config = {immediate={value=options[i].value}}
			else
				widgetHandler.configData["Auto Group"].config.immediate.value = options[i].value
			end
			saveOptionValue('Auto Group', 'autogroup', 'setImmediate', {'config','immediate','value'}, options[i].value)
		elseif id == 'resourceprompts' then
			Spring.SetConfigInt("evo_resourceprompts",value)
		elseif string.sub(id, 1, 19) == 'voicenotifs_' then
			local sound = string.sub(id, 20)
			saveOptionValue('Voice Notifs', 'voicenotifs', 'setSound'..sound, {'soundList'}, options[i].value)
		elseif id == 'musicplayer' then
			if value then
				Spring.StopSoundStream()
			end
		elseif id == 'simplifiedresourcebar' then
			Spring.SetConfigInt("evo_simplifiedresourcebar",value)
		elseif id == 'buildpichelp' then
			Spring.SetConfigInt("evo_buildpichelp",value)
		elseif id == 'dynamicmusic' then
			Spring.SetConfigInt("evo_dynamicmusic", value)
		elseif id == 'interruptmusic' then
			Spring.SetConfigInt("evo_interruptmusic", value)
		elseif id == 'showcost' then
			Spring.SetConfigInt("evo_showcost", value)
			if WG.buildOrderUI then WG.buildOrderUI.updateConfigInt = true end
		elseif id == 'showtechreq' then
			Spring.SetConfigInt("evo_showtechreq", value)
			if WG.buildOrderUI then WG.buildOrderUI.updateConfigInt = true end
		elseif id == 'showhotkeys' then
			Spring.SetConfigInt("evo_showhotkeys", value)
			if WG.buildOrderUI then WG.buildOrderUI.updateConfigInt = true end
		elseif id == 'ctrl_dequeue' then
			Spring.SetConfigInt("evo_ctrl_dequeue", value)
		end

		if options[i].widget ~= nil then
			if value == 1 then
				if id == 'bloom' or id == 'guishader' or id == 'xrayshader' or id == 'snow' or id == 'mapedgeextension' then
					if luaShaders ~= 1 and not enabledLuaShaders then
						Spring.SetConfigInt("ForceShaders", 1)
						enabledLuaShaders = true
					end
				end
			end
			if value == 1 then
				if widgetHandler.orderList[options[i].widget] < 0.5 then
					widgetHandler:EnableWidget(options[i].widget)
				end
				if id == "fancyselectedunits" and getOptionByID('fancyselectedunits_style') then
					options[getOptionByID('fancyselectedunits_style')].options = WG['fancyselectedunits'].getStyleList()
				end
			else
				if widgetHandler.orderList[options[i].widget] > 0 then
					widgetHandler:ToggleWidget(options[i].widget)
				else
					widgetHandler:DisableWidget(options[i].widget)
				end
			end
			forceUpdate = true
			if id == "teamcolors" then
      			Spring.SendCommands("luarules reloadluaui")	-- cause several widgets are still using old colors
			end
		end
	
	elseif options[i].type == 'slider' then
		local value =  options[i].value
		if id == 'msaa' then
			if value > 0 then
				Spring.SetConfigInt("MSAALevel",1)
			else
				Spring.SetConfigInt("MSAALevel",0)
			end
			Spring.SetConfigInt("FSAALevel",0)		-- engine deprecated it in 104.x
			Spring.SetConfigInt("MSAALevel",value)

		elseif id == 'vsync2' then
			Spring.SetConfigInt("VSync",value)
		elseif id == 'shadowslider' then
			local enabled = 1
			if value == options.min then 
				enabled = 0
			end
			Spring.SendCommands("shadows "..enabled.." "..value)
			Spring.SetConfigInt("shadows", value)
		elseif id == 'shadows_maxquality' then
			if value < options[getOptionByID('shadows_minquality')].value then
				options[getOptionByID('shadows_minquality')].value = value
				saveOptionValue('Shadow Quality Manager', 'shadowmanager', 'setMinQuality', {'maxQuality'}, value)
			end
			saveOptionValue('Shadow Quality Manager', 'shadowmanager', 'setMaxQuality', {'maxQuality'}, value)
		elseif id == 'shadows_minquality' then
			if value > options[getOptionByID('shadows_maxquality')].value then
				options[getOptionByID('shadows_maxquality')].value = value
				saveOptionValue('Shadow Quality Manager', 'shadowmanager', 'setMaxQuality', {'maxQuality'}, value)
			end
			saveOptionValue('Shadow Quality Manager', 'shadowmanager', 'setMinQuality', {'minQuality'}, value)
		elseif id == 'shadows_disablefps' then
			saveOptionValue('Shadow Quality Manager', 'shadowmanager', 'setDisableFps', {'disableFps'}, value)
		elseif id == 'decals' then
			Spring.SetConfigInt("GroundDecals", value)
			Spring.SendCommands("GroundDecals "..value)
			Spring.SetConfigInt("GroundScarAlphaFade", 1)
		elseif id == 'scrollspeed' then
			if options[getOptionByID('scrollinverse')].value then
				Spring.SetConfigInt("ScrollWheelSpeed",-value)
			else
				Spring.SetConfigInt("ScrollWheelSpeed",value)
			end
		elseif id == 'disticon' then
			if Spring.GetConfigInt("distdraw",1) < 10000 then
				Spring.SendCommands("distdraw 10000")
			end
			Spring.SendCommands("disticon "..value)
		elseif id == 'featuredrawdist' then
			if getOptionByID('featurefadedist') and value < options[getOptionByID('featurefadedist')].value then
				options[getOptionByID('featurefadedist')].value = value
				Spring.SetConfigInt("FeatureFadeDistance",value)
			end
			Spring.SetConfigInt("FeatureDrawDistance",value)
		elseif id == 'featurefadedist' then
			if getOptionByID('featuredrawdist') and value > options[getOptionByID('featuredrawdist')].value then
				options[getOptionByID('featuredrawdist')].value = value
				Spring.SetConfigInt("FeatureDrawDistance",value)
			end
			Spring.SetConfigInt("FeatureFadeDistance",value)
		elseif id == 'iconscale' then
			Spring.SendCommands("luarules uniticonscale "..value)
		elseif id == 'treeradius' then
			Spring.SetConfigInt("TreeRadius",value)
		elseif id == 'particles' then
			Spring.SetConfigInt("MaxParticles",value)


		elseif id == 'nanobeamamount' then
			Spring.SetConfigInt("NanoBeamAmount",value)
		elseif id == 'nanoparticles' then
			maxNanoParticles = value
			if getOptionByID('nanoeffect') and options[getOptionByID('nanoeffect')].value == 2 then
				Spring.SetConfigInt("MaxNanoParticles",value)
			end

		elseif id == 'grassdetail' then
			Spring.SetConfigInt("GrassDetail",value)
		elseif id == 'grounddetail' then
			Spring.SetConfigInt("GroundDetail", value)
			Spring.SendCommands("GroundDetail "..value)
		elseif id == 'sndvolmaster' then
			Spring.SetConfigInt("snd_volmaster", value)
		elseif id == 'sndvolbattle' then
			Spring.SetConfigInt("snd_volbattle", value)
		elseif id == 'sndvolgeneral' then
			Spring.SetConfigInt("snd_volgeneral", value)
		elseif id == 'sndvolui' then
			Spring.SetConfigInt("snd_volui", value)
		elseif id == 'sndvolunitreply' then
			Spring.SetConfigInt("snd_volunitreply", value)
		elseif id == 'sndairabsorption' then
			Spring.SetConfigFloat("snd_airAbsorption", value)
		elseif id == 'sndvolmusic' then
			if WG['music'] and WG['music'].SetMusicVolume then
				WG['music'].SetMusicVolume(value)
			else
				Spring.SetConfigInt("snd_volmusic", value)
			end
		elseif id == 'crossalpha' then
			Spring.SendCommands("cross "..tonumber(Spring.GetConfigInt("CrossSize",1) or 10).." "..value)
		elseif id == 'darkenmap' then
			saveOptionValue('Darken map', 'darkenmap', 'setMapDarkness', {'maps',Game.mapName:lower()}, value)
		elseif id == 'iconadjuster' then
			saveOptionValue('Icon adjuster', 'iconadjuster', 'setScale', {'iconScale'}, value)
		elseif id == 'healthbarsscale' then
			saveOptionValue('Health Bars', 'healthbars', 'setScale', {'barScale'}, value)
		elseif id == 'ssao_strength' then
			saveOptionValue('SSAO', 'ssao', 'setStrength', {'strength'}, value)
		elseif id == 'ssao_radius' then
			saveOptionValue('SSAO', 'ssao', 'setRadius', {'radius'}, value)
		elseif id == 'bloomdeferredbrightness' then
			saveOptionValue('Bloom Shader Deferred', 'bloomdeferred', 'setBrightness', {'glowAmplifier'}, value)
		elseif id == 'bloomdeferredsize' then
			saveOptionValue('Bloom Shader Deferred', 'bloomdeferred', 'setBlursize', {'globalBlursizeMult'}, value)
		elseif id == 'bloombrightness' then
			saveOptionValue('Bloom Shader', 'bloom', 'setBrightness', {'basicAlpha'}, value)
		elseif id == 'bloomsize' then
			saveOptionValue('Bloom Shader', 'bloom', 'setBlursize', {'globalBlursizeMult'}, value)
		elseif id == 'consolemaxlines' then
			saveOptionValue('Red Console (In-game chat only)', 'red_chatonlyconsole', 'setMaxLines', {'Config','console','maxlines'}, value)
			saveOptionValue('Red Console (old)', 'red_console', 'setMaxLines', {'Config','console','maxlines'}, value)
		elseif id == 'consolefontsize' then
			saveOptionValue('Red Console (In-game chat only)', 'red_chatonlyconsole', 'setFontsize', {'fontsizeMultiplier'}, value)
			saveOptionValue('Red Console (old)', 'red_console', 'setFontsize', {'fontsizeMultiplier'}, value)
		elseif id == 'guishaderintensity' then
			saveOptionValue('GUI Shader', 'guishader', 'setBlurIntensity', {'blurIntensity'}, value)
		elseif id == 'guiopacity' then
			Spring.SetConfigFloat("ui_opacity", value)
		elseif id == 'snowamount' then
			saveOptionValue('Snow', 'snow', 'setMultiplier', {'customParticleMultiplier'}, value)
		elseif id == 'dof_focusdepth' then
			saveOptionValue('Depth of Field', 'dof', 'setFocusDepth', {'focusDepth'}, value)
		elseif id == 'dof_fstop' then
			saveOptionValue('Depth of Field', 'dof', 'setFstop', {'fStop'}, value)
		elseif id == 'sun_x' then
			local sunX,sunY,sunZ = gl.GetSun("pos")
			sunX = value
			if sunX < options[getOptionByID('sun_x')].min then
				sunX = options[getOptionByID('sun_x')].min
			end
			if sunX > options[getOptionByID('sun_x')].max then
				sunX = options[getOptionByID('sun_x')].max
			end
			options[getOptionByID('sun_x')].value = sunX
			Spring.SetSunDirection(sunX,sunY,sunZ)
			-- just so that map/model lighting gets updated
			Spring.SetSunLighting({groundShadowDensity = gl.GetSun("shadowDensity"), modelShadowDensity = gl.GetSun("shadowDensity")})
            customMapSunPos[Game.mapName] = {gl.GetSun("pos")}
		elseif id == 'sun_y' then
			local sunX,sunY,sunZ = gl.GetSun("pos")
			sunY = value
			if sunY < options[getOptionByID('sun_y')].min then
				sunY = options[getOptionByID('sun_y')].min
			end
			if sunY > options[getOptionByID('sun_y')].max then
				sunY = options[getOptionByID('sun_y')].max
			end
			options[getOptionByID('sun_y')].value = sunY
			Spring.SetSunDirection(sunX,sunY,sunZ)
			-- just so that map/model lighting gets updated
			Spring.SetSunLighting({groundShadowDensity = gl.GetSun("shadowDensity"), modelShadowDensity = gl.GetSun("shadowDensity")})
            customMapSunPos[Game.mapName] = {gl.GetSun("pos")}
		elseif id == 'sun_z' then
			local sunX,sunY,sunZ = gl.GetSun("pos")
			sunZ = value
			if sunZ < options[getOptionByID('sun_z')].min then
				sunZ = options[getOptionByID('sun_z')].min
			end
			if sunZ > options[getOptionByID('sun_z')].max then
				sunZ = options[getOptionByID('sun_z')].max
			end
			options[getOptionByID('sun_z')].value = sunZ
			Spring.SetSunDirection(sunX,sunY,sunZ)
			-- just so that map/model lighting gets updated
			Spring.SetSunLighting({groundShadowDensity = gl.GetSun("shadowDensity"), modelShadowDensity = gl.GetSun("shadowDensity")})
            customMapSunPos[Game.mapName] = {gl.GetSun("pos")}
		elseif id == 'shadows_opacity' then
			Spring.SetSunLighting({groundShadowDensity = value, modelShadowDensity = value})
		elseif id == 'fog_start' then
			Spring.SetAtmosphere({fogStart = value})
			if value >= gl.GetAtmosphere("fogEnd") then
				value = value + 0.0001
				options[getOptionByID('fog_end')].value = value
				Spring.SetAtmosphere({fogEnd = value})
			end
		elseif id == 'fog_end' then
			Spring.SetAtmosphere({fogEnd = value})
			if value <= gl.GetAtmosphere("fogStart") then
				value = value - 0.0001
				options[getOptionByID('fog_start')].value = value
				Spring.SetAtmosphere({fogStart = value})
			end
		elseif id == 'commandsfxopacity' then
			saveOptionValue('Commands FX', 'commandsfx', 'setOpacity', {'opacity'}, value)
		elseif id == 'minimapiconsize' then
			minimapIconsize = value
			Spring.SetConfigFloat("MinimapIconScale", value)
			Spring.SendCommands("minimap unitsize "..value)		-- spring wont remember what you set with '/minimap iconssize #'
		elseif id == 'lighteffects_brightness' then
			saveOptionValue('Light Effects', 'lighteffects', 'setGlobalBrightness', {'globalLightMult'}, value)
		elseif id == 'lighteffects_radius' then
			saveOptionValue('Light Effects', 'lighteffects', 'setGlobalRadius', {'globalRadiusMult'}, value)
		elseif id == 'lighteffects_laserbrightness' then
			saveOptionValue('Light Effects', 'lighteffects', 'setLaserBrightness', {'globalLightMultLaser'}, value)
		elseif id == 'lighteffects_laserradius' then
			saveOptionValue('Light Effects', 'lighteffects', 'setLaserRadius', {'globalRadiusMultLaser'}, value)
		elseif id == 'lighteffects_life' then
			saveOptionValue('Light Effects', 'lighteffects', 'setLife', {'globalLifeMult'}, value)
		elseif id == 'teamplatter_opacity' then
			saveOptionValue('TeamPlatter', 'teamplatter', 'setOpacity', {'spotterOpacity'}, value)
		elseif id == 'enemyspotter_opacity' then
			saveOptionValue('EnemySpotter', 'enemyspotter', 'setOpacity', {'spotterOpacity'}, value)
		elseif id == 'outline_size' then
			saveOptionValue('Outline', 'outline', 'setSize', {'BLUR_SIGMA'}, value)
		elseif id == 'outline_strength' then
			saveOptionValue('Outline', 'outline', 'setStrength', {'OUTLINE_STRENGTH'}, value)
		elseif id == 'underconstructiongfx_opacity' then
			saveOptionValue('Highlight Selected Units', 'underconstructiongfx', 'setOpacity', {'highlightAlpha'}, value)
		elseif id == 'highlightselunits_opacity' then
			saveOptionValue('Highlight Selected Units', 'highlightselunits', 'setOpacity', {'highlightAlpha'}, value)
		elseif id == 'fancyselectedunits_opacity' then
			saveOptionValue('Fancy Selected Units', 'fancyselectedunits', 'setOpacity', {'spotterOpacity'}, value)
		elseif id == 'fancyselectedunits_baseopacity' then
			saveOptionValue('Fancy Selected Units', 'fancyselectedunits', 'setBaseOpacity', {'baseOpacity'}, value)
		elseif id == 'fancyselectedunits_teamcoloropacity' then
			saveOptionValue('Fancy Selected Units', 'fancyselectedunits', 'setTeamcolorOpacity', {'teamcolorOpacity'}, value)
		elseif id == 'voicenotifs_volume' then
			saveOptionValue('Voice Notifs', 'voicenotifs', 'setVolume', {'volume'}, value)
		elseif id == 'lockcamera_transitiontime' then
			saveOptionValue('AdvPlayersList', 'advplayerlist_api', 'SetLockTransitionTime', {'transitionTime'}, value)
		elseif id == 'playertv_countdown' then
			saveOptionValue('Player-TV', 'playertv', 'SetPlayerChangeDelay', {'playerChangeDelay'}, value)
		elseif id == 'camerasmoothness' then
			cameraTransitionTime = value
		elseif id == 'camerapansmoothness' then
			cameraPanTransitionTime = value
		elseif id == 'fov' then
			local current_cam_state = Spring.GetCameraState()
			if (current_cam_state.fov) then
				current_cam_state.fov = value
				Spring.SetCameraState(current_cam_state,0)
			end
		end

	elseif options[i].type == 'select' then
		local value =  options[i].value
		if id == 'preset' then
			Spring.Echo('Loading preset:   '..options[i].options[value])
			options[i].value = 0
			loadPreset(presetNames[value])
		elseif id == 'buildordermenu' then
			Spring.SetConfigInt("evo_buildorderui",(value-1))
			Spring.SendCommands("luarules reloadluaui")
		elseif id == 'water' then
			Spring.SendCommands("water "..(value-1))
			Spring.SendCommands("water "..(value-1))
		elseif id == 'lupseffectlevel' then
			if WG.Lups then
				Spring.SetConfigInt("LupsPriority",value)
				--Spring.Echo("option for lups",value,WG.LupsPriority)
			end
		elseif id == 'font' then
			if VFS.FileExists(LUAUI_DIRNAME..'fonts/'..options[i].optionsFont[value]) then
				Spring.SetConfigString("ui_font", options[i].optionsFont[value])
				Spring.SendCommands("luarules reloadluaui")
			end
		elseif id == 'font2' then
			if VFS.FileExists(LUAUI_DIRNAME..'fonts/'..options[i].optionsFont[value]) then
				Spring.SetConfigString("ui_font2", options[i].optionsFont[value])
				Spring.SendCommands("luarules reloadluaui")
			end
		elseif id == 'nanoeffect' then
			Spring.SetConfigInt("NanoEffect",value)
			if value == 1 then
				Spring.SetConfigInt("MaxNanoParticles",0)
			else
				Spring.SetConfigInt("MaxNanoParticles",maxNanoParticles)
			end
		elseif id == 'bloomdeferredquality' then
			saveOptionValue('Bloom Shader Deferred', 'bloomdeferred', 'setPreset', {'qualityPreset'}, value)
		elseif id == 'bloomquality' then
			saveOptionValue('Bloom Shader', 'bloom', 'setPreset', {'qualityPreset'}, value)
		elseif id == 'camera' then
			Spring.SetConfigInt("CamMode",(value-1))
			if value == 1 then 
				Spring.SendCommands('viewfps')
			elseif value == 2 then 
				Spring.SendCommands('viewta')
			elseif value == 3 then 
				Spring.SendCommands('viewspring')
			elseif value == 4 then 
				Spring.SendCommands('viewrot')
			elseif value == 5 then 
				Spring.SendCommands('viewfree')
			end
		elseif id == 'cursor' then
			saveOptionValue('Cursors', 'cursors', 'setcursor', {'cursorSet'}, options[i].options[value])
		elseif id == 'fancyselectedunits_style' then
			saveOptionValue('Fancy Selected Units', 'fancyselectedunits', 'setStyle', {'currentOption'}, value)
		elseif id == 'resolution' then
			local resolutionX = string.match(options[i].options[options[i].value], '[0-9]*')
			local resolutionY = string.gsub(string.match(options[i].options[options[i].value], 'x [0-9]*'), 'x ', '')
			if tonumber(Spring.GetConfigInt("Fullscreen",1) or 1) == 1 then
				Spring.SendCommands("Fullscreen 0")
				Spring.SetConfigInt("XResolution", tonumber(resolutionX))
				Spring.SetConfigInt("YResolution", tonumber(resolutionY))
				Spring.SendCommands("Fullscreen 1")
			else
				Spring.SendCommands("Fullscreen 1")
				Spring.SetConfigInt("XResolutionWindowed", tonumber(resolutionX))
				Spring.SetConfigInt("YResolutionWindowed", tonumber(resolutionY))
				Spring.SendCommands("Fullscreen 0")
			end
			--options[i].value = 0
		end
	end
	if skipRedrawWindow == nil then
		if windowList then gl.DeleteList(windowList) end
		windowList = gl.CreateList(DrawWindow)
	end
end

function loadPreset(preset)
	for optionID, value in pairs(presets[preset]) do
		local i = getOptionByID(optionID)
		if options[i] ~= nil then
			options[i].value = value
			applyOptionValue(i, true)
		end
	end

	if windowList then gl.DeleteList(windowList) end
	windowList = gl.CreateList(DrawWindow)
end


function widget:KeyPress(key)
	if key == 27 then	-- ESC
		if showSelectOptions then
			showSelectOptions = nil
		else
			show = false
		end
	end
end

function IsOnRect(x, y, BLcornerX, BLcornerY,TRcornerX,TRcornerY)
	
	-- check if the mouse is in a rectangle
	return x >= BLcornerX and x <= TRcornerX
	                      and y >= BLcornerY
	                      and y <= TRcornerY
end


function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
end


function NearestValue(table, number)
	local smallestSoFar, smallestIndex
	for i, y in ipairs(table) do
		if not smallestSoFar or (math.abs(number-y) < smallestSoFar) then
			smallestSoFar = math.abs(number-y)
			smallestIndex = i
		end
	end
	return table[smallestIndex]
end
function getSliderValue(draggingSlider, cx)
	local sliderWidth = optionButtons[draggingSlider].sliderXpos[2] - optionButtons[draggingSlider].sliderXpos[1]
	local value = (cx - optionButtons[draggingSlider].sliderXpos[1]) / sliderWidth
	local min, max
	if options[draggingSlider].steps then
		min, max = options[draggingSlider].steps[1], options[draggingSlider].steps[1]
		for k, v in ipairs(options[draggingSlider].steps) do
			if v > max then max = v end
			if v < min then min = v end
		end
	else
		min = options[draggingSlider].min
		max = options[draggingSlider].max
	end
	value = min + ((max - min) * value)
	if value < min then value = min end
	if value > max then value = max end
	if options[draggingSlider].steps ~= nil then
		value = NearestValue(options[draggingSlider].steps, value)
	elseif options[draggingSlider].step ~= nil then
		value = math.floor(value / options[draggingSlider].step) * options[draggingSlider].step
	end
	return value	-- is a string now :(
end

function widget:MouseWheel(up, value)
	local x,y = Spring.GetMouseState()
	local cx, cy = correctMouseForScaling(x,y)
	if show then	
		return true
	end
end

function widget:MouseMove(x, y)
	if draggingSlider ~= nil then
		local cx, cy = correctMouseForScaling(x,y)
		local newValue = getSliderValue(draggingSlider,cx)
		if options[draggingSlider].value ~= newValue then
			options[draggingSlider].value = newValue
			sliderValueChanged = true
			applyOptionValue(draggingSlider)
			if playSounds and (lastSliderSound == nil or os.clock() - lastSliderSound > 0.04) then
				lastSliderSound = os.clock()
				Spring.PlaySoundFile(sliderdrag, 0.4, 'ui')
			end
		end
	end
end

function widget:MousePress(x, y, button)
	return mouseEvent(x, y, button, false)
end

function widget:MouseRelease(x, y, button)
	return mouseEvent(x, y, button, true)
end


function mouseEvent(x, y, button, release)
	if spIsGUIHidden() then return false end

	local cx, cy = correctMouseForScaling(x,y)
	if show then
		local cx, cy = correctMouseForScaling(x,y)
		if button == 3 then
			if titleRect ~= nil and IsOnRect(cx, cy, titleRect[1], titleRect[2], titleRect[3], titleRect[4]) then	-- showhow rightmouse doesnt get triggered :S
				--Spring.Echo(button..'  '..math.random())
				return true
			end
			if showSelectOptions ~= nil and options[showSelectOptions].id == 'preset' then
				for i, o in pairs(optionSelect) do
					if IsOnRect(cx, cy, o[1], o[2], o[3], o[4]) then
						if presetNames[o[5]] and customPresets[presetNames[o[5]]] ~= nil then
							deletePreset(presetNames[o[5]])
							if playSounds then
								Spring.PlaySoundFile(selectclick, 0.5, 'ui')
							end
							if selectClickAllowHide ~= nil or not IsOnRect(cx, cy, optionButtons[showSelectOptions][1], optionButtons[showSelectOptions][2], optionButtons[showSelectOptions][3], optionButtons[showSelectOptions][4]) then
								showSelectOptions = nil
								selectClickAllowHide = nil
							else
								selectClickAllowHide = true
							end
							return
						end
					end
				end
			end
		elseif button == 1 then
			if release then

				-- navigation buttons
				if optionButtonForward ~=nil and IsOnRect(cx, cy, optionButtonForward[1], optionButtonForward[2], optionButtonForward[3], optionButtonForward[4]) then
					startColumn = startColumn + maxShownColumns
					if startColumn > totalColumns + (maxShownColumns-1) then
						startColumn = (totalColumns-maxShownColumns) + 1
					end
					if playSounds then
						Spring.PlaySoundFile(paginatorclick, 0.6, 'ui')
					end
					showSelectOptions = nil
					selectClickAllowHide = nil
					if windowList then gl.DeleteList(windowList) end
					windowList = gl.CreateList(DrawWindow)
					return
				end
				if optionButtonBackward ~= nil and IsOnRect(cx, cy, optionButtonBackward[1], optionButtonBackward[2], optionButtonBackward[3], optionButtonBackward[4]) then
					startColumn = startColumn - maxShownColumns
					if startColumn < 1 then startColumn = 1 end
					if playSounds then
						Spring.PlaySoundFile(paginatorclick, 0.6, 'ui')
					end
					showSelectOptions = nil
					selectClickAllowHide = nil
					if windowList then gl.DeleteList(windowList) end
					windowList = gl.CreateList(DrawWindow)
					return
				end

				-- apply new slider value
				if draggingSlider ~= nil then
					options[draggingSlider].value = getSliderValue(draggingSlider,cx)
					applyOptionValue(draggingSlider)
					draggingSlider = nil
					return
				end

				-- select option
				if showSelectOptions ~= nil then
					for i, o in pairs(optionSelect) do
						if IsOnRect(cx, cy, o[1], o[2], o[3], o[4]) then
							options[showSelectOptions].value = o[5]
							applyOptionValue(showSelectOptions)
							if playSounds then
								Spring.PlaySoundFile(selectclick, 0.5, 'ui')
							end
						end
					end
					if selectClickAllowHide ~= nil or not IsOnRect(cx, cy, optionButtons[showSelectOptions][1], optionButtons[showSelectOptions][2], optionButtons[showSelectOptions][3], optionButtons[showSelectOptions][4]) then
						showSelectOptions = nil
						selectClickAllowHide = nil
					else
						selectClickAllowHide = true
					end
					return
				end
			end


			local tabClicked = false
            if show and groupRect ~= nil then
                for id,group in pairs(optionGroups) do
                    if IsOnRect(cx, cy, groupRect[id][1], groupRect[id][2], groupRect[id][3], groupRect[id][4]) then
                        if not release then
                            currentGroupTab = group.id
                            startColumn = 1
                            showSelectOptions = nil
                            selectClickAllowHide = nil
                            if playSounds then
                                Spring.PlaySoundFile(paginatorclick, 0.9, 'ui')
                            end
                        end
                        tabClicked = true
                        returnTrue = true
                    end
                end
            end

			-- on window
			local rectX1 = ((screenX-bgMargin) * widgetScale) - ((vsx * (widgetScale-1))/2)
			local rectY1 = ((screenY+bgMargin) * widgetScale) - ((vsy * (widgetScale-1))/2)
			local rectX2 = ((screenX+screenWidth+bgMargin) * widgetScale) - ((vsx * (widgetScale-1))/2)
			local rectY2 = ((screenY-screenHeight-bgMargin) * widgetScale) - ((vsy * (widgetScale-1))/2)
			if tabClicked then

			elseif IsOnRect(x, y, rectX1, rectY2, rectX2, rectY1) then


				if release then

					-- select option
					if showSelectOptions == nil then
						if showPresetButtons then
							for preset, pp in pairs(presets) do
								if IsOnRect(cx, cy, pp.pos[1], pp.pos[2], pp.pos[3], pp.pos[4]) then
									loadPreset(preset)
								end
							end
						end

						for i, o in pairs(optionButtons) do
							if options[i].type == 'bool' and IsOnRect(cx, cy, o[1], o[2], o[3], o[4]) then
								options[i].value = not options[i].value
								applyOptionValue(i)
								if playSounds then
									if options[i].value then
										Spring.PlaySoundFile(toggleonclick, 0.75, 'ui')
									else
										Spring.PlaySoundFile(toggleoffclick, 0.75, 'ui')
									end
								end
							elseif options[i].type == 'slider' and IsOnRect(cx, cy, o[1], o[2], o[3], o[4]) then

							elseif options[i].type == 'select' and IsOnRect(cx, cy, o[1], o[2], o[3], o[4]) then
							end
						end
					end
				else -- mousepress

					if not showSelectOptions then
						for i, o in pairs(optionButtons) do
							if options[i].type == 'slider' and (IsOnRect(cx, cy, o.sliderXpos[1], o[2], o.sliderXpos[2], o[4]) or IsOnRect(cx, cy, o[1], o[2], o[3], o[4])) then
								draggingSlider = i
								local newValue = getSliderValue(draggingSlider,cx)
								if options[draggingSlider].value ~= newValue then
									options[draggingSlider].value = getSliderValue(draggingSlider,cx)
									applyOptionValue(draggingSlider)
									if playSounds then
										Spring.PlaySoundFile(sliderdrag, 0.3, 'ui')
									end
								end
							elseif options[i].type == 'select' and IsOnRect(cx, cy, o[1], o[2], o[3], o[4]) then

								if playSounds then
									Spring.PlaySoundFile(selectunfoldclick, 0.6, 'ui')
								end
								if showSelectOptions == nil then
									showSelectOptions = i
								elseif showSelectOptions == i then
									--showSelectOptions = nil
								end
							end
						end
					end
				end

				if button == 1 or button == 3 then
					return true
				end
			-- on title
			elseif titleRect ~= nil and IsOnRect(x, y, (titleRect[1] * widgetScale) - ((vsx * (widgetScale-1))/2), (titleRect[2] * widgetScale) - ((vsy * (widgetScale-1))/2), (titleRect[3] * widgetScale) - ((vsx * (widgetScale-1))/2), (titleRect[4] * widgetScale) - ((vsy * (widgetScale-1))/2)) then
				--currentGroupTab = nil
				--startColumn = 1
				returnTrue = true
			elseif not tabClicked then
				if release and draggingSlider == nil then
					showOnceMore = true		-- show once more because the guishader lags behind, though this will not fully fix it
					show = false
				end
				return true
			end

			if show then
				if windowList then gl.DeleteList(windowList) end
				windowList = gl.CreateList(DrawWindow)
			end
			if returnTrue then
				return true
			end
		end
	elseif showOptionsToggleButton then
		tx = (x - posX*vsx)/(17*widgetScale)
		ty = (y - posY*vsy)/(17*widgetScale)
		if tx < 0 or tx > 5.25 or ty < -0.25 or ty > 1.4 then return false end
		if release then
			showOnceMore = show		-- show once more because the guishader lags behind, though this will not fully fix it
			show = not show
		end
		if show then
			if windowList then gl.DeleteList(windowList) end
			windowList = gl.CreateList(DrawWindow)
		end
		return true
	end
end

function GetWidgetToggleValue(widgetname)
	if widgetHandler.orderList[widgetname] == nil or widgetHandler.orderList[widgetname] == 0 then
		return false
	elseif widgetHandler.orderList[widgetname] >= 1
			and widgetHandler.knownWidgets ~= nil
			and widgetHandler.knownWidgets[widgetname] ~= nil then
		if widgetHandler.knownWidgets[widgetname].active then
			return true
		else
			return 0.5
		end
	end
end

-- configVar = table, add more entries the deeper the configdata table var is: example: {'Config','console','maxlines'}  (limit = 3 deep)
function loadWidgetData(widgetName, optionId, configVar)
	if widgetHandler.knownWidgets[widgetName] ~= nil then
		if getOptionByID(optionId) and widgetHandler.configData[widgetName] ~= nil and widgetHandler.configData[widgetName][configVar[1]] ~= nil then
			if configVar[2] ~= nil and widgetHandler.configData[widgetName][configVar[1]][configVar[2]] ~= nil then
				if configVar[3] ~= nil and widgetHandler.configData[widgetName][configVar[1]][configVar[2]][configVar[3]] ~= nil then
					options[getOptionByID(optionId)].value = widgetHandler.configData[widgetName][configVar[1]][configVar[2]][configVar[3]]
					return true
				else
					options[getOptionByID(optionId)].value = widgetHandler.configData[widgetName][configVar[1]][configVar[2]]
					return true
				end
			elseif options[getOptionByID(optionId)].value ~= widgetHandler.configData[widgetName][configVar[1]] then
				options[getOptionByID(optionId)].value = widgetHandler.configData[widgetName][configVar[1]]
				return true
			end
		end
	end
end


-- loads values via stored game config in luaui/configs
function loadAllWidgetData()
	loadWidgetData("Health Bars", "healthbarsscale", {'barScale'})

	loadWidgetData("Shadow Quality Manager", "shadows_maxquality", {'maxQuality'})
	loadWidgetData("Shadow Quality Manager", "shadows_minquality", {'minQuality'})
	loadWidgetData("Shadow Quality Manager", "shadows_disablefps", {'disableFps'})

	loadWidgetData("SSAO", "ssao_strength", {'strength'})
	loadWidgetData("SSAO", "ssao_radius", {'radius'})

	loadWidgetData("Bloom Shader Deferred", "bloomdeferredbrightness", {'glowAmplifier'})
	loadWidgetData("Bloom Shader Deferred", "bloomdeferredsize", {'qualityBlursizeMult'})
	loadWidgetData("Bloom Shader Deferred", "bloomdeferredquality", {'qualityPreset'})

	loadWidgetData("Bloom Shader", "bloombrightness", {'basicAlpha'})
	loadWidgetData("Bloom Shader", "bloomsize", {'globalBlursizeMult'})
	loadWidgetData("Bloom Shader", "bloomquality", {'qualityPreset'})

	loadWidgetData("Red Console (In-game chat only)", "consolemaxlines", {'Config','console','maxlines'})
	loadWidgetData("Red Console (In-game chat only)", "consolefontsize", {'fontsizeMultiplier'})

	loadWidgetData("AdvPlayersList", "lockcamera_hideenemies", {'lockcameraHideEnemies'})
	loadWidgetData("AdvPlayersList", "lockcamera_los", {'lockcameraLos'})
	loadWidgetData("AdvPlayersList", "lockcamera_transitiontime", {'transitionTime'})
	loadWidgetData("AdvPlayersList", "playerlistcollapse", {'collapsable'})

	loadWidgetData("Top Bar", "resourcebarcoloring", {'resourcebarBgTint'})

	loadWidgetData("Commander Name Tags", "nametags_icon", {'drawForIcon'})

	loadWidgetData("Ally Selected Units", "allyselunits_select", {'selectPlayerUnits'})

	loadWidgetData("Voice Notifs", "voicenotifs_playtrackedplayernotifs", {'playTrackedPlayerNotifs'})

	loadWidgetData("GUI Shader", "guishaderintensity", {'blurIntensity'})

	loadWidgetData("Depth of Field", "dof_focusdepth", {'focusDepth'})
	loadWidgetData("Depth of Field", "dof_fstop", {'fStop'})
	loadWidgetData("Depth of Field", "dof_highquality", {'highQuality'})
	loadWidgetData("Depth of Field", "dof_autofocus", {'autofocus'})

	loadWidgetData("Snow", "snowamount", {'customParticleMultiplier'})
	loadWidgetData("Snow", "snowmap", {'snowMaps',Game.mapName:lower()})
	loadWidgetData("Snow", "snowautoreduce", {'autoReduce'})

	loadWidgetData("Commands FX", "commandsfxopacity", {'opacity'})
	loadWidgetData("Commands FX", "commandsfxfilterai", {'filterAIteams'})

	loadWidgetData("TeamPlatter", "teamplatter_opacity", {'spotterOpacity'})
	loadWidgetData("TeamPlatter", "teamplatter_skipownteam", {'skipOwnTeam'})

	loadWidgetData("EnemySpotter", "enemyspotter_opacity", {'spotterOpacity'})
	loadWidgetData("EnemySpotter", "enemyspotter_highlight", {'useXrayHighlight'})

	loadWidgetData("Outline", "outline_size", {'BLUR_SIGMA'})
	loadWidgetData("Outline", "outline_strength", {'OUTLINE_STRENGTH'})

	loadWidgetData("Under construction gfx", "underconstructiongfx_opacity", {'highlightAlpha'})
	loadWidgetData("Under construction gfx", "underconstructiongfx_shader", {'useHighlightShader'})

	loadWidgetData("Highlight Selected Units", "highlightselunits_opacity", {'highlightAlpha'})
	loadWidgetData("Highlight Selected Units", "highlightselunits_shader", {'useHighlightShader'})
	loadWidgetData("Highlight Selected Units", "highlightselunits_teamcolor", {'useTeamcolor'})

	loadWidgetData("Fancy Selected Units", "fancyselectedunits_style", {'currentOption'})
	loadWidgetData("Fancy Selected Units", "fancyselectedunits_opacity", {'spotterOpacity'})
	loadWidgetData("Fancy Selected Units", "fancyselectedunits_baseopacity", {'baseOpacity'})
	loadWidgetData("Fancy Selected Units", "fancyselectedunits_teamcoloropacity", {'teamcolorOpacity'})
	loadWidgetData("Fancy Selected Units", "fancyselectedunits_secondline", {'showSecondLine'})

	loadWidgetData("Voice Notifs", "voicenotifs_volume", {'volume'})

	loadWidgetData("Defense Range", "defrange_allyair", {'enabled','ally','air'})
	loadWidgetData("Defense Range", "defrange_allyground", {'enabled','ally','ground'})
	loadWidgetData("Defense Range", "defrange_allynuke", {'enabled','ally','nuke'})
	loadWidgetData("Defense Range", "defrange_enemyair", {'enabled','enemy','air'})
	loadWidgetData("Defense Range", "defrange_enemyground", {'enabled','enemy','ground'})
	loadWidgetData("Defense Range", "defrange_enemynuke", {'enabled','enemy','nuke'})

	loadWidgetData("Light Effects", "lighteffects_brightness", {'globalLightMult'})
	loadWidgetData("Light Effects", "lighteffects_radius", {'globalRadiusMult'})
	loadWidgetData("Light Effects", "lighteffects_laserbrightness", {'globalLightMultLaser'})
	loadWidgetData("Light Effects", "lighteffects_laserradius", {'globalRadiusMultLaser'})
	loadWidgetData("Light Effects", "lighteffects_life", {'globalLifeMult'})
	loadWidgetData("Light Effects", "lighteffects_heatdistortion", {'enableHeatDistortion'})
	loadWidgetData("Light Effects", "lighteffects_deferred", {'enableDeferred'})

	loadWidgetData("Auto Group", "autogroup_immediate", {'config','immediate','value'})

	return changes
end

function lines(str)
	local t = {}
	local function helper(line) table.insert(t, line) return "" end
	helper((str:gsub("(.-)\r?\n", helper)))
	return t
end

function init()

	local supportedResolutions = {}
	local infolog = VFS.LoadFile("infolog.txt")
	if infolog then
		local fileLines = lines(infolog)
		for i, line in ipairs(fileLines) do
			if addResolutions then
				local resolution = string.match(line, '[0-9]*x[0-9]*')
				if resolution and string.len(resolution) >= 7 then
					local resolution = string.gsub(resolution, "x", " x ")
					local resolutionX = string.match(resolution, '[0-9]*')
					local resolutionY = string.gsub(string.match(resolution, 'x [0-9]*'), 'x ', '')
					if tonumber(resolutionX) >= 640 and tonumber(resolutionY) >= 480 then
						supportedResolutions[#supportedResolutions+1] = resolution
					end
				else
					break
				end
			end
			if string.find(line, '	display=') then
				if addResolutions then
					break
				end
				addResolutions = true
			end
		end
	end

	-- if you want to add an option it should be added here, and in applyOptionValue(), if option needs shaders than see the code below the options definition
	optionGroups = {
		{id='gfx', name='Graphics'},
		{id='ui', name='Interface'},
		{id='snd', name='Sound'},
		{id='control', name='Control'},
		{id='game', name='Game'},
	}
	if not currentGroupTab or Spring.GetGameFrame() == 0 then
		currentGroupTab = optionGroups[1].id
	else
		-- check if group exists
		local found = false
		for id,group in pairs(optionGroups) do
			if group.id == currentGroupTab then
				found = true
				break
			end
		end
		if not found then
			currentGroupTab = optionGroups[1].id
		end
	end

	options = {
		-- PRESET
		{id="preset", group="gfx", name="Load graphics preset", type="select", options=presetNames, value=0, description='This wont set the preset every time you restart a game. So feel free to adjust things.\n\nSave custom preset with /savepreset name\nRightclick to delete a custom preset'},

		--GFX
		{id="resolution", group="gfx", name="Resolution", type="select", options=supportedResolutions, value=0, description='WARNING: sometimes freezes game engine in windowed mode'},
		{id="fullscreen", group="gfx", name="Fullscreen", type="bool", value=tonumber(Spring.GetConfigInt("Fullscreen",1) or 1) == 1},
		{id="borderless", group="gfx", name="Borderless window", type="bool", value=tonumber(Spring.GetConfigInt("WindowBorderless",1) or 1) == 1, description="Changes will be applied next game.\n\n(dont forget to turn off the \'fullscreen\' option next game)"},
		{id="windowpos", group="gfx", widget="Move Window Position", name="Move window position", type="bool", value=GetWidgetToggleValue("Move Window Position"), description='Toggle and move window position with the arrow keys or by dragging'},
		{id="vsync", group="gfx", name="V-sync", type="bool", value=tonumber(Spring.GetConfigInt("VSync",1) or 1) == 1, description=''},
		{id="msaa", group="gfx", name="Anti Aliasing", type="slider", steps={0,1,2,4,8,16}, restart=true, value=tonumber(Spring.GetConfigInt("MSAALevel",1) or 8), description='Enables multisample anti-aliasing. NOTE: Can be expensive!\n\nChanges will be applied next game'},
		{id="advmapshading", group="gfx", name="Advanced map shading", type="bool", value=tonumber(Spring.GetConfigInt("AdvMapShading",1) or 1) == 1, description='When disabled: map shadows aren\'t rendered as well'},
		{id="advmodelshading", group="gfx", name="Advanced model shading", type="bool", value=tonumber(Spring.GetConfigInt("AdvModelShading",1) or 1) == 1},
		{id="advsky", group="gfx", name="Advanced sky", type="bool", restart=true, value=tonumber(Spring.GetConfigInt("AdvSky",1) or 1) == 1, description='Enables high resolution clouds\n\nChanges will be applied next game'},

		-- only one of these shadow options are shown, depending if "Shadow Quality Manager" widget is active
		{id="shadows", group="gfx", name="Shadows", type="bool", value=tonumber(Spring.GetConfigInt("Shadows",1) or 1) == 1, description='Shadow detail is currently controlled by "Shadow Quality Manager" widget\n...this widget will auto reduce detail when fps gets low.\n\nShadows requires "Advanced map shading" option to be enabled'},
		{id="shadowslider", group="gfx", name="Shadows", type="slider", steps={1024,2048,4096,8192}, value=tonumber(Spring.GetConfigInt("ShadowMapSize",1) or 4096), description='Set shadow detail'},
		{id="shadows_maxquality", group="gfx", name=widgetOptionColor.."   max quality", min=1024, max=8192, step=1024, type="slider", value=8192, description='Maximum shadow detail when having high Frames Per Second'},
		{id="shadows_minquality", group="gfx", name=widgetOptionColor.."   min quality", min=1024, max=8192, step=1024, type="slider", value=1024, description='Minimum shadow detail when having low Frames Per Second'},
		--{id="shadows_disablefps", group="gfx", name=widgetOptionColor.."   disable at FPS", min=0, max=30, step=1, type="slider", value=0, description='Automaticly disables shadows at this average FPS value'},

		{id="shadows_opacity", group="gfx", name=widgetOptionColor.."   opacity", type="slider", min=0.3, max=1, step=0.01, value=gl.GetSun("shadowDensity"), description=''},

		{id="decals", group="gfx", name="Ground decals", type="slider", min=0, max=5, step=1, value=tonumber(Spring.GetConfigInt("GroundDecals",1) or 1), description='Set how long map decals will stay.\n\nDecals are ground scars, footsteps/tracks and shading under buildings'},
		{id="grounddetail", group="gfx", name="Ground detail", type="slider", min=32, max=200, step=1, value=tonumber(Spring.GetConfigInt("GroundDetail",1) or 1), description='Set how detailed the map mesh/model is. Note that detail over 120 is largely unnoticeable.\n64 is a good default amount for playing that will not cost unnecessary fps.'},
		{id="water", group="gfx", name="Water type", type="select", options={'basic','reflective','dynamic','reflective&refractive','bump-mapped'}, value=(tonumber(Spring.GetConfigInt("Water",1) or 1)+1)},

		{id="bloomdeferred", group="gfx", widget="Bloom Shader Deferred", name="Bloom (unit)", type="bool", value=GetWidgetToggleValue("Bloom Shader Deferred"), description='Unit highlights and lights will glow.\n\n(via deferred rendering = less lag)'},
		{id="bloomdeferredbrightness", group="gfx", name=widgetOptionColor.."   brightness", type="slider", min=0.4, max=1.1, step=0.05, value=1, description=''},
		--{id="bloomdeferredsize", group="gfx", name=widgetOptionColor.."   size", type="slider", min=0.8, max=1.5, step=0.05, value=1, description=''},
		--{id="bloomdeferredquality", group="gfx", name=widgetOptionColor.."   quality", type="select", options={'low','medium'}, value=1, description='Render quality'},

		{id="bloom", group="gfx", widget="Bloom Shader", name="Bloom (global)", type="bool", value=GetWidgetToggleValue("Bloom Shader"), description='Bloom will make the map and units glow\n\n(might result in more laggy experience)'},
		{id="bloombrightness", group="gfx", name=widgetOptionColor.."   brightness", type="slider", min=0.15, max=0.5, step=0.05, value=0.25, description=''},
		--{id="bloomsize", group="gfx", name=widgetOptionColor.."   size", type="slider", min=0.9, max=1.5, step=0.05, value=1.1, description=''},
		--{id="bloomquality", group="gfx", name=widgetOptionColor.."   quality", type="select", options={'low','medium'}, value=1, description='Render quality'},

		{id="mapedgeextension", group="gfx", widget="Map Edge Extension", name="Map edge extension", type="bool", value=GetWidgetToggleValue("Map Edge Extension"), description='Mirrors the map at screen edges and darkens and decolorizes them\n\nEnable shaders for best result'},
		--{id="grassdetail", group="gfx", name="Grass", type="slider", min=0, max=10, step=1, value=tonumber(Spring.GetConfigInt("GrassDetail",1) or 5), description='Amount of grass rendered\n\nChanges will be applied next game'},

		{id="darkenmap", group="gfx", name="Darken map", min=0, max=0.5, step=0.01, type="slider", value=0, description='Darkens the whole map (not the units)\n\nRemembers setting per map\nUse /resetmapdarkness if you want to reset all stored map settings'},
		{id="darkenmap_darkenfeatures", group="gfx", name=widgetOptionColor.."   darken features", type="bool", value=false, description='Darkens features (trees, wrecks, ect..) along with darken map slider above\n\nNOTE: Can be CPU intensive: it cycles through all visible features \nand renders them another time.'},

		{id="sun_y", group="gfx", name="Sun height", type="slider", min=0.05, max=0.9999, step=0.0001, value=select(2,gl.GetSun("pos")), description=''},
		{id="sun_x", group="gfx", name=widgetOptionColor.."   pos X", type="slider", min=-0.9999, max=0.9999, step=0.0001, value=select(1,gl.GetSun("pos")), description=''},
		{id="sun_z", group="gfx", name=widgetOptionColor.."   pos Z", type="slider", min=-0.9999, max=0.9999, step=0.0001, value=select(3,gl.GetSun("pos")), description=''},
        {id="sun_reset", group="gfx", name=widgetOptionColor.."   reset map default", type="bool", value=false, description=''},

		{id="ssao", group="gfx", widget="SSAO", name="SSAO", type="bool", value=GetWidgetToggleValue("SSAO"), description='Screen-Space Ambient Occlusion.'},
		{id="ssao_strength", group="gfx", name=widgetOptionColor.."   strength", type="slider", min=1, max=5, step=0.05, value=3.5, description=''},
		{id="ssao_radius", group="gfx", name=widgetOptionColor.."   radius", type="slider", min=4, max=7, step=1, value=4, description=''},

		{id="dof", group="gfx", widget="Depth of Field", name="Depth of Field", type="bool", value=GetWidgetToggleValue("Depth of Field"), description='Applies out of focus blur'},
		{id="dof_autofocus", group="gfx", name=widgetOptionColor.."   autofocus", type="bool", value=true, description='Disable to have mouse position focus'},
		--{id="dof_focusdepth", group="gfx", name=widgetOptionColor.."   focus depth", type="slider", min=0, max=2000, step=1, value=300, description=''},
		{id="dof_fstop", group="gfx", name=widgetOptionColor.."   f-stop", type="slider", min=1, max=16, step=0.1, value=3, description='Set amount of blur\n\nOnly works if autofocus is off'},
		--{id="dof_highquality", group="gfx", name=widgetOptionColor.."   high quality", type="bool", value=false, description=''},

		{id="outline", group="gfx", widget="Outline", name="Unit outline", type="bool", value=GetWidgetToggleValue("Outline"), description='Adds a small outline to all units which makes them crisp.'},
		{id="outline_size", group="gfx", name=widgetOptionColor.."   size", min=0.5, max=3, step=0.05, type="slider", value=1, description='Set the size of the outline'},
		--{id="outline_strength", group="gfx", name=widgetOptionColor.."   opacity", min=1, max=6, step=0.05, type="slider", value=2.5, description='Set the opacity of the outline'},

		{id="disticon", group="gfx", name="Strategic icon distance", type="slider", min=0, max=900, step=10, value=tonumber(Spring.GetConfigInt("UnitIconDist",1) or 400), description='Set a lower value to get better performance'},
		{id="iconscale", group="gfx", name=widgetOptionColor.."   scale", type="slider", min=0.85, max=1.35, step=0.05, value=tonumber(Spring.GetConfigFloat("UnitIconScale",1.15) or 1.05), description='Note that the minimap icon size is affected as well'},
		{id="minimapiconsize", group="gfx", name=widgetOptionColor.."   minimap scale", type="slider", min=1.5, max=5, step=0.25, value=tonumber(Spring.GetConfigFloat("MinimapIconScale",3.5) or 1), description=''},
		
		{id="featuredrawdist", group="gfx", name="Feature draw distance", type="slider", min=2500, max=15000, step=500, value=tonumber(Spring.GetConfigInt("FeatureDrawDistance",6000) or 400), description='Features (trees, stones, wreckage) stop being displayed at this distance'},
		
		{id="lighteffects", group="gfx", name="Light effects", type="bool", value=GetWidgetToggleValue("Light Effects"), description='Adds lights to projectiles, lasers and explosions.\n\nRequires shaders.'},
		--{id="lighteffects_deferred", group="gfx", name=widgetOptionColor.."   real map and model lights", type="bool", value=true, description='Otherwise simple ground flashes instead of actual map and model lighting.\n\nExpensive for the gpu when lots of (big) lights are there or when you zoom in on them.'},
		--{id="lighteffects_heatdistortion", group="gfx", name=widgetOptionColor.."   apply heat distortion", type="bool", value=true, description='Enables a distortion on top of explosions to simulate heat'},
		{id="lighteffects_life", group="gfx", name=widgetOptionColor.."   lifetime", min=0.25, max=1, step=0.05, type="slider", value=0.6, description='lifetime of explosion lights'},
		{id="lighteffects_brightness", group="gfx", name=widgetOptionColor.."   brightness", min=1, max=5, step=0.1, type="slider", value=2.5, description='Set the brightness of the lights'},
		{id="lighteffects_radius", group="gfx", name=widgetOptionColor.."   radius", min=1, max=2, step=0.1, type="slider", value=1.2, description='Set the radius of the lights\n\nWARNING: the bigger the radius the heavier on the GPU'},
		{id="lighteffects_laserbrightness", group="gfx", name=widgetOptionColor.."   laser brightness", min=0.4, max=2, step=0.1, type="slider", value=1.2, description='laser lights brightness RELATIVE to global light brightness set above'},
		{id="lighteffects_laserradius", group="gfx", name=widgetOptionColor.."   laser radius", min=0.4, max=2, step=0.1, type="slider", value=1, description='laser lights radius RELATIVE to global light radius set above\n\nWARNING: the bigger the radius the heavier on the GPU'},

		{id="lups", group="gfx", widget="LupsManager", name="Lups particle/shader effects", type="bool", value=GetWidgetToggleValue("LupsManager"), description='Toggle unit particle effects: jet beams, ground flashes, fusion energy balls'},

		{id="xrayshader", group="gfx", widget="XrayShader", name="Unit xray shader", type="bool", value=GetWidgetToggleValue("XrayShader"), description='Highlights all units, highlight effect dissolves on close camera range.\n\nFades out and disables at low fps\nWorks less on dark teamcolors'},
		{id="particles", group="gfx", name="Max particles", type="slider", min=5000, max=25000, step=500, value=tonumber(Spring.GetConfigInt("MaxParticles",1) or 10000), description='Particles used for explosions, smoke, fire and missiletrails\n\nSetting a low value will mean that various effects wont show properly'},
		{id="nanoparticles", group="gfx", name="Max nano particles", type="slider", min=0, max=5000, step=100, value=tonumber(Spring.GetConfigInt("MaxNanoParticles",1) or 500), description='NOTE: Nano particles are more expensive regarding the CPU'},

		--{id="treeradius", group="gfx", name="Tree render distance", type="slider", restart=true, min=0, max=2000, step=50, value=tonumber(Spring.GetConfigInt("TreeRadius",1) or 1000), description='Applies to SpringRTS engine default trees\n\nChanges will be applied next game'},

		{id="timecyclesweathereffects", group="gfx", name="Day/Night/Weather Cycles", type="bool", value=tonumber(Spring.GetConfigInt("evo_timecyclesweathereffects",0) or 0) == 1, description='Enables Day/Night Cycles and Weather Effects\n\nTHIS IS HIGHLY EXPERIMENTAL!!! *Could Cause Crashes on older hardware!!!*\n*NOTE* This will cause all widgets to reload'},
		{id="snow", group="gfx", widget="Snow", name="Snow", type="bool", value=GetWidgetToggleValue("Snow"), description='Snow widget (By default.. maps with wintery names have snow applied)'},
		{id="snowmap", group="gfx", name=widgetOptionColor.."   enabled on this map", type="bool", value=true, description='It will remember what you toggled for every map\n\n\(by default: maps with wintery names have this toggled)'},
		{id="snowautoreduce", group="gfx", name=widgetOptionColor.."   auto reduce", type="bool", value=true, description='Automaticly reduce snow when average FPS gets lower\n\n(re-enabling this needs time to readjust  to average fps again'},
		{id="snowamount", group="gfx", name=widgetOptionColor.."   amount", type="slider", min=0.2, max=2, step=0.2, value=1, description='Tip: disable "auto reduce" option temporarily to see the max snow amount you have set'},

		{id="dofintensity", group="gfx", name="DoF intensity", type="slider", min=0.05, max=5, step=0.01, value=1.5, description='Enable Depth of Field with F8 first'},

		{id="resurrectionhalos", group="gfx", widget="Resurrection Halos", name="Resurrected unit halos", type="bool", value=GetWidgetToggleValue("Resurrection Halos"), description='Gives units have have been resurrected a little halo above it.'},
        {id="tombstones", group="gfx", widget="Tombstones", name="Tombstones", type="bool", value=GetWidgetToggleValue("Tombstones"), description='Displays tombstones where commanders died'},
        {id="rankicons", group="gfx", widget="Rank Icons", name="Rank icons", type="bool", value=GetWidgetToggleValue("Rank Icons"), description='Shows a rank icon depending on experience next to units'},

		{id="underconstructiongfx", group="gfx", widget="Under construction gfx", name="Under construction highlight", type="bool", value=GetWidgetToggleValue("Under construction gfx"), description='Highlights unit models when under construction'},
		{id="underconstructiongfx_opacity", group="gfx", name=widgetOptionColor.."   opacity", min=0.25, max=0.5, step=0.01, type="slider", value=0.2, description='Set the opacity of the highlight on selected units'},
		{id="underconstructiongfx_shader", group="gfx", name=widgetOptionColor.."   use shader", type="bool", value=false, description='Highlight model edges a bit'},

		-- SND
		{id="sndvolmaster", group="snd", name="Master volume", type="slider", min=0, max=200, step=2, value=tonumber(Spring.GetConfigInt("snd_volmaster",1) or 100)},
		--{id="sndvolgeneral", group="snd", name="General volume", type="slider", min=0, max=100, step=2, value=tonumber(Spring.GetConfigInt("snd_volgeneral",1) or 100)},
		{id="sndvolbattle", group="snd", name="Battle volume", type="slider", min=0, max=100, step=2, value=tonumber(Spring.GetConfigInt("snd_volbattle",1) or 100)},
		{id="sndvolui", group="snd", name="Interface volume", type="slider", min=0, max=100, step=2, value=tonumber(Spring.GetConfigInt("snd_volui",1) or 100)},
		{id="sndvolunitreply", group="snd", name="Unit reply volume", type="slider", min=0, max=100, step=2, value=tonumber(Spring.GetConfigInt("snd_volunitreply",1) or 100)},
		{id="sndvolmusic", group="snd", name="Music volume", type="slider", min=0, max=100, step=2, value=tonumber(Spring.GetConfigInt("snd_volmusic",1) or 20)},
		{id="dynamicmusic", group="snd", name="Dynamic Music", type="bool", value=tonumber(Spring.GetConfigInt("evo_dynamicmusic",1) or 1) == 1, description="If enabled, Music trackks will dynamically switch between war and peace depending on what is going on at that moment."},
		{id="interruptmusic", group="snd", name="Dynamic Music Interruption", type="bool", value=tonumber(Spring.GetConfigInt("evo_interruptmusic",1) or 1) == 1, description="If enabled, Music tracks will fade out and switch from peace to war \nand vice versa at that moment instead of allowing the entire peace or war track to finish first."},
		--{id="sndairabsorption", group="snd", name="Air absorption", type="slider", min=0, max=0.5, step=0.01, value=tonumber(Spring.GetConfigInt("snd_airAbsorption",1) or.1)},
        {id="musicplayer", group="snd", widget="Music Player", name="Music player", type="bool", value=GetWidgetToggleValue("Music Player"), description='Shown on top of (adv)playerlist'},
		{id="buildmenusounds", group="snd", name="Buildmenu click sounds", type="bool", value=(WG['red_buildmenu']~=nil and WG['red_buildmenu'].getConfigPlaySounds~= nil and WG['red_buildmenu'].getConfigPlaySounds()), description='Plays a sound when clicking on orders or buildmenu icons'},

        {id="voicenotifs", group="snd", widget="Voice Notifs", name="Voice notifications", type="bool", value=GetWidgetToggleValue("Voice Notifs"), description='Plays various voice notifications\n\nAdjust volume with the interface volume slider'},
		{id="voicenotifs_playtrackedplayernotifs", group="snd", name=widgetOptionColor.."   tracked cam/player notifs",type="bool", value=(WG['voicenotifs']~=nil and WG['voicenotifs'].getPlayTrackedPlayerNotifs()), description='Play voice notifs from the perspective of the currently camera tracked player'},
		{id="voicenotifs_volume", group="snd", name=widgetOptionColor.."   volume", type="slider", min=0.05, max=1, step=0.05, value=1, description='NOTE: It uses interface volume channel'},

		-- CONTROL
		{id="camera", group="control", name="Camera", type="select", options={'fps','overhead','spring','rot overhead','free'}, value=(tonumber((Spring.GetConfigInt("CamMode",1)+1) or 2))},
		{id="camerashake", group="control", widget="CameraShake", name="Camera shake", type="bool", value=GetWidgetToggleValue("CameraShake"), description='Shakes camera on explosions'},
		{id="camerasmoothness", group="control", name="Camera smoothing", type="slider", min=0, max=2, step=0.01, value=cameraTransitionTime, description="How smooth should the transitions between camera movement be?"},
		{id="lockcamera_transitiontime", group="control", name="Tracking cam smoothing", type="slider", min=0.4, max=1.5, step=0.01, value=(WG['advplayerlist_api']~=nil and WG['advplayerlist_api'].GetLockTransitionTime~=nil and WG['advplayerlist_api'].GetLockTransitionTime()), description="When viewing a players camera...\nhow smooth should the transitions between camera movement be?"},

		{id="scrollspeed", group="control", name="Scroll zoom speed", type="slider", min=1, max=45, step=1, value=math.abs(tonumber(Spring.GetConfigInt("ScrollWheelSpeed",1) or 25)), description=''},
		{id="scrollinverse", group="control", name="Scroll inversed", type="bool", value=(tonumber(Spring.GetConfigInt("ScrollWheelSpeed",1) or 25) < 0), description=""},

		{id="hwcursor", group="control", name="Hardware cursor", type="bool", value=tonumber(Spring.GetConfigInt("hardwareCursor",1) or 1) == 1, description="When disabled: the mouse cursor refresh rate will be the same as your ingame fps"},
		{id="crossalpha", group="control", name="Mouse cross alpha", type="slider", min=0, max=1, step=0.05, value=tonumber(Spring.GetConfigString("CrossAlpha",1) or 1), description='Opacity of mouse icon in center of screen when you are in camera pan mode\n\n(The\'icon\' has a dot in center with 4 arrows pointing in all directions)'},
		{id="screenedgemove", group="control", name="Screen edge moves camera", type="bool", restart=true, value=tonumber(Spring.GetConfigInt("FullscreenEdgeMove",1) or 1) == 1, description="If mouse is close to screen edge this will move camera\n\nChanges will be applied next game"},
		{id="containmouse", group="control", widget="Grabinput", name="Contain mouse inside window", type="bool", value=GetWidgetToggleValue("Grabinput"), description='When you are in windowed mode, this will keep your mouse from moving out of it'},
		{id="allyselunits_select", group="control", name="Select units of tracked player", type="bool", value=(WG['allyselectedunits']~=nil and WG['allyselectedunits'].getSelectPlayerUnits()), description="When viewing a players camera, this will also select the units the player has selected"},
		{id="lockcamera_hideenemies", group="control", name="Only show tracked player viewpoint", type="bool", value=(WG['advplayerlist_api']~=nil and WG['advplayerlist_api'].GetLockHideEnemies()), description="When viewing a players camera, this will only display what the tracked player sees"},
		{id="lockcamera_los", group="control", name=widgetOptionColor.."   show tracked player LoS", type="bool", value=(WG['advplayerlist_api']~=nil and WG['advplayerlist_api'].GetLockLos()), description="When viewing a players camera and los, shows shaded los ranges too"},

		-- UI
		{id="buildordermenu", group="ui", name="Build Menu Preset", type="select", options={'Horizontal','Compact Horizontal','Traditional', 'Traditional (SxS)','Right Side','Right Side Compact'}, value=Spring.GetConfigInt("evo_buildorderui",0) + 1, description='Use these presets to change the build menu size and position.\nBuild and Order menus can further be custom positioned using TweakMode (ctrl+f11)\n\nNOTE: Changing this setting will cause the interface to be reloaded'},
		{id="showcost", group="ui", name="Show Cost", type="bool", value=Spring.GetConfigInt("evo_showcost",1) == 1, description='Show cost of units in the build icon'},
		{id="showtechreq", group="ui", name="Show Tech Requirement", type="bool", value=Spring.GetConfigInt("evo_showtechreq",1) == 1, description='Show tech requirement of units in the build icon'},
		{id="showhotkeys", group="ui", name="Show Build Hotkeys", type="bool", value=Spring.GetConfigInt("evo_showhotkeys",1) == 1, description='Show build hotkeys in the build icon'},
		
		{id="teamcolors", group="ui", widget="Player Color Palette", name="Team colors based on a palette", type="bool", value=GetWidgetToggleValue("Player Color Palette"), description='Replaces lobby team colors for a color palette based one\n\nNOTE: reloads all widgets because these need to update their teamcolors'},
		{id="sameteamcolors", group="ui", name=widgetOptionColor.."   same team colors", type="bool", value=(WG['playercolorpalette']~=nil and WG['playercolorpalette'].getSameTeamColors~=nil and WG['playercolorpalette'].getSameTeamColors()), description='Use the same teamcolor for all the players in a team\n\nNOTE: reloads all widgets because these need to update their teamcolors'},

		{id="simpleminimapcolors", group="ui", name="Simple minimap colors", type="bool", value=tonumber(Spring.GetConfigInt("SimpleMiniMapColors",0) or 0) == 1, description="Enable simple minimap teamcolors\nRed is enemy,blue is ally and you are green!"},

		{id="font", group="ui", name="Font", type="select", options={}, value=1, description='Regular read friendly font used for text'},
		{id="font2", group="ui", name="Font 2", type="select", options={}, value=1, description='Stylistic font mainly used for names/buttons/titles'},
		{id="guiopacity", group="ui", name="GUI opacity", type="slider", min=0, max=1, step=0.01, value=Spring.GetConfigFloat("ui_opacity",0.66), description=''},

		{id="guishader", group="ui", widget="GUI Shader", name="GUI blur", type="bool", value=GetWidgetToggleValue("GUI Shader"), description='Blurs the world under every user interface element'},
		{id="guishaderintensity", group="ui", name=widgetOptionColor.."   intensity", type="slider", min=0.001, max=0.003, step=0.0001, value=0.002, description=''},

		{id="autoquit", group="ui", widget="Autoquit", name="Auto quit", type="bool", value=GetWidgetToggleValue("Autoquit"), description='Automatically quits after the game ends.\n...unless the mouse has been moved within a few seconds.'},

		--{id="showbuilderqueue", group="ui", widget="Show Builder Queue", name="Show Builder Queue", type="bool", value=GetWidgetToggleValue("Show Builder Queue"), description='Shows ghosted buildings about to be built on the map'},

		{id="healthbarsscale", group="ui", name="Health Bars Scale", type="slider", min=0.7, max=1.31, step=0.1, value=1, description=''},

		{id="consolemaxlines", group="ui", name="Console max lines", type="slider", min=3, max=9, step=1, value=6, description=''},
		{id="consolefontsize", group="ui", name="Console font size", type="slider", min=0.9, max=1.1, step=0.05, value=1, description=''},

		--{id="buildmenuoldicons", group="ui", name="Buildmenu old unit icons", type="bool", value=(WG['red_buildmenu']~=nil and WG['red_buildmenu'].getConfigOldUnitIcons()), description='Use the old unit icons in the buildmenu\n\n(reselect something to see the change applied)'},
		{id="buildmenushortcuts", group="ui", name="Buildmenu shortcuts", type="bool", value=(WG['red_buildmenu']~=nil and WG['red_buildmenu'].getConfigShortcutsInfo()), description='Enables and shows shortcut keys in the buildmenu\n\n(reselect something to see the change applied)'},
		{id="buildmenuprices", group="ui", name="Buildmenu prices", type="bool", value=(WG['red_buildmenu']~=nil and WG['red_buildmenu'].getConfigUnitPrice~=nil and WG['red_buildmenu'].getConfigUnitPrice()), description='Enables and shows unit prices in the buildmenu\n\n(reselect something to see the change applied)'},
		{id="buildmenulargeicons", group="ui", name="Buildmenu large icons", type="bool", value=(WG['red_buildmenu']~=nil and WG['red_buildmenu'].getConfigLargeUnitIcons~=nil and WG['red_buildmenu'].getConfigLargeUnitIcons()), description='Use large unit icons'},
		{id="buildmenutooltip", group="ui", name="Buildmenu tooltip", type="bool", value=(WG['red_buildmenu']~=nil and WG['red_buildmenu'].getConfigUnitTooltip~=nil and WG['red_buildmenu'].getConfigUnitTooltip()), description='Enables unit tooltip when hovering over unit in buildmenu'},
		{id="buildmenubigtooltip", group="ui", name=widgetOptionColor.."   extensive unit info", type="bool", value=(WG['red_buildmenu']~=nil and WG['red_buildmenu'].getConfigUnitBigTooltip~=nil and WG['red_buildmenu'].getConfigUnitBigTooltip()), description='Displays elaborative unit description when availible'},
		{id="buildpichelp", group="ui", name="Flashing Buildpic Help", type="bool", value=tonumber(Spring.GetConfigInt("evo_buildpichelp",1) or 1) == 1, description="Flashes relevant build menu items when resources are in a crisis situation"},

		{id="resourceprompts", group="ui", name="Audio/Visual Helper Prompts", type="bool", value=tonumber(Spring.GetConfigInt("evo_resourceprompts",1) or 1) == 1, description="If enabled, messages will be sent to the chat as well as\naudio cues when your resources need attention"},
		{id="simplifiedresourcebar", group="ui", name="Simplified Resource Bar", type="bool", value=tonumber(Spring.GetConfigInt("evo_simplifiedresourcebar",1) or 1) == 1, description="Removes extra information from the resource bar"},

		--{id="fancyselunits", group="gfx", widget="Fancy Selected Units", name="Fancy Selected Units", type="bool", value=GetWidgetToggleValue("Fancy Selected Units"), description=''},

		--{id="fpstimespeed", group="ui", name="Display FPS, GameTime and Speed", type="bool", value=tonumber(Spring.GetConfigInt("ShowFPS",1) or 1) == 1, description='Located at the top right of the screen\n\nIndividually toggle them with /fps /clock /speed'},
		{id="playerlistcollapse", group="ui", name="Playerlist auto collapses", type="bool", value=false, description='Auto collapses the playerlist, mouseover will show it again'},
		{id="fpstimespeed-widget", group="ui", widget="AdvPlayersList info", name="Playerlist time/speed/fps", type="bool", value=GetWidgetToggleValue("AdvPlayersList info"), description='Shows time, gamespeed and fps on top of the (adv)playerslist'},
		--{id="mascotte", group="ui", widget="AdvPlayersList mascotte", name="Playerlist mascotte", type="bool", value=GetWidgetToggleValue("AdvPlayersList mascotte"), description='Shows a mascotte on top of the (adv)playerslist'},

		{id="displaydps", group="ui", widget="Display DPS", name="Display DPS", type="bool", value=GetWidgetToggleValue("Display DPS"), description='Display the \'Damage Per Second\' done where target are hit'},

		{id="nametags_icon", group="ui", name="Commander name on icon", type="bool", value=(WG['nametags']~=nil and WG['nametags'].getDrawForIcon()), description='Show commander name when its displayed as icon'},

		{id="idlebuilders", group="ui", widget="Idle Builders", name="List Idle builders", type="bool", value=GetWidgetToggleValue("Idle Builders"), description='Displays a row containing a list of idle builder units (if there are any)'},
		{id="betfrontend", group="ui", widget="Bet-Frontend", name="Bet interface", type="bool", value=GetWidgetToggleValue("Bet-Frontend"), description='When spectator: display a betting interface.\nIt allows betting on when you think a unit will be destroyed.\nBeware... you have a limited supply of chips.'},
		{id="commandsfx", group="ui", widget="Commands FX", name="Command FX", type="bool", value=GetWidgetToggleValue("Commands FX"), description='Shows unit target lines when you give orders\n\nThe commands from your teammates are shown as well'},
		{id="commandsfxfilterai", group="ui", name=widgetOptionColor.."   filter AI teams", type="bool", value=true, description='Hide commands for AI teams'},
		{id="commandsfxopacity", group="ui", name=widgetOptionColor.."   opacity", type="slider", min=0.3, max=1, step=0.1, value=1, description=''},

		--{id="teamplatter", group="ui", widget="TeamPlatter", name="Unit team platters", type="bool", value=GetWidgetToggleValue("TeamPlatter"), description='Shows a team color platter above all visible units'},
		--{id="teamplatter_opacity", group="ui", name=widgetOptionColor.."   opacity", min=0.15, max=0.4, step=0.01, type="slider", value=0.3, description='Set the opacity of the team spotters'},
		--{id="teamplatter_skipownteam", group="ui", name=widgetOptionColor.."   skip own units", type="bool", value=false, description='Doesnt draw platters for yourself'},

        --{id="enemyspotter", group="ui", widget="EnemySpotter", name="Enemy spotters", type="bool", value=GetWidgetToggleValue("EnemySpotter"), description='Draws smoothed circles under enemy units'},
		--{id="enemyspotter_opacity", group="ui", name=widgetOptionColor.."   opacity", min=0.12, max=0.4, step=0.01, type="slider", value=0.15, description='Set the opacity of the enemy-spotter rings'},
		--{id="enemyspotter_highlight", group="ui", name=widgetOptionColor.."   unit highlight", type="bool", value=false, description='Colorize/highlight enemy units'},

		{id="highlightselunits", group="ui", widget="Highlight Selected Units", name="Highlight selected units", type="bool", value=GetWidgetToggleValue("Highlight Selected Units"), description='Highlights unit models when selected'},
		{id="highlightselunits_opacity", group="ui", name=widgetOptionColor.."   opacity", min=0.08, max=0.3, step=0.01, type="slider", value=0.2, description='Set the opacity of the highlight on selected units'},
        {id="highlightselunits_shader", group="ui", name=widgetOptionColor.."   use shader", type="bool", value=false, description='Highlight model edges a bit'},
        {id="highlightselunits_teamcolor", group="ui", name=widgetOptionColor.."   use teamcolor", type="bool", value=false, description='Use teamcolor instead of unit health coloring'},

		{id="fancyselectedunits", group="ui", widget="Fancy Selected Units", name="Fancy selected units", type="bool", value=GetWidgetToggleValue("Fancy Selected Units"), description='Draws a platter under selected units\n\n\NOTE: this widget can be heavy when having lots of units selected'},
		--{id="fancyselectedunits_style", group="ui", name=widgetOptionColor.."   style", type="select", options={}, value=1},
		{id="fancyselectedunits_opacity", group="ui", name=widgetOptionColor.."   line opacity", min=0.8, max=1, step=0.01, type="slider", value=0.9, description='Set the opacity of the highlight on selected units'},
		{id="fancyselectedunits_baseopacity", group="ui", name=widgetOptionColor.."   base opacity", min=0, max=0.5, step=0.01, type="slider", value=0.25, description='Set the opacity of the highlight on selected units'},
		{id="fancyselectedunits_teamcoloropacity", group="ui", name=widgetOptionColor.."   teamcolor opacity", min=0, max=1, step=0.01, type="slider", value=0.1, description='Set the amount of teamcolor used for the base platter'},
		--{id="fancyselectedunits_secondline", group="ui", name=widgetOptionColor.."   add second line", type="bool", value=false, description='Adds a second line'},

		{id="pausescreen", group="ui", widget="Pause Screen", name="Pause screen", type="bool", value=GetWidgetToggleValue("Pause Screen"), description='Displays an overlay when the game is paused'},
		{id="givenunits", group="ui", widget="Given Units", name="Given unit icons", type="bool", value=GetWidgetToggleValue("Given Units"), description='Tags given units with \'new\' icon'},


		-- GAME
		{id="autoquit", group="game", widget="Autoquit", name="Auto quit", type="bool", value=GetWidgetToggleValue("Autoquit"), description='Automatically quits after the game ends.\n...unless the mouse has been moved within a few seconds.'},

		{id="ctrl_dequeue", group="game", name="Ctrl to dequeue units", type="bool", value=Spring.GetConfigInt("evo_ctrl_dequeue",1) == 1, description='Use ctrl key to dequeue units for factory'},
		
		{id="smartselect_includebuildings", group="game", name="Include structures in area-selection", type="bool", value=false, description='When rectangle-drag-selecting an area, include building units too?\n\ndisabled: non-mobile units will be excluded\n(except: nanos always will be selected)'},
		{id="smartselect_includebuilders", group="game", name=widgetOptionColor.."   include builders   (if above is off)", type="bool", value=true, description='When rectangle-drag-selecting an area, exclude builder units'},

        {id="onlyfighterspatrol", group="game", widget="OnlyFightersPatrol", name="Only fighters patrol", type="bool", value=GetWidgetToggleValue("Autoquit"), description='Only fighters obey a factory\'s patrol route after leaving airlab.'},
		{id="fightersfly", group="game", widget="Set fighters on Fly mode", name="Set fighters on Fly mode", type="bool", value=GetWidgetToggleValue("Set fighters on Fly mode"), description='Setting fighters on Fly mode when created'},

		{id="passivebuilders", group="game", widget="Passive builders", name="Passive builders", type="bool", value=GetWidgetToggleValue("Passive builders"), description='Sets builders (nanos, labs and cons) on passive mode\n\nPassive mode means that builders will only spend energy when its availible.\nUsage: You could set your most important builders on active and leave the rest on passive'},

		{id="autogroup_immediate", group="game", name="Autogroup immediate mode", type="bool", value=(WG['autogroup']~=nil and WG['autogroup'].getImmediate~=nil and WG['autogroup'].getImmediate()), description='Units built/resurrected/received are added to autogroups immediately instead of waiting them to be idle.\n\n(add units to autogroup with ALT+number)'},

		{id="factoryguard", group="game", widget="FactoryGuard", name="Factory guard (builders)", type="bool", value=GetWidgetToggleValue("FactoryGuard"), description='Newly created builders will assist their source factory'},
		{id="factoryholdpos", group="game", widget="Factory hold position", name="Factory hold position", type="bool", value=GetWidgetToggleValue("Factory hold position"), description='Sets new factories, and all units they build, to hold position automatically (not aircraft)'},
		{id="factoryrepeat", group="game", widget="Factory Auto-Repeat", name="Factory auto-repeat", type="bool", value=GetWidgetToggleValue("Factory Auto-Repeat"), description='Sets new factories on Repeat mode'},

        {id="transportai", group="game", widget="Transport AI", name="Transport AI", type="bool", value=GetWidgetToggleValue("Transport AI"), description='Transport units automatically pick up new units going to factory waypoint.'},
		{id="settargetdefault", group="game", widget="Set target default", name="Set-target as default", type="bool", value=GetWidgetToggleValue("Set target default"), description='Replace default attack command to a set-target command\n(when rightclicked on enemy unit)'},
	}

	-- set lowest quality shadows for Intel GPU (they eat fps but dont show)
	if Platform ~= nil and Platform.gpuVendor == 'Intel' then
		options[getOptionByID('shadows_maxquality')] = nil
		options[getOptionByID('shadows_minquality')] = nil
		options[getOptionByID('shadowslider')] = nil
		options[getOptionByID('shadows_opacity')] = nil
	end

	if getOptionByID('fancyselectedunits_style') then
		options[getOptionByID('fancyselectedunits_style')].options = WG['fancyselectedunits'].getStyleList()
	end

	-- add fonts
	if getOptionByID('font') then
		local fonts = {}
		local fontsFull = {}
		local fontsn = {}
		local files = VFS.DirList(LUAUI_DIRNAME..'fonts', '*')
		fontOption = {}
		for k, file in ipairs(files) do
			local name = string.sub(file, 13)
			local ext = string.sub(name, string.len(name) - 2)
			if ext == 'otf' or ext == 'ttf' then
				name = string.sub(name, 1, string.len(name) - 4)
				if not fontsn[name:lower()] then
					fonts[#fonts+1] = name
					fontsFull[#fontsFull+1] = string.sub(file, 13)
					fontsn[name:lower()] = true
					local fontScale = (0.5 + (vsx*vsy / 5700000))
					fontOption[#fonts] = gl.LoadFont(LUAUI_DIRNAME .. "fonts/"..fontsFull[#fontsFull], 20*fontScale, 5*fontScale, 1.5)
				end
			end
		end

		options[getOptionByID('font')].options = fonts
		options[getOptionByID('font')].optionsFont = fontsFull
		local fname = Spring.GetConfigString("ui_font", "JosefinSans-SemiBold.ttf"):lower()
		options[getOptionByID('font')].value = getSelectKey(getOptionByID('font'), string.sub(fname, 1, string.len(fname) - 4))

		options[getOptionByID('font2')].options = fonts
		options[getOptionByID('font2')].optionsFont = fontsFull
		local fname = Spring.GetConfigString("ui_font2", "JosefinSans-Bold.ttf"):lower()
		options[getOptionByID('font2')].value = getSelectKey(getOptionByID('font2'), string.sub(fname, 1, string.len(fname) - 4))
	end

	-- set sun minimal height
	if getOptionByID('sun_y') then
		if select(2,gl.GetSun("pos")) < options[getOptionByID('sun_y')].min then
			Spring.SetSunDirection(select(1,gl.GetSun("pos")), options[getOptionByID('sun_y')].min, select(3,gl.GetSun("pos")))
		end
	end

	-- set minimal shadow opacity
	if getOptionByID('shadows_opacity') then
		if gl.GetSun("shadowDensity") < options[getOptionByID('shadows_opacity')].min then
			Spring.SetSunLighting({groundShadowDensity = options[getOptionByID('shadows_opacity')].min, modelShadowDensity = options[getOptionByID('shadows_opacity')].min})
		end
	end

	-- fsaa is deprecated in 104.x
	if tonumber(Spring.GetConfigInt("FSAALevel",0)) > 0 then
		local fsaa = tonumber(Spring.GetConfigInt("FSAALevel",0))
		if fsaa > 4 then
			fsaa = 8
		end
		Spring.SetConfigInt("MSAALevel", 8)
		Spring.SetConfigInt("FSAALevel", 0)
	end

	-- remove engine particles if nano beams are enabled
	if options[getOptionByID('nanoeffect')] and options[getOptionByID('nanoeffect')].value == 1 then
		Spring.SetConfigInt("MaxNanoParticles", 0)
	end
	-- loads values via stored game config in luaui/configs
	loadAllWidgetData()

	-- while we have set config-ints, that isnt enough to have these settings applied ingame
	if savedConfig and Spring.GetGameFrame() == 0 then
		for k, v in pairs(savedConfig) do
			if getOptionByID(k) then
				applyOptionValue(getOptionByID(k))
			end
		end
		changesRequireRestart = false
	end

    -- detect AI
    local aiDetected = false
    local t = Spring.GetTeamList()
    for _,teamID in ipairs(t) do
        if select(4,Spring.GetTeamInfo(teamID,false)) then
            aiDetected = true
        end
    end
    if not aiDetected then
        options[getOptionByID('commandsfxfilterai')] = nil
	end

	if #supportedResolutions < 2 then
		options[getOptionByID('resolution')] = nil
	else
		for id,res in pairs(options[getOptionByID('resolution')].options) do
			if res == vsx..' x '..vsy then
				options[getOptionByID('resolution')].value = id
				break
			end
		end

		-- disable music volume slider
		if widgetHandler.knownWidgets["Music Player"] == nil then
			options[getOptionByID('sndvolmusic')] = nil
		end
	end

	-- add sound notification widget sound toggle options
	if widgetHandler.knownWidgets["Voice Notifs"] then
		local soundList
		if WG['voicenotifs'] ~= nil then
			soundList =  WG['voicenotifs'].getSoundList()
		elseif widgetHandler.configData["Voice Notifs"] ~= nil and widgetHandler.configData["Voice Notifs"].soundList ~= nil then
			soundList = widgetHandler.configData["Voice Notifs"].soundList
		end
		if type(soundList) == 'table' then
			local newOptions = {}
			local count = 0
			for i, option in pairs(options) do
				count = count + 1
				newOptions[count] = option
				if option.id == 'voicenotifs_volume' then
					for sound, enabled in pairs(soundList) do
						count = count + 1
						newOptions[count] = {id="voicenotifs_snd_"..sound, group="snd", name=widgetOptionColor.."   "..sound, type="bool", value=enabled, description=''}
					end
				end
			end
			options = newOptions
		end
	else
		options[getOptionByID('voicenotifs')] = nil
		options[getOptionByID('voicenotifs_volume')] = nil
		options[getOptionByID('voicenotifs_playtrackedplayernotifs')] = nil
	end

	if not widgetHandler.knownWidgets["Player-TV"] then
		options[getOptionByID('playertv_countdown')] = nil
	end


	-- cursors
	if (WG['cursors'] == nil) then
		options[getOptionByID('cursor')] = nil
	else
		local cursorsets = {}
		local cursor = 1
		local cursoroption
		cursorsets = WG['cursors'].getcursorsets()
		local cursorname = WG['cursors'].getcursor()
		for i,c in pairs(cursorsets) do
			if c == cursorname then
				cursor = i
				break
			end
		end
		options[getOptionByID('cursor')].options = cursorsets
		options[getOptionByID('cursor')].value = cursor
	end
	if widgetHandler.knownWidgets["SSAO"] == nil then
		options[getOptionByID('ssao')] = nil
		options[getOptionByID('ssao_strength')] = nil
		options[getOptionByID('ssao_radius')] = nil
	end
	if widgetHandler.knownWidgets["Bloom Shader"] == nil then
		options[getOptionByID('bloombrightness')] = nil
		options[getOptionByID('bloomsize')] = nil
		options[getOptionByID('bloomquality')] = nil
	end
	if widgetHandler.knownWidgets["Bloom Shader Deferred"] == nil then
		options[getOptionByID('bloomdeferredbrightness')] = nil
		options[getOptionByID('bloomdeferredsize')] = nil
		options[getOptionByID('bloomdeferredquality')] = nil
	end

	if (WG['healthbars'] == nil) then
		options[getOptionByID('healthbarsscale')] = nil
	elseif WG['healthbars'].getScale ~= nil then
		options[getOptionByID('healthbarsscale')].value = WG['healthbars'].getScale()
	end

	if (WG['smartselect'] == nil) then
		options[getOptionByID('smartselect_includebuildings')] = nil
		options[getOptionByID('smartselect_includebuilders')] = nil
	else
		options[getOptionByID('smartselect_includebuildings')].value = WG['smartselect'].getIncludeBuildings()
		options[getOptionByID('smartselect_includebuilders')].value = WG['smartselect'].getIncludeBuilders()
	end

	if WG['snow'] ~= nil and WG['snow'].getSnowMap ~= nil then
		options[getOptionByID('snowmap')].value = WG['snow'].getSnowMap()
	end
	if (WG['LupsPriority'] ~= nil) then
		options[getOptionByID('lupseffectlevel')].value = WG['LupsPriority']
	end

	if (WG['darkenmap'] == nil) then
		options[getOptionByID('darkenmap')] = nil
		options[getOptionByID('darkenmap_darkenfeatures')] = nil
	else
		options[getOptionByID('darkenmap')].value = WG['darkenmap'].getMapDarkness()
		options[getOptionByID('darkenmap_darkenfeatures')].value = WG['darkenmap'].getDarkenFeatures()
	end

	-- not sure if needed: remove vsync option when its done by monitor (freesync/gsync) -> config value is set as 'x'
	if Spring.GetConfigInt("VSync",1) == 'x' then
		options[getOptionByID('vsync')] = nil
	end

	if not widgetHandler.knownWidgets["Commander Name Tags"] then
		options[getOptionByID('nametags_icon')] = nil
	end

	if WG['red_buildmenu'] == nil or WG['red_buildmenu'].getConfigShortcutsInfo == nil then
		options[getOptionByID('buildmenushortcuts')] = nil
	end
	if WG['red_buildmenu'] == nil or WG['red_buildmenu'].getConfigUnitPrice == nil then
		options[getOptionByID('buildmenuprices')] = nil
	end
	if WG['red_buildmenu'] == nil or WG['red_buildmenu'].getConfigPlaySounds == nil then
		options[getOptionByID('buildmenusounds')] = nil
	end
	if WG['red_buildmenu'] == nil or WG['red_buildmenu'].getConfigUnitTooltip == nil then
		options[getOptionByID('buildmenutooltip')] = nil
	end
	if WG['red_buildmenu'] == nil or WG['red_buildmenu'].getConfigUnitBigTooltip == nil then
		options[getOptionByID('buildmenubigtooltip')] = nil
	end
	if WG['red_buildmenu'] == nil or WG['red_buildmenu'].getConfigLargeUnitIcons == nil then
		options[getOptionByID('buildmenulargeicons')] = nil
	end

	if WG['playercolorpalette'] == nil or WG['playercolorpalette'].getSameTeamColors == nil then
		options[getOptionByID('sameteamcolors')] = nil
	end

	if WG['advplayerlist_api']==nil or WG['advplayerlist_api'].GetLockTransitionTime==nil then
		options[getOptionByID('lockcamera_transitiontime')] = nil
	end

	-- disable options when widget isnt availible
	if widgetHandler.knownWidgets["Outline"] == nil then
		options[getOptionByID('outline')] = nil
		options[getOptionByID("outline_size")] = nil
		options[getOptionByID("outline_strength")] = nil
	end

	if widgetHandler.knownWidgets["Fancy Selected Units"] == nil then
		options[getOptionByID('fancyselectedunits')] = nil
		options[getOptionByID("fancyselectedunits_style")] = nil
		options[getOptionByID("fancyselectedunits_opacity")] = nil
		options[getOptionByID("fancyselectedunits_baseopacity")] = nil
		options[getOptionByID("fancyselectedunits_teamcoloropacity")] = nil
		options[getOptionByID("fancyselectedunits_secondline")] = nil
	end

	if widgetHandler.knownWidgets["Auto Group"] == nil then
		options[getOptionByID("autogroup_immediate")] = nil
	end

	if widgetHandler.knownWidgets["Highlight Selected Units"] == nil then
		options[getOptionByID('highlightselunits')] = nil
		options[getOptionByID("highlightselunits_opacity")] = nil
		options[getOptionByID("highlightselunits_shader")] = nil
		options[getOptionByID("highlightselunits_teamcolor")] = nil
	end

	if widgetHandler.knownWidgets["Under construction gfx"] == nil then
		options[getOptionByID('underconstructiongfx')] = nil
		options[getOptionByID("underconstructiongfx_opacity")] = nil
		options[getOptionByID("underconstructiongfx_shader")] = nil
	end

	if widgetHandler.knownWidgets["Light Effects"] == nil or widgetHandler.knownWidgets["Deferred rendering"] == nil then
		options[getOptionByID('lighteffects')] = nil
		options[getOptionByID("lighteffects_brightness")] = nil
		options[getOptionByID("lighteffects_laserbrightness")] = nil
		options[getOptionByID("lighteffects_radius")] = nil
		options[getOptionByID("lighteffects_laserradius")] = nil
		--options[getOptionByID("lighteffects_heatdistortion")] = nil
		--options[getOptionByID("lighteffects_deferred")] = nil
	end

	if widgetHandler.knownWidgets["TeamPlatter"] == nil then
		options[getOptionByID('teamplatter_opacity')] = nil
		options[getOptionByID('teamplatter_skipownunits')] = nil
	end

	if widgetHandler.knownWidgets["EnemySpotter"] == nil then
		options[getOptionByID('enemyspotter_opacity')] = nil
		options[getOptionByID('enemyspotter_highlight')] = nil
	end

	local processedOptions = {}
	local processedOptionsCount = 0
	local insert = true
	for oid,option in pairs(options) do
		insert = true
		if option.type == 'slider' and not option.steps then
			if option.value < option.min then option.value = option.min end
			if option.value > option.max then option.value = option.max end
		end
		if (option.id == "shadows" or option.id == "shadows_maxquality" or option.id == "shadows_minquality" or option.id == "shadows_disablefps") and (widgetHandler.knownWidgets["Shadow Quality Manager"] == nil or (widgetHandler.orderList["Shadow Quality Manager"] == 0)) then
			insert = false
		end
		if option.id == "shadowslider" and widgetHandler.knownWidgets["Shadow Quality Manager"] ~= nil and (widgetHandler.orderList["Shadow Quality Manager"] > 0) then
			insert = false
		end
		if option.widget ~= nil and widgetHandler.knownWidgets[option.widget] == nil then
			insert = false
		end
		if insert then
			processedOptionsCount = processedOptionsCount + 1
			processedOptions[processedOptionsCount] = option
		end
	end
	options = processedOptions
end


function deletePreset(name)
	Spring.Echo('deleted preset:  '..name)
	customPresets[name] = nil
	presets[name] = nil
	local newPresetNames = {}
	for _, presetName in ipairs(presetNames) do
		if presetName ~= name then
			table.insert(newPresetNames, presetName)
		end
	end
	presetNames = newPresetNames
	options[getOptionByID('preset')].options = presetNames
	if windowList then gl.DeleteList(windowList) end
	windowList = gl.CreateList(DrawWindow)
end

function savePreset(name)
	if name == nil then
		name = 'custom'
		local i = 1
		while customPresets[name] ~= nil do
			i = i + 1
			name = 'custom'..i
		end
	end
	if presets[name] ~= nil then
		Spring.Echo("preset '"..name.."' already exists")
	else
		local preset = {}
		for optionID, _ in pairs(presets['lowest']) do
			if options[getOptionByID(optionID)] ~= nil then
				preset[optionID] = options[getOptionByID(optionID)].value
			end
		end
		customPresets[name] = preset
		presets[name] = preset
		table.insert(presetNames, name)
		options[getOptionByID('preset')].options = presetNames
		Spring.Echo('saved preset: '..name)
		if windowList then gl.DeleteList(windowList) end
		windowList = gl.CreateList(DrawWindow)
	end
end


function widget:Initialize()

	if Spring.GetGameFrame() == 0 then
		-- set minimum particle amount
		if tonumber(Spring.GetConfigInt("MaxParticles",1) or 10000) <= 10000 then
			Spring.SetConfigInt("MaxParticles",10000)
		end
		-- enable lua shaders
		if not tonumber(Spring.GetConfigInt("ForceShaders",1) or 0) then
			Spring.SetConfigInt("ForceShaders", 1)
		end
		-- enable map/model shading
		if Spring.GetConfigInt("AdvMapShading",0) ~= 1 then
			Spring.SetConfigInt("AdvMapShading",1)
		end
		if Spring.GetConfigInt("AdvModelShading",0) ~= 1 then
			Spring.SetConfigInt("AdvModelShading",1)
		end
		-- enable normal mapping
		--if Spring.GetConfigInt("NormalMapping",0) ~= 1 then
		--	Spring.SetConfigInt("NormalMapping",1)
		--	Spring.SendCommands("luarules normalmapping 1")
		--end
		-- disable clouds
		--if Spring.GetConfigInt("AdvSky",0) ~= 0 then
		--	Spring.SetConfigInt("AdvSky",0)
		--end
		-- disable grass
		if Spring.GetConfigInt("GrassDetail",0) ~= 0 then
			Spring.SetConfigInt("GrassDetail",0)
		end

		--if Platform ~= nil and Platform.gpuVendor ~= 'Nvidia' then	-- because UsePBO displays tiled map texture bug for ATI/AMD cards
		--Spring.SetConfigInt("UsePBO",0)
		--end

		-- enable shadows at gamestart
		--if Spring.GetConfigInt("Shadows",0) ~= 1 then
		--	Spring.SetConfigInt("Shadows",1)
		--	Spring.SendCommands("Shadows 1")
		--end
		-- set lowest quality shadows for Intel GPU (they eat fps but dont really show, but without any shadows enables it looks glitchy)
		if Platform ~= nil and Platform.gpuVendor == 'Intel' then
			Spring.SendCommands("Shadows 1 1024")
        end

        -- set custom user map sun position
        if customMapSunPos[Game.mapName] and customMapSunPos[Game.mapName][1] then
            Spring.SetSunDirection(customMapSunPos[Game.mapName][1],customMapSunPos[Game.mapName][2],customMapSunPos[Game.mapName][3])
            Spring.SetSunLighting({groundShadowDensity = gl.GetSun("shadowDensity"), modelShadowDensity = gl.GetSun("shadowDensity")})
        end

		-- disable fog
		Spring.SetAtmosphere({fogStart = 0.99999, fogEnd = 1.0, fogColor = {1.0, 1.0, 1.0, 0.0}})
	end

	Spring.SendCommands("minimap unitsize "..(Spring.GetConfigFloat("MinimapIconScale", 3.5)))		-- spring wont remember what you set with '/minimap iconssize #'

	Spring.SendCommands({"bind f10 options"})

	WG['options'] = {}
	WG['options'].toggle = function(state)
		if state ~= nil then
			show = state
		else
			show = not show
		end
	end
	WG['options'].isvisible = function()
		return show
	end
	WG['options'].getCameraSmoothness = function()
		return cameraTransitionTime
	end

	presets = tableMerge(presets, customPresets)
	for preset,_ in pairs(customPresets) do
		table.insert(presetNames, preset)
	end

	init()
end

function widget:Shutdown()
    if buttonGL then
        glDeleteList(buttonGL)
    end
    if windowList then
        glDeleteList(windowList)
	end
	if fontOption then
		for i, font in pairs(fontOption) do
			gl.DeleteFont(fontOption[i])
		end
	end
	if WG['guishader'] then
		WG['guishader'].DeleteDlist('options')
	end
	gl.DeleteFont(font)
	gl.DeleteFont(font2)
	WG['options'] = nil
end


local function Split(s, separator)
	local results = {}
	for part in s:gmatch("[^"..separator.."]+") do
		results[#results + 1] = part
	end
	return results
end

local lastOptionCommand = 0
function widget:TextCommand(command)
	if (string.find(command, "options") == 1  and  string.len(command) == 7) then
		show = not show
	end
	if os.clock() > lastOptionCommand+1 and string.sub(command, 1, 7) == "option " then		-- clock check is needed because toggling widget will somehow do an identical call of widget:TextCommand(command)
		local option = string.sub(command, 8)
		local optionID = getOptionByID(option)
		if optionID then
			if options[optionID].type == 'bool' then
				lastOptionCommand = os.clock()
				options[optionID].value = not options[optionID].value
				applyOptionValue(optionID)
			else
				show = true
			end
		else
			option = Split(option, ' ')
			optionID = option[1]
			if optionID then
				optionID = getOptionByID(optionID)
				if optionID and option[2] then
					lastOptionCommand = os.clock()
					if options[optionID].type == 'select' then
						local selectKey = getSelectKey(optionID, option[2])
						if selectKey then
							options[optionID].value = selectKey
							applyOptionValue(optionID)
						end
					elseif options[optionID].type == 'bool' then
						if option[2] == '0' then
							options[optionID].value = false
						else
							options[optionID].value = true
						end
						applyOptionValue(optionID)
					else
						options[optionID].value = tonumber(option[2])
						applyOptionValue(optionID)
					end
				end
			end
		end
	end
	if (string.find(command, "savepreset") == 1)  then
		local words = Split(command, ' ')
		if words[2] then
			savePreset(words[2])
		else
			savePreset()
		end
	end
end

function getSelectKey(i, value)
	for k, v in pairs(options[i].options) do
		if v == value then
			return k
		end
	end
	return false
end


function widget:GetConfigData(data)
	savedTable = {}
	savedTable.customPresets = customPresets
	savedTable.cameraTransitionTime = cameraTransitionTime
	savedTable.cameraPanTransitionTime = cameraPanTransitionTime
	savedTable.maxNanoParticles = maxNanoParticles
    savedTable.currentGroupTab = currentGroupTab
    savedTable.show = show
    savedTable.defaultMapSunPos = defaultMapSunPos
    savedTable.mapName = Game.mapName
    savedTable.customMapSunPos = customMapSunPos
	savedTable.savedConfig = {
		vsync = {'VSync', tonumber(Spring.GetConfigInt("VSync",1) or 1)},
		water = {'Water', tonumber(Spring.GetConfigInt("Water",1) or 1)},
		disticon = {'UnitIconDist', tonumber(Spring.GetConfigInt("UnitIconDist",1) or 400)},
		particles = {'MaxParticles', tonumber(Spring.GetConfigInt("MaxParticles",1) or 10000)},
		nanoparticles = {'MaxNanoParticles', tonumber(Spring.GetConfigInt("MaxNanoParticles",1) or 500)},
		decals = {'GroundDecals', tonumber(Spring.GetConfigInt("GroundDecals",1) or 1)},
		grounddetail = {'GroundDetail', tonumber(Spring.GetConfigInt("GroundDetail",1) or 1)},
		grassdetail = {'GrassDetail', tonumber(Spring.GetConfigInt("GrassDetail",1) or 5)},
		shadows = {'Shadows', tonumber(Spring.GetConfigInt("Shadows",1) or 1)},
		advsky = {'AdvSky', tonumber(Spring.GetConfigInt("AdvSky",1) or 1)},
		camera = {'CamMode', tonumber(Spring.GetConfigInt("CamMode",1) or 1)},
		advmodelshading = {'AdvModelShading', tonumber(Spring.GetConfigInt("AdvModelShading",1) or 1)},
		advmapshading = {'AdvMapShading', tonumber(Spring.GetConfigInt("AdvMapShading",1) or 1)},
		--normalmapping = {'NormalMapping', tonumber(Spring.GetConfigInt("NormalMapping",1) or 1)},
		--treewind = {'TreeWind', tonumber(Spring.GetConfigInt("TreeWind",1) or 1)},
		hwcursor = {'HardwareCursor', tonumber(Spring.GetConfigInt("HardwareCursor",1) or 1)},
		sndvolmaster = {'snd_volmaster', tonumber(Spring.GetConfigInt("snd_volmaster",1) or 50)},
		sndvolbattle = {'snd_volbattle', tonumber(Spring.GetConfigInt("snd_volbattle",1) or 50)},
		sndvolunitreply = {'snd_volunitreply', tonumber(Spring.GetConfigInt("snd_volunitreply",1) or 50)},
		sndvolmusic = {'snd_volmusic', tonumber(Spring.GetConfigInt("snd_volmusic",1) or 50)},
	}
	return savedTable
end

function widget:SetConfigData(data)
	if data.customPresets ~= nil then
		customPresets = data.customPresets
	end
	if data.cameraTransitionTime ~= nil then
		cameraTransitionTime = data.cameraTransitionTime
	end
	if data.cameraPanTransitionTime ~= nil then
		cameraPanTransitionTime = data.cameraPanTransitionTime
	end
	if data.maxNanoParticles ~= nil then
		maxNanoParticles = data.maxNanoParticles
	end
    if data.currentGroupTab ~= nil then
        currentGroupTab = data.currentGroupTab
    end
    if data.show ~= nil and Spring.GetGameFrame() > 0 then
        show = data.show
    end
	if data.savedConfig ~= nil then
		savedConfig = data.savedConfig
		for k, v in pairs(savedConfig) do
			Spring.SetConfigFloat(v[1],v[2])
		end
    end
    if data.defaultMapSunPos ~= nil and data.mapName == Game.mapName then
        defaultMapSunPos = data.defaultMapSunPos
    end
    if data.customMapSunPos then
        customMapSunPos = data.customMapSunPos
    end
end
