local CMD_BUILD = 10010
local CMD_RAMP = 39734
local CMD_LEVEL = 39736
local CMD_RAISE = 39737
local CMD_SMOOTH = 39738
local CMD_RESTORE = 39739
local CMD_EMBARK = 31800
local CMD_DISEMBARK = 31801
local CMD_RETREAT_ZONE = 10001
local CMD_RETREAT =	10000
local CMD_PRIORITY=34220
local CMD_STEALTH = 32100
local CMD_UNIT_AI = 36214
local CMD_AREA_MEX = 10100
local CMD_CLOAK_SHIELD = 32101

local factories = {
	ebasefactory = {order = 1},
	eamphibfac = {order = 2},
	eminifac = {order = 3},
	eairplant = {order = 4},
	eexperimentalfac = {order = 5},
}

--Integral menu is NON-ROBUST
--all buildings (except facs) need a row or they won't appear!
--also if you put too many things into the same row, the overflow won't be displayed!
local econ = {
	emetalextractor = {order = 1, row = 1},
	esolar2 = {order = 2, row = 2},
	egeothermal = {order = 3, row = 2},
	efusion2 = {order = 4, row = 2},
	emaker = {order = 5, row = 2},
	estorage = {order = 6, row = 2},
}

local defense = {
	elightturret2 = {order = 0, row = 1},
	eheavyturret2 = {order = 1, row = 1},
	eaaturret = {order = 2, row = 1},
	ebarricade = {order = 3, row = 1},
	eshieldgen = {order = 4, row = 1},
}

local aux = {	--merged into special
	eradar2 = {order = 10, row = 1},
	ejammer2 = {order = 11, row = 1},
}

local super = {	--merged into special
	elrpc = {order = 0, row = 2},
	esilo = {order = 1, row = 2},
}

--number doesn't mean anything
local common_commands = {
	[CMD.STOP]=1, [CMD.GUARD]=1, [CMD.ATTACK]=1, [CMD.FIGHT]=1,
	[CMD.WAIT]=2, [CMD.PATROL]=2, [CMD.MOVE]=2, 
	[CMD.REPAIR]=1,   [CMD.RECLAIM]=1, [CMD_BUILD] = 1, [CMD.CAPTURE] = 1, [CMD.RESURRECT] = 1, 
--	[CMD_LEVEL] =1, [CMD_RAMP]= 1, [CMD_RAISE] = 2, [CMD_SMOOTH] =2,  [CMD_RESTORE] =2,
	[CMD.SELFD]=1, [CMD.AUTOREPAIRLEVEL]=1,[CMD.DGUN]=1,
	[CMD_RETREAT_ZONE] = 2,
	[CMD_AREA_MEX] = 1,
}

--not needed; menu has autodetection
local states_commands = {

}

local factory_commands = {}
local econ_commands = {}
local defense_commands = {}
local special_commands = {
	[CMD_RAMP] = {order = 16, row = 3},
	[CMD_LEVEL] = {order = 17, row = 3},
	[CMD_RAISE] = {order = 18, row = 3},
	[CMD_SMOOTH] = {order = 19, row = 3},
	[CMD_RESTORE] = {order = 20, row = 3},
}

local function CopyBuildArray(source, target)
	for name, value in pairs(source) do
		udef = (UnitDefNames[name])
		if udef then
			target[-udef.id] = value
		end
	end
end

CopyBuildArray(factories, factory_commands)
CopyBuildArray(econ, econ_commands)
CopyBuildArray(aux, special_commands)
CopyBuildArray(defense, defense_commands)
CopyBuildArray(super, special_commands)

-- Global commands defined here - they have cmdDesc format + 
local globalCommands = {
--[[	{
		name = "crap",
		texture= 'LuaUi/Images/move_hold.png',
		id = math.huge,
		OnClick = {function() 
			Spring.SendMessage("crap")
		end }
	}
	{
		id      = CMD_RETREAT_ZONE
		type    = CMDTYPE.ICON_MAP,
		tooltip = 'Place a retreat zone. Units will retreat there. Constructors placed in it will repair units.',
		cursor  = 'Repair',
		action  = 'sethaven',
		params  = { }, 
		texture = 'LuaUI/Images/ambulance.png',
	}]]--
}

