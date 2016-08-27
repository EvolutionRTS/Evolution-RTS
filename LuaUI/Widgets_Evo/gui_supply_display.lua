function widget:GetInfo()
    return {
        name = "Supply Text Display",
        desc = "Displays supply economy parameters as text",
        author = "Code_Man",
        date = "11/4/2016",
        license = "MIT X11",
        layer = 1,
        enabled = true
    }
end

--Disable Default Resources Bar
Spring.SendCommands({"resbar 0"})

local white = "\255\255\255\255"
local yellow = "\255\255\255\0"
local orange = "\255\255\135\0"
local green = "\255\0\255\0"
local red = "\255\255\0\0"
local skyblue = "\255\136\197\226"

local str = ""
local FontSize = 15
local vsx, vsy = gl.GetViewSizes()
local posx, posy = vsx - 245, vsy - 60
local maxSupply = 200

function widget:GameFrame(n)
	local myTeamID = Spring.GetMyTeamID()
	--math.round(Spring.GetTeamRulesParam(myTeamID, "supplyUsed")) -- (su)
	--math.round(Spring.GetTeamRulesParam(myTeamID, "supplyMax")) -- (sm)
    local su, sm = math.round(Spring.GetTeamRulesParam(myTeamID, "supplyUsed")), math.round(Spring.GetTeamRulesParam(myTeamID, "supplyMax"))
	
	if su >= sm - 10 then
		warningColor = red
	else
		warningColor = green
	end
	
	if su >= maxSupply - 10 then
		warningColor = green
	end
	
    str =warningColor .. "Supply: " .. white .. su .. "/" .. sm .. " (" .. orange .. "±" .. tostring(sm - su) .. white .. "/" .. green .. maxSupply .. white .. ")"
end

function widget:TweakMousePress(x, y, button)
    if x >= posx and x < posx + 100 and y >= posy and y < posy + FontSize * 2 then
        return true
    end
end

function widget:TweakMouseMove(x, y, dx, dy, button)
    if x >= 0 and x < vsx - 100 and y >= 0 and y < vsy then
        posx = x
        posy = y
    end
end

function DrawScreen()
    local vsx, vsy = gl.GetViewSizes()
    gl.Text(str, posx, posy, FontSize, "on")  
end