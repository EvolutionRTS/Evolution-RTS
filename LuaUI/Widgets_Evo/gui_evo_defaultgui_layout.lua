--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    gui_EVO_Layout.lua
--  author:  jK
--  based heavily on code by: Dave Rodgers (aka trepan)
--  orig. filename: layout.lua
--
--  Copyright (C) 2007.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "EVO Default Engine Gui Layout",
    desc      = "Sets the control panel to EVO default",
    author    = "jK and trepan, mixed by lurker and DeadnightWarrior",
    date      = "Feb 3, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = -10,
    handler   = true,
    enabled   = false  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

include("colors.h.lua")

local floor = math.floor
local glColor = gl.Color
local glRect = gl.Rect
local glTexRect = gl.TexRect
local glPushMatrix = gl.PushMatrix
local glPopMatrix = gl.PopMatrix
local glTranslate = gl.Translate
local glBeginText = gl.BeginText
local glEndText = gl.EndText
local glText = gl.Text
local glTexture = gl.Texture

local langSuffix = Spring.GetConfigString('Language', 'fr')
local l10nName = 'L10N/commands_' .. langSuffix .. '.lua'
local success, translations = pcall(VFS.Include, l10nName)
if (not success) then
  translations = nil
end

-- for DefaultHandler
local FrameTex   = "bitmaps/icons/frame_slate_128x96.png"
local FrameScale     = "&0.099x0.132&"
local PageNumTex = "bitmaps/icons/frame_slate_128x96.png"
local btns = {}

if (false) then  --  disable textured buttons?
  FrameTex   = ""
  PageNumTex = ""
end

local PageNumCmd = {
  name     = "1",
  iconname = PageNumTexture,
  tooltip  = "Active Page Number\n(click to toggle buildiconsfirst)",
  actions  = { "buildiconsfirst", "firstmenu" }
}

local engineVersion = (Game and Game.version) or (Engine and Engine.version) or "Engine version error"
if (engineVersion:find("0.75")==nil)or(engineVersion:find("svn")) then
  PageNumCmd.texture  = PageNumCmd.iconname
  PageNumCmd.iconname = nil
end

local X, Y
local TweakPosX, TweakPosY
local btnOffset, txtOffset
local bntTxtSize, TweakTitleSize
local rowSize, btnSize
--------------------------------------------------------------------------------

local function CustomLayoutHandler(xIcons, yIcons, cmdCount, commands)

  widgetHandler.commands   = commands
  --widgetHandler.commands.n = cmdCount
  widgetHandler:CommandsChanged()

  -- FIXME: custom commands
  if (cmdCount <= 0) then
    return "", xIcons, yIcons, {}, {}, {}, {}, {}, {}, {}, {}
  end

  local menuName = ''
  local removeCmds = {}
  local customCmds = widgetHandler.customCommands
  local onlyTexCmds = {}
  local reTexCmds = {}
  local reNamedCmds = {}
  local reTooltipCmds = {}
  local reParamsCmds = {}
  local iconList = {}

  local ipp
  if cmdCount-2 > xIcons * (yIcons+1) then
    ipp = (xIcons * yIcons)  -- iconsPerPage
  else
    ipp = (xIcons * (yIcons + 1))
  end

  local activePage = Spring.GetActivePage()

  local prevCmd = cmdCount - 1
  local nextCmd = cmdCount - 0
  local prevPos = ipp - xIcons
  local nextPos = ipp - 1
  if (prevCmd >= 1) then reTexCmds[prevCmd] = FrameTex end
  if (nextCmd >= 1) then reTexCmds[nextCmd] = FrameTex end

  local pageNumCmd = -1
  local pageNumPos = (prevPos + nextPos) / 2
  if (xIcons > 2) then
    local color
    if (commands[1].id < 0) then color = GreenStr else color = RedStr end
    local activePage = activePage or 0
    local pageNum = '' .. (activePage + 1) .. ''
    PageNumCmd.name = color .. '   ' .. pageNum .. '   '
    table.insert(customCmds, PageNumCmd)
    pageNumCmd = cmdCount + 1
  end

  local pos = 0;
  local firstSpecial = ipp - xIcons

  for cmdSlot = 1, (cmdCount - 2) do

    -- fill the last row with special buttons
    while (math.fmod(pos, ipp) >= firstSpecial) do
      pos = pos + 1
    end

    local onLastRow = (math.abs(math.fmod(pos, ipp)) < 0.1)

    if (onLastRow) then
      local pageStart = math.floor(ipp * math.floor(pos / ipp))
      if (pageStart > 0) then
        iconList[prevPos + pageStart] = prevCmd
        iconList[nextPos + pageStart] = nextCmd
        if (pageNumCmd > 0) then
          iconList[pageNumPos + pageStart] = pageNumCmd
        end
      end
      if (pageStart == ipp) then
        iconList[prevPos] = prevCmd
        iconList[nextPos] = nextCmd
        if (pageNumCmd > 0) then
          iconList[pageNumPos] = pageNumCmd
        end
      end
    end

    -- add the command icons to iconList
    local cmd = commands[cmdSlot]

    if ((cmd ~= nil) and (cmd.hidden == false)) then

      iconList[pos] = cmdSlot
      pos = pos + 1

      local cmdTex = cmd.texture or "" -- FIXME 0.75b2 compatibility

      if (translations) then
        local trans = translations[cmd.id]
        if (trans) then
          reTooltipCmds[cmdSlot] = trans.desc
          if (not trans.params) then
            if (cmd.id ~= CMD.STOCKPILE) then
              reNamedCmds[cmdSlot] = trans.name
            end
          else
            local num = tonumber(cmd.params[1])
            if (num) then
              num = (num + 1)
              cmd.params[num] = trans.params[num]
              reParamsCmds[cmdSlot] = cmd.params
            end
          end
        end
      end
    end
  end

  return menuName, xIcons, yIcons,
         removeCmds, customCmds,
         onlyTexCmds, reTexCmds,
         reNamedCmds, reTooltipCmds, reParamsCmds,
         iconList
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local Echo = Spring.Echo