-- Command overrides. State commands by default expect array of textures, one for each state.
-- You can specify texture, text,tooltip, color
local overrides = {
	[CMD.ATTACK] = { texture = 'bitmaps/ui/buttons/cmd_attack.png',  text= '\255\0\255\0A\008ttack'},
	[CMD.STOP] = { texture = 'bitmaps/ui/buttons/cmd_stop.png', color={1,0,0,1.2}, text= '\255\0\255\0S\008top'},
	[CMD.FIGHT] = { texture = 'bitmaps/ui/buttons/cmd_fight.png',text= '\255\0\255\0F\008ight'},
	[CMD.GUARD] = { texture = 'bitmaps/ui/buttons/cmd_guard.png', text= '\255\0\255\0G\008uard'},
	[CMD.MOVE] = { texture = 'bitmaps/ui/buttons/cmd_move.png', text= '\255\0\255\0M\008ove'},
	[CMD.PATROL] = { texture = 'bitmaps/ui/buttons/cmd_patrol.png', text= '\255\0\255\0P\008atrol'},
	[CMD.WAIT] = { texture = 'bitmaps/ui/buttons/cmd_wait.png', text= '\255\0\255\0W\008ait'},
	
	[CMD.REPAIR] = {text= '\255\0\255\0R\008epair', texture = 'bitmaps/ui/buttons/cmd_repair.png'},
	[CMD.RECLAIM] = {text= 'R\255\0\255\0e\008claim', texture = 'bitmaps/ui/buttons/cmd_reclaim.png'},
--	[CMD.RESURRECT] = {text= 'Resurrec\255\0\255\0t\008', texture = 'bitmaps/ui/buttons/resurrect.png'},
	[CMD_BUILD] = {text = '\255\0\255\0B\008uild'},
	[CMD.DGUN] = { texture = 'bitmaps/ui/buttons/cmd_dgun.png', text= '\255\0\255\0D\008Gun'},
	
--	[CMD_RAMP] = {text = 'Ramp', texture = 'bitmaps/ui/buttons/ramp.png'},
--	[CMD_LEVEL] = {text = 'Level', texture = 'bitmaps/ui/buttons/level.png'},
--	[CMD_RAISE] = {text = 'Raise', texture = 'bitmaps/ui/buttons/raise.png'},
--	[CMD_SMOOTH] = {text = 'Smooth', texture = 'bitmaps/ui/buttons/smooth.png'},
	[CMD_RESTORE] = {text = 'Restore', texture = 'bitmaps/ui/buttons/cmd_restore.png'},
	
	[CMD_AREA_MEX] = {text = 'Mex', texture = 'bitmaps/ui/buttons/cmd_area_mex.png'},
	
	[CMD.ONOFF] = { texture = {'bitmaps/ui/buttons/cmd_off.png', 'bitmaps/ui/buttons/cmd_on.png'}, text=''},
	[CMD_UNIT_AI] = { texture = {'bitmaps/ui/buttons/bulb_off.png', 'bitmaps/ui/buttons/bulb_on.png'}, text=''},
	[CMD.REPEAT] = { texture = {'bitmaps/ui/buttons/cmd_repeatoff.png', 'bitmaps/ui/buttons/cmd_repeaton.png'}, text=''},
	[CMD.CLOAK] = { texture = {'bitmaps/ui/buttons/cmd_cloakstateoff.png', 'bitmaps/ui/buttons/cmd_cloakstateon.png'}, text ='', tooltip =  'Unit cloaking state - press \255\0\255\0K\008 to toggle'},
--	[CMD_CLOAK_SHIELD] = { texture = {'bitmaps/ui/buttons/areacloak_off.png', 'bitmaps/ui/buttons/areacloak_on.png'}, text ='',},
--	[CMD_STEALTH] = { texture = {'bitmaps/ui/buttons/stealth_off.png', 'bitmaps/ui/buttons/stealth_on.png'}, text ='', },
	[CMD_PRIORITY] = { texture = {'bitmaps/ui/buttons/cmd_prioritylow.png', 'bitmaps/ui/buttons/cmd_prioritymed.png', 'bitmaps/ui/buttons/cmd_priorityhigh.png'}, text='', tooltip = 'Set construction priority (high, normal, low)'},
	[CMD.MOVE_STATE] = { texture = {'bitmaps/ui/buttons/cmd_movestateholdposition.png', 'bitmaps/ui/buttons/cmd_movestatemaneuver.png', 'bitmaps/ui/buttons/cmd_movestateroam.png'}, text=''},
	[CMD.FIRE_STATE] = { texture = {'bitmaps/ui/buttons/cmd_firestateholdfire.png', 'bitmaps/ui/buttons/cmd_firestatereturnfire.png', 'bitmaps/ui/buttons/cmd_firestatefireatwill.png'}, text=''},
	[CMD_RETREAT] = { texture = {'bitmaps/ui/buttons/retreat_off.png', 'bitmaps/ui/buttons/retreat_30.png', 'bitmaps/ui/buttons/retreat_60.png', 'bitmaps/ui/buttons/retreat_90.png'}, text=''},
}

return common_commands, states_commands, factory_commands, econ_commands, defense_commands, special_commands, globalCommands, overrides