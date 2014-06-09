function widget:GetInfo()
	return {
	name      = "Simple Console", --version 1
	desc      = "Draws a simple console + filters out frame numbers",
	author    = "abma",
	date      = "November, 2011", --last change November, 2011
	license   = "GNU GPL, v2 or later",
	layer     = 0,
	enabled   = true, --enabled by default
	}
end

local linesbuffer={}
local maxlines=10
local fontsize=14
local lineheight=fontsize+2

function widget:Initialize()
	Spring.SendCommands("console 0")
end

function widget:Shutdown()
	Spring.SendCommands("console 1")
end

function widget:DrawScreen()
	local vsx, vsy = gl.GetViewSizes()
	local posx, posy = vsx * 0.27, vsy * 0.96
	count=math.max(#linesbuffer-maxlines, 0)
	i=0
	for n, v in pairs(linesbuffer) do
		if n>count then
			gl.Text(v["line"], posx, posy-i*lineheight, fontsize, "on")
			i=i+1
		end
	end
end

function widget:AddConsoleLine(lines,priority)
	lines = lines:match('^\[f=[0-9]+\] (<.*>.*)$')
	if lines==nil then
		return
	end
	len=#linesbuffer
	for line in lines:gmatch("[^\n]+") do
		table.insert(linesbuffer, {frame=Spring.GetGameFrame(), line=line})
	end
end

function widget:GameFrame(curframe)
	if #linesbuffer>0 then
		for n,v in pairs(linesbuffer) do
			if curframe > v["frame"]+400 then
				table.remove(linesbuffer, n)
			end
		end
	end
end

