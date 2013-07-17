
if addon.InGetInfo then
	return {
		name    = "GLSL.heroku",
		desc    = "",
		author  = "jK",
		date    = "2013",
		license = "GPL2",
		layer   = 1,
		--depend  = {"LoadProgress"},
		enabled = true,
	}
end

------------------------------------------

local shader
local fbo
local fboTex
local resDiv = 4
local timUniform
local resUniform

function addon.DrawLoadScreen()
	--local loadProgress = SG.GetLoadProgress()
	local vsx, vsy = gl.GetViewSizes()

	if (not fbo) then
		fboTex = gl.CreateTexture(math.floor(vsx/resDiv), math.floor(vsy/resDiv), {border=false})

		fbo = gl.CreateFBO({color0 = fboTex})

		shader = gl.CreateShader({
			vertex = [[
				void main()
				{
					gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
				}
			]],

			fragment = VFS.LoadFile(LUA_DIRNAME .. "Assets/shader.glsl"),
		})

		timUniform = gl.GetUniformLocation(shader, "time")
		resUniform = gl.GetUniformLocation(shader, "resolution")
	end

	if (not fbo)or(not fboTex)or(not shader) then
		addon.Remove()
	end

	gl.ActiveFBO(fbo, true, function()
		gl.Clear(GL.COLOR_BUFFER_BIT, 1, 1, 1, 1)

		gl.UseShader(shader)
		gl.DepthMask(false)
		gl.Blending(false)

		gl.Uniform(timUniform, os.clock())
		gl.Uniform(resUniform, vsx/resDiv, vsy/resDiv)

		gl.Rect(-1,-1,1,1)

		gl.Blending(true)
		gl.DepthMask(true)
		gl.UseShader(0)
	end)

	gl.DepthMask(false)
	gl.Blending(false)
	gl.Texture(fboTex)
	gl.TexRect(0,0,1,1)
	gl.Texture(false)
	gl.Blending(true)
	gl.DepthMask(true)
end

function addon.Shutdown()
	gl.DeleteShader(shader)
	gl.DeleteFBO(fbo)
	gl.DeleteTexture(fboTex)
end
