function widget:GetInfo()
  return {
    name      = "Chili Docking",
    desc      = "Provides docking and position saving for chili windows",
    author    = "Licho, jK",
    date      = "2010, 2013",
    license   = "GNU GPL, v2 or later",
    layer     = 50,
    experimental = false,
    enabled   = true  --  loaded by default?
  }
end


local Chili

local forceUpdate = false 
options_path = 'Settings/Interface/Docking'
options_order = { 'dockEnabled', 'dockThreshold', }
options = {
	dockThreshold = {
		name = "Docking distance",
		type = 'number',
		advanced = true,
		value = 10,
		min=1,max=50,step=1,
		OnChange = {function() 
			forceUpdate = true
		end },
	},
	
	dockEnabled = {
		name = 'Use docking',
		advanced = false,
		type = 'bool',
		value = true,
		desc = 'Dock windows to screen edges and each other to prevent overlaps',
	},
}



local lastPos  = {} -- "window name" indexed array of {x,y,x2,y2}
local settings = {} -- "window name" indexed array of {x,y,w,h}
local buttons  = {} -- "window name" indexed array of minimize buttons


function widget:Initialize()
	if (not WG.Chili) then
		widgetHandler:RemoveWidget()
		return
	end

	-- setup Chili
	Chili = WG.Chili
end 

local frameCounter = 0



-- returns snap orientation of box A compared to box B and distance of their edges  - orientation = L/R/T/D and distance of snap
local function GetBoxRelation(boxa, boxb)
	local mpah = 0 -- midposition a horizontal
	local mpbh = 0
	local mpav = 0
	local mpbv = 0

	local snaph, snapv
	
	if not (boxa[2] > boxb[4] or boxa[4] < boxb[2]) then  -- "vertical collision" they are either to left or to right
		mpah = (boxa[3] + boxa[1])/2  -- gets midpos
		mpbh = (boxb[3] + boxb[1])/2 
		snaph = true 
	end 

	if not (boxa[1] > boxb[3] or boxa[3] <boxb[1]) then  -- "horizontal collision" they are above or below
		mpav = (boxa[4] + boxa[2])/2  -- gets midpos
		mpbv = (boxb[4] + boxb[2])/2 
		snapv = true
	end 
	
	
	local axis = nil
	local dist = 99999
	if (snaph) then 
		if mpah < mpbh then 
			axis = 'R'
			dist = boxb[1] - boxa[3]
		else 
			axis = 'L'
			dist = boxa[1] - boxb[3]
		end 
	end 
	
	if (snapv) then 
		if mpav < mpbv then 
			local nd = boxb[2] - boxa[4]
			if  math.abs(nd) < math.abs(dist) then  -- only snap this axis if its shorter "snap" distance 
				axis = 'D'
				dist = nd
			end 
		else 
			local nd = boxa[2] - boxb[4]
			if math.abs(nd) < math.abs(dist) then 
				axis = 'T'
				dist = nd
			end 
			
		end 
	end 
	
	if axis ~= nil then return axis, dist 
	else return nil, nil end
end

 


-- returns closest axis to snap to existing windows or screen edges - first parameter is axis (L/R/T/D) second is snap distance
local function GetClosestAxis(winPos, dockWindows, win)
	local dockDist = options.dockThreshold.value
	local minDist =  dockDist + 1
	local minAxis= 'L'
	
	local function CheckAxis(dist, newAxis) 
		if dist < minDist and dist ~= 0 then 
			if newAxis == 'L' and (winPos[1] - dist < 0 or winPos[3] - dist > Chili.Screen0.width) then return end 
			if newAxis == 'R' and (winPos[1] + dist < 0 or winPos[3] + dist > Chili.Screen0.width) then return end 
			if newAxis == 'T' and (winPos[2] - dist < 0 or winPos[4] - dist > Chili.Screen0.height) then return end 
			if newAxis == 'D' and (winPos[2] + dist < 0 or winPos[4] + dist > Chili.Screen0.height) then return end 
			minDist = dist
			minAxis = newAxis
		end 
	end 

	CheckAxis(winPos[1], 'L') 
	CheckAxis(winPos[2], 'T')
	CheckAxis(Chili.Screen0.width  - winPos[3], 'R')
	CheckAxis(Chili.Screen0.height - winPos[4], 'D')
	if (minDist < dockDist and minDist ~= 0) then 
		return minAxis, minDist  -- screen edges have priority ,dont check anything else
	end 
	
	for w, dp in pairs(dockWindows) do 
		if win ~= w then 
			local a, d = GetBoxRelation(winPos, dp)
			if a ~= nil then 
				CheckAxis(d, a)
			end 
		end 
	end 

	
	if minDist < dockDist and minDist ~= 0 then 
		return minAxis, minDist
	else
		return nil, nil
	end
