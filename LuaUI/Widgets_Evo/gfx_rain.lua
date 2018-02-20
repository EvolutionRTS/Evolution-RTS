--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    precipitation.lua
--  brief:   precipitation shader gadget
--  author:  Dave Rodgers
--
--  Copyright (C) 2007.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "GFX Rain",
    desc      = "Precipitation shader widget",
    author    = "trepan, Argh, The_Yak",
    date      = "August 27, 2009, Aug 2, 2013",
    license   = "GNU GPL, v2 or later",
    layer     = -24,
    enabled   = true  --  loaded by default?
  }
end

local timeCyclesWeatherEffects = Spring.GetConfigInt("evo_timecyclesweathereffects", 0)
if timeCyclesWeatherEffects ~= 1 then
	return false
end

-------------------------------------------------------------------------------
--------------------------------------------------------------------------------
b = 1
local particleType = 1 -- 1 for rain, 2 for snow, 3 for clouds (when they finally work)
local particleDensity = 0  -- how many particles?  Limit for performance!
f = 0
nbPlayers = 0
X = Game.mapSizeX
Z = Game.mapSizeZ
r = 1
aparticleDensity = 1
function GameStart()
r = 1
roster = Spring.GetPlayerRoster(2)
nbPlayers = 0
for i,isSpec in pairs(roster) do
if isSpec[5] == false then
nbPlayers = nbPlayers + 1
end
end
end

function widget:UnitDamaged(_,_,_,da)

if da >= 1500 then 
da = 1500
end
b = b + da
--Spring.Echo(particleDensity)
end

--Rain Color Control
local function ColorFunc()
	local rainColorR = 0.2*((15000-particleDensity)/15000)
	local rainColorG = math.random(2,5)/10*((15000-particleDensity)/15000)
	local rainColorB = 0.5*((15000-particleDensity)/15000)
	local rainAlpha = (1*(particleDensity/15000))^(1/4)
	-- Spring.Echo(rainColorR)
	-- Spring.Echo(rainColorG)
	-- Spring.Echo(rainColorB)
	-- Spring.Echo(rainAlpha)
	return rainColorR,rainColorG,rainColorB,rainAlpha
end

--particleOne
local particleOneGravity = 50 -- how fast does it fall?
local particleOneDriftX = -20 -- how fast does it move on the X axis?  Can be positive or negative.
local particleOneDriftZ = -20 -- how fast does it move on the Z axis?  Can be positive or negative.
local particleOneTexture = 'LuaUI/Widgets/snowflake1.tga'  -- what bitmap are we using?
local particleOneScale = 4000  -- scale, see GLSL for details

local particleTwoGravity = 40 -- how fast does it fall?
local particleTwoDriftX = -40 -- how fast does it move on the X axis?  Can be positive or negative.
local particleTwoDriftZ = 20 -- how fast does it move on the Z axis?  Can be positive or negative.
local particleTwoTexture = 'LuaUI/Widgets/snowflake2.tga'   -- what bitmap are we using?
local particleTwoScale = 3000  -- scale, see GLSL for details

local particleThreeGravity = 60 -- how fast does it fall?
local particleThreeDriftX = -60 -- how fast does it move on the X axis?  Can be positive or negative.
local particleThreeDriftZ = 20 -- how fast does it move on the Z axis?  Can be positive or negative.
local particleThreeTexture = 'LuaUI/Widgets/snowflake3.tga'  -- what bitmap are we using?
local particleThreeScale = 2500  -- scale, see GLSL for details

local math_random = math.random
local math_randomseed = math.randomseed

local shader
local rainshader
local shaderTimeLoc
local shaderCamPosLoc
local shaderScaleLoc
local shaderSpeedLoc

local startTimer = Spring.GetTimer()
local diffTime = 0

local rainparticleOneList
local rainparticleTwoList
local rainparticleThreeList

