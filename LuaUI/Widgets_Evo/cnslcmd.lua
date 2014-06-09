
function widget:GetInfo()
	return {
		name = "Luarules Console Commands",
		desc = "Remove the need to add /luarules in front of gadgets command",
		author = "zwzsg",
		date = "15th July, 2009",
		license = "Public Domain",
		layer = 0,
		enabled = true,
		handler = false,
	}
end

function widget:AddConsoleLine(line,priority)
	if string.match("\n"..line,"\n/(.+)") and not string.match("\n"..line,"\n/luarules(.+)") then
		Spring.SendCommands("luarules "..string.match("\n"..line,"\n/(.+)"))
	end
end
