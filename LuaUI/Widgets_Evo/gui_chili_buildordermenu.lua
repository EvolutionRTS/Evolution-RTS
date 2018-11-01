function widget:GetInfo()
    return {
        version   = "0.1",
        name      = "chiliBuildOrderMenu",
        desc      = "Build/Order menu implemented with chili ui",
        author    = "Adrianulima",
        date      = "WIP",
        license   = "GNU GPL, v2 or later",
        layer     = 1,
        enabled   = true, --false,
        handler   = true,
    }
end
--------------------------------------------------------------------------------
-- Localize
local sForceLayoutUpdate = Spring.ForceLayoutUpdate
local sSetActiveCommand = Spring.SetActiveCommand
local sGetCmdDescIndex = Spring.GetCmdDescIndex
local sGetActiveCommand = Spring.GetActiveCommand
local sGetWindowGeometry = Spring.GetWindowGeometry

local stringfind = string.find
local stringsub = string.sub
local stringgsub = string.gsub
local mathceil = math.ceil
local mathmax = math.max
local mathmin = math.min

local glGetTextWidth = gl.GetTextWidth

-- Chili classes
local Chili, Window, Image, Button, Grid, Label, ScrollPanel, color2incolor

-- Global vars
local orderWindow, buildWindow, orderGrid, buildGrid, updateRequired, tooltip, btWidth
local chiliCache = {}
local vsx, vsy = sGetWindowGeometry()

local buildOrderUI = Spring.GetConfigInt("evo_buildorderui", 0) or 0

if buildOrderUI == 0 or buildOrderUI == nil then
	Config = {
		ordermenu = {
			name = 'ordermenu',
			rows = 13, columns = 2,
			x = '0%', y = '35%',
			width = '50%', height = '50%',
			orientation = 'horizontal',
			maxWidth = 390,
			padding = {5, 5, 5, 5},     -- outer panel
		},
		buildmenu = {
			name = 'buildmenu',
			rows = 2, columns = 10,
			x = '21.2%', y = '66%',
			width = '60%', height = '20%',
			orientation = 'horizontal',
			--maxWidth = 420,
			padding = {5, 5, 5, 5},
		},
		labels = {
			captionFontMaxSize = 12,
			queueFontSize = 12, --32 (MaDDoX)
			costFontSize = 12,
			showMetalCost = true,
			showEnergyCost = true, --true
		},
		hiddenCMDs = {
			timewait = true, deathwait = true, squadwait = true, gatherwait = true,
			loadonto = true, selfd = false, settargetnoground = true,
		},
	}
end

if buildOrderUI == 1 then
	Config = {
		ordermenu = {
			name = 'ordermenu',
			rows = 13, columns = 2,
			x = '0%', y = '35%',
			width = '50%', height = '50%',
			orientation = 'horizontal',
			maxWidth = 390,
			padding = {5, 5, 5, 5},     -- outer panel
		},
		buildmenu = {
			name = 'buildmenu',
			rows = 3, columns = 10,
			x = '32%', y = '66%',
			width = '40%', height = '15%',
			orientation = 'horizontal',
			--maxWidth = 420,
			padding = {5, 5, 5, 5},
		},
		labels = {
			captionFontMaxSize = 12,
			queueFontSize = 12, --32 (MaDDoX)
			costFontSize = 12,
			showMetalCost = true,
			showEnergyCost = true, --true
		},
		hiddenCMDs = {
			timewait = true, deathwait = true, squadwait = true, gatherwait = true,
			loadonto = true, selfd = false, settargetnoground = true,
		},
	}
end

if buildOrderUI == 2 then
	Config = {
		ordermenu = {
			name = 'ordermenu',
			rows = 13, columns = 2,
			x = '0%', y = '35%',
			width = '50%', height = '50%',
			orientation = 'horizontal',
			maxWidth = 390,
			padding = {5, 5, 5, 5},     -- outer panel
		},
		buildmenu = {
			name = 'buildmenu',
			rows = 7, columns = 5,
			x = '21%', y = '35%',
			width = '50%', height = '50%',
			orientation = 'horizontal',
			maxWidth = 390,
			padding = {5, 5, 5, 5},
		},
		labels = {
			captionFontMaxSize = 12,
			queueFontSize = 12, --32 (MaDDoX)
			costFontSize = 12,
			showMetalCost = true,
			showEnergyCost = true, --true
		},
		hiddenCMDs = {
			timewait = true, deathwait = true, squadwait = true, gatherwait = true,
			loadonto = true, selfd = false, settargetnoground = true,
		},
	}