local firstPos = 0
local secondPos = 0
local thirdPos = 0
local camX,camY,camZ

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--OpenGL stuff.
	local glBeginEnd           = gl.BeginEnd
	local glVertex = gl.Vertex
	local glColor              = gl.Color
	local glBlending           = gl.Blending
	local glTranslate          = gl.Translate
	local glCallList = gl.CallList
	local glDepthTest          = gl.DepthTest
	local glCreateList         = gl.CreateList
	local glDeleteList         = gl.DeleteList
	local glTexture            = gl.Texture
	local glGetShaderLog       = gl.GetShaderLog
	local glCreateShader       = gl.CreateShader
	local glDeleteShader       = gl.DeleteShader
	local glUseShader          = gl.UseShader
	local glUniformMatrix      = gl.UniformMatrix
	local glUniformInt         = gl.UniformInt
	local glUniform            = gl.Uniform
	local glGetUniformLocation = gl.GetUniformLocation
	local glGetActiveUniforms  = gl.GetActiveUniforms
	local glBeginEnd = gl.BeginEnd
	local glPointSprite = gl.PointSprite
	local glPointSize = gl.PointSize
	local glPointParameter = gl.PointParameter
	local glResetState = gl.ResetState
	local GL_POINTS = GL.POINTS

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function widget:Shutdown()
	--glDeleteList(particleOneSubList)
	glDeleteList(particleOneList)
end

local function CreateParticleOneList()
  particleOneList = gl.CreateList(function()
    local tmpRand = math.random()
    math.randomseed(1)
    gl.BeginEnd(GL.POINTS, function()
      for i = 1, aparticleDensity do
        local x = math.random()
        local y = math.random()
        local z = math.random()
        local w = math.random()
        gl.Vertex(x, y, z, w)
      end
    end)
    math.random(1e9 * tmpRand)
  end)
end

local function CreateParticleTwoList()
  particleTwoList = gl.CreateList(function()
    local tmpRand = math.random()
    math.randomseed(2)
    gl.BeginEnd(GL.POINTS, function()
      for i = 1, aparticleDensity do
        local x = math.random()
        local y = math.random()
        local z = math.random()
        local w = math.random()
        gl.Vertex(x, y, z, w)
      end
    end)
    math.random(1e9 * tmpRand)
  end)
end

local function CreateParticleThreeList()
  particleThreeList = gl.CreateList(function()
    local tmpRand = math.random()
    math.randomseed(3)
    gl.BeginEnd(GL.POINTS, function()
      for i = 1, aparticleDensity do
        local x = math.random()
        local y = math.random()
        local z = math.random()
        local w = math.random()
        gl.Vertex(x, y, z, w)
      end
    end)
    math.random(1e9 * tmpRand)
  end)
end

local function CreateCloudList()
	cloudOneList = gl.CreateList(function()

    gl.BeginEnd(GL.POINTS, function()
glVertex(-30,0,40)
glVertex(-40,30,-20)
glVertex(-40,-20,0)
glVertex(-30,-40,30)
glVertex(-30,10,-20)
glVertex(-20,0,-20)
glVertex(-10,-20,-30)
glVertex(-20,50,50)
glVertex(-20,40,0)
glVertex(-20,-30,40)
glVertex(-30,-50,10)
glVertex(30,10,30)
glVertex(30,-30,10)
glVertex(20,-10,40)
glVertex(20,-50,30)
glVertex(30,50,-10)
glVertex(20,20,-20)
glVertex(20,-20,10)
glVertex(0,70,-50)
glVertex(0,-40,30)
glVertex(0,-10,10)
glVertex(0,-20,-20)
glVertex(0,-60,50)
glVertex(0,-40,0)
glVertex(0,-30,80)
glVertex(0,20,0)
glVertex(0,40,60)
glVertex(0,-20,30)
    end)
  end)
end


local function CreateRainDrops()
  rainparticleOneList = glCreateList(function()
    local tmpRand = math_random()
    math_randomseed(6)
    glBeginEnd(GL.LINES, function()
      for i = 1, particleDensity do
        local x = math_random(-3000,3000)
        local y = math_random(-5000,10000)
        local z = math_random(-3000,3000)
	glColor(ColorFunc())
	glVertex(x,y,z)
	glVertex(x,y- math_random(20,40),z)
      end
    end)
    math_random(1e9 * tmpRand)
  end)

  rainparticleTwoList = glCreateList(function()
    local tmpRand = math_random()
    math_randomseed(6)
    glBeginEnd(GL.LINES, function()
      for i = 1, particleDensity do
        local x = math_random(-3000,3000)
        local y = math_random(-5000,20000)
        local z = math_random(-3000,3000)
	glColor(ColorFunc())
	glVertex(x,y,z)
	glVertex(x,y- math_random(20,40),z)
      end
    end)
    math_random(1e9 * tmpRand)
  end)

  rainparticleThreeList = glCreateList(function()
    local tmpRand = math_random()
    math_randomseed(6)
    glBeginEnd(GL.LINES, function()
      for i = 1, particleDensity do
        local x = math_random(-3000,3000)
        local y = math_random(-5000,30000)
        local z = math_random(-3000,3000)
	glColor(ColorFunc())
	glVertex(x,y,z)
	glVertex(x,y- math_random(20,40),z)
      end
    end)
    math_random(1e9 * tmpRand)
  end)

  if (rainparticleOneList == nil) then
    return false
  end
  return true
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:Update(dt) 
t = t + dt

