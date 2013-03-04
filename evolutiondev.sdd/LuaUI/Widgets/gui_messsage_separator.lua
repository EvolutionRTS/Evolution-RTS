-- to move and resize, press ctrl + f11 to enter tweak mode
-- to change font size, use the scrollwheel on the text area in the tweak mode
-- control + \: enable/disable commands not marked by **
-- control + p: switch word wrap mode
-- control + f: enable/disable message filtering
-- control + o: enable/disable message outlining
-- control + ,: scroll up message history **
-- control + .: scroll down message history **

include("colors.h.lua")
include("keysym.h.lua")

function widget:GetInfo()
	return {
		name      = "Message Separator",
		desc      = "chat console that separates player and system messages",
		author    = "Kloot & BD",
		date      = "April 22, 2009",
		license   = "GNU GPL v2",
		layer     = 0,
		enabled   = true
	}
end

local BOX_BORDER_SIZE				= 30
local PLAYER_MSG_BOX_MIN_W		= BOX_BORDER_SIZE * 4
local PLAYER_MSG_BOX_MIN_H		= BOX_BORDER_SIZE * 4
local SYSTEM_MSG_BOX_MIN_W		= BOX_BORDER_SIZE * 4
local SYSTEM_MSG_BOX_MIN_H		= BOX_BORDER_SIZE * 4
local FONT_MAX_SIZE				= 30
local ROSTER_SORT_TYPE			= 1
local NAME_PREFIX_PATTERNS		= {"%<", "%["}
local NAME_POSTFIX_PATTERNS		= {"%> ", "%] "}
local NUM_PLAYER_MESSAGES			= 0
local NUM_SYSTEM_MESSAGES			= 0
local MASTER_KEY					= KEYSYMS.BACKSLASH
local FILTER_KEY					= KEYSYMS.F
local WRAP_KEY					= KEYSYMS.P
local TEXT_OUTLINE_KEY			= KEYSYMS.O
local SCROLL_UP_KEY				= KEYSYMS.COMMA
local SCROLL_DOWN_KEY				= KEYSYMS.PERIOD
-- how many game-logic frames to wait
-- before clearing message buffers at
-- normal (1x) speed, 30 frames per sec
local DELAY_BEFORE_CLEAR			= 15 * 30
-- clear boxes on resize since text
-- might otherwise end up outside them
local PLAYER_MSG_HISTORY			= {}
local SYSTEM_MSG_HISTORY			= {}
-- "n": ignore embedded colors, "o/O": black/white outline
local FONT_RENDER_STYLES			= {"", "o", "O"}
local MIN_ALPHA					= 0.0
local MAX_ALPHA					= 0.8
local PLAYER_BOX_ALPHA			= MIN_ALPHA
local SYSTEM_BOX_ALPHA			= MIN_ALPHA
local PLAYER_BOX_FILL_COLOR			= {0.66, 0.66, 0.66, PLAYER_BOX_ALPHA}
local PLAYER_BOX_LINE_COLOR			= {0, 0, 0, PLAYER_BOX_ALPHA}
local SYSTEM_BOX_FILL_COLOR			= {0.66, 0.66, 0.66, SYSTEM_BOX_ALPHA}
local SYSTEM_BOX_LINE_COLOR			= {0.22, 0.22, 0.22, SYSTEM_BOX_ALPHA}
local PLAYER_TEXT_OUTLINE_COLOR		= {0.00, 0.00, 0.00, 0.05}
local PLAYER_TEXT_DEFAULT_COLOR		= {-1.0, -1.0, -1.0, 1.0}
local SYSTEM_TEXT_COLOR				= { 1.0,  1.0,  1.0, 0}
-- use color codes to define font colors, otherwise uses gl_Color, unfortunately, colored font with outline doesn't seems to be supported when this is off
local USECOLORCODES = true
-- timer-related variables
local CURRENT_FRAME				= 0
local LAST_PLAYER_MSG_CLEAR_FRAME	= 0
local LAST_SYSTEM_MSG_CLEAR_FRAME	= 0
-- table mapping names to colors
local PLAYER_COLOR_TABLE			= {}
-- message patterns our filter should match
local MESSAGE_FILTERS				= {"Can't reach destination", "Build pos blocked", "Delayed response", "Sync error", "Error", "User exited"}
-- are we currently dragging or resizing a message box?
local DRAGGING_PLAYER_BOX			= false
local DRAGGING_SYSTEM_BOX			= false
local RESIZING_PLAYER_BOX			= false
local RESIZING_SYSTEM_BOX			= false
-- has time to visually clear messages been reached?
-- (note: only used in scrollable-history mode)
local DRAW_PLAYER_MESSAGES		= true
-- which font render-style are we currently using?
-- (currently only set here in favor of formula)
local FONT_STYLES_INDEX			= 1
-- should key commands be enabled?
local KEYS_ENABLED				= 0
local LAST_LINE					= ""
local FILTER_SYSTEM_MESSAGES = 1
local MESSAGE_WRAPPING = 1
local TEXT_OUTLINING = 1
local FONT_SIZE = 15
local FONT_RENDER_STYLE = FONT_RENDER_STYLES[1]
local BORDER_MASKS = { 0,0,0,0 }

-- Compensate for gl.Text y positioning change between 0.80.0 and 0.80.1
if not gl.TextAdjusted then
   local glText = gl.Text
   gl.Text = function(text,x,y,size,options)
      if size then
         glText(text,x,y+size/4,size,options)
      else
         glText(text,x,y,size,options)
      end
   end
   gl.TextAdjusted = true
