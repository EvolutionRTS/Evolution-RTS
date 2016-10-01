function widget:GetInfo()
    return {
        name = "Evo Resource Display",
        desc = "Displays economy parameters",
        author = "Code_Man, CommonPlayer",
        date = "11/4/2016", -- modified by CommonPlayer on Oct 2016
        license = "MIT X11",
        layer = 1,
        enabled = false
    }
end

--Disable Default Resources Bar
Spring.SendCommands({"resbar 0"})

-- configurable settings
local FontSize = 22
local supplyOffset = 0
local supplyBarWidth = 340
local energyOffset = 350
local energyBarWidth = 340
local metalOffset = 700
local metalBarWidth = 340
local width, height = metalOffset+metalBarWidth, 40
local textOffsetX, textOffsetY = 5, 17

-- resource bars: ON means the bars show percentage, OFF means they simply change color depending on state
local progressBars = true

local maxSupply = 200

-- internal settings, do not touch
local white = "\255\255\255\255"
local yellow = "\255\255\255\0"
local orange = "\255\255\135\0"
local green = "\255\0\255\0"
local red = "\255\255\0\0"
local skyblue = "\255\136\197\226"

local supplyStr = ""
local energyStr = ""
local metalStr = ""

-- Avoids spamming of income increased notification
local incomeIncreased = false
local increment = 0
local vsx, vsy = gl.GetViewSizes()
local posx, posy = vsx - width, vsy - height
local tweakStartX, tweakStartY = 0, 0

-- how long before metal income changes, in seconds
local metalIncomeTimer = 150


--Spring.GetTeamResources
-- ( number teamID, string "metal" | "energy" ) ->
--   nil | number currentLevel, (mc)
--         number storage, (ms)
--         number pull, (mp)
--         number income, (mi)
--         number expense, (me)
--         number share,
--         number sent,
--         number received
		 
function widget:GameFrame(n)
	myTeamID = Spring.GetMyTeamID()
	
	-- Supply part
	su, sm = math.round(Spring.GetTeamRulesParam(myTeamID, "supplyUsed") or 0), math.round(Spring.GetTeamRulesParam(myTeamID, "supplyMax") or 0)
	warningColor = white -- If the word "energy" displays as white, something below isn't working correctly
	
	if (sm < 30 and su >= sm - 5) or (sm >= 30 and su >= sm - 10) then
		supplyWarning = true
		warningColor = "\255\255" .. string.char (increment) .. "\0"
	else
		supplyWarning = false
		warningColor = green
	end
	
	supplyStr = warningColor .. "Supply: " .. white .. su .. "/" .. sm .. " (" .. orange .. "±" .. tostring(sm - su) .. white .. "/" .. green .. maxSupply .. white .. ")"
	
	-- Energy part
    ec, es, ep, ei, ee = Spring.GetTeamResources(myTeamID, "energy")
	warningColor = white -- If the word "energy" displays as white, something below isn't working correctly
	
	if ec <= es * 0.2 then
		energyWarning = true
		warningColor = "\255\255" .. string.char (increment) .. "\0"
	else
		energyWarning = false
		warningColor = yellow
	end
	
	energyStr = warningColor .. "Energy: " .. green .. "+" .. tostring(math.round(ei)) .. white .. " (" .. yellow .. tostring(math.round(ec)).. white .. "/" .. tostring(math.round(es)) .. ")"
	
	-- Metal part
    mc, ms, mp, mi, me = Spring.GetTeamResources(myTeamID, "metal")

	warningColor = white -- If the word "energy" displays as white, something below isn't working correctly
	if mc >= ms * 0.8 then
		metalWarning = true
		warningColor = "\255\255" .. string.char (increment) .. "\0"
	else
		metalWarning = false
		warningColor = skyblue
	end

	metalStr = warningColor .. "Metal: " .. orange .. "±" .. tostring(math.round(mi - me)) .. green .. " +" .. tostring(math.round(mi)) .. white .. "/" .. red .. "-" .. tostring(math.round(mp)) .. white .. " (" .. skyblue .. tostring(math.round(mc)) .. white .. "/" .. tostring(math.round(ms)) .. ")"

	
	-- Flashing text if player messed up his eco
	if supplyWarning == true or energyWarning == true or metalWarning == true then
		if increment == 0 then
			countUp = true
		end
	
		if increment < 255 and countUp == true then
			increment = increment + 15
		elseif increment > 0 then
			countUp = false
			increment = increment - 15
		end
	end
end

-- tweaking UI position with ctrl+f11
function widget:TweakMousePress(x, y, button)
    if x >= posx and x < posx + width and y >= posy and y < posy + height then
		tweakStartX = x - posx
		tweakStartY = y - posy
        return true
    end
end

function widget:TweakMouseMove(x, y, dx, dy, button)
	posx = x - tweakStartX
	posy = y - tweakStartY
	if posx < 0 then
		posx = 0
	end
	if posx > vsx - width then
		posx = vsx - width
	end
	if posy < 0 then
		posy = 0
	end
	if posy > vsy - height then
		posy = vsy - height
	end
