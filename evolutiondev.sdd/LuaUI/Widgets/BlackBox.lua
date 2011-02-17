--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Black Box",
    desc      = "Creates black box around map borders.",
    author    = "Argh",
    date      = "August 6, 2008",
    license   = "(C) Wolfe Games, 2008",
    layer     = -255,
    enabled   = true
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--VARIABLE DECLARATIONS
local texture = "LuaUI/Graphics/BoxTex.tga"
local texture2 = "LuaUI/Graphics/BoxTex2.tga"
local BotY, TopY = Spring.GetGroundExtremes()
local mapy					= Game.mapY
local mapx					= Game.mapX
local mx					= Game.mapSizeX
local mz					= Game.mapSizeZ
local GL_LEQUAL = GL.LEQUAL
local GL_QUADS = GL.QUADS
local GL_TEXTURE_GEN_MODE = GL.TEXTURE_GEN_MODE
local GL_EYE_PLANE  = GL.EYE_PLANE
local GL_EYE_LINEAR = GL.EYE_LINEAR
local GL_T   = GL.T
local GL_S   = GL.S
local GL_ONE = GL.ONE
local GL_SRC_ALPHA           = GL.SRC_ALPHA
local GL_ONE_MINUS_SRC_ALPHA = GL.ONE_MINUS_SRC_ALPHA
local glVertex        	= gl.Vertex
local glBeginEnd      	= gl.BeginEnd
local glTexRect       	= gl.TexRect
local glTranslate     	= gl.Translate
local glColor         	= gl.Color
local glDrawFuncAtUnit	= gl.DrawFuncAtUnit
local glFog           	= gl.Fog
local glDepthTest     	= gl.DepthTest
local glTranslate     	= gl.Translate
local glTexture       	= gl.Texture
local glText          	= gl.Text
local glPushMatrix    	= gl.PushMatrix
local glPopMatrix     	= gl.PopMatrix
local glBillboard     	= gl.Billboard
local glDepthMask     	= gl.DepthMask
local glBlending      	= gl.Blending
local glTexCoord      	= gl.TexCoord
local glUnit          	= gl.Unit
local glTexGen        	= gl.TexGen
local glPolygonOffset 	= gl.PolygonOffset
local glGetViewSizes 	= gl.GetViewSizes
local glCreateList 	= gl.CreateList
local glCallList        = gl.CallList
local glResetMatrices = gl.ResetMatrices
local glResetState = gl.ResetState
local glScissor = gl.Scissor

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
----Box display list

if BotY > 0 then BotY = 0 end

local BlackBox = function()
   glBeginEnd(GL_QUADS,function()
	glTexCoord(0.04,0.04)
	glVertex(0,100,0)
	glTexCoord(0.96,0.04)
	glVertex(0 + mapx*512,100,0)
	glTexCoord(0.96,0.96)
	glVertex(0 + mapx*512,BotY-1,0)
	glTexCoord(0.04,0.96)
	glVertex(0,BotY-1,0)
	--
	glTexCoord(0.04,0.04)
	glVertex(0,100,0 + mapy*512)
	glTexCoord(0.96,0.04)
	glVertex(0 + mapx*512,100,0 + mapy*512)
	glTexCoord(0.96,0.96)
	glVertex(0 + mapx*512,BotY-1,0 + mapy*512)
	glTexCoord(0.04,0.96)
	glVertex(0,BotY-1,0 + mapy*512)
	--
	glTexCoord(0.04,0.04)
	glVertex(0,100,0 + mapy*512)
	glTexCoord(0.96,0.04)
	glVertex(0,100,0)
	glTexCoord(0.96,0.96)
	glVertex(0,BotY-1,0)
	glTexCoord(0.04,0.96)
	glVertex(0,BotY-1,0 + mapy*512)
	--
	glTexCoord(0.04,0.04)
	glVertex(0 + mapx*512,100,0 + mapy*512)
	glTexCoord(0.96,0.04)
	glVertex(0 + mapx*512,100,0)
	glTexCoord(0.96,0.96)
	glVertex(0 + mapx*512,BotY-1,0)
	glTexCoord(0.04,0.96)
	glVertex(0 + mapx*512,BotY-1,0 + mapy*512)
   end)
end