end
local SendCommands = Spring.SendCommands
local GetMouseState = Spring.GetMouseState
local GetPlayerRoster = Spring.GetPlayerRoster
local GetTeamColor = Spring.GetTeamColor
local GetGameFrame = Spring.GetGameFrame
local math_ceil 		= math.ceil
local math_floor 		= math.floor
local math_min 			= math.min
local math_max			= math.max
local string_char		= string.char
local gl_Color 			= gl.Color
local gl_Text 			= gl.Text
local gl_GetTextWidth 	= gl.GetTextWidth
local gl_Rect 			= gl.Rect

function widget:Initialize()
	-- disable default console
	SendCommands({"console 0"})

	setDefaultUserVars(-1, -1, false)
	buildTable()
end

function widget:Shutdown()
	-- enable default console
	SendCommands({"console 1"})
end

-- retrieve config data from widget handler
-- (if no config has been saved yet these
-- will be nil but immediately overwritten
-- by setDefaultUserVars())
function widget:SetConfigData(data)
	FILTER_SYSTEM_MESSAGES = data.filterSystemMessages
	MESSAGE_WRAPPING = data.messageWrapping
	TEXT_OUTLINING = data.textOutlining
	FONT_SIZE = data.fontSize
	FONT_RENDER_STYLE = data.fontRenderStyle
	PLAYER_MSG_BOX_W = data.playerMsgBoxWidth
	PLAYER_MSG_BOX_H = data.playerMsgBoxHeight
	SYSTEM_MSG_BOX_W = data.systemMsgBoxWidth
	SYSTEM_MSG_BOX_H = data.systemMsgBoxHeight
	-- restore relative message box positions
	PLAYER_MSG_BOX_X_MIN = data.playerMsgBoxXMin
	SYSTEM_MSG_BOX_X_MIN = data.systemMsgBoxXMin
	PLAYER_MSG_BOX_Y_MAX = data.playerMsgBoxYMax
	SYSTEM_MSG_BOX_Y_MAX = data.systemMsgBoxYMax
	return
end

-- return config data to widget handler
-- (called on startup after Initialize()
-- and on shutdown before Shutdown())
function widget:GetConfigData()
	-- if our viewport dimensions are OK then
	-- we've completed initialisation properly
	if (SIZE_X > 1 and SIZE_Y > 1) then
		return {
			filterSystemMessages = FILTER_SYSTEM_MESSAGES,
			messageWrapping = MESSAGE_WRAPPING,
			textOutlining = TEXT_OUTLINING,
			fontSize = FONT_SIZE,
			fontRenderStyle = FONT_RENDER_STYLE,
			playerMsgBoxWidth = PLAYER_MSG_BOX_W,
			playerMsgBoxHeight = PLAYER_MSG_BOX_H,
			systemMsgBoxWidth = SYSTEM_MSG_BOX_W,
			systemMsgBoxHeight = SYSTEM_MSG_BOX_H,
			playerMsgBoxXMin = PLAYER_MSG_BOX_X_MIN / SIZE_X,
			systemMsgBoxXMin = SYSTEM_MSG_BOX_X_MIN / SIZE_X,
			playerMsgBoxYMax = PLAYER_MSG_BOX_Y_MAX / SIZE_Y,
			systemMsgBoxYMax = SYSTEM_MSG_BOX_Y_MAX / SIZE_Y
		}
	else
		return {}
	end
end


function convertColor(colorarray)
	local red = math_ceil(colorarray[1]*255)
	local green = math_ceil(colorarray[2]*255)
	local blue = math_ceil(colorarray[3]*255)
	red = math_max( red, 1 )
	green = math_max( green, 1 )
	blue = math_max( blue, 1 )
	red = math_min( red, 255 )
	green = math_min( green, 255 )
	blue = math_min( blue, 255 )
	return string_char(255,red,green,blue)
end

function widget:KeyPress(key, modifier, isRepeat)
	if (modifier.ctrl) then
		if (key == MASTER_KEY) then
			if (KEYS_ENABLED == 1) then
				SendCommands({"echo {MessageSeparator} key-shortcuts disabled"})
				KEYS_ENABLED = 0
			else
				SendCommands({"echo {MessageSeparator} key-shortcuts enabled"})
				KEYS_ENABLED = 1
			end
		end

		if (KEYS_ENABLED == 1) then
			if (key == FILTER_KEY) then
				if (FILTER_SYSTEM_MESSAGES == 1) then
					FILTER_SYSTEM_MESSAGES = 0
					SendCommands({"echo {MessageSeparator} message filtering disabled"})
				else
					FILTER_SYSTEM_MESSAGES = 1
					SendCommands({"echo {MessageSeparator} message filtering enabled"})
				end
			end


			if (key == WRAP_KEY) then
				if (MESSAGE_WRAPPING == 1) then
					SendCommands({"echo {MessageSeparator} message wrapping disabled"})
					MESSAGE_WRAPPING = 0
				else
					SendCommands({"echo {MessageSeparator} message wrapping enabled"})
					MESSAGE_WRAPPING = 1
				end
			end

			if (key == TEXT_OUTLINE_KEY) then
				if (TEXT_OUTLINING == 1) then
					SendCommands({"echo {MessageSeparator} text-outlining disabled"})
					TEXT_OUTLINING = 0
				else
					SendCommands({"echo {MessageSeparator} text-outlining enabled"})
					TEXT_OUTLINING = 1
				end
			end


		end

		if (key == SCROLL_UP_KEY) then
			-- if we are in non-transparent rendering mode
			-- then make sure scrolling causes box to appear
			-- (as well as any messages in box)
			PLAYER_BOX_ALPHA = MAX_ALPHA
			DRAW_PLAYER_MESSAGES = true

			if (MESSAGE_FRAME_MIN > 1) then
				MESSAGE_FRAME_MIN = MESSAGE_FRAME_MIN - 1
				MESSAGE_FRAME_MAX = MESSAGE_FRAME_MAX - 1
			end
		end
		if (key == SCROLL_DOWN_KEY) then
			-- if we are in non-transparent rendering mode
			-- then make sure scrolling causes box to appear
			-- (as well as any messages in box)
			PLAYER_BOX_ALPHA = MAX_ALPHA
			DRAW_PLAYER_MESSAGES = true

			if (MESSAGE_FRAME_MAX < NUM_PLAYER_MESSAGES) then
				MESSAGE_FRAME_MIN = MESSAGE_FRAME_MIN + 1
				MESSAGE_FRAME_MAX = MESSAGE_FRAME_MAX + 1
			end
		end
	end