end

if buildOrderUI == 3 then
	Config = {
		ordermenu = {
			name = 'ordermenu',
			rows = 13, columns = 2,
			x = '0%', y = '35%',
			width = '50%', height = '50%',
			orientation = 'horizontal',
			maxWidth = 390,
			padding = {5, 5, 5, 5},     -- outer panel
		},
		buildmenu = {
			name = 'buildmenu',
			rows = 7, columns = 5,
			x = '79.75%', y = '35%',
			width = '50%', height = '50%',
			orientation = 'horizontal',
			maxWidth = 390,
			padding = {5, 5, 5, 5},
		},
		labels = {
			captionFontMaxSize = 12,
			queueFontSize = 12, --32 (MaDDoX)
			costFontSize = 12,
			showMetalCost = true,
			showEnergyCost = true, --true
		},
		hiddenCMDs = {
			timewait = true, deathwait = true, squadwait = true, gatherwait = true,
			loadonto = true, selfd = false, settargetnoground = true,
		},
	}
end

if buildOrderUI == 4 then
	Config = {
		ordermenu = {
			name = 'ordermenu',
			rows = 13, columns = 2,
			x = '0%', y = '35%',
			width = '50%', height = '50%',
			orientation = 'horizontal',
			maxWidth = 390,
			padding = {5, 5, 5, 5},     -- outer panel
		},
		buildmenu = {
			name = 'buildmenu',
			rows = 7, columns = 5,
			x = '85%', y = '35%',
			width = '15%', height = '30%',
			orientation = 'horizontal',
			padding = {5, 5, 5, 5},
		},
		labels = {
			captionFontMaxSize = 12,
			queueFontSize = 12, --32 (MaDDoX)
			costFontSize = 12,
			showMetalCost = true,
			showEnergyCost = true, --true
		},
		hiddenCMDs = {
			timewait = true, deathwait = true, squadwait = true, gatherwait = true,
			loadonto = true, selfd = false, settargetnoground = true,
		},
	}
end

--------------------------------------------------------------------------------
-- Helpers
local function deepEquals(t1, t2, ignore_mt)
    if t1 == t2 then return true end
    local ty1 = type(t1)
    local ty2 = type(t2)
    if ty1 ~= ty2 then return false end
    -- non-table types can be directly compared
    if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
    -- as well as tables which have the metamethod __eq
    local mt = getmetatable(t1)
    if not ignore_mt and mt and mt.__eq then return t1 == t2 end
    for k1,v1 in pairs(t1) do
        local v2 = t2[k1]
        if v2 == nil or not deepEquals(v1, v2) then return false end
    end
    for k2,v2 in pairs(t2) do
        local v1 = t1[k2]
        if v1 == nil or not deepEquals(v1, v2) then return false end
    end
    return true
end --deepEquals

local function processRelativeCoord(code, total)
    local num = tonumber(code)
    if (type(code) == "string") then
        local percent = tonumber(code:sub(1,-2)) or 0
        if (percent<0) then
            percent = 0
        elseif (percent>100) then
            percent = 100
        end
        return math.floor(total * percent/100)
    elseif (num)and((1/num)<0) then
        return math.floor(total + num)
    else
        return math.floor(num or 0)
    end
end --processRelativeCoord

