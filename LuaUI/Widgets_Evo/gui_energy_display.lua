function widget:GetInfo()
    return {
        name = "Energy Text Display",
        desc = "Displays energy economy parameters as text",
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
local posx, posy = vsx * 0.78, vsy * 0.98

function widget:GameFrame(n)
    local ec, es, ep, ei, ee = Spring.GetTeamResources(myTeamID, "energy")
    str = "\255\255\255\0Energy: \255\255\135\0±" .. tostring(math.round(ep)) .. "\255\0\255\0 +" .. tostring(math.round(ei)) .. "\255\255\255\255/\255\255\0\0-" .. tostring(math.round(ee)) .. "\255\255\255\255 (" .. tostring(math.round(ec)) .. "/" .. tostring(math.round(es)) .. "\255\255\255\255)"
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