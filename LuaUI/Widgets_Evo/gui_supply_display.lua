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

local str = ""
local FontSize = 15
local vsx, vsy = gl.GetViewSizes()
local posx, posy = vsx * 0.875, vsy * 0.98
local maxSupply = 200

function widget:GameFrame(n)
	local myTeamID = Spring.GetMyTeamID()
    local su, sm = math.round(Spring.GetTeamRulesParam(myTeamID, "supplyUsed")), math.round(Spring.GetTeamRulesParam(myTeamID, "supplyMax"))
    str = "\255\0\255\0Supply: " .. "\255\255\255\255" .. su .. "/" .. sm .. " (\255\255\135\0±" .. tostring(sm - su) .. "\255\255\255\255/\255\0\255\0" .. maxSupply .. "\255\255\255\255)"
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