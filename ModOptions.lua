local options= {
	{
		key    = 'startingresources',
		name   = 'Starting Resources',
		desc   = 'Sets storage and amount of resources that players will start with',
		type   = 'section',
	},
	{
		key    = 'startmetal',
		name   = 'Starting Metal',
		desc   = 'Determines amount of metal and metal storage that each player will start with',
		type   = 'number',
		section= 'startingresources',
		def    = 100,
		min    = 0,
		max    = 1000,
		step   = 1,  -- quantization is aligned to the def value
		-- (step <= 0) means that there is no quantization
	},
	{
		key    = 'startenergy',
		name   = 'Starting Energy',
		desc   = 'Determines amount of energy and energy storage that each player will start with',
		type   = 'number',
		section= 'startingresources',
		def    = 250,
		min    = 0,
		max    = 1000,
		step   = 1,  -- quantization is aligned to the def value
		-- (step <= 0) means that there is no quantization
	},
	
	{
		key    = 'gameplayoptions',
		name   = 'Gameplay Options',
		desc   = 'Sets storage and amount of resources that players will start with',
		type   = 'section',
	},
	{
		key="gameplayspeed",
		name="Gameplay Speed",
		desc="Modifies buildtimes based upon cost",
		type="list",
		def="faster",
		section="gameplayoptions",
		items={
			{key="normal", name="Normal", desc="Unit buildtimes are equal to their metal cost"},
			{key="fast", name="Fast", desc="Unit buildtimes are equal to their metal cost divided by 2"},
			{key="faster", name="Faster", desc="Unit buildtimes are equal to their metal cost divided by 4"},
			{key="fastest", name="Fastest", desc="All units have a buildtime of 5 seconds"},
		}
	},
	
	
	{
		key="aidifficulty",
		name="AI Difficulty",
		desc="Modifies how much Shard cheats",
		type="list",
		def="medium",
		section="gameplayoptions",
		items={
			{key="veryeasy", name="Very Easy", desc="AI gets a gift of 5 metal every 5 seconds and a static 5 energy income."},
			{key="easy", name="Easy", desc="AI gets a gift of 10 metal every 5 seconds and a static 10 energy income."},
			{key="medium", name="Medium", desc="AI gets a gift of 25 metal every 5 seconds and a static 25 energy income."},
			{key="hard", name="Hard", desc="AI gets a gift of 50 metal every 5 seconds and a static 50 energy income."},
			{key="insane", name="Insane", desc="AI gets a gift of 100 metal every 5 seconds and a static 100 energy income."},
		}
	},
	
}

return options