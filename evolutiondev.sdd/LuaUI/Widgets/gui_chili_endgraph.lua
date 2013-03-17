--[[
	TO DO:
	add amount label when mouseover line on graph (e.g to see exact metal produced at a certain time)
]]
function widget:GetInfo()
	return {
		name		    = "EndGame Stats",
		desc		    = "work on replacing default end game statistics",
		author		  = "Funkencool",
		date		    = "2013",
		license     = "public domain",
		layer		    = math.huge,
		enabled   	= true
	}
end

local testing = false
-- INCLUDES

--comment out any stats you don't want included, order also directly effects button layout..
local engineStats = {
	-- {"time"            , "time"},
	-- {"frame"           , ""},
	{"metalUsed"       , "Metal Used"},
	{"metalProduced"   , "Metal Produced"},
	{"metalExcess"     , "Metal Excess"},
	-- {"metalReceived"   , ""},
	-- {"metalSent"       , ""},
	{"energyUsed"      , "Energy Used"},
	{"energyProduced"  , "Energy Produced"},
	{"energyExcess"    , "Energy Excess"},
	-- {"energyReceived"  , ""},
	-- {"energySent"      , ""},
	{"damageDealt"     , "Damage Dealt"},
	--{"damageReceived"  , "Damage Received"},
	{"unitsProduced"   , "Units Built"},
	{"unitsKilled"     , "Units Killed"},
	{"unitsDied"       , "Units Lost"},
	-- {"unitsReceived"   , ""},
	-- {"unitsSent"       , ""},
	-- {"unitsCaptured"   , ""},
	-- {"unitsOutCaptured", ""},
}

local customStats = {
-- {external_dataArray, "button label"},
[[Not Implemented yet:
	I organize the engine stats in this widget but custom will have to be handled by themselves
  Probably in a dataArray = {player1_array = {data}, player2_array = {data}} ]]
}

-- CONSTANTS
local chiliConst = {
--	borderColor = {0,0,0,0}
	}
-- CHILI CONTROLS
local Chili
local window0 	
local graphPanel 
local graphSelect
local graphLabel

-- MEMBERS

local function numFormat(label)
	local string
	if label/1000000 > 1 then
		label =  math.floor(label/1000000)
		string = label .. "M"
	elseif label/1000 > 1 then
		label = math.floor(label/1000)
		string = label .. "k"
	else
	string = math.floor(label) .. ""
	end
	return string
end
	
local function drawGraph(graphArray, graph_m, teamID)
	local _,teamLeader = Spring.GetTeamInfo(teamID)
	local playerName = Spring.GetPlayerInfo(teamLeader) or ""
	local r,g,b,a = Spring.GetTeamColor(teamID)
	local teamColor = {r,g,b,a}
	local lineLabel = numFormat(graphArray[#graphArray])
	
	for i=1, #graphArray do
		if (graph_m < graphArray[i]) then graph_m = graphArray[i] end
	end	

	local drawLine = function()		
		for i=1, #graphArray do
			local ordinate = graphArray[i]
			gl.Vertex((i - 1)/(#graphArray - 1), 1 - ordinate/graph_m)
		end
	end
	-- Spring.Echo(lineLabel)
	local label1 = Chili.Label:New{parent = lineLabels, y = (1 - graphArray[#graphArray]/graph_m) * 100 - 2 .. "%", width = "100%", caption = lineLabel, font = {color = teamColor}}
	local label2 = Chili.Label:New{parent = graphPanel, x = 10, y = (teamID)*20 + 5, width = "100%", height  = 20, caption = playerName, font = {color = teamColor}}
	local graph = Chili.Control:New{
		parent	= graphPanel,
		x       = 0,
		y       = 0,
		height  = "100%",
		width   = "100%",
		padding = {0,0,0,0},
		DrawControl = function (obj)
			local x = obj.x
			local y = obj.y
			local w = obj.width
			local h = obj.height
			
			gl.Color(teamColor)
			gl.PushMatrix()
			gl.Translate(x, y, 0)
			gl.Scale(w, h, 1)
			gl.LineWidth(3)
			gl.BeginEnd(GL.LINE_STRIP, drawLine)
			gl.PopMatrix()
		end
		}
end

local function getEngineArrays(statistic, labelCaption)
	local teamScores = {}
	local teams	= Spring.GetTeamList()
	local players = (#teams - 1)
	local max = Spring.GetTeamStatsHistory(0) - 1
	-- Spring.Echo(labelCaption)
	
	--Applies label of the currently selected graph at bottom of window
	graphLabel:SetCaption(labelCaption)

	--finds highest stat out all the player stats to find the highest point of the graph
	local graphMax = 0
	for a=0, players do
		local stats = Spring.GetTeamStatsHistory(a, 0, max)
		for b=1, max do
			if (graphMax < stats[b][statistic]) then graphMax = stats[b][statistic] end
		end
	end
	
	--Applys each player to graph accordingly
	for a=0, players do
		local stats = Spring.GetTeamStatsHistory(a, 0, max)
		local teamScores = {}
		for b=1, max do
			teamScores[b] = stats[b][statistic]
		end
		drawGraph(teamScores, graphMax, a)
	end
end

-- WIDGET CODE
function loadpanel()

	Chili = WG.Chili
	local screen0 = Chili.Screen0
	
	window0 		= Chili.Window:New{parent = screen0, x = "20%", y = "20%", width = "60%", height = "60%"}
	lineLabels 	= Chili.Control:New{parent = window0,right = 0, y = 0, width = "5%", height = "90%", padding = {0,0,0,0},}
	graphPanel 	= Chili.Panel:New{parent = window0, right = "5%", y = 0, width = "75%", height = "90%",}
	graphSelect	= Chili.StackPanel:New{minHeight = 70, parent = window0, x =  0  , y = 0, width = "20%", height = "100%",}
	graphLabel  = Chili.Label:New{autosize = true, parent = window0, bottom = 0,caption = "", align = "center", width = "70%", x = "20%", height = "10%", font = {size = 30,},}
	
	for a=1, #engineStats do
		local engineButton =	Chili.Button:New{name = engineStats[a][1], caption = engineStats[a][2], maxHeight = 30, parent = graphSelect, OnClick = {function(obj) graphPanel:ClearChildren();lineLabels:ClearChildren();getEngineArrays(obj.name,obj.caption);end},}
	end
	
	local exitButton = Chili.Button:New{name = "exit", caption = "Exit", bottom = 0, right = 0, height = 30, width = 40 , parent = window0, OnClick = {function() Spring.SendCommands("quitforce");end},}

end

function widget:Initialize()
	if testing then
	Spring.SendCommands("endgraph 0")
	loadpanel()
	end
end

function widget:GameOver()
	if not testing then
	Spring.SendCommands("endgraph 0")
	loadpanel()
	end
end