end




function mouseOverPlayerMessageBox(x, y)
	-- use <BOX_BORDER_SIZE>-pixel borders to make resizing less problematic
	if (x > (PLAYER_MSG_BOX_X_MIN + BOX_BORDER_SIZE) and x < (PLAYER_MSG_BOX_X_MAX - BOX_BORDER_SIZE)) then
		if (y < (PLAYER_MSG_BOX_Y_MAX - BOX_BORDER_SIZE) and y > (PLAYER_MSG_BOX_Y_MIN + BOX_BORDER_SIZE)) then
			return true
		end
	end

	return false
end

function mouseOverSystemMessageBox(x, y)
	-- use BOX_BORDER_SIZE-pixel borders to make resizing less problematic
	if (x > (SYSTEM_MSG_BOX_X_MIN + BOX_BORDER_SIZE) and x < (SYSTEM_MSG_BOX_X_MAX + BOX_BORDER_SIZE)) then
		if (y < (SYSTEM_MSG_BOX_Y_MAX - BOX_BORDER_SIZE) and y > (SYSTEM_MSG_BOX_Y_MIN + BOX_BORDER_SIZE)) then
			return true
		end
	end

	return false
end


-- this would be a lot simpler if we had bit-ops...
function mouseOverPlayerMessageBoxBorder(x, y)
	local r = {0, 0, 0, 0}
	local b = false

	-- left vertical boundary
	if (x > PLAYER_MSG_BOX_X_MIN and x < (PLAYER_MSG_BOX_X_MIN + BOX_BORDER_SIZE)) then
		if (y < PLAYER_MSG_BOX_Y_MAX and y > PLAYER_MSG_BOX_Y_MIN) then
			r[1] = 1
			b = true
		end
	end
	-- right vertical boundary
	if (x > (PLAYER_MSG_BOX_X_MAX - BOX_BORDER_SIZE) and x < PLAYER_MSG_BOX_X_MAX) then
		if (y < PLAYER_MSG_BOX_Y_MAX and y > PLAYER_MSG_BOX_Y_MIN) then
			r[2] = 1
			b = true
		end
	end

	-- top horizontal boundary
	if (y < PLAYER_MSG_BOX_Y_MAX and y > (PLAYER_MSG_BOX_Y_MAX - BOX_BORDER_SIZE)) then
		if (x > PLAYER_MSG_BOX_X_MIN and x < PLAYER_MSG_BOX_X_MAX) then
			r[3] = 1
			b = true

		end
	end
	-- bottom horizontal boundary
	if (y > PLAYER_MSG_BOX_Y_MIN and y < (PLAYER_MSG_BOX_Y_MIN + BOX_BORDER_SIZE)) then
		if (x > PLAYER_MSG_BOX_X_MIN and x < PLAYER_MSG_BOX_X_MAX) then
			r[4] = 1
			b = true
		end
	end

	return b, r
end

-- this would be a lot simpler if we had bit-ops...
function mouseOverSystemMessageBoxBorder(x, y)
	local r = {0, 0, 0, 0}
	local b = false

	-- left vertical boundary
	if (x > SYSTEM_MSG_BOX_X_MIN and x < (SYSTEM_MSG_BOX_X_MIN + BOX_BORDER_SIZE)) then
		if (y < SYSTEM_MSG_BOX_Y_MAX and y > SYSTEM_MSG_BOX_Y_MIN) then
			r[1] = 1
			b = true
		end
	end
	-- right vertical boundary
	if (x > (SYSTEM_MSG_BOX_X_MAX - BOX_BORDER_SIZE) and x < SYSTEM_MSG_BOX_X_MAX) then
		if (y < SYSTEM_MSG_BOX_Y_MAX and y > SYSTEM_MSG_BOX_Y_MIN) then
			r[2] = 1
			b = true
		end
	end

	-- top horizontal boundary
	if (y < SYSTEM_MSG_BOX_Y_MAX and y > (SYSTEM_MSG_BOX_Y_MAX - BOX_BORDER_SIZE)) then
		if (x > SYSTEM_MSG_BOX_X_MIN and x < SYSTEM_MSG_BOX_X_MAX) then
			r[3] = 1
			b = true
		end
	end
	-- bottom horizontal boundary
	if (y > SYSTEM_MSG_BOX_Y_MIN and y < (SYSTEM_MSG_BOX_Y_MIN + BOX_BORDER_SIZE)) then
		if (x > SYSTEM_MSG_BOX_X_MIN and x < SYSTEM_MSG_BOX_X_MAX) then
			r[4] = 1
			b = true
		end
	end

	return b, r
end

function widget:TweakMousePress(x, y, button)
	DRAGGING_PLAYER_BOX = false
	DRAGGING_SYSTEM_BOX = false
	RESIZING_PLAYER_BOX = false
	RESIZING_SYSTEM_BOX = false
	if button ~= 1 then
		return false
	end
	local over,masks = mouseOverPlayerMessageBoxBorder( x, y )
	if over then
		RESIZING_PLAYER_BOX = true
		BORDER_MASKS = masks
		return true
	end
	over, masks = mouseOverSystemMessageBoxBorder( x, y )
	if over then
		RESIZING_SYSTEM_BOX = true
		BORDER_MASKS = masks
		return true
	end
	if mouseOverPlayerMessageBox( x,y ) then
		DRAGGING_PLAYER_BOX = true
		return true
	end
	if mouseOverSystemMessageBox( x, y ) then
		DRAGGING_SYSTEM_BOX = true
		return true
	end
	return false