r = r + 2000*dt
	f = f +1
	-- Spring.Echo(f)
if r >= b then
r = b
end
K = (X*Z/3500)*nbPlayers
-- Spring.Echo(rfx)
p = 1-(math.exp(-r/K))
particleDensity = 15000*(1-gl.GetAtmosphere("fogStart"))
-- Spring.Echo(aparticleDensity)
aparticleDensity = 15000*(p)
if particleDensity >= 15000 then 
particleDensity = 15000 
end

if aparticleDensity >= 15000 then 
aparticleDensity = 15000 
end
	b = b * 0.9995^(dt*30)
	-- Spring.Echo(dt*30)
	
if f%150 == 0 then
	if (Spring.GetMapOptions().alt == "0") then 
		widgetHandler:RemoveWidget()
		return
	end
	if (glCreateShader == nil) then
		Spring.Echo("[Weather Particles:Initialize] no shader support")
		widgetHandler:RemoveWidget()
		return
	end
CreateRainDrops()
	-- CreateParticleOneList()
	-- CreateParticleTwoList()
	-- CreateParticleThreeList()

	-- Spring.Echo("Finished Snow / Rain Shader")
	end
end

function widget:Initialize() 
t = 0
f = 0
rfx = 0
roster = Spring.GetPlayerRoster(2)
nbPlayers = 0
for i,isSpec in pairs(roster) do
if isSpec[5] == false then
nbPlayers = nbPlayers + 1
end
end

	if (Spring.GetMapOptions().alt == "0") then 
		widgetHandler:RemoveWidget()
		return
	end
	if (glCreateShader == nil) then
		Spring.Echo("[Weather Particles:Initialize] no shader support")
		widgetHandler:RemoveWidget()
		return
	end

	shader = glCreateShader({

    vertex = [[
		uniform float time;
		uniform float scale;
		uniform vec3 speed;
		uniform vec3 camPos;
		void main(void)
		{
		vec3 scalePos = vec3(gl_Vertex) * scale;

		gl_FrontColor = vec4(0.8,0.8,0.9,0.0 + 0.8 * cos(scalePos.y));

		vec3 pos = scalePos - mod(camPos, scale);
		pos.y -= time * 0.5 * (speed.x * (2.0 + gl_Vertex.w));
		pos.x += (sin(time)*10.0) + (time * speed.y);
		pos.z += (cos(time)*10.0) + (time * speed.z);
		pos = mod(pos, scale) - (scale * 0.5) + camPos;
		if (pos.y < 0.0) {
		  	gl_FrontColor *= 1.0 + 2.0 * (pos.y / scale);
		  	pos.y = 0.0;
		}
		vec4 eyePos = gl_ModelViewMatrix * vec4(pos, 1.0);
				
		gl_PointSize = (1.0 + gl_Vertex.w) * 5000.0 / length(eyePos);

		gl_Position = gl_ProjectionMatrix * eyePos;
		}
	]],
	uniform = {
		time   = diffTime,
		scale  = 0,
		speed  = {0,0,0},
		camPos = {0,0,0},
    		},
  	})

rainshader = glCreateShader({
    vertex = [[
		void main(void)
		{
			gl_FrontColor = gl_Color;
			gl_Position = ftransform();
		}
	]],
  	})

