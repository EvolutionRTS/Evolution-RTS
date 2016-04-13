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
		def="veryeasy",
		section="gameplayoptions",
		items={
			{key="veryeasy", name="Very Easy", desc="AI gets a gift of 5 metal every 5 seconds and a static 5 energy income."},
			{key="easy", name="Easy", desc="AI gets a gift of 10 metal every 5 seconds and a static 10 energy income."},
			{key="medium", name="Medium", desc="AI gets a gift of 25 metal every 5 seconds and a static 25 energy income."},
			{key="hard", name="Hard", desc="AI gets a gift of 50 metal every 5 seconds and a static 50 energy income."},
			{key="insane", name="Insane", desc="AI gets a gift of 100 metal every 5 seconds and a static 100 energy income."},
		}
	},
	{
		key="scoremode",
		name="Scoring Mode (Control Victory Points)",
		desc="Defines how the game is played",
		type="list",
		def="countdown",
		section="gameplayoptions",
		items={
			{key="disabled", name="Disabled", desc="Disable Control Points as a victory condition."},
			{key="countdown", name="Countdown", desc="A Control Point decreases all opponents' scores, zero means defeat."},
			{key="tugowar", name="Tug of War", desc="A Control Point steals enemy score, zero means defeat."},
			{key="multidomination", name="Domination", desc="Holding all Control Points will grant 100 score, first to reach the score limit wins."},
		}
	},
	{
		key    = 'controlvictoryoptions',
		name   = 'Control Victory Options',
		desc   = 'Allows you to control at a granular level the individual options for Control Point Victory',
		type   = 'section',
	},
	
	{
		key    = 'limitscore',
		name   = 'Total Score',
		desc   = 'Total score amount available.',
		type   = 'number',
		section= 'controlvictoryoptions',
		def    = 3500,
		min    = 500,
		max    = 5000,
		step   = 1,  -- quantization is aligned to the def value
		-- (step <= 0) means that there is no quantization
	},
	{
		key    = 'captureradius',
		name   = 'Capture Radius',
		desc   = 'Radius around a point in which to capture it.',
		type   = 'number',
		section= 'controlvictoryoptions',
		def    = 500,
		min    = 100,
		max    = 1000,
		step   = 25,  -- quantization is aligned to the def value
		-- (step <= 0) means that there is no quantization
	},
		{
		key    = 'capturetime',
		name   = 'Capture Time',
		desc   = 'Time to capture a point.',
		type   = 'number',
		section= 'controlvictoryoptions',
		def    = 30,
		min    = 1,
		max    = 60,
		step   = 1,  -- quantization is aligned to the def value
		-- (step <= 0) means that there is no quantization
	},
		{
		key    = 'capturebonus',
		name   = 'Capture Bonus',
		desc   = 'How much faster capture takes place by adding more units.',
		type   = 'number',
		section= 'controlvictoryoptions',
		def    = 0.5,
		min    = 0,
		max    = 10,
		step   = 0.1,  -- quantization is aligned to the def value
		-- (step <= 0) means that there is no quantization
	},
		{
		key    = 'decapspeed',
		name   = 'De-Cap Speed',
		desc   = 'Speed multiplier for neutralizing an enemy point.',
		type   = 'number',
		section= 'controlvictoryoptions',
		def    = 3,
		min    = 0.1,
		max    = 10,
		step   = 0.1,  -- quantization is aligned to the def value
		-- (step <= 0) means that there is no quantization
	},
		{
		key    = 'starttime',
		name   = 'Start Time',
		desc   = 'The time when capturing can start.',
		type   = 'number',
		section= 'controlvictoryoptions',
		def    = 0,
		min    = 0,
		max    = 300,
		step   = 1,  -- quantization is aligned to the def value
		-- (step <= 0) means that there is no quantization
	},
		{
		key    = 'dominationscoretime',
		name   = 'Domination Score Time',
		desc   = 'Time needed holding all points to score in multi domination.',
		type   = 'number',
		section= 'controlvictoryoptions',
		def    = 30,
		min    = 1,
		max    = 60,
		step   = 1,  -- quantization is aligned to the def value
		-- (step <= 0) means that there is no quantization
	},
}

return options