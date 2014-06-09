include("keysym.h.lua")
local versionNumber = "1.4"

function widget:GetInfo()
	return {
		name      = "Factory Exit Indicator",
		desc      = "[v" .. string.format("%s", versionNumber ) .. "] Shows which direction a factory is facing",
		author    = "very_bad_soldier, cannibalized badly by Forboding Angel",
		date      = "2009.08.10",
		license   = "GNU GPL v2",
		layer     = 0,
		enabled   = true
	}
end

--1.1 Tweaks by Pako, big thx!

-- CONFIGURATION
local debug = false
local updateInt = 1 --seconds for the ::update loop
local sens = 150	--rotate mouse sensitivity - length of mouse movement vector
local drawForAll = false --draw facing direction also for other buildings than labs
--------------------------------------------------------------------------------
local inDrag = false
local metaStart = false
local mouseDeltaX = 0
local mouseDeltaY = 0
local mouseXStartRotate = 0
local mouseYStartRotate = 0
local mouseXStartDrag = 0
local mouseYStartDrag = 0
local mouseLbLast = false
-------------------------------------------------------------------------------
local udefTab				= UnitDefs

local spGetActiveCommand 	= Spring.GetActiveCommand
local spGetKeyState         = Spring.GetKeyState
local spGetModKeyState      = Spring.GetModKeyState
local spGetSelectedUnits    = Spring.GetSelectedUnits
local spGetUnitDefID        = Spring.GetUnitDefID
local spGetUnitPosition     = Spring.GetUnitPosition
local spGetGameSeconds      = Spring.GetGameSeconds
local spGetActiveCommand 	= Spring.GetActiveCommand
local spGetActiveCmdDesc 	= Spring.GetActiveCmdDesc
local spGetMouseState       = Spring.GetMouseState
local spTraceScreenRay      = Spring.TraceScreenRay
local spGetMyPlayerID       = Spring.GetMyPlayerID
local spGetPlayerInfo       = Spring.GetPlayerInfo
local spGetCameraVectors    = Spring.GetCameraVectors
local spEcho                = Spring.Echo
local spWarpMouse			= Spring.WarpMouse
local spGetBuildFacing		= Spring.GetBuildFacing
local spSetBuildFacing 		= Spring.SetBuildFacing
local spPos2BuildPos 		= Spring.Pos2BuildPos
local spGetGroundHeight 	= Spring.GetGroundHeight

local floor                 = math.floor
local abs					= math.abs
local atan2                 = math.atan2
local pi                    = math.pi
local sqrt                  = math.sqrt

local glColor               = gl.Color
local glLineWidth           = gl.LineWidth
local glDepthTest           = gl.DepthTest
local glTexture             = gl.Texture
local glDrawGroundCircle    = gl.DrawGroundCircle
local glPopMatrix           = gl.PopMatrix
local glPushMatrix          = gl.PushMatrix
local glTranslate           = gl.Translate
local glText                = gl.Text
local glVertex              = gl.Vertex
local glRotate				= gl.Rotate
local glBeginEnd			= gl.BeginEnd
local glScale				= gl.Scale

local GL_TRIANGLES			= GL.TRIANGLES
----------------------------------------------------------------------------------
function widget:Update()
	local timef = spGetGameSeconds()
	local time = floor(timef)
	
	-- update timers once every <updateInt> seconds
	if (time % updateInt == 0 and time ~= lastTimeUpdate) then	
		lastTimeUpdate = time
		--do update stuff:
		
		if ( CheckSpecState() == false ) then
			return false
		end
	end
end

function widget:DrawWorld()
	drawOrientation()
	
	ResetGl()
end

function getVector2dLen( vector )
	return sqrt( ( vector[1] * vector[1] ) + ( vector[2] * vector[2] ) )
end

function getRotationVectors2d( vectorA, vectorB )
	vectorA = normalizeVector2d( vectorA )
	vectorB = normalizeVector2d( vectorB )
	local radian = atan2( vectorA[2], vectorA[1] ) - atan2( vectorB[2], vectorB[1] )
	local val = ( 360.0 * radian) / ( 2 * pi ) 
	return normalizeDegreeRange(val)
