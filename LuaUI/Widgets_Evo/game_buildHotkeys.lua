function widget:GetInfo()
	return {
	version   = "1.0",
	name      = "EvoRTS Build Hotkeys",
	desc      = "Use hotkeys to build units",
	author    = "CommonPlayer",
	date      = "5 Oct 2018",
	license   = "GNU GPL, v2 or later",
	layer     = 0,
	enabled   = false,
	handler   = true, --can use widgetHandler:x()
	}
end

-- first look through nameToKeyCode, then use the key to find ud
local nameToKeyCode = {
	elighttank3 = {98, 113},
	etech1 = {98, 97},
}

-- Taken from gui_red_buildordermenu
local sGetSelectedUnitsCount = Spring.GetSelectedUnitsCount
local sGetActiveCmdDescs = Spring.GetActiveCmdDescs
local ssub = string.sub

local function GetCommands()
	local hiddencmds = {
		[76] = true, --load units clone
		[65] = true, --selfd
		[9] = true, --gatherwait
		[8] = true, --squadwait
		[7] = true, --deathwait
		[6] = true, --timewait
		[39812] = true, --raw move
		[34922] = true, -- set unit target
		--[34923] = true, -- set target
	}
	local buildcmds = {}
	local statecmds = {}
	local othercmds = {}
	local buildcmdscount = 0
	local statecmdscount = 0
	local othercmdscount = 0
	for index,cmd in pairs(sGetActiveCmdDescs()) do
		if (type(cmd) == "table") then
			if (
			(not hiddencmds[cmd.id]) and
			(cmd.action ~= nil) and
			--(not cmd.disabled) and
			(not widgetHandler.commands[index].hidden) and --apparently GetActiveCmdDescs is bugged and returns hidden for every command
			(cmd.type ~= 21) and
			(cmd.type ~= 18) and
			(cmd.type ~= 17)
			) then
				if (((cmd.type == 20) --build building
				or (ssub(cmd.action,1,10) == "buildunit_"))) then
					buildcmdscount = buildcmdscount + 1
					buildcmds[buildcmdscount] = cmd
				elseif (cmd.type == 5) then
					statecmdscount = statecmdscount + 1
					statecmds[statecmdscount] = cmd
				else
					othercmdscount = othercmdscount + 1
					othercmds[othercmdscount] = cmd
				end
			end
		end
	end
	local tempcmds = {}
	for i=1,statecmdscount do
		tempcmds[i] = statecmds[i]
	end
	for i=1,othercmdscount do
		tempcmds[i+statecmdscount] = othercmds[i]
	end
	othercmdscount = othercmdscount + statecmdscount
	othercmds = tempcmds
	
	return buildcmds,othercmds
end

local sPlaySoundFile = Spring.PlaySoundFile
local sGetModKeyState = Spring.GetModKeyState
local sGetCmdDescIndex = Spring.GetCmdDescIndex
local sSetActiveCommand = Spring.SetActiveCommand

local updateCommands = false
local buildOptions = {}
local lengBuildOptions = 0

function widget:CommandsChanged()
	updateCommands = true
end
function widget:Update(dt)
	if updateCommands then
		updateCommands = false
		lengKeysPressed = 0
		keysPressed = {}
		
		buildOptions = {}
		lengBuildOptions = 0
		local buildcmds, othercmds = GetCommands()
		for i = 1, #buildcmds do
			if nameToKeyCode[buildcmds[i].name] then
				lengBuildOptions = lengBuildOptions + 1
				buildOptions[lengBuildOptions] = {
					keyCode = nameToKeyCode[buildcmds[i].name],
					id = buildcmds[i].id
				}
			end
		end
	end
end

local lengKeysPressed = 0
local keysPressed = {}
function widget:KeyPress(key, mods, isRepeat)
	if key == 304 or key == 306 or key == 308 then return false end -- shift, ctrl, alt keys
	lengKeysPressed = lengKeysPressed + 1
	keysPressed[lengKeysPressed] = key

	local lengMatches = 0
	local matches = {}
	for i = 1, lengBuildOptions do
		local getKeyCode = buildOptions[i].keyCode
		local lengKeyCode = #getKeyCode
		if lengKeyCode >= lengKeysPressed then
			local match = true
			for j = 1, lengKeysPressed do
				if keysPressed[j] ~= getKeyCode[j] then
					match = false
					break
				end
			end
			if match then
				lengMatches = lengMatches + 1
				matches[lengMatches] = {id = buildOptions[i].id, sameLeng = lengKeyCode == lengKeysPressed}
			end
		end
	end
	if matches[1] then
		for i = 1, lengMatches do
			if matches[i].sameLeng then
				-- if playSounds then
				-- 	sPlaySoundFile(sound_queue_add, 0.75, 'ui')
				-- end
				local alt, ctrl, meta, shift = sGetModKeyState()
				local index = sGetCmdDescIndex(matches[i].id)
				sSetActiveCommand(index, 1, true, false, alt, ctrl, meta, shift)
				keysPressed[lengKeysPressed] = nil
				lengKeysPressed = lengKeysPressed - 1 -- so you can B + Q + Q + Q to spam units
				return true
			end
		end
	else -- reset
		lengKeysPressed = 0
		keysPressed = {}
	end
	return false
end

function widget:MousePress(x, y, button)
	-- reset on left click or right click (button = 2 for clicking mouse wheel because ???)
	--if button == 1 or button == 3 then building = -1 end
	if button == 1 or button == 3 then
		lengKeysPressed = 0
		keysPressed = {}
	end
	return false
end
