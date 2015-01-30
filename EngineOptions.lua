--  Custom Options Definition Table format

--  NOTES:
--  - using an enumerated table lets you specify the options order

--
--  These keywords must be lowercase for LuaParser to read them.
--
--  key:      the string used in the script.txt
--  name:     the displayed name
--  desc:     the description (could be used as a tooltip)
--  type:     the option type
--  def:      the default value
--  min:      minimum value for number options
--  max:      maximum value for number options
--  step:     quantization step, aligned to the def value
--  maxlen:   the maximum string length for string options
--  items:    array of item strings for list options
--  scope:    'global', 'player', 'team', 'allyteam'
--

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  Example EngineOptions.lua
--

local options =
{
	{
		key    = 'engineoptions',
		name   = 'Engine Options',
		desc   = 'Limits maximum and minimum speed that the players will be allowed to change to',
		type   = 'section',
	},
	{
		key    = 'maxunits',
		name   = 'Max units',
		desc   = 'Maximum number of units (including buildings) for each team allowed at the same time',
		type   = 'number',
		section= 'engineoptions',
		def    = 5000,
		min    = 100,
		max    = 5000, --- engine caps at lower limit if more than 3 team are ingame
		step   = 1,  -- quantization is aligned to the def value
		-- (step <= 0) means that there is no quantization
	},
	{
		key    = 'ghostedbuildings',
		name   = 'Ghosted buildings',
		desc   = "Once an enemy building will be spotted\na ghost trail will be placed to memorize location even after the loss of the line of sight",
		type   = 'bool',
		section= 'engineoptions',
		def    = true,
	},
	{
		key    = 'fixedallies',
		name   = 'Fixed ingame alliances',
		desc   = 'Disables the possibility of players to dynamically change alliances ingame',
		type   = 'bool',
		section= 'engineoptions',
		def    = false,
	},
	{
		key    = 'disablemapdamage',
		name   = 'Undeformable map',
		desc   = 'Prevents the map shape from being changed by weapons',
		type   = 'bool',
		section= 'engineoptions',
		def    = false,
	},

	{
		key    = 'limitspeed',
		name   = 'Speed Restriction',
		desc   = 'Limits maximum and minimum speed that the players will be allowed to change to',
		type   = 'section',
	},

	{
		key    = 'maxspeed',
		name   = 'Maximum game speed',
		desc   = 'Sets the maximum speed that the players will be allowed to change to',
		type   = 'number',
		section= 'limitspeed',
		def    = 1,
		min    = 0.1,
		max    = 100,
		step   = 0.1,  -- quantization is aligned to the def value
		-- (step <= 0) means that there is no quantization
	},

	{
		key    = 'minspeed',
		name   = 'Minimum game speed',
		desc   = 'Sets the minimum speed that the players will be allowed to change to',
		type   = 'number',
		section= 'limitspeed',
		def    = 1,
		min    = 0.1,
		max    = 100,
		step   = 0.1,  -- quantization is aligned to the def value
		-- (step <= 0) means that there is no quantization
	},
	--[[
	-- the following options can create problems and were never used by interface programs, thus are commented out for the moment

	{
		key    = 'NoHelperAIs',
		name   = 'Disable helper AIs',
		desc   = 'Disables luaui ai usage for all players',
		type   = 'bool',
		def    = false,
	},
	--]]
}

return options
