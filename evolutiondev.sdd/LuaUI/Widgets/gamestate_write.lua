
function widget:GetInfo()
	return {
		name = "Write GameState",
		desc = "Necessary for Lua gadgets to write startscripts.",
		author = "zwzsg",
		version = "1.52",
		date = "8th december, 2009",
		license = "Public Domain",
		layer = 0,
		enabled = true,
	}
end

VFS.Include("LuaRules/Gadgets/libs/dump_units_lib.lua",nil)
VFS.Include("LuaRules/Gadgets/libs/FillModSpecific.lua",nil)
--VFS.Include("LuaRules/Gadgets/libs/ColorConversion.lua",nil) -- Not need to invent new color when we take current ones
VFS.Include("LuaRules/Gadgets/libs/GenerateGame.lua",nil) -- Only so WriteScript.lua gets GetMaxAllyTeam from GenerateGame.lua"
VFS.Include("LuaRules/Gadgets/libs/WriteScript.lua",nil)


local function WriteStateToScript(state,filename)
	FillModSpecific()
	WriteScript(state,filename)
end

local function WriteAndRunState(state,filename)
	FillModSpecific()
	local filename=filename or ModSpecific.ScriptFileName
	Spring.Echo(widget:GetInfo().name..": Writing game state to \""..filename.."\"")
	WriteScript(state)
	if Spring.Restart then
		Spring.Echo(widget:GetInfo().name..": Restarting game")
		Spring.Restart("-s",VFS.LoadFile(filename))
	else
		Spring.Echo(widget:GetInfo().name..": Cannot restart game: Spring.Restart not implemented in this build of Spring!")
		Spring.Echo(widget:GetInfo().name..": Quit, then drag'n'drop "..filename.." over "..ModSpecific.ExecutableFileName.." manually.")
	end
end

function widget:Initialize()
	widgetHandler:RegisterGlobal("WriteStateToScript",WriteStateToScript)
	widgetHandler:RegisterGlobal("WriteAndRunState",WriteAndRunState)
end