local commonConfig = {
"outlinefont 	1",
"dropShadows 	1",
"useOptionLEDs 	1",
"textureAlpha 	1.0",
"frameAlpha 	0.5",
"selectGaps 	1",
"selectThrough 	1",

"xPos           0",
"yPos           0.097",
"ySelectionPos  0.094",
"prevPageSlot 	auto",
"deadIconSlot 	none",
"nextPageSlot 	auto",
"textBorder 	0.0025",
"iconBorder 	0.0005",
"frameBorder 	0.000",

}

local config = {}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:Initialize()
	widgetHandler:DisableWidget("Red Build/Order Menu")
	if not btns.x or not btns.y then
		btns = {x = 5, y = 11}
	end
	X, Y = Spring.GetViewGeometry()
	local maxButSize=(1-0.097-0.31-4/Y)/btns.y-.0005
	TweakPosX = floor((maxButSize+0.0005)*btns.x*Y*1.12)
	TweakPosY = floor(maxButSize*btns.y*Y)
	btnOffset, txtOffset = floor(12*Y/1200), floor(48*Y/1200)
	bntTxtSize = 22*Y/1200
	TweakTitleSize = 10*Y/1200
	rowSize, btnSize = floor(25*Y/1200), floor(80*Y/1200)


	config = {
		"xIcons         " .. btns.x,
		"yIcons         " .. btns.y,
		"xSelectionPos " .. TweakPosX/3/X,
		"xIconSize " .. maxButSize*1.12*Y/X,
		"yIconSize " .. maxButSize
	}

	--[[
	-- 4:3 Screen aspect ratio
	if (X/Y == 4/3) then
		config = {"xIconSize 0.054375", "yIconSize 0.0725"}

	-- 5:4 Screen aspect ratio
	elseif (X/Y == 5/4) then
		config = {"xIconSize 0.05704", "yIconSize 0.0713"}

	-- 16:9 Screen aspect ratio
	elseif ((X/Y == 16/9) or (X==1366 and Y==768)) then
		config = {"xIconSize 0.040", "yIconSize 0.0643"}

	-- 16:10 Screen aspect ratio
	elseif (X/Y == 16/10) then
		config = {"xIconSize 0.044", "yIconSize 0.0675"}
	else
		Echo("Control Panel Widget doens't support your " ..X.. "x" ..Y.. " resolution.")
		Echo("Call back your default Layout.")
		Shutdown()
		return
	end
	--]]

	local file = io.open(LUAUI_DIRNAME .. 'ctrlpanelImp.txt', 'w')

	for k, v in pairs(commonConfig) do
		file:write(v .. '\n')
	end
	for k, v in pairs(config) do
		file:write(v .. '\n')
	end

	file:close()
	Spring.SendCommands('ctrlpanel ' .. LUAUI_DIRNAME .. 'ctrlpanelImp.txt')

	widgetHandler:ConfigLayoutHandler(CustomLayoutHandler)
end

function widget:Shutdown()
  Spring.SendCommands({"ctrlpanel " .. LUAUI_DIRNAME .. "ctrlpanel.txt"})
  widgetHandler:ConfigLayoutHandler(true)
end


-- LuaUI Tweak mode

local TweakAbove

function widget:RecvLuaMsg(msg, playerID)
	if msg:sub(1,18) == 'LobbyOverlayActive' then
		chobbyInterface = (msg:sub(1,19) == 'LobbyOverlayActive1')
	end
end

function widget:DrawScreen()
	if chobbyInterface then return end	--Tweak Mode doesn't work without it
end
function widget:TweakDrawScreen()
	glPushMatrix()
		glTranslate(TweakPosX, TweakPosY, 0)
		glColor(0, 0, 0, 0.5)
		for i=0,2 do
			glRect(btnOffset,rowSize*i+i,btnSize,rowSize*(i+1))
		end
		glColor(1, 1, 1, 1)
		glBeginText()
			glText('Select button configuration', btnOffset, 3*rowSize+3, TweakTitleSize, 'd')
			glText('3 x 8', txtOffset, 2*rowSize, bntTxtSize, 'cd')
			glText('4 x 9', txtOffset, rowSize, bntTxtSize, 'cd')
			glText('5 x 11', txtOffset, 0, bntTxtSize, 'cd')
		glEndText()
	glPopMatrix()
end

function widget:TweakIsAbove(x,y)
	if x>TweakPosX and y>TweakPosY and x<TweakPosX+btnSize and y<TweakPosY+3*rowSize then
		TweakAbove = true
	else
		TweakAbove = false
	end
	return TweakAbove
end

function widget:TweakGetTooltip(x,y)
  return 'Select number of icons'
end

function widget:TweakMousePress(x, y, button)
	if (TweakAbove) then
		btns.x=3+(2-floor((y-TweakPosY) / rowSize))
		btns.y=2*btns.x+1
		if btns.y==7 then btns.y=8 end
		self:Initialize()
		return true
	end
	return false
end

--load / save to config file
function widget:SetConfigData(data)
	if (data ~= nil) then
		btns = data
		if not btns.x or not btns.y then
			btns = {x = 4,	y = 9,}
		end
	else
		btns = {x = 4,	y = 9,}
	end
end
function widget:GetConfigData()
	return btns
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