end


-- snaps box data with axis and distance 
local function SnapBox(wp, a,d)
	if a == 'L' then
		wp[1] = wp[1] - d
		wp[3] = wp[3] - d
	elseif a== 'R' then
		wp[1] = wp[1] + d
		wp[3] = wp[3] + d
	elseif a== 'T' then
		wp[2] = wp[2] - d
		wp[4] = wp[4] - d
	elseif a== 'D' then
		wp[2] = wp[2] + d
		wp[4] = wp[4] + d
	end
end 


local lastCount = 0
local lastWidth = 0
local lastHeight= 0

local function GetButtonPos(win)
	local size = 5 -- button thickness
	local mindist = win.x*5000 + win.height
	local mode = 'L'
	
	local dist = win.y*5000 + win.width
	if dist < mindist then
		mindist = dist
		mode = 'T'
	end 
	
	dist = (Chili.Screen0.width - win.x - win.width)*5000 + win.height
	if dist < mindist then
		mindist = dist
		mode = 'R'
	end
	
	dist = (Chili.Screen0.height - win.y - win.height)*5000 + win.width
	if dist < mindist then
		mindist = dist
		mode = 'B'
	end
	
	
	if mode == 'L' then
		return {x=win.x-3, y= win.y, width = size, height = win.height}
	elseif mode =='T' then
		return {x=win.x, y= win.y-3, width = win.width, height = size}
	elseif mode =='R' then
		return {x=win.x + win.width - size-3, y= win.y, width = size, height = win.height}
	elseif mode=='B' then
		return {x=win.x, y= win.y + win.height - size-3, width = win.width, height = size}
	end 
end


local function GetEdgePositions(win)
	local pw = win.parent.width
	local ph = win.parent.height

	local distLeft   = win.x / pw
	local distTop    = win.y / ph
	local distRight  = (pw - (win.x + win.width )) / pw
	local distBottom = (ph - (win.y + win.height)) / ph

	local edgePos = {distLeft, distTop, win.width / pw, win.height / ph}
	if (distRight < distLeft) then
		edgePos[1] = tostring(-distRight) -- tostring to preserve "-0", as number it would become +0
	end
	if (distBottom < distTop) then
		edgePos[2] = tostring(-distBottom)
	end

	return edgePos
end


local function ApplySavedSettingToWindow(win)
	local settingsPos = settings[win.name]
	if not settingsPos then
		-- we don't have settings stored for new window
		return
	end

	local pw = (win.parent and win.parent.width ) or Chili.Screen0.width
	local ph = (win.parent and win.parent.height) or Chili.Screen0.height

	do
		local w = settingsPos[3] * pw
		local h = settingsPos[4] * ph

		if win.fixedRatio then
			local limit = 0
			if (w > h) then limit = w else limit = h end 
			if (win.width > win.height) then
				w = limit
				h = limit * (win.height/win.width)
			else 
				h = limit
				w = limit * (win.width/win.height)
			end
		end
		if win.resizable or win.tweakResizable then
			win:Resize(w, h)
		end
	end

	do
		win.x = nil
		win.y = nil
		if (1 / settingsPos[1]) > 0 then
			win.x = settingsPos[1] * pw
		else
			win.right = -settingsPos[1] * pw
		end
		if (1 / settingsPos[2]) > 0 then
			win.y = settingsPos[2] * ph
		else
			win.bottom = -settingsPos[2] * ph
		end
		win:DetectRelativeBounds()
		win:AlignControl()
	end
end


local function MinimizeDispose(obj)
	buttons[obj.name]:Dispose()
	buttons[obj.name] = nil
end


local function MinimizeResize(obj)
	local pos = GetButtonPos(obj)
	buttons[obj.name]:SetPos(pos.x, pos.y, pos.width, pos.height)
end