end

function widget:TweakMouseRelease(x, y, button)
	DRAGGING_PLAYER_BOX = false
	DRAGGING_SYSTEM_BOX = false
	RESIZING_PLAYER_BOX = false
	RESIZING_SYSTEM_BOX = false
end

function widget:TweakMouseWheel(up, value)
	local x,y,_,_,_ = GetMouseState()
	if mouseOverPlayerMessageBox( x, y ) or mouseOverSystemMessageBox( x, y ) then
		if up then
			if (FONT_SIZE < FONT_MAX_SIZE) then
				FONT_SIZE = FONT_SIZE + 1
				MAX_NUM_PLAYER_MESSAGES = math_floor((PLAYER_MSG_BOX_H - FONT_SIZE) / FONT_SIZE)
				MAX_NUM_SYSTEM_MESSAGES = math_floor((SYSTEM_MSG_BOX_H - FONT_SIZE) / FONT_SIZE)
			end
		else
			if (FONT_SIZE > 1) then
				FONT_SIZE = FONT_SIZE - 1
				MAX_NUM_PLAYER_MESSAGES = math_floor((PLAYER_MSG_BOX_H - FONT_SIZE) / FONT_SIZE)
				MAX_NUM_SYSTEM_MESSAGES = math_floor((SYSTEM_MSG_BOX_H - FONT_SIZE) / FONT_SIZE)
			end
		end
		return true
	end
	return false
end

function widget:MouseWheel(up, value)
	local x,y,_,_,_ = GetMouseState()
	-- scroll history only if there's some messages on screen already, don't scroll if gui is hidden
	if mouseOverPlayerMessageBox( x, y ) and NUM_PLAYER_MESSAGES > 0 and DRAW_PLAYER_MESSAGES then
		-- if we are in non-transparent rendering mode
		-- then make sure scrolling causes box to appear
		-- (as well as any messages in box)
		PLAYER_BOX_ALPHA = MAX_ALPHA
		DRAW_PLAYER_MESSAGES = true
		if up then
			if (MESSAGE_FRAME_MIN > 1) then
				MESSAGE_FRAME_MIN = MESSAGE_FRAME_MIN - 1
				MESSAGE_FRAME_MAX = MESSAGE_FRAME_MAX - 1
			end
		else
			if (MESSAGE_FRAME_MAX < NUM_PLAYER_MESSAGES) then
				MESSAGE_FRAME_MIN = MESSAGE_FRAME_MIN + 1
				MESSAGE_FRAME_MAX = MESSAGE_FRAME_MAX + 1
			end
		end
		return true
	-- scroll history only if there's some messages on screen already, don't scroll if gui is hidden
	elseif mouseOverSystemMessageBox( x, y ) and NUM_SYSTEM_MESSAGES > 0 then
		return true
	end
	return false
end

