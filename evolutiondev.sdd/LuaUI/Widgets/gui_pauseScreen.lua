include("keysym.h.lua")
local versionNumber = "1.0"

function widget:GetInfo()
	return {
		name      = "Pause Screen",
		desc      = "[v" .. string.format("%s", versionNumber ) .. "] Displays pause screen when game is paused.",
		author    = "very_bad_soldier",
		date      = "2009.08.16",
		license   = "GNU GPL v2",
		layer     = 0,
		enabled   = true
	}
end


local spGetGameSeconds      = Spring.GetGameSeconds
local spGetMouseState       = Spring.GetMouseState
local spEcho                = Spring.Echo

local spGetGameSpeed 		= Spring.GetGameSpeed

local max					= math.max

local glColor               = gl.Color
local glTexture             = gl.Texture
local glPopMatrix           = gl.PopMatrix
local glPushMatrix          = gl.PushMatrix
local glTranslate           = gl.Translate
local glText                = gl.Text
local glBeginEnd			= gl.BeginEnd
local glTexRect 			= gl.TexRect
local glLoadFont			= gl.LoadFont
local glDeleteFont			= gl.DeleteFont
local glRect				= gl.Rect
local glLineWidth           = gl.LineWidth
local glDepthTest           = gl.DepthTest

local osClock				= os.clock
----------------------------------------------------------------------------------
-- CONFIGURATION
local debug = false	
local boxWidth = 300
local boxHeight = 60
local slideTime = 0.4
local fadeTime = 1
local wndBorderSize = 4
local imgWidth = 160 --acording to the used png
local fontSizeHeadline = 36
local fontSizeAddon = 24
local windowIconPath = "LuaUI/Images/evologo.png"
local fontPath = "LuaUI/Fonts/MicrogrammaDBold.ttf"
--Color config in drawPause function
	
----------------
local screenx, screeny
local myFont
local clickTimestamp = 0
local pauseTimestamp = 0 --start or end of pause
local lastPause = false
local screenCenterX = nil
local screenCenterY = nil
local wndX1 = nil
local wndY1 = nil
local wndX2 = nil
local wndY2 = nil
local textX = nil
local textY = nil
local lineOffset = nil
local yCenter = nil
local xCut = nil



function widget:Initialize()
	myFont = glLoadFont( fontPath, fontSizeHeadline )
	updateWindowCoords()
end

function widget:Shutdown()
	glDeleteFont( myFont )
end

function widget:DrawScreen()
	local now = osClock()
	local _, _, paused = spGetGameSpeed()
	local diffPauseTime = ( now - pauseTimestamp)
	
	if ( ( not paused and lastPause ) or ( paused and not lastPause ) ) then
		--pause switch
		pauseTimestamp = osClock()
		if ( diffPauseTime <= slideTime ) then
			pauseTimestamp = pauseTimestamp - ( slideTime - ( diffPauseTime / slideTime ) * slideTime )
		end
	end
	
	if ( paused and not lastPause ) then
		--new pause
		clickTimestamp = nil
	end

	lastPause = paused
		
	if ( paused or ( ( now - pauseTimestamp) <= slideTime ) ) then
		drawPause()
	end
	
	ResetGl()
end

function widget:MousePress(x, y, button)
  if ( not clickTimestamp ) then
	if ( ( x > screenCenterX - boxWidth) and ( y < screenCenterY + boxHeight ) and 
		( x < screenCenterX + boxWidth ) and ( y > screenCenterY - boxHeight ) ) then	
		printDebug("CLICK")
		clickTimestamp = osClock()
		return true
	end
  end

  return false
end

