function widget:GetInfo()
    return {
        name = "Evo Resource Display",
        desc = "Displays economy parameters",
        author = "Code_Man, CommonPlayer, Floris",
        date = "11/4/2016", -- modified by CommonPlayer on Oct 2016
        license = "MIT X11",
        layer = 1,
        enabled = true
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

local maxSupply = tonumber(Spring.GetModOptions().supplycap) or 200

-- internal settings, do not touch
local white = "\255\255\255\255"
local yellow = "\255\255\255\0"
local orange = "\255\255\135\0"
local green = "\255\0\255\0"
local red = "\255\255\0\0"
local skyblue = "\255\136\197\226"

local barTexture = LUAUI_DIRNAME.."Images/resbar.dds"
local barGlowCenterTexture = LUAUI_DIRNAME.."Images/barglow-center.dds"
local barGlowEdgeTexture = LUAUI_DIRNAME.."Images/barglow-edge.dds"
local energyTexture = LUAUI_DIRNAME.."Images/energy2.png"
local metalTexture = LUAUI_DIRNAME.."Images/metal.png"
local supplyTexture = LUAUI_DIRNAME.."Images/supply.png"

local supplyWarning = false
local energyWarning = false
local metalWarning = false

-- Avoids spamming of income increased notification
local incomeIncreased = false

local increment = 0
local vsx, vsy = gl.GetViewSizes()
local widgetScale = 1		-- gets auto changed anyway
local bgmargin = 12
local bgmargin2 = 6
local posx, posy = vsx - width, vsy - height
local tweakStartX, tweakStartY = 0, 0

local modoptMincome = Spring.GetModOptions().mincome

-- how long before metal income changes, in seconds (default 150s, or 2.5min)
local metalIncomeTimer = 150

-- how long before metal income stops increasing, in seconds (default 60s, or 10min, 4 times the metalIncomeTimer)
local incomeProgressionEndTimer = metalIncomeTimer * 4 + 5


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


local bgcorner = ":n:"..LUAUI_DIRNAME.."Images/bgcorner.png"
local function DrawRectRound(px,py,sx,sy,cs, tl,tr,br,bl)
	gl.TexCoord(0.8,0.8)
	gl.Vertex(px+cs, py, 0)
	gl.Vertex(sx-cs, py, 0)
	gl.Vertex(sx-cs, sy, 0)
	gl.Vertex(px+cs, sy, 0)
	
	gl.Vertex(px, py+cs, 0)
	gl.Vertex(px+cs, py+cs, 0)
	gl.Vertex(px+cs, sy-cs, 0)
	gl.Vertex(px, sy-cs, 0)
	
	gl.Vertex(sx, py+cs, 0)
	gl.Vertex(sx-cs, py+cs, 0)
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.Vertex(sx, sy-cs, 0)
	
	local offset = 0.07		-- texture offset, because else gaps could show
	local o = offset
	
	-- bottom left
	--if ((py <= 0 or px <= 0)  or (bl ~= nil and bl == 0)) and bl ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(px, py, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(px+cs, py, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(px+cs, py+cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(px, py+cs, 0)
	-- bottom right
	--if ((py <= 0 or sx >= vsx) or (br ~= nil and br == 0)) and br ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(sx, py, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(sx-cs, py, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(sx-cs, py+cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(sx, py+cs, 0)
	-- top left
	--if ((sy >= vsy or px <= 0) or (tl ~= nil and tl == 0)) and tl ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(px, sy, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(px+cs, sy, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(px+cs, sy-cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(px, sy-cs, 0)
	-- top right
	--if ((sy >= vsy or sx >= vsx)  or (tr ~= nil and tr == 0)) and tr ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(sx, sy, 0)
	gl.TexCoord(o,1-o)
	gl.Vertex(sx-cs, sy, 0)
	gl.TexCoord(1-o,1-o)
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.TexCoord(1-o,o)
	gl.Vertex(sx, sy-cs, 0)
end
function RectRound(px,py,sx,sy,cs, tl,tr,br,bl)		-- (coordinates work differently than the RectRound func in other widgets)
	gl.Texture(bgcorner)
	gl.BeginEnd(GL.QUADS, DrawRectRound, px,py,sx,sy,cs, tl,tr,br,bl)
	gl.Texture(false)
end

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
	local posxScaled = posx - (bgmargin*widgetScale) - ((vsx - posx) * (widgetScale-1))
	local posyScaled = posy - (bgmargin*widgetScale) - ((vsy - posy) * (widgetScale-1))
  if x >= posxScaled and x < posxScaled + ((width+bgmargin+bgmargin)*widgetScale) and y >= posyScaled and y < posyScaled + ((height+bgmargin+bgmargin)*widgetScale) then
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
	generateDisplayList()
	generateDisplayList3()
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
	generateDisplayList()	
	generateDisplayList3()	
end


local prevGameframe = 0
function widget:DrawScreen()
	if Spring.GetGameFrame() ~= prevGameframe then
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
		
		percentage = su / maxSupply
		if percentage > 1 then percentage = 1 end
		
		energyPercentage = ec / es
		if energyPercentage > 1 then energyPercentage = 1 end
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
		if metalPercentage > 1 then metalPercentage = 1 end
		if metalPercentage > 0.8 then
			metalWarning = true
			bgMetalR = 1
			bgMetalG = increment/bgFlashPeriod
		else
			metalWarning = false
			bgMetalR = 0
			bgMetalG = 0
		end
		
		generateDisplayList2()
	end
	if displayList2 ~= nil then
		gl.CallList(displayList)
		gl.CallList(displayList2)
		gl.CallList(displayList3)
	end
end

function widget:Initialize()
	if Spring.GetModOptions().basicincomeinterval ~= nil then
		metalIncomeTimer = tonumber(Spring.GetModOptions().basicincomeinterval) * 60
	end
	
	local incomePerInterval = 3
	if Spring.GetModOptions().basicincome ~= nil then
		incomePerInterval = Spring.GetModOptions().basicincome
	end
	local totalSteps = math.ceil(maxBasicIncome / incomePerInterval) - 1
	local incomeProgressionEndTimer = totalSteps * metalIncomeTimer
	incomeProgressionEndTimer = incomeProgressionEndTimer + 5   -- five extra seconds to ensure it ends properly
	
	self:ViewResize(gl.GetViewSizes())
end


function widget:Shutdown()
	if (WG['guishader_api'] ~= nil) then
		WG['guishader_api'].RemoveRect('resources')
	end
	
	if displayList ~= nil then
		gl.DeleteList(displayList)
		gl.DeleteList(displayList2)
		gl.DeleteList(displayList3)
	end
end
---------------------------------------------------------------------------------------------------------

function generateDisplayList()	
	if displayList ~= nil then
		gl.DeleteList(displayList)
	end
	displayList = gl.CreateList( function()
				
		-- start drawing
		gl.PushMatrix()
		
		-- set position
		gl.Translate(posx, posy, 0)
		
		-- apply scaling
		gl.Translate(-((vsx - posx) * (widgetScale-1)), -((vsy - posy) * (widgetScale-1)), 0)
		gl.Scale(widgetScale, widgetScale, 1)
		
		-- background
	  gl.Color(0,0,0,0.8)
		RectRound(supplyOffset-bgmargin, -bgmargin, metalOffset+metalBarWidth+bgmargin, height+bgmargin, 10)
		
		-- content area
		gl.Color(0.33,0.33,0.33,0.15)
		RectRound(supplyOffset-bgmargin2, -bgmargin2, metalOffset+metalBarWidth+bgmargin2, height+bgmargin2,9)
		
		if (WG['guishader_api'] ~= nil) then
			WG['guishader_api'].InsertRect(supplyOffset-(bgmargin*0.8), -(bgmargin*0.8), metalOffset+metalBarWidth+(bgmargin*0.8), height+(bgmargin*0.8), 'resources')
		end
		
		gl.Text(yellow .. "Energy", energyOffset+textOffsetX+29, textOffsetY, FontSize, "on")
		gl.Text(green .. "Supply", supplyOffset+textOffsetX+29, textOffsetY, FontSize, "on")
		gl.Text(skyblue .. "Metal", metalOffset+textOffsetX+29, textOffsetY, FontSize, "on")
		
	  
	  gl.Texture(false)
		
	end)
end

function generateDisplayList2()
	if displayList2 ~= nil then
		gl.DeleteList(displayList2)
	end
	displayList2 = gl.CreateList(function ()
		-- draw background (black / gray / black / ...)
		-- background flashes when the player messed up their eco
		local glowSize = (height/6) * 3
		local glowAlpha = 0.14
		
		gl.Color(bgSupplyR,bgSupplyG,0,0.33)
		gl.Texture(barTexture)
		RectRound(supplyOffset,0,supplyOffset+supplyBarWidth,height, 5)
		
		gl.Color(bgEnergyR,bgEnergyG,0,0.33)
		RectRound(energyOffset,0,energyOffset+energyBarWidth,height, 5)

		gl.Color(bgMetalR,bgMetalG,0,0.33)
		RectRound(metalOffset,0,metalOffset+metalBarWidth,height, 5)
		
		-- supply bar
		r, g, b = 0, 0, 0
		
		if supplyWarning then
			r = 1
		else
			r, g, b = 1, 0.5, 0
		end
		
		gl.Texture(barTexture)
		-- gray bar for locked supply, black bar for unlocked supply, last bar for used supply
		gl.Color(0.5,0.5,0.5,1)
		gl.TexRect(supplyOffset,0,supplyOffset+supplyBarWidth,height/6)
		maxPercentage = sm / maxSupply
		
		gl.Color(0,1,0,1)
		gl.TexRect(supplyOffset,0,supplyOffset+supplyBarWidth*maxPercentage,height/6)
		
		gl.Color(0,1,0,glowAlpha)
		gl.Texture(barGlowCenterTexture)
		gl.TexRect(supplyOffset,-glowSize,supplyOffset+supplyBarWidth*maxPercentage,(height/6)+glowSize)
		gl.Texture(barGlowEdgeTexture)
		gl.TexRect(supplyOffset-glowSize-glowSize,-glowSize,supplyOffset,(height/6)+glowSize)
		gl.Texture(barGlowEdgeTexture)
		gl.TexRect(supplyOffset+(supplyBarWidth*maxPercentage)+glowSize+glowSize,-glowSize,supplyOffset+(supplyBarWidth*maxPercentage),(height/6)+glowSize)
		
		gl.Color(r,g,b,1)
		
		if not progressBars then
			percentage = 1
		end
		gl.TexRect(supplyOffset,0,supplyOffset+supplyBarWidth*percentage,height/6)
		
		supplyStr = white .. su .. "/" .. sm .. " (" .. orange .. "±" .. tostring(sm - su) .. white .. "/" .. green .. maxSupply .. white .. ") "
	  gl.Text(supplyStr, supplyOffset+supplyBarWidth, textOffsetY, FontSize, "onr")
		
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
		
		gl.Texture(barTexture)
		gl.TexRect(energyOffset,0,energyOffset+energyBarWidth*energyPercentage,height/6)
		
		gl.Color(0,1,0,glowAlpha)
		gl.Texture(barGlowCenterTexture)
		gl.TexRect(energyOffset,-glowSize,energyOffset+energyBarWidth*energyPercentage,(height/6)+glowSize)
		gl.Texture(barGlowEdgeTexture)
		gl.TexRect(energyOffset-glowSize-glowSize,-glowSize,energyOffset,(height/6)+glowSize)
		gl.Texture(barGlowEdgeTexture)
		gl.TexRect(energyOffset+(energyBarWidth*energyPercentage)+glowSize+glowSize,-glowSize,energyOffset+(energyBarWidth*energyPercentage),(height/6)+glowSize)
		
		energyStr = green .. "+" .. tostring(math.round(ei)) .. white .. " (" .. yellow .. tostring(math.round(ec)).. white .. "/" .. tostring(math.round(es)) .. ") "
	  gl.Text(energyStr, energyOffset+energyBarWidth, textOffsetY, FontSize, "onr")
		
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
		gl.Texture(barTexture)
		gl.TexRect(metalOffset,0,metalOffset+metalBarWidth*metalPercentage,height/6)
		
		gl.Color(0,1,0,glowAlpha)
		gl.Texture(barGlowCenterTexture)
		gl.TexRect(metalOffset,-glowSize,metalOffset+metalBarWidth*metalPercentage,(height/6)+glowSize)
		gl.Texture(barGlowEdgeTexture)
		gl.TexRect(metalOffset-glowSize-glowSize,-glowSize,metalOffset,(height/6)+glowSize)
		gl.Texture(barGlowEdgeTexture)
		gl.TexRect(metalOffset+(metalBarWidth*metalPercentage)+glowSize+glowSize,-glowSize,metalOffset+(metalBarWidth*metalPercentage),(height/6)+glowSize)
		
		-- draw metal income timer
		if modoptMincome ~= "disabled" then
			timeElapsed = Spring.GetGameSeconds()
			if timeElapsed < incomeProgressionEndTimer then
				percentage = timeElapsed%metalIncomeTimer/metalIncomeTimer
				gl.Color(1,0.5,0,1)
				gl.Texture(barTexture)
				gl.TexRect(metalOffset,0,metalOffset+metalBarWidth*percentage,height/20)
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
		end
		
		metalStr = orange .. "±" .. tostring(math.round(mi - me)) .. green .. " +" .. tostring(math.round(mi)) .. white .. "/" .. red .. "-" .. tostring(math.round(mp)) .. white .. " (" .. skyblue .. tostring(math.round(mc)) .. white .. "/" .. tostring(math.round(ms)) .. ") "
	  gl.Text(metalStr, metalOffset+metalBarWidth, textOffsetY, FontSize, "onr")
	    
	  gl.Texture(false)
	
  end)
end

function generateDisplayList3()
	if displayList3 ~= nil then
		gl.DeleteList(displayList3)
	end
	displayList3 = gl.CreateList(function ()
		
		-- draw icons
		local iconSize = 32
	  gl.Color(1,1,1,1)
	  gl.Texture(supplyTexture)
	  gl.TexRect(supplyOffset+1, height-iconSize, supplyOffset+iconSize+1, height)
	  
	  gl.Texture(energyTexture)
	  gl.TexRect(energyOffset+1, height-iconSize, energyOffset+iconSize+1, height)
	  
	  gl.Texture(metalTexture)
	  gl.TexRect(metalOffset+1, height-iconSize, metalOffset+iconSize+1, height)
	  
	  
		gl.PopMatrix()
	end)
end

function widget:ViewResize(newX,newY)
  vsx, vsy = newX, newY
	widgetScale = (0.72 + (vsx*vsy / 13300000))
	generateDisplayList()
	generateDisplayList3()
end
