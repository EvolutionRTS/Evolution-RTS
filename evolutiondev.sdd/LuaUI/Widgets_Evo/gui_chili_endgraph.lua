-- v1.0
function widget:GetInfo()
	return {
		name    = 'Funks EndGame Graph',
		desc    = 'Chili replacement for default EndGame Graph, v1.0',
		author  = 'Funkencool',
		date    = '2013', -- 2014
		license = 'GNU GPL v2',
		layer   = 0,
		enabled = true
	}
end


-- Comment out any stats you don't want included
--  order also directly effects button layout..
--  { [1] = engineName, [2] = 'Custom Caption' }
local statName = {
	--{'time'            , 'time'},
	--{'frame'           , ''},
	{'metalUsed'       , 'Metal Used'},
	{'metalProduced'   , 'Metal Produced'},
	--{'metalExcess'     , 'Metal Excess'},
	--{'metalReceived'   , ''},
	--{'metalSent'       , ''},
	{'energyUsed'      , 'Energy Used'},
	{'energyProduced'  , 'Energy Produced'},
	--{'energyExcess'    , 'Energy Excess'},
	--{'energyReceived'  , ''},
	--{'energySent'      , ''},
	{'damageDealt'     , 'Damage Dealt'},
	{'damageReceived'  , 'Damage Received'},
	{'unitsProduced'   , 'Units Built'},
	{'unitsKilled'     , 'Units Killed'},
	--{'unitsDied'       , 'Units Lost'},
	--{'unitsReceived'   , ''},
	--{'unitsSent'       , ''},
	--{'unitsCaptured'   , ''},
	--{'unitsOutCaptured', ''},
}

local speccing = Spring.IsGameOver() or Spring.GetSpectatingState()
local isDelta  = false
local curGraph = {}
local button = {}
local team = {}

-- Chili vars
local Chili, control0
local graphPanel, graphLabel, graphTime, lineLabels, graphPanel
local playerList, graphSelect
-------------

------------------------------------
-- Formats final stat to fit in label
--  could use some work
local function numFormat(value)
	local value = math.floor(value)
	local label = ''
	if value/1000000000 >= 1 then
		label = string.sub(value/1000000000 .. '', 0, 4) .. 'B'
	elseif value/1000000 >= 1 then
		label = string.sub(value/1000000 .. '', 0, 4) .. 'M'
	elseif value/10000 >= 1 then
		label = string.sub(value/1000 .. '', 0, 4) .. 'k'
	else
		label = math.floor(value) .. ''
	end
	if label:find('%.') == 4 then
		label = label:gsub('%.', '')
	end
	return label
end

local function formatTime(seconds, short)
	local seconds = math.floor(seconds)
	local minutes = math.floor(seconds/60)
	seconds = seconds % 60
	if short then
		if seconds < 10 then
			seconds = '0' .. seconds
		end
		-- if minutes < 10 then
			-- minutes = '0' .. minutes
		-- end
		return minutes..':'..seconds
	else
		return '\255\255\127\0'..minutes..'\bmin, '..'\255\255\127\0'..seconds..'\bsec'
	end
end

local function drawIntervals(graphMax, gameTime)
	for i=1, 4 do
		-- Stat
		Chili.Line:New{
			parent = graphPanel,
			x      = 0,
			bottom = (i)/5*100 .. '%',
			width  = '100%',
		}
		Chili.Label:New{
			parent  = graphPanel,
			x       = 0,
			bottom  = (i)/5*100+2 .. '%',
			caption = numFormat(graphMax*i/5),
		}
		-- Time
		Chili.Line:New{
			parent = graphPanel,
			x      = (i)/5*100 .. '%',
			y      = 0,
			width  = 1,
			height = '100%',
			style  = 'vertical',
		}
		Chili.Label:New{
			parent  = graphPanel,
			x       = (i)/5*100+2 .. '%',
			y       = 0,
			caption = formatTime(gameTime*i/5, true),
		}
		--------
	end
end


local function setTip(obj, x, y)
	local graph    = graphPanel
	local gameTime = graphPanel.time
	local graphMax = graphPanel.maxValue
	local height   = graphPanel.height
	local width    = graphPanel.width
	local score = numFormat(graphMax - (graphMax/height)*y)
	local time  = formatTime((gameTime/width)*x, true)
	graphPanel.tooltip = 'Time: '.. time ..'\n'.. 'Score: '..score
end


local function alignLabels()
	local checkAgain
	local labels = lineLabels.children
	for a=1, #labels do
		local first = labels[a].y
		for b=1, #labels do
			if a ~= b then
				local second = labels[b].y
				local overlap = (first >= second and first < second + 14)
				if overlap then
					labels[a]:SetPos(0, labels[b].y + 14)
					checkAgain = true
				end
			end
		end
	end
	lineLabels.children = labels
	if checkAgain then alignLabels() end
end