local function HandleMinimizeBar(objs)
	-- BUTTONS to minimize stuff
	for name, win in pairs(objs) do
		if win.minimizable then
			local button = buttons[name]

			if not button then
				button = Chili.Button:New{
					x = win.x, y = win.y; width=50; height=20;
					caption  = '';
					dockable = false;
					tooltip  = 'Minimize ' .. win.name;
					backgroundColor = {0,1,0,1};
					parent  = Chili.Screen0;
					OnClick = {
						function(self)
							if win.visible then
								self.tooltip = 'Expand ' .. win.name
								self.backgroundColor={1,0,0,1}
								if not win.selfImplementedMinimizable then
									win:Hide()
								else
									win.selfImplementedMinimizable(false)
								end
							else 
								self.tooltip = 'Minimize ' .. win.name
								self.backgroundColor={0,1,0,1}
								if not win.selfImplementedMinimizable then
									win:Show()
								else
									win.selfImplementedMinimizable(true)
								end
							end
						end
					}
				}
				buttons[name] = button
				button:BringToFront()

				win.OnDispose[#win.OnDispose + 1] = MinimizeDispose
				win.OnResize[#win.OnResize + 1]   = MinimizeResize
			end
		end
	end
end


local function sign(x)
	if (x==0) then
		return 0
	elseif (x>0) then
		return 1
	else
		return -1
	end
end


local function DockResize(obj)
	local collideWindows = {}
	for _, win in ipairs(obj.parent.children) do
		if win.collide or win.dockable then
			collideWindows[win] = {win.x, win.y, win.x + win.width, win.y + win.height}
		end
	end

	local wp = {obj.x, obj.y, obj.x + obj.width, obj.y + obj.height}
	local dp = {obj.x, obj.y, obj.x + obj.width, obj.y + obj.height}
	local lp = lastPos[obj.name]

	-- dock windows
	repeat
		local numTries = 5
		local clipDirs = {}
		repeat
			local a,d = GetClosestAxis(dp, collideWindows, obj)
			if a then
				SnapBox(dp,a,d)
				clipDirs[a] = true
			end
			numTries = numTries - 1
		until (not a) or numTries == 0

		if (dp[1] == obj.x) and (dp[2] == obj.y) then
			break
		end

		if (obj.dragging) then
			if clipDirs["L"] and (sign(wp[1] - lp[1]) > 0) then
				break
			end
			if clipDirs["R"] and (sign(wp[1] - lp[1]) < 0) then
				break
			end
			if clipDirs["T"] and (sign(wp[2] - lp[2]) > 0) then
				break
			end
			if clipDirs["D"] and (sign(wp[2] - lp[2]) < 0) then
				break
			end

			--//FIXME this is a workaround OnResize get strange calls that are filtered with this
			if sign(wp[1] - lp[1]) == 0 then
				break
			end
			if sign(wp[2] - lp[2]) == 0 then
				break
			end
		elseif (resizing) then
			--FIXME
		end

		obj:SetPos(dp[1], dp[2])
		break
	until true

	local winPos = { obj.x, obj.y, obj.x + obj.width, obj.y + obj.height }
	lastPos[obj.name] = winPos
	settings[obj.name] = GetEdgePositions(obj)
end


function widget:DrawScreen() 
	frameCounter = frameCounter + 1
	if (frameCounter % 88 ~= 87) and (#Chili.Screen0.children == lastCount) then return end
	lastCount = #Chili.Screen0.children

	if (Chili.Screen0.width ~= lastWidth or Chili.Screen0.height ~= lastHeight) then
		forceUpdate = true
		lastWidth  = Chili.Screen0.width
		lastHeight = Chili.Screen0.height
	end

	local newWindow = true

	local bynames = {}
	for _, win in ipairs(Chili.Screen0.children) do
		if win.dockable then
			bynames[win.name] = win
			local lastWinPos = lastPos[win.name]
			if (not lastWinPos)or(forceUpdate) then  -- new window appeared
				newWindow = true
				ApplySavedSettingToWindow(win)
				if not options.dockEnabled.value then
					lastPos[win.name] = { win.x, win.y, win.x + win.width, win.y + win.height }
				end
				win.OnResize[#win.OnResize + 1] = DockResize
			end
		end
	end

	if forceUpdate or (newWindow and options.dockEnabled.value) then 
		forceUpdate = false
		local dockWindows = {}
		local collideWindows = {}
		for _, win in ipairs(Chili.Screen0.children) do
			if
				win.dockable and win.dragging --or (win.custom_freshlyMoved) --FIXME
			then
				dockWindows[win] = {win.x, win.y, win.x + win.width, win.y + win.height}
			end

			if win.collide or win.dockable then
				collideWindows[win] = {win.x, win.y, win.x + win.width, win.y + win.height}
			end
		end

		-- dock windows
		local mc = 2
		repeat
			for win, wp in pairs(dockWindows) do
				local numTries = 5
				repeat 
					local a,d = GetClosestAxis(wp, collideWindows, win)
					if a then
						SnapBox(wp,a,d)
					end
					numTries = numTries - 1
				until (not a) or numTries == 0

				win:SetPos(wp[1], wp[2])
			end

			mc = mc -1
		until mc == 0

		for win in pairs(dockWindows) do
			local winPos = { win.x, win.y, win.x + win.width, win.y + win.height }
			lastPos[win.name]  = winPos
			settings[win.name] = GetEdgePositions(win)
		end
	end 

	HandleMinimizeBar(bynames)

	windowMoved = false
end


function widget:SetConfigData(data)
	settings = data
end


function widget:GetConfigData()
	return settings
end