function widget:TweakMouseMove(x, y, dx, dy, button)
	-- we must be over player box and not dragging system box and have at least one message visible
	if (DRAGGING_PLAYER_BOX == true) then
		PLAYER_MSG_BOX_X_MIN = PLAYER_MSG_BOX_X_MIN + dx
		PLAYER_MSG_BOX_X_MAX = PLAYER_MSG_BOX_X_MAX + dx
		PLAYER_MSG_BOX_Y_MAX = PLAYER_MSG_BOX_Y_MAX + dy
		PLAYER_MSG_BOX_Y_MIN = PLAYER_MSG_BOX_Y_MAX - PLAYER_MSG_BOX_H

		-- return here in case player message box is positioned over
		-- system message box so we don't start moving that as well
		return
	end

	-- we must be over system box and not dragging player box and have at least one message visible
	if (DRAGGING_SYSTEM_BOX == true) then
		SYSTEM_MSG_BOX_X_MIN = SYSTEM_MSG_BOX_X_MIN + dx
		SYSTEM_MSG_BOX_X_MAX = SYSTEM_MSG_BOX_X_MAX + dx
		SYSTEM_MSG_BOX_Y_MAX = SYSTEM_MSG_BOX_Y_MAX + dy
		SYSTEM_MSG_BOX_Y_MIN = SYSTEM_MSG_BOX_Y_MAX - SYSTEM_MSG_BOX_H

		-- dragging takes precedence over resizing if both are enabled
		return
	end

	-- we must be over player box border
	if ( RESIZING_PLAYER_BOX == true) then
		if (PLAYER_MSG_BOX_W > PLAYER_MSG_BOX_MIN_W) then
			if (BORDER_MASKS[1] == 1) then PLAYER_MSG_BOX_X_MIN = PLAYER_MSG_BOX_X_MIN + dx end
			if (BORDER_MASKS[2] == 1) then PLAYER_MSG_BOX_X_MAX = PLAYER_MSG_BOX_X_MAX + dx end
		else
			-- we may only increase horizontal box size (meaning if we are over left border
			-- and moving mouse left or if we are over right border and moving mouse right)
			if (BORDER_MASKS[1] == 1 and dx < 0) then PLAYER_MSG_BOX_X_MIN = PLAYER_MSG_BOX_X_MIN + dx end
			if (BORDER_MASKS[2] == 1 and dx > 0) then PLAYER_MSG_BOX_X_MAX = PLAYER_MSG_BOX_X_MAX + dx end
		end

		if (PLAYER_MSG_BOX_H > PLAYER_MSG_BOX_MIN_H) then
			if (BORDER_MASKS[3] == 1) then PLAYER_MSG_BOX_Y_MAX = PLAYER_MSG_BOX_Y_MAX + dy end
			if (BORDER_MASKS[4] == 1) then PLAYER_MSG_BOX_Y_MIN = PLAYER_MSG_BOX_Y_MIN + dy end
		else
			-- we may only increase vertical box size (meaning if we are over top border
			-- and moving mouse up or if we are over bottom border and moving mouse down)
			if (BORDER_MASKS[3] == 1 and dy > 0) then PLAYER_MSG_BOX_Y_MAX = PLAYER_MSG_BOX_Y_MAX + dy end
			if (BORDER_MASKS[4] == 1 and dy < 0) then PLAYER_MSG_BOX_Y_MIN = PLAYER_MSG_BOX_Y_MIN + dy end
		end

		PLAYER_MSG_BOX_W = PLAYER_MSG_BOX_X_MAX - PLAYER_MSG_BOX_X_MIN
		PLAYER_MSG_BOX_H = PLAYER_MSG_BOX_Y_MAX - PLAYER_MSG_BOX_Y_MIN
		MAX_NUM_PLAYER_MESSAGES = math_floor((PLAYER_MSG_BOX_H - FONT_SIZE) / FONT_SIZE)

		-- return here in case player message box is stretched out across
		-- system message box so we don't start resizing that as well
		return
	end

	-- we must be over system box border
	if (RESIZING_SYSTEM_BOX == true) then
		if (SYSTEM_MSG_BOX_W > SYSTEM_MSG_BOX_MIN_W) then
			if (BORDER_MASKS[1] == 1) then SYSTEM_MSG_BOX_X_MIN = SYSTEM_MSG_BOX_X_MIN + dx end
			if (BORDER_MASKS[2] == 1) then SYSTEM_MSG_BOX_X_MAX = SYSTEM_MSG_BOX_X_MAX + dx end
		else
			-- we may only increase horizontal box size (meaning if we are over left border
			-- and moving mouse left or if we are over right border and moving mouse right)
			if (BORDER_MASKS[1] == 1 and dx < 0) then SYSTEM_MSG_BOX_X_MIN = SYSTEM_MSG_BOX_X_MIN + dx end
			if (BORDER_MASKS[2] == 1 and dx > 0) then SYSTEM_MSG_BOX_X_MAX = SYSTEM_MSG_BOX_X_MAX + dx end
		end

		if (SYSTEM_MSG_BOX_H > SYSTEM_MSG_BOX_MIN_H) then
			if (BORDER_MASKS[3] == 1) then SYSTEM_MSG_BOX_Y_MAX = SYSTEM_MSG_BOX_Y_MAX + dy end
			if (BORDER_MASKS[4] == 1) then SYSTEM_MSG_BOX_Y_MIN = SYSTEM_MSG_BOX_Y_MIN + dy end
		else
			-- we may only increase vertical box size (meaning if we are over top border
			-- and moving mouse up or if we are over bottom border and moving mouse down)
			if (BORDER_MASKS[3] == 1 and dy > 0) then SYSTEM_MSG_BOX_Y_MAX = SYSTEM_MSG_BOX_Y_MAX + dy end
			if (BORDER_MASKS[4] == 1 and dy < 0) then SYSTEM_MSG_BOX_Y_MIN = SYSTEM_MSG_BOX_Y_MIN + dy end
		end

		SYSTEM_MSG_BOX_W = SYSTEM_MSG_BOX_X_MAX - SYSTEM_MSG_BOX_X_MIN
		SYSTEM_MSG_BOX_H = SYSTEM_MSG_BOX_Y_MAX - SYSTEM_MSG_BOX_Y_MIN
		MAX_NUM_SYSTEM_MESSAGES = math_floor((SYSTEM_MSG_BOX_H - FONT_SIZE) / FONT_SIZE)

		return
	end

end




-- set default values for user-configurable vars
-- if they haven't yet been initialized (called
-- (from Initialize() and ViewResize() call-ins)
function setDefaultUserVars(sizeX, sizeY, useParams)

	if (useParams == true) then
		SIZE_X = sizeX
		SIZE_Y = sizeY
	else
		-- get dimensions of our OGL viewport
		SIZE_X, SIZE_Y = widgetHandler:GetViewSizes()
	end

	if (SIZE_X > 1 and SIZE_Y > 1) then
		-- default positions and dimensions of message boxes are relative to viewport size
		if ((PLAYER_MSG_BOX_W == nil or PLAYER_MSG_BOX_H == nil) or (SYSTEM_MSG_BOX_W == nil or SYSTEM_MSG_BOX_H == nil)) then
			PLAYER_MSG_BOX_X_MIN = (SIZE_X / 4)
			PLAYER_MSG_BOX_X_MAX = (SIZE_X / 4) * 3
			SYSTEM_MSG_BOX_X_MIN = PLAYER_MSG_BOX_X_MIN
			SYSTEM_MSG_BOX_X_MAX = PLAYER_MSG_BOX_X_MAX

			PLAYER_MSG_BOX_W = PLAYER_MSG_BOX_X_MAX - PLAYER_MSG_BOX_X_MIN
			SYSTEM_MSG_BOX_W = SYSTEM_MSG_BOX_X_MAX - SYSTEM_MSG_BOX_X_MIN
			PLAYER_MSG_BOX_H = (SIZE_Y / 8) + (SIZE_Y / 16)
			SYSTEM_MSG_BOX_H = (PLAYER_MSG_BOX_H / 2)

			PLAYER_MSG_BOX_Y_MAX = SIZE_Y - 40
			PLAYER_MSG_BOX_Y_MIN = PLAYER_MSG_BOX_Y_MAX - PLAYER_MSG_BOX_H
			SYSTEM_MSG_BOX_Y_MAX = PLAYER_MSG_BOX_Y_MIN - 50
			SYSTEM_MSG_BOX_Y_MIN = SYSTEM_MSG_BOX_Y_MAX - SYSTEM_MSG_BOX_H
		else
			-- turn serialized relative coordinates into absolute ones again
			-- (if coordinates are already absolute then we should reposition
			-- and/or resize boxes, but for now just do nothing)
			if ((PLAYER_MSG_BOX_X_MIN < 1 and PLAYER_MSG_BOX_Y_MAX < 1) and (SYSTEM_MSG_BOX_X_MIN < 1 and SYSTEM_MSG_BOX_Y_MAX < 1)) then
				PLAYER_MSG_BOX_X_MIN = PLAYER_MSG_BOX_X_MIN * SIZE_X
				SYSTEM_MSG_BOX_X_MIN = SYSTEM_MSG_BOX_X_MIN * SIZE_X
				PLAYER_MSG_BOX_Y_MAX = PLAYER_MSG_BOX_Y_MAX * SIZE_Y
				SYSTEM_MSG_BOX_Y_MAX = SYSTEM_MSG_BOX_Y_MAX * SIZE_Y
				-- restore message box dimensions
				PLAYER_MSG_BOX_X_MAX = PLAYER_MSG_BOX_X_MIN + PLAYER_MSG_BOX_W
				SYSTEM_MSG_BOX_X_MAX = SYSTEM_MSG_BOX_X_MIN + SYSTEM_MSG_BOX_W
				PLAYER_MSG_BOX_Y_MIN = PLAYER_MSG_BOX_Y_MAX - PLAYER_MSG_BOX_H
				SYSTEM_MSG_BOX_Y_MIN = SYSTEM_MSG_BOX_Y_MAX - SYSTEM_MSG_BOX_H
			end
		end

		MAX_NUM_PLAYER_MESSAGES = math_floor((PLAYER_MSG_BOX_H - FONT_SIZE) / FONT_SIZE)
		MAX_NUM_SYSTEM_MESSAGES = math_floor((SYSTEM_MSG_BOX_H - FONT_SIZE) / FONT_SIZE)

		MESSAGE_FRAME_MIN = 1
		MESSAGE_FRAME_MAX = MAX_NUM_PLAYER_MESSAGES
	end