end

-- save and load
function widget:GetConfigData(data)
	return {
		posx = posx,
		posy = posy,
	}
end

function widget:SetConfigData(data)
	posx = data.posx or posx
	posy = data.posy or posy
end

function widget:DrawScreen()
	-- draw background (black / gray / black / ...)
	gl.Color(0,0,0,0.4)
	gl.Rect(posx+supplyOffset,posy,posx+supplyOffset+supplyBarWidth,posy+height)
	
	gl.Color(0.5,0.5,0.5,0.4)
	gl.Rect(posx+supplyOffset+supplyBarWidth,posy,posx+energyOffset,posy+height)
	
	gl.Color(0,0,0,0.4)
	gl.Rect(posx+energyOffset,posy,posx+energyOffset+energyBarWidth,posy+height)
	
	gl.Color(0.5,0.5,0.5,0.4)
	gl.Rect(posx+energyOffset+energyBarWidth,posy,posx+metalOffset,posy+height)
	
	gl.Color(0,0,0,0.4)
	gl.Rect(posx+metalOffset,posy,posx+metalOffset+metalBarWidth,posy+height)
	
	myTeamID = Spring.GetMyTeamID()
    vsx, vsy = gl.GetViewSizes()
	
	-- supply part
	su, sm = math.round(Spring.GetTeamRulesParam(myTeamID, "supplyUsed") or 0), math.round(Spring.GetTeamRulesParam(myTeamID, "supplyMax") or 0)
	
	-- draw resource bar
	r, g, b = 0, 0, 0
	percentage = su / maxSupply
	
	if (sm < 30 and su >= sm - 5) or (sm >= 30 and su >= sm - 10) then
		r = 1
	else
		r, g, b = 0, 1, 0
	end
	
	-- gray bar for locked supply, black bar for unlocked supply, last bar for used supply
	gl.Color(0.5,0.5,0.5,1)
	gl.Rect(posx+supplyOffset,posy,posx+supplyBarWidth,posy+height/4)
	maxPercentage = sm / maxSupply
	gl.Color(0,0,0,1)
	gl.Rect(posx+supplyOffset,posy,posx+supplyBarWidth*maxPercentage,posy+height/4)
	gl.Color(r,g,b,1)
	if not progressBars then
		percentage = 1
	end
	gl.Rect(posx+supplyOffset,posy,posx+supplyBarWidth*percentage,posy+height/4)
	
    gl.Text(supplyStr, posx+supplyOffset+textOffsetX, posy+textOffsetY, FontSize, "on")
	
	-- energy part
    ec, es, ep, ei, ee = Spring.GetTeamResources(myTeamID, "energy")
	
	-- draw resource bar
	r, g, b = 0, 0, 0
	percentage = ec / es
	
	if percentage >= 0.8 then
		g = 1
	elseif percentage < 0.2 then
		r = 1
	else
		r, g, b = 1, 1, 0
	end
	
	gl.Color(r,g,b,1)
	if not progressBars then
		percentage = 1
	end
	gl.Rect(posx+energyOffset,posy,posx+energyOffset+energyBarWidth*percentage,posy+height/4)
	
    gl.Text(energyStr, posx+energyOffset+textOffsetX, posy+textOffsetY, FontSize, "on")
	
	-----
	
	-- metal part
    mc, ms, mp, mi, me = Spring.GetTeamResources(myTeamID, "metal")
	
	-- draw resource bar
	r, g, b = 0, 0, 0
	percentage = mc / ms
	
	if percentage >= 0.8 then
		g = 1
	elseif percentage < 0.2 then
		r = 1
	else
		r, g, b = .53, .77, .89
	end
	
	gl.Color(r,g,b,1)
	if not progressBars then
		percentage = 1
	end
	gl.Rect(posx+metalOffset,posy,posx+metalOffset+metalBarWidth*percentage,posy+height/4)
	
	-- draw metal income timer
	timeElapsed = Spring.GetGameSeconds()
	percentage = timeElapsed%metalIncomeTimer/metalIncomeTimer
	gl.Color(1,1,0,1)
	gl.Rect(posx+metalOffset,posy,posx+metalOffset+metalBarWidth*percentage,posy+height/10)
	if percentage == 0 and timeElapsed > 0 and (not incomeIncreased) then
		Spring.Echo("-------------------------------------")
		Spring.Echo("Metal income has increased!")
		Spring.Echo("-------------------------------------")
		incomeIncreased = true
	end
	if percentage > 0.5 and incomeIncreased then
		incomeIncreased = false
	end
	
    gl.Text(metalStr, posx+metalOffset+textOffsetX, posy+textOffsetY, FontSize, "on")
end

function widget:Initialize()
	if Spring.GetModOptions().basicincomeinterval ~= nil then
		metalIncomeTimer = tonumber(Spring.GetModOptions().basicincomeinterval) * 60
	else
		metalIncomeTimer = 2.5 * 60
	end
end
---------------------------------------------------------------------------------------------------------