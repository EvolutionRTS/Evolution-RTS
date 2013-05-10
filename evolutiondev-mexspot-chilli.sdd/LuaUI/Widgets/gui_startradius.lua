--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    gui_startradius.lua
--  brief:   displays a full-screen CAD style cursor
--  author:  Dave Rodgers
--
--  Copyright (C) 2007.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "StartRadius",
    desc      = "Shows Commander Start Radius",
    author    = "thor",
    date      = "July 3, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

include("colors.h.lua")


local vsx, vsy = widgetHandler:GetViewSizes()

function widget:ViewResize(viewSizeX, viewSizeY)
  vsx = viewSizeX
  vsy = viewSizeY
end


-------------------------------------------------------------------------------

local GL_LINES           = GL.LINES
local glBeginEnd         = gl.BeginEnd
local glColor            = gl.Color
local glVertex           = gl.Vertex
local spGetActiveCommand = Spring.GetActiveCommand
local spGetMouseState    = Spring.GetMouseState
local DrawGroundCircle = gl.DrawGroundCircle

local PushMatrix = gl.PushMatrix
local PopMatrix = gl.PopMatrix
local Translate = gl.Translate
local Scale = gl.Scale

local spTraceScreenRay          = Spring.TraceScreenRay
local spGetMyTeamID        = Spring.GetMyTeamID

local TraceScreenRay          = spTraceScreenRay

local MyTeamID = Spring.GetMyTeamID
-------------------------------------------------------------------------------

centerGap = 20

local r,g,b = .2,.8,.2
local x,y,z
local sx,sy,sz
local sxin,syin,szin
local count = 0
local skip_frame = true

-------------------------------------------------------------------------------


local function DrawPoints()

      glColor(r,g,b,1)


  if (sx == sxin and sy == syin and sz == szin) then

      DrawGroundCircle(x, y, z, 1000, 128)  
	count = count + 1

  else

   DrawGroundCircle(sx, sy, sz, 1000, 128)  

  end

end


function widget:DrawWorld()

  if (skip_frame) then 
	skip_frame = false
	return
  end 


    sx, sy, sz = Spring.GetTeamStartPosition(spGetMyTeamID())

  if (count == 0) then

  sxin, syin, szin = sx, sy, sz

  end

   gl.DepthTest(GL.LEQUAL)
   gl.PolygonOffset(-10,-10)
   DrawPoints()
   gl.DepthTest(false)
   gl.PolygonOffset(false)
end


function widget:Update()


  if (Spring.GetGameFrame() > 1) then
    widgetHandler:RemoveWidget()
    return
  end

  mx, my = spGetMouseState()
              _,pos = TraceScreenRay(mx,my,true)

if(pos ~= nil) then
	x = pos[1]
	y = pos[2]
	z = pos[3]
end

end

function widget:Initialize()

local commodes= {
	comstart=true,
}

	if commodes[Spring.GetModOptions().startoptions] then
   		 widgetHandler:RemoveWidget()
	end

end



-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
