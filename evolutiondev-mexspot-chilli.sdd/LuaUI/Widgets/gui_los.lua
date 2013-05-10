function widget:GetInfo()
  return {
    name      = "Fog of War",
    desc      = "Draw fog of war",
    author    = "Knorke",
    date      = "Mar 2011, 2011",
    license   = "Public Domain",
    layer     = -3,
    enabled   = false
  }
end

local DspLst=nil
local res = 152			--75  50 to 200, multiple of 8 work better eg 64
local TileMaxX = Game.mapSizeX/res +1
local TileMaxZ = Game.mapSizeZ/res +1
local unexplored = 0
local visible = 1
local explored = 2
local FOG = {}
local localAllyID = Spring.GetLocalAllyTeamID ()
local updateRate = 15	--15 to 30,lower=faster updating
local fogAlpha = 1	--0.7
---magical speedups---
local Spring_GetGroundHeight = Spring.GetGroundHeight
local Spring_IsPosInLos = Spring.IsPosInLos
local gl_Vertex = gl.Vertex
local gl_Color = gl.Color
local gl_CreateList = gl.CreateList
local gl_BeginEnd = gl.BeginEnd
local gl_DepthMask = gl.DepthMask
----------------------

local function updateFOG()	
	for x=1,TileMaxX do
		mx=x*res		
		for z=1,TileMaxZ do
			mz=z*res			
			local los = Spring_IsPosInLos (mx,  Spring_GetGroundHeight(x,z), mz, localAllyID)
			if (los==true) then FOG[x][z] = 1 end
			if (los==false) then
				if (FOG[x][z]==visible) then FOG[x][z] = explored end
				--FOG[x][z] = 2
			end
		end
	end	
end

function widget:GameFrame (f)
	if (f%updateRate==0) then 
		updateFOG()
		ForceRefresh()
	end
end

function widget:Initialize (f)
	checkToDisable ()
	for x=1,TileMaxX do		
		FOG[x] = {}
		for z=1,TileMaxZ do
			FOG[x][z] = unexplored --0
		end
	end		
	updateFOG()
end

local function TilesVerticesOutside(h)
	for x=1,TileMaxX,1 do
		for z=1,TileMaxZ,1 do
			if (x >= 1 and z >= 1 and x < TileMaxX and z < TileMaxZ) then 
			--if (false) then
			if (FOG[x][z]~=nil) then
				if (FOG[x][z] == unexplored) then gl_Color(0,0,0,fogAlpha/2) end				
				if (FOG[x][z] == explored) then gl_Color(0,0,0,fogAlpha/2) end
				if (FOG[x][z] ~= visible) then
					gl_Vertex(res*(x-1),h+Spring.GetGroundHeight(res*(x-1),res*z),res*z)					
					gl_Vertex(res*x,h+Spring_GetGroundHeight(res*x,res*z),res*z)					
					gl_Vertex(res*x,h+Spring_GetGroundHeight(res*x,res*(z-1)),res*(z-1))					
					gl_Vertex(res*(x-1),h+Spring_GetGroundHeight(res*(x-1),res*(z-1)),res*(z-1))
				end
			end
			else
				local a = math.random (0,10)/64 --math.abs (math.sin (x*z))
				gl_Color(a,a,a,fogAlpha)				--a,a,a for black&white
				gl_Vertex(res*(x-1),Spring.GetGroundHeight(res*(x-1),res*z),res*z)					
				gl_Vertex(res*x,Spring_GetGroundHeight(res*x,res*z),res*z)					
				gl_Vertex(res*x,Spring_GetGroundHeight(res*x,res*(z-1)),res*(z-1))					
				gl_Vertex(res*(x-1),Spring_GetGroundHeight(res*(x-1),res*(z-1)),res*(z-1))
			end
		end
	end
end

local function TilesVertices(h)
	for x=1,TileMaxX do
		for z=1,TileMaxZ do
			if (FOG[x][z]~=nil) then
				if (FOG[x][z] == unexplored) then gl_Color(0,0,0,fogAlpha) end
				--if (FOG[x][z] == visible) then gl_Color(0,0,0,0) end
				if (FOG[x][z] == explored) then gl_Color(0,0,0,fogAlpha/2) end
				if (FOG[x][z] ~= visible) then
				--if (x > TileMaxX or z > TileMaxZ) then 
				local a = math.random (0,10)/10
				gl_Color(a,a,a,fogAlpha) 
				--end	
					gl_Vertex(res*(x-1),h+Spring.GetGroundHeight(res*(x-1),res*z),res*z)					
					gl_Vertex(res*x,h+Spring_GetGroundHeight(res*x,res*z),res*z)					
					gl_Vertex(res*x,h+Spring_GetGroundHeight(res*x,res*(z-1)),res*(z-1))					
					gl_Vertex(res*(x-1),h+Spring_GetGroundHeight(res*(x-1),res*(z-1)),res*(z-1))
				end
			end
		end
	end
end

local function DrawTiles()
	gl.PushAttrib(GL.ALL_ATTRIB_BITS)
	gl.DepthTest(true)
	gl_DepthMask(true)
	--gl.Texture(":a:foggy.png")
	--r = math.random(0,100)/100
	gl_Color(1,1,1,1)
	--gl_BeginEnd(GL.QUADS,TilesVertices,8)
	gl_BeginEnd(GL.QUADS,TilesVerticesOutside,50)
	--gl_BeginEnd(GL.TRIANGLES,TilesVertices,8)
	gl.Texture(false)
	gl_DepthMask(false)
	gl.DepthTest(false)
	gl_Color(1,1,1,1)
	gl.PopAttrib()
end

--function widget:DrawWorldPreUnit()
function widget:DrawWorld()
--function widget:DrawInMiniMap()
	if not DspLst then
		DspLst=gl_CreateList(DrawTiles)
	end
	gl.CallList(DspLst)-- Or maybe you want to keep it cached but not draw it everytime.
	-- Maybe you want Spring.SetDrawGround(false) somewhere
end


function ForceRefresh()
	if DspLst then
		gl.DeleteList(DspLst)
		DspLst=nil
	end
end


function checkToDisable ()
	if (Spring.IsReplay() or Spring.GetSpectatingState ()) then
		widgetHandler:RemoveWidget()
	end
end

function widget:PlayerChanged  (playerID)
	checkToDisable ()
end