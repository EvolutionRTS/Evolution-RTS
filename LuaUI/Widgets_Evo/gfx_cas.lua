if gl.CreateShader == nil then
	return
end

function widget:GetInfo()
	return {
		name	  = "Contrast Adaptive Sharpen (Old)",
		desc	  = "Spring port of AMD FidelityFX' Contrast Adaptive Sharpen (CAS)",
		author	  = "martymcmodding, ivand",
		layer	  = 2000,
		enabled   = true,
	}
end

-- Shameless port from https://gist.github.com/martymcmodding/30304c4bffa6e2bd2eb59ff8bb09d135

-----------------------------------------------------------------
-- Constants
-----------------------------------------------------------------

local GL_RGBA8 = 0x8058

local SHARPNESS = 0.7
local version = 1.01

-----------------------------------------------------------------
-- Lua Shortcuts
-----------------------------------------------------------------

local glTexture		 = gl.Texture
local glTexRect		 = gl.TexRect
local glCallList		= gl.CallList
local glCopyToTexture   = gl.CopyToTexture

-----------------------------------------------------------------
-- File path Constants
-----------------------------------------------------------------

local luaShaderDir = "LuaUI/Widgets_Evo/Include/"

-----------------------------------------------------------------
-- Shader Sources
-----------------------------------------------------------------

local vsCAS = [[
#version 150 compatibility

void main() {
	gl_Position = gl_Vertex;
}
]]

local fsCAS = [[
#version 150 compatibility
#line 20051

uniform sampler2D screenCopyTex;
uniform float sharpness;

#if 0
	#define TEXEL_FETCH_OFFSET(t, c, l, o) texelFetch(t, c + o, l)
#else
	#define TEXEL_FETCH_OFFSET texelFetchOffset
#endif

vec3 CASPass(ivec2 tc) {
	// fetch a 3x3 neighborhood around the pixel 'e',
	//  a b c
	//  d(e)f
	//  g h i
	vec3 a = TEXEL_FETCH_OFFSET(screenCopyTex, tc, 0, ivec2(-1, -1)).rgb;
	vec3 b = TEXEL_FETCH_OFFSET(screenCopyTex, tc, 0, ivec2( 0, -1)).rgb;
	vec3 c = TEXEL_FETCH_OFFSET(screenCopyTex, tc, 0, ivec2( 1, -1)).rgb;
	vec3 d = TEXEL_FETCH_OFFSET(screenCopyTex, tc, 0, ivec2(-1,  0)).rgb;
	vec3 e = TEXEL_FETCH_OFFSET(screenCopyTex, tc, 0, ivec2( 0,  0)).rgb;
	vec3 f = TEXEL_FETCH_OFFSET(screenCopyTex, tc, 0, ivec2( 1,  0)).rgb;
	vec3 g = TEXEL_FETCH_OFFSET(screenCopyTex, tc, 0, ivec2(-1,  1)).rgb;
	vec3 h = TEXEL_FETCH_OFFSET(screenCopyTex, tc, 0, ivec2( 0,  1)).rgb;
	vec3 i = TEXEL_FETCH_OFFSET(screenCopyTex, tc, 0, ivec2( 1,  1)).rgb;

	// Soft min and max.
	//  a b c			 b
	//  d e f * 0.5  +  d e f * 0.5
	//  g h i			 h
	// These are 2.0x bigger (factored out the extra multiply).
	vec3 mnRGB = min(min(min(d, e), min(f, b)), h);
	vec3 mnRGB2 = min(mnRGB, min(min(a, c), min(g, i)));
	mnRGB += mnRGB2;

	vec3 mxRGB = max(max(max(d, e), max(f, b)), h);
	vec3 mxRGB2 = max(mxRGB, max(max(a, c), max(g, i)));
	mxRGB += mxRGB2;

	// Smooth minimum distance to signal limit divided by smooth max.
	vec3 rcpMRGB = vec3(1.0) / mxRGB;
	vec3 ampRGB = clamp(min(mnRGB, 2.0 - mxRGB) * rcpMRGB, vec3(0.0), vec3(1.0));

	// Shaping amount of sharpening.
	ampRGB = inversesqrt(ampRGB);

	float peak = 8.0 - 3.0 * sharpness;
	vec3 wRGB = vec3(-1.0) / (ampRGB * peak);

	vec3 rcpWeightRGB = vec3(1.0) / (1.0 + 4.0 * wRGB);

	//						  0 w 0
	//  Filter shape:		   w 1 w
	//						  0 w 0
	vec3 window = (b + d) + (f + h);
	vec3 outColor = clamp((window * wRGB + e) * rcpWeightRGB, vec3(0.0), vec3(1.0));

	return outColor;
}

void main() {
	gl_FragColor = vec4(CASPass(ivec2(gl_FragCoord.xy)), 1.0);
}
]]

-----------------------------------------------------------------
-- Global Variables
-----------------------------------------------------------------

local LuaShader = VFS.Include(luaShaderDir.."LuaShader.lua")

local vsx, vsy, vpx, vpy
local screenCopyTex
local casShader

local fullTexQuad

-----------------------------------------------------------------
-- Local Functions
-----------------------------------------------------------------


-----------------------------------------------------------------
-- Widget Functions
-----------------------------------------------------------------


function widget:Initialize()

	if gl.CreateShader == nil then
		Spring.Echo("CAS: createshader not supported, removing")
		widgetHandler:RemoveWidget(self)
		return
	end

	vsx, vsy, vpx, vpy = Spring.GetViewGeometry()

	local commonTexOpts = {
		target = GL_TEXTURE_2D,
		border = false,
		min_filter = GL.NEAREST,
		mag_filter = GL.NEAREST,

		wrap_s = GL.CLAMP_TO_EDGE,
		wrap_t = GL.CLAMP_TO_EDGE,
	}

	commonTexOpts.format = GL_RGBA8
	screenCopyTex = gl.CreateTexture(vsx, vsy, commonTexOpts)

	casShader = LuaShader({
		vertex = vsCAS,
		fragment = fsCAS,
		uniformInt = {
			screenCopyTex = 0,
		},
	}, ": Contrast Adaptive Sharpen")
	casShader:Initialize()

	fullTexQuad = gl.CreateList( function ()
		gl.DepthTest(false)
		gl.Blending(false)
		gl.TexRect(-1, -1, 1, 1, false, true) --false, true
		gl.Blending(true)
	end)

	WG.cas = {}
	WG.cas.setSharpness = function(value)
		SHARPNESS = value
	end
	WG.cas.getSharpness = function(value)
		return SHARPNESS
	end
end

function widget:Shutdown()
	gl.DeleteTexture(screenCopyTex)
	casShader:Finalize()
	gl.DeleteList(fullTexQuad)
end

function widget:ViewResize()
	widget:Shutdown()
	widget:Initialize()
end

function widget:DrawScreenEffects()
	glCopyToTexture(screenCopyTex, 0, 0, vpx, vpy, vsx, vsy)
	glTexture(0, screenCopyTex)
	casShader:ActivateWith( function()
		casShader:SetUniform("sharpness", SHARPNESS)
		glCallList(fullTexQuad)
	end)
	glTexture(0, false)
end

function widget:GetConfigData(data)
	return {
		version = version,
		SHARPNESS = SHARPNESS
	}
end

function widget:SetConfigData(data)
	if data.SHARPNESS ~= nil  and data.version ~= nil and data.version == version then
		SHARPNESS = data.SHARPNESS
	end
end
