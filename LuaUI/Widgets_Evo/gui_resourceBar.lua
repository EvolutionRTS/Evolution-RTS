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
local bgFlashPeriod = 45
local maxBasicIncome = Spring.GetModOptions().maxbasicincome or 15

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

local supplyWarning = false
local energyWarning = false
local metalWarning = false

-- Avoids spamming of income increased notification
local incomeIncreased = false

local increment = 0
local vsx, vsy = gl.GetViewSizes()
local posx, posy = vsx - width, vsy - height
local tweakStartX, tweakStartY = 0, 0

-- how long before metal income changes, in seconds (default 150s, or 2.5min)
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
	-- background flashes when the player messed up their eco
	if supplyWarning == true or energyWarning == true or metalWarning == true then
		if increment == 0 then
			countUp = true
		end
	
		if increment < bgFlashPeriod and countUp == true then
			increment = increment + 1
		elseif increment > 0 then
			countUp = false
			increment = increment - 1
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
    vsx, vsy = gl.GetViewSizes()

	-- check resource status first
	myTeamID = Spring.GetMyTeamID()
	
	su, sm = math.round(Spring.GetTeamRulesParam(myTeamID, "supplyUsed") or 0), math.round(Spring.GetTeamRulesParam(myTeamID, "supplyMax") or 0)
    ec, es, ep, ei, ee = Spring.GetTeamResources(myTeamID, "energy")
    mc, ms, mp, mi, me = Spring.GetTeamResources(myTeamID, "metal")
	
	if (sm < 30 and su >= sm - 5) or (sm >= 30 and su >= sm - 10) then
		supplyWarning = true
		bgSupplyR = 1
		bgSupplyG = increment/bgFlashPeriod
	else
		supplyWarning = false
		bgSupplyR = 0
		bgSupplyG = 0
	end
	
	energyPercentage = ec / es
	if energyPercentage < 0.2 then
		energyWarning = true
		bgEnergyR = 1
		bgEnergyG = increment/bgFlashPeriod
	else
		energyWarning = false
		bgEnergyR = 0
		bgEnergyG = 0
	end
	
	metalPercentage = mc / ms
	if metalPercentage > 0.8 then
		metalWarning = true
		bgMetalR = 1
		bgMetalG = increment/bgFlashPeriod
	else
		metalWarning = false
		bgMetalR = 0
		bgMetalG = 0
	end
	
	-- draw background (black / gray / black / ...)
	-- background flashes when the player messed up their eco
	gl.Color(bgSupplyR,bgSupplyG,0,0.6)
	gl.Rect(posx+supplyOffset,posy,posx+supplyOffset+supplyBarWidth,posy+height)
	
	gl.Color(0.5,0.5,0.5,0.4)
	gl.Rect(posx+supplyOffset+supplyBarWidth,posy,posx+energyOffset,posy+height)
	
	gl.Color(bgEnergyR,bgEnergyG,0,0.6)
	gl.Rect(posx+energyOffset,posy,posx+energyOffset+energyBarWidth,posy+height)
	
	gl.Color(0.5,0.5,0.5,0.4)
	gl.Rect(posx+energyOffset+energyBarWidth,posy,posx+metalOffset,posy+height)
	
	gl.Color(bgMetalR,bgMetalG,0,0.6)
	gl.Rect(posx+metalOffset,posy,posx+metalOffset+metalBarWidth,posy+height)
	
	-- supply bar
	r, g, b = 0, 0, 0
	percentage = su / maxSupply
	
	if supplyWarning then
		r = 1
	else
		r, g, b = 0, 0.9, 0
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
	
	supplyStr = green .. "Supply: " .. white .. su .. "/" .. sm .. " (" .. orange .. "±" .. tostring(sm - su) .. white .. "/" .. green .. maxSupply .. white .. ")"
    gl.Text(supplyStr, posx+supplyOffset+textOffsetX, posy+textOffsetY, FontSize, "on")
	
	-- energy bar
	r, g, b = 0, 0, 0
	
	if energyPercentage > 0.8 then
		g = 0.9
	elseif energyPercentage < 0.2 then
		r = 1
	else
		r, g, b = 1, 0.9, 0
	end
	
	gl.Color(r,g,b,1)
	if not progressBars then
		energyPercentage = 1
	end
	gl.Rect(posx+energyOffset,posy,posx+energyOffset+energyBarWidth*energyPercentage,posy+height/4)
	
	energyStr = yellow .. "Energy: " .. green .. "+" .. tostring(math.round(ei)) .. white .. " (" .. yellow .. tostring(math.round(ec)).. white .. "/" .. tostring(math.round(es)) .. ")"
    gl.Text(energyStr, posx+energyOffset+textOffsetX, posy+textOffsetY, FontSize, "on")
	
	-- metal bar
	r, g, b = 0, 0, 0
	
	if metalPercentage > 0.8 then
		g = 0.9
	elseif metalPercentage < 0.2 then
		r = 1
	else
		r, g, b = .53, .77, .89
	end
	
	gl.Color(r,g,b,1)
	if not progressBars then
		metalPercentage = 1
	end
	gl.Rect(posx+metalOffset,posy,posx+metalOffset+metalBarWidth*metalPercentage,posy+height/4)
	
	-- draw metal income timer
	if mi ~= maxBasicIncome then
		timeElapsed = Spring.GetGameSeconds()
		percentage = timeElapsed%metalIncomeTimer/metalIncomeTimer
		gl.Color(1,0.5,0,1)
		gl.Rect(posx+metalOffset,posy,posx+metalOffset+metalBarWidth*percentage,posy+height/10)
		if percentage == 0 and timeElapsed > 0 and (not incomeIncreased) then
			Spring.PlaySoundFile("sounds/metalincomeincrease.wav", 1)
			Spring.Echo("-------------------------------------")
			Spring.Echo("Metal income has increased!")
			Spring.Echo("-------------------------------------")
			incomeIncreased = true
		end
		if percentage > 0.5 and incomeIncreased then
			incomeIncreased = false
		end
	end
	
	metalStr = skyblue .. "Metal: " .. orange .. "±" .. tostring(math.round(mi - me)) .. green .. " +" .. tostring(math.round(mi)) .. white .. "/" .. red .. "-" .. tostring(math.round(mp)) .. white .. " (" .. skyblue .. tostring(math.round(mc)) .. white .. "/" .. tostring(math.round(ms)) .. ")"
    gl.Text(metalStr, posx+metalOffset+textOffsetX, posy+textOffsetY, FontSize, "on")
end

function widget:Initialize()
	if Spring.GetModOptions().basicincomeinterval ~= nil then
		metalIncomeTimer = tonumber(Spring.GetModOptions().basicincomeinterval) * 60
	end
end
---------------------------------------------------------------------------------------------------------