local Edges = function()
   glBeginEnd(GL_QUADS,function()
	glTexCoord(0.04,0.04)
	glVertex(0 - 128,5,0 - 128)
	glTexCoord(0.96,0.04)
	glVertex(0 + 128 + mapx*512,5,0 - 128)
	glTexCoord(0.96,0.96)
	glVertex(0 + mapx*512,100,0)
	glTexCoord(0.04,0.96)
	glVertex(0,100,0)
	--
	glTexCoord(0.04,0.04)
	glVertex(0 - 128,5,0 +mapy*512 + 128)
	glTexCoord(0.96,0.04)
	glVertex(0 + 128 + mapx*512,5,0 + mapy*512 + 128)
	glTexCoord(0.96,0.96)
	glVertex(0 + mapx*512,100,0 +mapy*512)
	glTexCoord(0.04,0.96)
	glVertex(0,100,0 + mapy*512)
	--
	glTexCoord(0.04,0.04)
	glVertex(0 - 128,5,0 +mapy*512 + 128)
	glTexCoord(0.96,0.04)
	glVertex(0 - 128,5,0 - 128)
	glTexCoord(0.96,0.96)
	glVertex(0,100,0)
	glTexCoord(0.04,0.96)
	glVertex(0,100,0 +mapy*512)
	--
	glTexCoord(0.04,0.04)
	glVertex(0 + 128 +mapx*512,5,0 +mapy*512 + 128)
	glTexCoord(0.96,0.04)
	glVertex(0 + 128 + mapx*512,5,0 - 128)
	glTexCoord(0.96,0.96)
	glVertex(mapx*512,100,0)
	glTexCoord(0.04,0.96)
	glVertex(mapx*512,100,0 +mapy*512)
   end)
end

local Outer = function()
   glBeginEnd(GL_QUADS,function()
	glTexCoord(0.04,0.04)
	glVertex(0 - mapx*2048,5,0 - mapy*2048)
	glTexCoord(0.96,0.04)
	glVertex(0 + mapx*512 + mapx*2048,5,0 - mapy*2048)
	glTexCoord(0.96,0.96)
	glVertex(128 + mapx*512,5,0 - 128)
	glTexCoord(0.04,0.96)
	glVertex(0 - 128,5,0 - 128)
	--
	glTexCoord(0.04,0.04)
	glVertex(0 - mapx*2048,5,0 +mapy*512 + mapy*2048)
	glTexCoord(0.96,0.04)
	glVertex(0 - mapx*2048,5,0 - mapy*2048)
	glTexCoord(0.96,0.96)
	glVertex(0 - 128,5,0 - 128)
	glTexCoord(0.04,0.96)
	glVertex(0 - 128,5,0 + mapy*512 + 128)
	--
	glTexCoord(0.04,0.04)
	glVertex(0 + mapx*2048 + mapx*512,5,0 + mapy*512 + mapy*2048)
	glTexCoord(0.96,0.04)
	glVertex(0 - mapx*2048,5,0 + mapy*512 + mapy*2048)
	glTexCoord(0.96,0.96)
	glVertex(0 - 128,5,mapy*512 + 128)
	glTexCoord(0.04,0.96)
	glVertex(mapx*512 + 128,5,mapy*512 + 128)
	--
	glTexCoord(0.04,0.04)
	glVertex(0 + mapx*512 + mapx*2048,5,0 - mapy*2048)
	glTexCoord(0.96,0.04)
	glVertex(0 + mapx*512 + mapx*2048,5,0 + mapy*512 + mapy*2048)
	glTexCoord(0.96,0.96)
	glVertex(0 + mapx*512 + 128,5,0 + mapy*512 + 128)
	glTexCoord(0.04,0.96)
	glVertex(0 + mapx*512 + 128,5,0 - 128)
   end)
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
----fog rendering pass

local Box = function()

	glResetMatrices()
	glColor(1,1,1,1)
	glBlending(false)
	glDepthTest(GL.LESS)
	glDepthMask(false)
	
	glTexture(texture2)
	glPushMatrix()
 	glCallList(box)
	glPopMatrix()

	glTexture(texture)
	glPushMatrix()
	glCallList(edges)
	glPopMatrix()

	glColor(0,0,0)
	glTexture(false)
	glPushMatrix()
 	glCallList(outer)
	glPopMatrix()

	glResetMatrices()
	glResetState()

end 


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
----main draw function, calls all the effect creators.


function widget:DrawWorld()
	Box()
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
----setup the lists

function widget:Initialize()
  	box = glCreateList(BlackBox)
  	edges = glCreateList(Edges)
  	outer = glCreateList(Outer)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------