end


function clearPlayerMessageHistory()
	PLAYER_MSG_HISTORY = {}
	NUM_PLAYER_MESSAGES = 0
end
function clearSystemMessageHistory()
	SYSTEM_MSG_HISTORY = {}
	NUM_SYSTEM_MESSAGES = 0
end


-- if our viewport is resized then we need to
-- reposition (and resize?) our message boxes
-- accordingly since they might end up outside
-- viewport (note: also called on startup with
-- nil parameters!)
function widget:ViewResize(newSizeX, newSizeY)
	if (newSizeX ~= nil and newSizeY ~= nil) then
		if (newSizeX > 1 and newSizeY > 1) then
			setDefaultUserVars(newSizeX, newSizeY, true)
		end
	end
end


-- add message to player or system buffer
function widget:AddConsoleLine(line)
	if (string.len(line) > 0) then
		local playerName = getPlayerName(line)
		local playerColor = getPlayerColor(playerName)
		local playerFontStyle = getPlayerFontStyle(playerColor)

		if ( line == LAST_LINE ) then
			return -- drop duplicate messages
		end
		LAST_LINE = line

		if (string.len(playerName) > 0) then
			-- autoscroll if bottom of message
			-- frame is equal to last message
			if (MESSAGE_FRAME_MAX == NUM_PLAYER_MESSAGES) then
				MESSAGE_FRAME_MIN = MESSAGE_FRAME_MIN + 1
				MESSAGE_FRAME_MAX = MESSAGE_FRAME_MAX + 1
			end

			DRAW_PLAYER_MESSAGES = true

			LAST_PLAYER_MSG_CLEAR_FRAME = CURRENT_FRAME
			PLAYER_MSG_HISTORY[NUM_PLAYER_MESSAGES + 1] = {playerColor, playerFontStyle, line}
			NUM_PLAYER_MESSAGES = NUM_PLAYER_MESSAGES + 1
			PLAYER_BOX_ALPHA = MAX_ALPHA

		else
			if (FILTER_SYSTEM_MESSAGES == 1) then
				for index = 1, table.getn(MESSAGE_FILTERS), 1 do
					if (string.find(line, MESSAGE_FILTERS[index]) ~= nil) then
						return
					end
				end
			end

			-- is system message box about to overflow vertically?
			if ( NUM_SYSTEM_MESSAGES ~= nil ) then
				if ( MAX_NUM_SYSTEM_MESSAGES ~= nil ) then
					if (NUM_SYSTEM_MESSAGES >= MAX_NUM_SYSTEM_MESSAGES) then
						clearSystemMessageHistory()
					end
				end
			end

			LAST_SYSTEM_MSG_CLEAR_FRAME = CURRENT_FRAME
			SYSTEM_MSG_HISTORY[NUM_SYSTEM_MESSAGES + 1] = line
			NUM_SYSTEM_MESSAGES = NUM_SYSTEM_MESSAGES + 1
			SYSTEM_BOX_ALPHA = MAX_ALPHA
		end
	end
end




