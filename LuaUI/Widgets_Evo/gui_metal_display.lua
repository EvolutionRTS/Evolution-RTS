function widget:GetInfo()
    return {
        name = "Metal Text Display",
        desc = "Displays metal economy parameters as text",
        author = "Code_Man",
        date = "11/4/2016",
        license = "MIT X11",
        layer = 1,
        enabled = true
    }
end

--Disable Default Resources Bar
Spring.SendCommands({"resbar 0"})

local myTeamID = Spring.GetMyTeamID()
local str = ""
local FontSize = 15
local vsx, vsy = gl.GetViewSizes()
local posx, posy = vsx * 0.65, vsy * 0.98

function widget:GameFrame(n)
    local mc, ms, mp, mi, me = Spring.GetTeamResources(myTeamID, "metal")
    str = "\255\136\197\226Metal: \255\255\135\0±" .. tostring(math.round(mp)) .. "\255\0\255\0 +" .. tostring(math.round(mi)) .. "\255\255\255\255/\255\255\0\0-" .. tostring(math.round(me)) .. "\255\255\255\255 (" .. tostring(math.round(mc)) .. "/" .. tostring(math.round(ms)) .. "\255\255\255\255)"
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
---------------------------------------------------------------------------------------------------------