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

-- ASCII: a is 97, z is 122
local building = -1 -- -1 = not building, 0 = B + *, 1 = N + *, 2 = N + N + *
local buildStartKey = 98 -- B, for B + *
local buildNextKey = 110 -- N, for N + *, N + N + *
-- Q W E R T, A S D F G, Z X C V B
local buildKeys = { -- mapping keys to the correct indices
	[113] = 1,
	[119] = 2,
	[101] = 3,
	[114] = 4,
	[116] = 5,
	
	[97] = 6,
	[115] = 7,
	[100] = 8,
	[102] = 9,
	[103] = 10,
	
	[122] = 11,
	[120] = 12,
	[99] = 13,
	[118] = 14,
	[98] = 15,
}
--local buildLetters = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}

function widget:KeyPress(key, mods, isRepeat)
	if building ~= -1 then
		if building == 1 and key == buildNextKey then
			building = 2 -- N + N + *
			return true
		end
		
		local buildcmds, othercmds = GetCommands()
		local found = buildKeys[key]
		if found then
			found = found + 15 * building
			if buildcmds[found] ~= nil then
				if playSounds then
					Spring.PlaySoundFile(sound_queue_add, 0.75, 'ui')
				end
				Spring.SetActiveCommand(Spring.GetCmdDescIndex(buildcmds[found].id),1,true,false,Spring.GetModKeyState())
			end
		end
		building = -1
		return true
	else
		-- this prevents keys to be captured when you cannot build anything
		local buildcmds = GetCommands()
		if #buildcmds == 0 then return false end
		
		if key == buildStartKey then
			building = 0 -- B + *
			return true
		elseif key == buildNextKey then
			building = 1 -- N + *
			return true
		end
	end
	return false
end