function widget:DrawScreen()

	CURRENT_FRAME = GetGameFrame()

	-- is it time to clear our player message buffer?
	if ((CURRENT_FRAME - LAST_PLAYER_MSG_CLEAR_FRAME) > DELAY_BEFORE_CLEAR) then
		DRAW_PLAYER_MESSAGES = false

		LAST_PLAYER_MSG_CLEAR_FRAME = CURRENT_FRAME
		PLAYER_BOX_ALPHA = MIN_ALPHA
	end

	-- is it time to clear our system message buffer?
	if ((CURRENT_FRAME - LAST_SYSTEM_MSG_CLEAR_FRAME) > DELAY_BEFORE_CLEAR) then
		LAST_SYSTEM_MSG_CLEAR_FRAME = CURRENT_FRAME
		SYSTEM_BOX_ALPHA = MIN_ALPHA

		clearSystemMessageHistory()
	end

	-- only draw boxes in tweak mode
	if (widgetHandler:InTweakMode()) then
		PLAYER_BOX_FILL_COLOR[4] = PLAYER_BOX_ALPHA
		PLAYER_BOX_LINE_COLOR[4] = PLAYER_BOX_ALPHA
		SYSTEM_BOX_FILL_COLOR[4] = SYSTEM_BOX_ALPHA
		SYSTEM_BOX_LINE_COLOR[4] = SYSTEM_BOX_ALPHA

		drawBox(PLAYER_MSG_BOX_X_MIN, PLAYER_MSG_BOX_Y_MAX, PLAYER_MSG_BOX_W, PLAYER_MSG_BOX_H, PLAYER_BOX_FILL_COLOR, PLAYER_BOX_LINE_COLOR)
		drawBox(SYSTEM_MSG_BOX_X_MIN, SYSTEM_MSG_BOX_Y_MAX, SYSTEM_MSG_BOX_W, SYSTEM_MSG_BOX_H, SYSTEM_BOX_FILL_COLOR, SYSTEM_BOX_LINE_COLOR)
		-- Spring.Echo("-------------Message Box Width---------------- ")	
		-- Spring.Echo ("Player box width:", PLAYER_MSG_BOX_W)
		-- Spring.Echo ("System box width:", SYSTEM_MSG_BOX_W)
		-- Spring.Echo ("Error: LuaRules", SYSTEM_MSG_BOX_W)
	end


	local y = PLAYER_MSG_BOX_Y_MAX - (FONT_SIZE + 6)

	-- because PLAYER_MSG_HISTORY is never reset to {}
	-- while scrollable history enabled we need another
	-- way to determine if we should draw messages
	if (DRAW_PLAYER_MESSAGES == true) then
		for index = MESSAGE_FRAME_MIN, MESSAGE_FRAME_MAX, 1 do
			if (index <= NUM_PLAYER_MESSAGES) then
				if PLAYER_MSG_HISTORY[index] ~= nil then
					local playerColor = PLAYER_MSG_HISTORY[index][1]
					local playerFontStyle = PLAYER_MSG_HISTORY[index][2]
					local playerMessage = PLAYER_MSG_HISTORY[index][3]
					local playerMessageWidth = (gl_GetTextWidth(playerMessage) * FONT_SIZE )

					if (MESSAGE_WRAPPING == 1) then
						local bufferIndex, buffer = getMessageParts(playerMessage, playerMessageWidth, PLAYER_MSG_BOX_W)

						if (bufferIndex > 1) then
							-- our buffer was filled with at least two message parts
							copyPlayerMessageBuffer(buffer, bufferIndex, index, playerColor, playerFontStyle)

							-- we've expanded our player message
							-- history, abort drawing this frame
							break
						end
					else
						-- fix horizontal overflow the easy way
						playerMessage, _ = splitMessage(playerMessage, playerMessageWidth, PLAYER_MSG_BOX_W)
					end

					if (TEXT_OUTLINING == 1 and not widgetHandler:InTweakMode()) then
						-- draw bars behind player messages (only if player message box not rendered)
						drawBox(PLAYER_MSG_BOX_X_MIN, (y + FONT_SIZE), PLAYER_MSG_BOX_W, FONT_SIZE, PLAYER_TEXT_OUTLINE_COLOR, PLAYER_TEXT_OUTLINE_COLOR)
					end

					local text = playerMessage
					local style = playerFontStyle
					if ( USECOLORCODES ) then
						local colorcode = convertColor(playerColor)
						text = colorcode..playerMessage
					else
						style = playerFontStyle.."n"
					end
					gl_Color(playerColor)
					gl_Text(text, PLAYER_MSG_BOX_X_MIN, y, FONT_SIZE, style)
				end
			end

			y = y - FONT_SIZE
		end
	end



	y = SYSTEM_MSG_BOX_Y_MAX - (FONT_SIZE + 6)

	-- draw system message strings
	for index = 1, table.getn(SYSTEM_MSG_HISTORY), 1 do
		local systemMessage = SYSTEM_MSG_HISTORY[index]
		local systemMessageWidth
		if systemMessage ~= nil then
			systemMessageWidth = (gl_GetTextWidth(systemMessage) * FONT_SIZE )
		else
			systemMessageWidth = 0
		end

		if (MESSAGE_WRAPPING == 1) then
			local bufferIndex, buffer = getMessageParts(systemMessage, systemMessageWidth, SYSTEM_MSG_BOX_W)

			if (bufferIndex > 1) then
				-- our buffer was filled with at least two message parts
				copySystemMessageBuffer(buffer, bufferIndex, index)

				-- we've expanded our system message
				-- history so abort drawing this frame
				break
			end
		else
			-- fix horizontal overflow the easy way
			systemMessage, _ = splitMessage(systemMessage, systemMessageWidth, SYSTEM_MSG_BOX_W)
		end

		-- make sure messages do not get printed below
		-- bottom edge of box in case user increased
		-- fontsize and box already reasonably full
		if (index <= MAX_NUM_SYSTEM_MESSAGES) then
			if ( systemMessageWidth > 0 ) then
				local text = systemMessage
				local style = FONT_RENDER_STYLES[1]
				if ( USECOLORCODES ) then
					local colorcode = convertColor(SYSTEM_TEXT_COLOR)
					text = colorcode..systemMessage
				else
					style = FONT_RENDER_STYLES[1].."n"
				end
				gl_Color(SYSTEM_TEXT_COLOR)
				gl_Text(text, SYSTEM_MSG_BOX_X_MIN, y, FONT_SIZE, style)
			end
		end

		y = y - FONT_SIZE
	end
end




