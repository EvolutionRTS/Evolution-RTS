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
    max    = 100,
    step   = 1,  -- quantization is aligned to the def value
                    -- (step <= 0) means that there is no quantization
  },
  {
   key    = 'StartMetal',
   scope  = 'team',
   name   = 'Team Starting metal',
   desc   = 'Determines amount of metal and metal storage this team will start with',
   type   = 'number',
   section= 'StartingResources',
   def    = 100,
   min    = 0,
   max    = 100,
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
    max    = 250,
    step   = 1,  -- quantization is aligned to the def value
                    -- (step <= 0) means that there is no quantization
  },
  {
   key    = 'StartEnergy',
   scope  = 'team',
   name   = 'Team Starting energy',
   desc   = 'Determines amount of energy and energy storage that this team will start with',
   type   = 'number',
   section= 'StartingResources',
   def    = 250,
   min    = 0,
   max    = 250,
   step   = 1,  -- quantization is aligned to the def value
   -- (step <= 0) means that there is no quantization
  },

	{
    key='typemapsetting',
    name='Terrain Speed Boost',
    desc='Choose which map Speed Boost to use',
    type='list',
    section= 'mapsettings',
    def='alloff',
	    items = {
		{ key='mapdefault', name="Map Default", desc='Use map speed boost' },
		{ key='average', name="Average", desc='Each terrain types speed boost is averaged' },
		{ key='keepequal', name="Keep Equal", desc='Non-equal speedboost removed' },
		{ key='onlyimpassable', name="Only Impassable", desc='Override all speedboost except impassable terrain' },
		{ key='alloff', name="All Off", desc='Disable all speed boost' },
		},
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