end

--i currently get all degress in a range from 0 to 270 and 0 to -90
--this is a hack to correct this
--also corrects values >360
function normalizeDegreeRange( degree )
	if ( degree < 0.0 ) then
		degree = 360.0 + degree
	elseif ( degree > 360.0 ) then
		degree = degree - 360.0
	end
	return degree
end

function normalizeVector2d( vector )
	local len = getVector2dLen( vector )
	local normVec = {0.0,0.0};
	normVec[1] = vector[1] / len
	normVec[2] = vector[2] / len
	return normVec
end

function drawOrientation()
	local idx, cmd_id, cmd_type, cmd_name = spGetActiveCommand()
	local cmdDesc = spGetActiveCmdDesc( idx )
	
	if ( cmdDesc == nil or cmdDesc["type"] ~= 20 ) then
		--quit here if not a build command
		return
	end
	
	local unitDefID = -cmd_id
	local alt,ctrl,meta,shift = spGetModKeyState()
	
	local udef = udefTab[unitDefID]
	if (drawForAll == false and udef["isFactory"] == false ) then
		return
	end
	
	local mx, my = spGetMouseState()
	
	if ( shift and inDrag ) then
		mx = mouseXStartDrag
		my = mouseYStartDrag
		printDebug("UDEFID: " .. mx )
	end

	local _, coords = spTraceScreenRay(mx, my, true, true)
	
	if not coords then return end
		
	local centerX = coords[1]
	local centerY = coords[2]
	local centerZ = coords[3]
	
	centerX, centerY, centerZ = spPos2BuildPos( unitDefID, centerX, centerY, centerZ )
	
	glLineWidth(1)
	glColor( 0.0, 1.0, 0.0, 0.5 )
	
	local function drawFunc()
		glVertex( 0, 0, -8)
		glVertex( 0, 0, 8)
		glVertex( 50, 0, -3)

		glVertex( 0, 0,  8)
		glVertex( 50, 0, 3)
		glVertex( 50, 0, -3 )
		
		glVertex( 50, 0, 0)
		glVertex( 30, 0, -30 )
		glVertex( 80, 0, 0 )

		glVertex( 50, 0, 0)
		glVertex( 80, 0, 0 )
		glVertex( 30, 0, 30 )
	end
  
	--local height = spGetGroundHeight( centerX, centerZ )
	local transSpace = udef["zsize"] * 4   --should be ysize but its not there?!?

	local transX, transZ
	local facing = spGetBuildFacing()
	if ( facing == 0 ) then
		transX = 0
		transZ = transSpace
	elseif ( facing == 1 ) then
		transX = transSpace
		transZ = 0
	elseif ( facing == 2 ) then
		transX = 0
		transZ = -transSpace
	elseif ( facing == 3 ) then
		transX = -transSpace
		transZ = 0
	end

	glPushMatrix()
	
	glTranslate( centerX + transX, centerY, centerZ + transZ)
	glRotate( ( 3 + facing ) * 90, 0, 1, 0 )
	glScale( (transSpace or 70)/70, 1.0, (transSpace or 70)/70)
	glBeginEnd( GL_TRIANGLES, drawFunc )
	
	glScale( 1.0, 1.0, 1.0 )
	
	glPopMatrix()

	glColor( 1.0, 1.0, 1.0 )
end

--Commons
function ResetGl() 
	glColor( { 1.0, 1.0, 1.0, 1.0 } )
	glLineWidth( 1.0 )
	glDepthTest(false)
	glTexture(false)
end

function CheckSpecState()
	local playerID = spGetMyPlayerID()
	local _, _, spec, _, _, _, _, _ = spGetPlayerInfo(playerID)
		
	if ( spec == true ) then
		spEcho("<Easy Facing> Spectator mode. Widget removed.")
		widgetHandler:RemoveWidget()
		return false
	end
	
	return true	
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
	