function copyPlayerMessageBuffer(buffer, bufferIndex, index, color, fontStyle)
	-- autoscroll <number of message parts> lines if
	-- bottom of message frame is equal to last message
	if (MESSAGE_FRAME_MAX == NUM_PLAYER_MESSAGES) then
		MESSAGE_FRAME_MIN = MESSAGE_FRAME_MIN + bufferIndex
		MESSAGE_FRAME_MAX = MESSAGE_FRAME_MAX + bufferIndex
	end

	NUM_PLAYER_MESSAGES = (NUM_PLAYER_MESSAGES - 1) + bufferIndex

	for i = 1, table.getn(buffer), 1 do
		-- copy over message parts from temporary buffer
		-- (overwrites original overflowing message)
		PLAYER_MSG_HISTORY[index + i - 1] = {color, fontStyle, buffer[i]}
	end
end

function copySystemMessageBuffer(buffer, bufferIndex, index)
	-- are there more system message parts than we have room left to display?
	if (((NUM_SYSTEM_MESSAGES - 1) + bufferIndex) > MAX_NUM_SYSTEM_MESSAGES) then
		NUM_SYSTEM_MESSAGES = bufferIndex
		SYSTEM_MSG_HISTORY = {}
		index = 1
	else
		NUM_SYSTEM_MESSAGES = (NUM_SYSTEM_MESSAGES - 1) + bufferIndex
	end

	for i = 1, table.getn(buffer), 1 do
		-- copy over message parts from temporary buffer
		SYSTEM_MSG_HISTORY[index + i - 1] = buffer[i]
	end
end


function splitMessage(message, messageWidth, boxWidth)
	if (messageWidth >= boxWidth) then
		local messageLen = string.len(message)
		local overflowFactor = messageWidth / boxWidth
		local cutoffIndex = math_floor(messageLen / overflowFactor)

		local messagePartL = string.sub(message, 1, cutoffIndex - 1)
		local messagePartR = string.sub(message, cutoffIndex)

		return messagePartL, messagePartR
	else
		return message, ""
	end
end


-- break message into parts if it's too wide for
-- player or system box and store them in buffer
function getMessageParts(message, messageWidth, boxWidth)
	local buffer = {}
	local bufferIndex = 1
	local messagePartL = ""
	local messagePartR = ""

	while (messageWidth >= boxWidth) do
		-- continue splitting while parts are too long
		messagePartL, messagePartR = splitMessage(message, messageWidth, boxWidth)

		buffer[bufferIndex] = messagePartL
		bufferIndex = bufferIndex + 1

		message = messagePartR
		messageWidth = (gl_GetTextWidth(message) * FONT_SIZE)
	end

	-- copy last remaining message part
	buffer[bufferIndex] = messagePartR

	return bufferIndex, buffer
end




function buildTable()
	local playerRoster = GetPlayerRoster(ROSTER_SORT_TYPE)

	for index, playerInfo in ipairs(playerRoster) do
		local playerName = playerInfo[1]
		local playerTeam = playerInfo[3]
		local r, g, b, a = GetTeamColor(playerTeam)

		PLAYER_COLOR_TABLE[playerName] = {r, g, b, a}
	end
end


-- extract a player name from a text message
-- (note: this can generate false positives if
-- player has name of form "<XYZ>" or "[XYZ]"
-- for certain system messages since strings
-- returned will then be "XYZ>" and "XYZ]"
-- rather than "")
function getPlayerName(playerMessage)
	local i1 = string.find(playerMessage, NAME_PREFIX_PATTERNS[1])
	local i2 = string.find(playerMessage, NAME_POSTFIX_PATTERNS[1])

	if (i1 ~= nil and i2 ~= nil and i1 == 1) then
		-- player messages start with "<" so start index is 2
		return (string.sub(playerMessage, 2, i2 - 1))
	end

	local j1 = string.find(playerMessage, NAME_PREFIX_PATTERNS[2])
	local j2 = string.find(playerMessage, NAME_POSTFIX_PATTERNS[2])

	if (j1 ~= nil and j2 ~= nil and j1 == 1) then
		-- spectator messages start with "[" so start index is 2
		return (string.sub(playerMessage, 2, j2 - 1))
	end

	-- no match found
	return ""
end


-- get a player's team-color
function getPlayerColor(playerName)
	-- this should have O(log n) or O(1) time complexity
	local playerColor = PLAYER_COLOR_TABLE[playerName]

	if (playerColor ~= nil) then
		return playerColor
	else
		-- if playerName was not valid key then getPlayerName()
		-- either found no match at all or false positive one,
		-- or table missing entry for actual player (due to
		-- pathing delays etc.)
		if (string.len(playerName) > 0) then
			-- rebuild table in case this was message from real player (ie.
			-- getPlayerName() found true positive) we didn't know about yet
			buildTable()
		end

		local playerColor = PLAYER_COLOR_TABLE[playerName]
		if (playerColor ~= nil) then
			return playerColor
		else
			return PLAYER_TEXT_DEFAULT_COLOR
		end
	end
end


-- get a player's font outline-mode string
-- (only used if font outlining is enabled)
function getPlayerFontStyle(playerColor)

	local luminance  = (playerColor[1] * 0.299) + (playerColor[2] * 0.587) + (playerColor[3] * 0.114)

	if (luminance > 0.25) then
		-- black outline
		playerFontStyle = FONT_RENDER_STYLES[2]
	else
		-- white outline
		playerFontStyle = FONT_RENDER_STYLES[3]
	end

	return playerFontStyle
end


function drawBox(left, top, width, height, fillColor, lineColor)
	if (width < 2 or height < 2) then
		return false
	end

	gl_Color(lineColor)
	gl_Rect(left - 1, top + 1, left + width + 1, top - height - 1)

	gl_Color(fillColor)
	gl_Rect(left, top, left + width, top - height)
end
