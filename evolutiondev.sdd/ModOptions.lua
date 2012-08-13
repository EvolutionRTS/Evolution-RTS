local options= {
  {
    key    = 'StartingResources',
    name   = 'Starting Resources',
    desc   = 'Sets storage and amount of resources that players will start with',
    type   = 'section',
  },
  {
    key    = 'StartMetal',
    name   = 'Starting metal',
    desc   = 'Determines amount of metal and metal storage that each player will start with',
    type   = 'number',
    section= 'StartingResources',
    def    = 100,
    min    = 0,
    max    = 1000,
    step   = 1,  -- quantization is aligned to the def value
                    -- (step <= 0) means that there is no quantization
  },
  {
    key    = 'StartEnergy',
    name   = 'Starting energy',
    desc   = 'Determines amount of energy and energy storage that each player will start with',
    type   = 'number',
    section= 'StartingResources',
    def    = 250,
    min    = 0,
    max    = 1000,
    step   = 1,  -- quantization is aligned to the def value
                    -- (step <= 0) means that there is no quantization
  },
	{
		key="comm",
		name="Game Mode",
		desc="Choose the type of game",
		type="list",
		def="std",
		items = {
			{ key = "std", name = "Skirmish", desc = "Commander"  },
			{ key = "sandbox", name = "Sandbox", desc = "Testing!" },
			{ key = "feature", name = "Feature Placer", desc = "Not for gameplay, used for map development." }
			--{ key = "con", name = "Standard Constructor", desc = "A regular T1 construction unit" }
		},
	},  
}

return options