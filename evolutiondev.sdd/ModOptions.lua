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

--[[ Gameovercode for 0.83
	
	{
      key="teamdeathmode",
      name="Team Game End Mode",
      desc="What it takes to eliminate a Team",
      type="list",
      def="allyzerounits",
      items={
         {key="none", name="Never Die", desc="All Teams will stay alive regardless of what happends, gameover will never arrive."},
         {key="teamzerounits", name="Team Death on Zero Units", desc="The Team will die when it has 0 units."},
         {key="allyzerounits", name="AllyTeam Death on Zero units", desc="The Team will die when every Team in his AllyTeam have 0 units."},
      }
   },
   {
      key    = "shareddynamicalliancevictory",
      name   = "Dynamic Ally Victory",
      desc   = "Ingame alliance should count for game over condition.",
      type   = "bool",
      def    = false,
    },
	
	]]--
	--[[
	{
       key="Dawn of War 2 Scoring Mode",
       name="Dawn of War 2 Scoring Mode",
       desc="Dawn of War 2 Scoring Mode Options",
       type="section",
    },
	
	{
    key    = 'dow2mode',
    name   = 'Dawn of War 2 Scoring Mode',
    desc   = 'Enables the Dawn of War 2 control point based scoring mode',
    type   = 'bool',
    section = "Dawn of War 2 Scoring Mode",
    def    = false,
    },

	{
      key="scoremode",
      name="Score Mode",
      desc="How are points are scored",
      type="list",
	  section = "Dawn of War 2 Scoring Mode",
      def="countdown",
      items = {
         { key = "countdown", name = "Count Down", desc = "Points reduce enemy score, score cannot be regained" },
         { key = "tugowar", name = "Tug o'War", desc = "Points steal enemy score, owner gains score" },
         { key = "multidomination", name = "Multi Domination", desc = "Hold all points for 20 seconds to score" },
      }
   },
  {
      key="starttime",
      name="Start Time",
      desc="When the capturing of points can begin.",
      type="list",
	  section = "Dawn of War 2 Scoring Mode",
      def="2",
      items = {
         { key = "2", name = "2", desc = "2 minutes" },
         { key = "3", name = "3", desc = "3 minutes" },
         { key = "5", name = "5", desc = "5 minutes" },
         { key = "10", name = "10", desc = "10 minutes" },
      }
   },
   {
      key="limitscore",
      name="Score Limit",
      desc="Score players start at or have to reach (depending on mode)",
      type="list",
	  section = "Dawn of War 2 Scoring Mode",
      def="1000",
      items = {
         { key = "200", name = "200", desc = "very short" },
         { key = "500", name = "500", desc = "short" },
         { key = "1000", name = "1000", desc = "average" },
         { key = "2000", name = "2000", desc = "long" },
         { key = "3000", name = "2000", desc = "long" },
         { key = "4000", name = "2000", desc = "long" },
         { key = "5000", name = "5000", desc = "Long" },
         { key = "6000", name = "2000", desc = "long" },
         { key = "7000", name = "2000", desc = "long" },
         { key = "8000", name = "2000", desc = "long" },
         { key = "9000", name = "2000", desc = "long" },
         { key = "10000", name = "10000", desc = "Insane!" },
      }
   },
   ]]--
	
		--
	--  chickens stuff
	--	
	{
       key="spawner",
       name="Spawner Ai Options",
       desc="Spawner Ai Options",
       type="section",
    },
	{
		key="mo_chickenstart",
		name="Burrow Placement",
		desc="Control where burrows spawn",
		type="list",
		def="avoid",
		section="spawner",
		items={
			{key="anywhere", name="Anywhere", desc="Burrows can spawn anywhere"},
			{key="avoid", name="Avoid Players", desc="Burrows do not spawn on player units"},
			{key="initialbox", name="Initial Start Box", desc="First wave spawns in Spawner start box, following burrows avoid players"},
			{key="alwaysbox", name="Always Start Box", desc="Burrows always spawn in Spawner start box"},
		}
	},
	-- {
		-- key="mo_queendifficulty",
		-- name="Queen Difficulty",
		-- desc="How hard doth the Chicken Queen",
		-- type="list",
		-- def="n_chickenq",
		-- section="spawner",
		-- items={
			-- {key="ve_chickenq", name="Very Easy", desc="Cakewalk"},
			-- {key="e_chickenq", name="Easy", desc="Somewhat Challenging"},
			-- {key="n_chickenq", name="Normal", desc="A Good Challenge"},
			-- {key="h_chickenq", name="Hard", desc="Serious Business"},
			-- {key="vh_chickenq", name="Very Hard", desc="Impossible"},
		-- }
	-- },
	{
		key    = "mo_queentime",
		name   = "Time until Big Daddy comes",
		desc   = "A Big Daddy will come to attack after given time.",
		type   = "number",
		def    = 40,
		min    = 1,
		max    = 90,
		step   = 1,
		section= "spawner",
	},
	{
		key    = "mo_maxchicken",
		name   = "Unit limit",
		desc   = "Maximum number of units on map.",
		type   = "number",
		def    = 100,
		min    = 100,
		max    = 5000,
		step   = 50,
		section= "spawner",
	},
	{
		key    = "mo_graceperiod",
		name   = "Grace Period (Seconds)",
		desc   = "Time before Survival Mode becomes active.",
		type   = "number",
		def    = 120,
		min    = 10,
		max    = 3600,
		step   = 10,
		section= "spawner",
	},
	-- {  --useless in gundam
		-- key    = "mo_queenanger",
		-- name   = "Add Queen Anger",
		-- desc   = "Killing burrows adds to queen anger.",
		-- type   = "bool",
		-- def    = true,
		-- section= "spawner",
    -- },
	-- dunno
	{
		key    = "mo_custom_burrowspawn",
		name   = "Elevator Spawn (Seconds)",
		desc   = "Time between elevator spawns.",
		type   = "number",
		def    = 120,
		min    = 1,
		max    = 600,
		step   = 1,
		section= "cust",
	},
	{
		key    = "mo_custom_chickenspawn",
		name   = "Wave Spawn Rate (Seconds)",
		desc   = "Time between waves.",
		type   = "number",
		def    = 90,
		min    = 10,
		max    = 600,
		step   = 1,
		section= "cust",
	},
	{
		key    = "mo_custom_minchicken",
		name   = "Min enemy units Per Player",
		desc   = "Minimum Number of enemy units before spawn chance kicks in",
		type   = "number",
		def    = 8,
		min    = 1,
		max    = 250,
		step   = 1,
		section= "cust",
	},
	{
		key    = "mo_custom_spawnchance",
		name   = "Spawn Chance (Percent)",
		desc   = "Percent chance of each enemy unit spawn once greater than the min chickens per player limit",
		type   = "number",
		def    = 33,
		min    = 0,
		max    = 100,
		step   = 1,
		section= "cust",
	},
	{
		key    = "mo_custom_angerbonus",
		name   = "Burrow Kill Anger (Seconds)",
		desc   = "Seconds added per burrow kill.",
		type   = "number",
		def    = 20,
		min    = 0,
		max    = 600,
		step   = 1,
		section= "cust",
	},
	{
		key    = "mo_custom_queenspawnmult",
		name   = "Queen Wave Size Mod",
		desc   = "Number of squads spawned by the queen at once.",
		type   = "number",
		def    = 1,
		min    = 0,
		max    = 5,
		step   = 1,
		section= "cust",
	},
	{
		key    = "mo_custom_expstep",
		name   = "Bonus Experience",
		desc   = "Exp each enemy unit will receive by the end of the game",
		type   = "number",
		def    = 1.5,
		min    = 0,
		max    = 2.5,
		step   = 0.1,
		section= "cust",
	},
	{
		key    = "mo_custom_lobberemp",
		name   = "Lobber EMP Duration",
		desc   = "Max duration of Lobber EMP artillery",
		type   = "number",
		def    = 4,
		min    = 0,
		max    = 30,
		step   = 0.5,
		section= "cust",
	},
}

return options