cloudshader = glCreateShader({
    vertex = [[
		uniform vec3 camPos;
		void main(void)
		{
		
		//float myLength = distance(gl_Vertex.xyz, camPos.xyz);
		//gl_PointSize = 100.0 / myLength / 1000;
		gl_Position = ftransform();

		}
	]],
	uniform = {
		camPos = {0,0,0},
    		},
  	})

	if (shader == nil) then
		Spring.Echo("[Weather Particles:Initialize] particle shader compilation failed")
		Spring.Echo(glGetShaderLog())
		widgetHandler:RemoveWidget()
		return
	end

	if (rainshader == nil) then
		Spring.Echo("[Weather Particles:Initialize] rain shader compilation failed")
		Spring.Echo(glGetShaderLog())
		widgetHandler:RemoveWidget()
		return
	end

	if (cloudshader == nil) then
		Spring.Echo("[Weather Particles:Initialize] cloud shader compilation failed")
		Spring.Echo(glGetShaderLog())
		widgetHandler:RemoveWidget()
		return
	end
	
	shaderTimeLoc   = glGetUniformLocation(shader, 'time')
	shaderCamPosLoc = glGetUniformLocation(shader, 'camPos')

	shaderScaleLoc   = glGetUniformLocation(shader, 'scale')
	shaderSpeedLoc = glGetUniformLocation(shader, 'speed')

	cloudShaderCamPosLoc = glGetUniformLocation(cloudshader, 'camPos')

	CreateParticleOneList()
	CreateParticleTwoList()
	CreateParticleThreeList()
	CreateCloudList()
	CreateRainDrops()

	Spring.Echo("Finished Snow / Rain Shader")

end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function widget:DrawWorld()


	if particleType == 1 then
		camX,camY,camZ = Spring.GetCameraPosition()
		glDepthTest(GL.LEQUAL)
		glBlending(GL.SRC_ALPHA, GL.ONE)
		gl.DepthMask(false)
		glUseShader(rainshader)

		firstPos = firstPos - particleOneGravity
		if firstPos <= camY-10000 then
			firstPos = camY + 100
		end
	
		gl.Translate(camX,firstPos,camZ)
		glCallList(rainparticleOneList)
		
		secondPos = secondPos - particleTwoGravity
		if secondPos <= camY-20000 then
			secondPos = camY + 300
		end
		gl.Translate(camX,secondPos,camZ)
		glCallList(rainparticleTwoList)


		thirdPos = thirdPos - particleThreeGravity
		if thirdPos <= camY-30000 then
			thirdPos = camY + 500
		end
		gl.Translate(camX,thirdPos,camZ)
		glCallList(rainparticleThreeList)
		
				glUseShader(shader)	
		camX,camY,camZ = Spring.GetCameraPosition()
		diffTime = Spring.DiffTimers(Spring.GetTimer(), startTimer)
		--Spring.Echo(diffTime,camX,camY,camZ)
		glUniform(shaderTimeLoc,diffTime * 1)
		glUniform(shaderCamPosLoc, camX, camY, camZ)

		glDepthTest(true)
		glBlending(GL.SRC_ALPHA, GL.ONE)
		
		gl.PointSprite(true, true)
		gl.PointSize(10.0)
		gl.PointParameter(0, 0, 0.001, 0, 1e9, 1)
		
		glTexture(particleOneTexture)
		glUniform(shaderScaleLoc,  particleOneScale)
		glUniform(shaderSpeedLoc, particleOneGravity,particleOneDriftX, particleOneDriftZ)
		glCallList(particleOneList)	
		
	
		glTexture(particleTwoTexture)
		glUniform(shaderScaleLoc, particleTwoScale)
		glUniform(shaderSpeedLoc, particleTwoGravity, particleTwoDriftX, particleTwoDriftZ)
		glCallList(particleTwoList)

		glTexture(particleThreeTexture)
		glUniform(shaderScaleLoc, particleThreeScale)
		glUniform(shaderSpeedLoc, particleThreeGravity, particleThreeDriftX, particleThreeDriftZ)
		glCallList(particleThreeList)
	end



	if particleType == 3 then
		glColor(1.0,1.0,1.0,1.0)
		glUseShader(cloudshader)
		camX,camY,camZ = Spring.GetCameraPosition()
		glUniform(cloudShaderCamPosLoc, camX, camY, camZ)
		diffTime = Spring.DiffTimers(Spring.GetTimer(), startTimer)

		--glUniform(shaderTimeLoc,diffTime * 1)
		glDepthTest(true)
		--glTexture(cloudTextureThree)
		glBlending(GL.SRC_ALPHA, GL.ONE)
		
		gl.PointSprite(true, true)
		gl.PointSize(1)
		gl.PointParameter(0, 0, 0, 0, 1, 1)
		gl.Translate(500,1500,500)
		glCallList(cloudOneList)
	end

	gl.PointParameter(1, 0, 0, 0, 1e9, 1)
	gl.PointSize(1.0)
	gl.PointSprite(false, false)
	glResetState()
	glUseShader(0)
end
              
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