local function createGridWindow(config)
    local scroll =  ScrollPanel:New{
        name = 'scroll_' .. config.name,
        x = '0%', y = '0%',
        width = '100%', height = '100%',
        padding = config.padding,
    }
    local grid = Grid:New{
        name = 'grid_' .. config.name,
        x = '0%', y = '0%',
        width = '100%', height = '100%',
        rows = config.rows,
        columns = config.columns,
        orientation = config.orientation,
        padding = {0, 0, 0, 0},
    }
    local gridWindow = Window:New{
        name = 'window_' .. config.name,
        parent = Chili.Screen0,
        x = config.x, y = config.y,
        height = config.height, width = config.width,
        maxWidth = config.maxWidth,
        children = {grid},
        bringToFrontOnClick = false, dockable = false, draggable = false,
        resizable = false, tweakDraggable = true, tweakResizable = false,
        padding = config.padding,
    }

    local function updateGrid()
        local rowsNeeded = mathceil(#grid.children / grid.columns)
        if rowsNeeded > grid.rows then
            local ratio = (gridWindow.height / config.rows) / (gridWindow.width / config.columns)
            grid:SetPos(nil, nil, nil, (grid.width / grid.columns) * ratio * rowsNeeded)
            grid.rows = rowsNeeded
            if grid.parent and grid.parent.name == gridWindow.name then
                gridWindow:RemoveChild(grid)
                gridWindow:AddChild(scroll)
                scroll:AddChild(grid)
            end
        elseif rowsNeeded <= config.rows then
            grid:SetPos(nil, nil, nil, gridWindow.height - gridWindow.padding[2] - gridWindow.padding[4])
            grid.rows = config.rows
            if scroll.parent and scroll.parent.name == gridWindow.name then
                scroll:RemoveChild(grid)
                gridWindow:RemoveChild(scroll)
                gridWindow:AddChild(grid)
            end
        end
    end

    grid.updateGrid = updateGrid
    gridWindow:Hide()
    return grid, gridWindow
end --createGridWindow

local function applyHighlightHandler(button, cmd)
    local selected = {0.85, 0.65, 0, 0.5}
    local hovered = {0.75, 0.75, 0.75, 0.25}
    local out = {0, 0, 0, 0}
    local disabled = {0, 0, 0, 0.6}

    local highlight = chiliCache['highlight' .. button.cmdID] or Image:New{
        name = 'highlight' .. button.cmdID,
        parent = button,
        file   = 'LuaUI/Images/button-highlight.dds',
        width = '100%', height = '100%',
        fixedRatio = false, keepAspect = false,
        color = out,
    }
    chiliCache['highlight' .. button.cmdID] = highlight
    local function updateSelection(cmdID)
        local function checkColor(color)
            if highlight.color ~= color then
                highlight.color = color
                highlight:Invalidate()
            end
        end

        if cmd.disabled then
            checkColor(disabled)
            if button.state.hovered then
                tooltip = stringgsub(cmd.tooltip, "Metal cost %d*\nEnergy cost %d*\n", "")
            end
        elseif button.cmdID == cmdID then checkColor(selected)
        elseif button.state.hovered then
            tooltip = stringgsub(cmd.tooltip, "Metal cost %d*\nEnergy cost %d*\n", "")
            checkColor(hovered)
        else checkColor(out)
        end
    end
    button.updateSelection = updateSelection
    updateSelection()
    return button
end --applyHighlightHandler

local function applyStateHandler(button, cmd)
    local stateCount = #cmd.params - 1
    local state = cmd.params[1] + 1

    local function curve(c) return -0.5 * c * (c - 4) end -- makes yellow more vivid
    local function getStateColor(i)
        local g = (i - 1) / (stateCount - 1)
        return (i == state) and {curve(1 - g), curve(g), 0, 1} or {0.9, 0.9, 0.9, 0.3}
    end

    local stateButtons = {}
    for i = 1, stateCount do
        local pad = 7
        local sx = (100 - pad * (stateCount + 3)) / stateCount
        local px = pad + i * pad + (i - 1) * sx
        stateButtons[i] = chiliCache['stateButton_' .. cmd.id .. '_' .. i] or Image:New{
            name = 'stateButton_' .. cmd.id .. '_' .. i,
            parent = button,
            file   = 'LuaUI/Images/button-highlight.dds',
            x = px .. '%', y = '75%',
            width = sx .. '%', maxHeight = 6,
            keepAspect = false,
            color = getStateColor(i),
        }
        chiliCache['stateButton_' .. cmd.id .. '_' .. i] = stateButtons[i]
    end
    local oldUpdateSelection = button.updateSelection
    local function updateSelection(cmdID)
        oldUpdateSelection(cmdID)
        for i = 1, stateCount do stateButtons[i].color = getStateColor(i) end
    end
    button.updateSelection = updateSelection
    return button
end --applyStateHandler
--------------------------------------------------------------------------------
local function InitializeControls()
    orderGrid, orderWindow = createGridWindow(Config.ordermenu)
    buildGrid, buildWindow = createGridWindow(Config.buildmenu)
end --InitializeControls

local function ActionCommand(self, x, y, mouse, mods)
    local index = sGetCmdDescIndex(self.cmdID)
    if index then
        local left, right = mouse == 1, mouse == 3
        local alt, ctrl, meta, shift = mods.alt, mods.ctrl, mods.meta, mods.shift
        sSetActiveCommand(index, mouse, left, right, alt, ctrl, meta, shift)
    end
end --ActionCommand

local function addOrderCommand(cmd)
    local button = chiliCache['button' .. cmd.id] or Button:New{
        name = 'button' .. cmd.id,
        --parent = orderGrid,
        cmdID = cmd.id,
        caption = cmd.name,
        textPadding = 9, --8, (MaDDoX)
        padding = {0, 0, 0, 0},
        margin = {2, 2, 2, 2},
        OnMouseUp = {ActionCommand},
    }
    if cmd.name == "Repair" then button:SetCaption("Build")
    else button:SetCaption(cmd.name) end
    chiliCache['button' .. cmd.id] = button
    local s = (btWidth - button.textPadding * 2) / glGetTextWidth(button.caption)
    button.font:SetSize(mathmin(s, Config.labels.captionFontMaxSize))
    applyHighlightHandler(button, cmd)
    orderGrid:AddChild(button)
end --addOrderCommand

local function addStateCommand(cmd)
    local button = chiliCache['button' .. cmd.id] or Button:New{
        name = 'button' .. cmd.id,
        cmdID = cmd.id,
        caption = cmd.params[cmd.params[1] + 2],
        textPadding = 12, --8,
        padding = {0, 0, 0, 0},
        margin = {2, 2, 2, 2},
        OnMouseUp = {ActionCommand},
    }
    button:SetCaption(cmd.params[cmd.params[1] + 2])
    chiliCache['button' .. cmd.id] = button
    local s = (btWidth - button.textPadding * 2) / glGetTextWidth(button.caption)
    button.font:SetSize(mathmin(s, Config.labels.captionFontMaxSize))
    applyHighlightHandler(button, cmd)
    applyStateHandler(button, cmd)
    orderGrid:AddChild(button)
end --addStateCommand

local function addBuildCommand(cmd)
    local image = chiliCache['button' .. cmd.id] or Image:New{
        name = 'button' .. cmd.id,
        cmdID = cmd.id,
        width = '100%', height = '100%',
        file = '#' .. cmd.id * -1,
        padding = {0, 0, 0, 0},
        margin = {2, 2, 2, 2},
        OnClick = {ActionCommand},
    }
    chiliCache['button' .. cmd.id] = image

    if cmd.params[1] then
        if (not chiliCache['queueLabel' .. cmd.id]) then
            chiliCache['queueLabel' .. cmd.id] = Label:New{
                name = 'queueLabel' .. cmd.id,
                parent = image,
                right = '5%', y = '5%',
                align = 'right',
                valign = 'top',
                --caption = tostring(cmd.params[1] or ''),
                font = {
                    size = Config.labels.queueFontSize,
                    outline = true, shadow  = true,
                    outlineWidth  = 4, outlineWeight = 4,
                },
            }
        end
    end
    if chiliCache['queueLabel' .. cmd.id] then
        chiliCache['queueLabel' .. cmd.id]:SetCaption(tostring(cmd.params[1] or ''))
    end

    if not cmd.disabled and (Config.labels.showMetalCost or Config.labels.showEnergyCost) then
        local s, e, metalCost, energyCost, line = 0, 0, '', '', '\n'
        if Config.labels.showMetalCost then
            s, e = stringfind(cmd.tooltip, 'Metal cost %d*')
            metalCost = color2incolor(0.53,0.77,0.89) .. stringsub(cmd.tooltip, s + 11, e)
        else line = '' end
        if Config.labels.showEnergyCost then
            s, e = stringfind(cmd.tooltip, 'Energy cost %d*')
            energyCost = color2incolor(1,1,0) .. stringsub(cmd.tooltip, s + 12, e)
        else line = '' end
        if (not chiliCache['costLabel' .. cmd.id]) then
            chiliCache['costLabel' .. cmd.id] = Label:New{
                name = 'costLabel' .. cmd.id,
                parent = image,
                x = '5%', bottom = '5%',
                valign = 'bottom',
                --caption = metalCost .. line .. energyCost,
                font = {
                    size = Config.labels.costFontSize,
                    outline = true, shadow  = true,
                    outlineWidth  = 4, outlineWeight = 4,
                },
            }
        end
        chiliCache['costLabel' .. cmd.id]:SetCaption(metalCost .. line .. energyCost)
    end

    applyHighlightHandler(image, cmd)
    buildGrid:AddChild(image)
    end --addBuildCommand

local function processCommand(cmd)
    if UnitDefNames[cmd.name] then return 3
    elseif #cmd.params > 1 then return 1
    else return 2 end
end --processCommand

local lastCommands
local function processAllCommands()
    if (deepEquals(lastCommands, widgetHandler.commands)) then
     return
    end
    lastCommands = widgetHandler.commands

    buildGrid:ClearChildren()
    orderGrid:ClearChildren()
    --chiliCache = {} -- clears all cached chili elements

    local haveCmd = 0
    local commands = { [1] = {}, [2] = {}, [3] = {} }
    for _,cmd in ipairs(lastCommands) do
        if cmd.name ~= '' and not (Config.hiddenCMDs[cmd.name] or Config.hiddenCMDs[cmd.action]) then
            local grid = processCommand(cmd)
            haveCmd = mathmax(haveCmd, grid)
            commands[grid][#commands[grid]+1] = cmd
        end
    end

    local gridFunc = { [1] = addStateCommand, [2] = addOrderCommand, [3] = addBuildCommand }
    for grid,cmds in ipairs(commands) do
        for i = 1, #cmds do gridFunc[grid](cmds[i]) end
    end

    orderGrid.updateGrid()
    buildGrid.updateGrid()

    if haveCmd > 0 and orderWindow.hidden then orderWindow:Show()
    elseif haveCmd == 0 and orderWindow.visible then orderWindow:Hide() end
    if haveCmd > 2 and buildWindow.hidden then buildWindow:Show()
    elseif haveCmd <= 2 and buildWindow.visible then buildWindow:Hide() end
end --processAllCommands

local function updateSelection()
    tooltip = nil
    local _,cmdID = sGetActiveCommand()
    for _, bt in ipairs(buildGrid.children) do
        if bt.updateSelection then bt.updateSelection(cmdID) end
    end
    for _, bt in ipairs(orderGrid.children) do
        if bt.updateSelection then bt.updateSelection(cmdID) end
    end
end --updateSelection

local function OverrideDefaultMenu()
    local function layoutHandler(xIcons, yIcons, cmdCount, commands)
        widgetHandler.commands = commands
        widgetHandler.commands.n = cmdCount
        widgetHandler:CommandsChanged()
        local customCmds = widgetHandler.customCommands
        return '', xIcons, yIcons, {}, customCmds, {}, {}, {}, {}, {}, {[1337]=9001}
    end
    widgetHandler:ConfigLayoutHandler(layoutHandler)
    sForceLayoutUpdate()
end --OverrideDefaultMenu
--------------------------------------------------------------------------------
function widget:Initialize()
    if not WG.Chili then
        widgetHandler:RemoveWidget()
        return
    end
    OverrideDefaultMenu()

    Chili = WG.Chili
    Window = Chili.Window
    Grid = Chili.Grid
    Image = Chili.Image
    Button = Chili.Button
    Label = Chili.Label
    ScrollPanel = Chili.ScrollPanel
    color2incolor = Chili.color2incolor

    btWidth = processRelativeCoord(Config.ordermenu.width, vsx/Config.ordermenu.columns)

    InitializeControls()
end --Initialize

function widget:CommandsChanged()
    updateRequired = true
end --CommandsChanged

function widget:Update()
    if updateRequired then
        processAllCommands()
        updateRequired = false
    end
    updateSelection()
end --Update

function widget:WorldTooltip(ttType,data1,data2,data3)
    return tooltip
end --WorldTooltip

function widget:ViewResize(newX,newY)
    -- TODO: implement config for this resize and make a reusable helper function to handle it
    Config.buildmenu.height = buildWindow.width * (Config.buildmenu.rows / Config.buildmenu.columns)
    buildWindow:SetPos(nil, nil, nil,Config.buildmenu.height)
end --ViewResize

function widget:Shutdown()
    orderWindow:Dispose()
    buildWindow:Dispose()
    widgetHandler:ConfigLayoutHandler(nil)
    chiliCache = nil
    sForceLayoutUpdate()
end --Shutdown