function drawPause()
	local _, _, paused = spGetGameSpeed()
	local now = osClock()
	local diffPauseTime = ( now - pauseTimestamp)

	local text =  { 1.0, 1.0, 1.0, 1.0 }
	local text2 =  { 0.9, 0.9, 0.9, 1.0 }
	local outline =  { 0.4, 0.4, 0.4, 1.0 }	
	local colorWnd = { 0.0, 0.0, 0.0, 0.6 }
	local colorWnd2 = { 0.5, 0.5, 0.5, 0.6 }
	local iconColor = { 1.0, 1.0, 1.0, 1.0 }

	--adjust transparency when clicked
	if ( clickTimestamp ~= nil ) then
		local factor = ( 1.0 - ( now - clickTimestamp ) / fadeTime )
		factor = max( factor, 0.3 )
		colorWnd[4] = colorWnd[4] * factor
		text[4] = text[4] * factor
		text2[4] = text2[4] * factor
		outline[4] = outline[4] * factor
		iconColor[4] = iconColor[4] * factor	
		printDebug("fac: " .. factor)
	end
	local imgWidthHalf = imgWidth * 0.5
	
	--draw window
	glPushMatrix()
	local group1XOffset = 0
	if ( diffPauseTime <= slideTime ) then
		--we are sliding
		if ( paused ) then
			--sliding in
			group1XOffset = ( screenx - wndX1 ) * ( 1.0 - ( diffPauseTime / slideTime ) )
		else
			--sliding out
			group1XOffset = ( screenx - wndX1 ) * ( ( diffPauseTime / slideTime ) )
		end
		glTranslate( group1XOffset, 0, 0)
	end
	
	glColor( colorWnd )
	glRect( wndX1, wndY1, wndX2, wndY2 )
	glColor( colorWnd )
	glRect( wndX1 - wndBorderSize, wndY1 + wndBorderSize, wndX2 + wndBorderSize, wndY2 - wndBorderSize)
	glPopMatrix()
	
	--draw text
	myFont:Begin()
	myFont:SetOutlineColor( outline )

	myFont:SetTextColor( text )
	myFont:Print( "GAME PAUSED", textX + group1XOffset, textY, fontSizeHeadline, "O" )
		
	myFont:SetTextColor( text2 )
	myFont:Print( "Press 'Pause' to continue.", textX + group1XOffset, textY - lineOffset, fontSizeAddon, "O" )
	
	myFont:End()
	
	--draw icon
	glColor(  iconColor )
	glTexture( ":n:" .. windowIconPath )
	glPushMatrix()
	
	if ( diffPauseTime <= slideTime ) then
		--we are sliding
		if ( paused ) then
			--sliding in
			glTranslate( 0, ( ( yCenter + imgWidthHalf ) * ( 1.0 - ( diffPauseTime / slideTime ) ) ), 0)
		else
			--sliding out
			glTranslate( 0, ( yCenter + imgWidthHalf ) * ( diffPauseTime / slideTime ), 0)
		end
	end
	
	glTexRect( xCut - imgWidthHalf, yCenter + imgWidthHalf, xCut + imgWidthHalf, yCenter - imgWidthHalf, 0.0, 0.0, 1.0, 1.0 )
	glPopMatrix()
	
	glTexture(false)
end

function updateWindowCoords()
	screenx, screeny = widgetHandler:GetViewSizes()
	
	screenCenterX = screenx / 2
	screenCenterY = screeny / 2
	wndX1 = screenCenterX - boxWidth
	wndY1 = screenCenterY + boxHeight
	wndX2 = screenCenterX + boxWidth
	wndY2 = screenCenterY - boxHeight

	textX = wndX1 + ( wndX2 - wndX1 ) * 0.35
	textY = wndY2 + ( wndY1 - wndY2 ) * 0.5
	lineOffset = ( wndY1 - wndY2 ) * 0.3
	
	yCenter = wndY2 + ( wndY1 - wndY2 ) * 0.5
	xCut = wndX1 + ( wndX2 - wndX1 ) * 0.2
end

function widget:ViewResize(viewSizeX, viewSizeY)
  updateWindowCoords()
 end

--Commons
function ResetGl() 
	glColor( { 1.0, 1.0, 1.0, 1.0 } )
	glLineWidth( 1.0 )
	glDepthTest(false)
	glTexture(false)
end


function printDebug( value )
	if ( debug ) then
		if ( type( value ) == "boolean" ) then
			if ( value == true ) then spEcho( "true" )
				else spEcho("false") end
		elseif ( type(value ) == "table" ) then
			spEcho("Dumping table:")
			for key,val in pairs(value) do 
				spEcho(key,val) 
			end
		else
			spEcho( value )
		end
	end
end
	