local function labelLine(teamID)
	local graphMax = graphPanel.maxValue
	local array = team[teamID].array
	if not array[#array] then return end
	-- Adds value to end of graph
	local lineLabel = numFormat(array[#array])
	local bottom = (array[#array]/graphMax) * (lineLabels.height-30)
	Chili.Label:New{
		parent  = lineLabels,
		height  = 14,
		bottom  = bottom,
		width   = '100%',
		caption = lineLabel,
		font    = {
			color        = team[teamID].color,
			outlineColor = {0,0,0,1},
		},
	}
end

local function resize()
	if not lineLabels then return end
	-- Draws each teams relevant line
	lineLabels:ClearChildren()
	for teamID = 1, #team do
		if team[teamID].show then
			labelLine(teamID)
		end
	end
	alignLabels()
end
----------------------------------------------------------------
----------------------------------------------------------------

------------------------
-- Total package of graph: Draws graph and labels for a single nonSpec player
local function drawLine(graphMax, teamID)
	local array = team[teamID].array

	-- Gets vertex's from array and plots them
	local vertex = function()
		for i=1, #array do
			local ordinate = array[i]
			gl.Vertex((i - 1)/(#array - 1), 1 - ordinate/graphMax)
		end
	end

	-- Creates graph element with custom drawcontrol for the lines in the graph
	Chili.Control:New{
		parent        = graphPanel,
		x             = 0,
		y             = 0,
		height        = '100%',
		width         = '100%',
		padding       = {0,0,0,0},
		drawcontrolv2 = true,
		DrawControl   = function (obj)
			local x = obj.x
			local y = obj.y
			local w = obj.width
			local h = obj.height

			gl.Color(team[teamID].color)
			gl.PushMatrix()
			gl.Translate(x, y, 0)
			gl.Scale(w, h, 1)
			gl.LineWidth(3)
			gl.BeginEnd(GL.LINE_STRIP, vertex)
			gl.PopMatrix()
		end
	}

end

------------------------
-- Returns arrays for each team (to be drawn)
--  also finds highest point of graph
local function getArrays(statName, graphLength)
	local graphMax = 0
	for teamID = 1, #team do
		if team[teamID].show then
			local array = {}

			-- GetTeamStatsHistory() is synced so  being a spec or gameOver is required to work
			local engineID = team[teamID].id
			local stats = Spring.GetTeamStatsHistory(engineID, 0, graphLength)

			-- subtract one from graphlength to correct for delta (should do it a better way)
			for i=1, graphLength - 1 do
				array[i] = stats[i][statName]

				-- Gets difference between current index and the next
				if isDelta then
					array[i] = ( stats[i+1][statName] - array[i] )
				end

				-- Checks for highest value in the graph
				if ( array[i] > graphMax ) then
					graphMax = array[i]
				end

			end
			team[teamID].array = array
		end
	end

	return graphMax
end

------------------------
-- Starting point for graph drawing
--  when button is pressed, it graphs relevant stats
local function drawGraph(obj)

	-- if no obj is passed it recycles old graph (when options are toggled)
	local obj = obj or curGraph
	graphPanel:ClearChildren()
	lineLabels:ClearChildren()

	local graphLength = Spring.GetTeamStatsHistory(0) - 1 -- last index isn't complete

	if graphLength < 4 then
		Spring.Echo("End game Stats is still collecting data")
		return false
	end

	local gameStats = Spring.GetTeamStatsHistory(0, 0, graphLength - 1)
	local gameTime  = gameStats[graphLength - 1]['time']


	-- Sets title of graph and game time
	graphLabel:SetCaption(obj.caption)
	graphTime:SetCaption('Total Time: ' .. formatTime(gameTime))
	------------------------------------

	curGraph.caption = obj.caption
	curGraph.name    = obj.name

	local graphMax = getArrays(curGraph.name, graphLength)
	graphPanel.maxValue = graphMax
	graphPanel.time     = gameTime
	-- draws 5 lines across graph for reference
	if graphMax > 5 then drawIntervals(graphMax, gameTime) end

	-- Draws each teams relevant line
	for teamID = 1, #team do
		if team[teamID].show then
			drawLine(graphMax,teamID)
			labelLine(teamID)
		end
	end

	alignLabels()
end

------------------------
-- Fetches needed team info from engine
--  filters out inactive teams
--  Todo: handle multiple players per team (commander sharing)
local function getTeamInfo()
	for engineID = 0, (#Spring.GetTeamList() - 1) do

		-- All the needed info about players
		local _,teamLeader,_,isAI    = Spring.GetTeamInfo(engineID)
		local name, isActive, isSpec = Spring.GetPlayerInfo(teamLeader)
		local r,g,b,a                = Spring.GetTeamColor(engineID)
		local teamColor              = {r,g,b,a}

		-- Sets AI name to reflect AI used
		if isAI then
			local _,botID,_,shortName = Spring.GetAIInfo(engineID)
			name = botID ..' (' .. shortName .. ')'
		end

		if isActive then
			team[#team + 1] = {
				id    = engineID,
				color = teamColor,
				name  = name,
				show  = true, -- Toggled with checkbox
				array = {},
			}
		end

	end
end

-----------------------------------------------------------------------
-- Draws all the main elements which are later tailored
function loadWindow()
	local selW  = 150

	control0 = Chili.Control:New{
		x        = 0,
		y        = 0,
		right    = 0,
		bottom   = 0,
		padding  = {5,5,5,5},
	}

	graphSelect = Chili.StackPanel:New{
		width       = '100%',
		x           = 0,
		y           = 0,
		height      = 30,
		padding     = {0,0,0,0},
		itemPadding = {0,3,0,3},
		itemMargin  = {0,0,0,0},
		resizeItems = false,
		autosize    = true,
		preserveChildrenOrder = true,
	}

	graphPanel = Chili.Control:New{
		parent   = control0,
		maxValue = 0,
		time     = 0,
		x        = selW,
		y        = 40,
		right    = 40,
		bottom   = 0,
		tooltip  = '',
		OnMouseMove = {setTip},
	}

	Chili.ScrollPanel:New{
		parent    = control0,
		width     = selW,
		x         = 0,
		y         = 0,
		bottom    = '50%',
		children  = {graphSelect},
	}

	playerList = Chili.StackPanel:New{
		width       = '100%',
		x           = 0,
		y           = 0,
		height      = 30,
		padding     = {0,0,0,0},
		itemPadding = {0,0,0,0},
		itemMargin  = {0,0,0,0},
		resizeItems = false,
		autosize    = true,
		preserveChildrenOrder = true,
	}

	Chili.ScrollPanel:New{
		parent    = control0,
		width     = selW,
		x         = 0,
		y         = '50%',
		bottom    = 0,
		children  = {playerList},
	}


	lineLabels = Chili.Control:New{
		parent  = control0,
		right   = 0,
		width   = 40,
		y       = 20,
		bottom  = 0,
		padding = {0,0,0,0},
		OnResize = {resize},
	}

	graphLabel = Chili.Label:New{
		caption  = 'Wait a minute, collecting data',
		parent   = control0,
		x        = selW+5,
		right    = 0,
		y        = 0,
		font     = {size = 25},
	}

	graphTime = Chili.Label:New{
		parent  = control0,
		caption = '',
		y       = 0,
		right   = 60,
	}

	for a=1, #statName do
		button[a] = Chili.Button:New{
			parent  = graphSelect,
			name    = statName[a][1],
			caption = statName[a][2],
			width   = '100%',
			height  = 25,
			align   = "left",
			OnClick = {drawGraph},
		}
	end

	-- Adds players to Legend
	for teamID = 1, #team do
		Chili.Checkbox:New{
			parent   = playerList,
			teamID   = teamID,
			width    = '100%',
			x        = 0,
			height   = 20,
			caption  = team[teamID].name,
			font     = {color = team[teamID].color},
			OnChange = {
				function()
					team[teamID].show = not team[teamID].show
					if curGraph.name then
						drawGraph()
					end
				end
			},
		}
	end

	Chili.Checkbox:New{
		parent   = control0,
		caption  = 'Delta',
		y        = 25,
		x        = selW + 6,
		width    = 60,
		checked  = false,
		OnChange = {
			function()
				isDelta = not isDelta
				if curGraph.name then
					drawGraph()
				end
			end
		},
	}

	if WG.BarMenu then
		WG.BarMenu.AddControl('Graph', control0)
	else
		Chili.Button:New{
			parent = control0,
			caption = 'Quit',
			right = 0,
			y = 0,
			width = 50,
			height = 25,
			OnMouseUp = {
				function()
					Spring.SendCommands{'quit'}
				end
			},
		}
		Chili.Window:New{
			parent    = Chili.Screen0,
			x         = '20%',
			y         = '20%',
			right     = '20%',
			bottom    = '20%',
			draggable = true,
			resizable = true,
			children  = {control0},
		}
	end
end

function widget:Initialize()
	Spring.SendCommands('endgraph 0')
	Chili = WG.Chili

	if Spring.GetGameFrame() < 30 then
		return -- not started, wait for callin
	end

	getTeamInfo()
	if WG.BarMenu and speccing then
		loadWindow()
	end
end

function widget:GameStart()
	getTeamInfo()
	if WG.BarMenu and speccing then
		loadWindow()
	end
end

function widget:GameOver()
	if not (WG.BarMenu and speccing) then
		loadWindow()
		drawGraph(button[1])
	end
	
	if WG.BarMenu then
		drawGraph(button[1])
		WG.BarMenu.ShowHide('Graph')
	end
end

function widget:Shutdown()
	Spring.SendCommands('endgraph 1')
end
