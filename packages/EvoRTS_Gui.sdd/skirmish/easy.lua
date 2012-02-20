
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local options = {

	--mandatory descriptive text
	{
		key 	= "description",
		type	= "string",
		desc	= "basic html allowed",
		def 	= "<h1>Battle for Jugahut</h1><p>some other text</p>",
	},
	--this is mandatory, min. 1 listitem
    {
	key    = "ai_team_ids",
	name   = "AI Teams",
	desc   = "used to map ai num <-> team id and define number of added AIs",
	type   = "list",
	def    = "0",
	items  = {
		{
		key  = "0",
		name = "2",
		desc = "put first AI into team 2",
		},
	  },
  },
  	--mandatory, list exactly as many Side names for AI players as there are ai_team_ids listitems
    {
	key    = "ai_sides",
	name   = "AI Sides",
	desc   = "used to map ai num <-> Side ",
	type   = "list",
	def    = "0",
	items  = {
		{
		key  = "0",
		name = "Outer_Colonies",
		desc = "",
		},
	  },
  },
	--optional, use to override the default setting from LobbyOptions.lua
		--listitem key should map to index in ai_team_ids, but does not need to be contiguous
    {
	key    = "ai_names",
	name   = "AI names",
	desc   = "used to map ai num <-> AI lib name (shortname) ",
	type   = "list",
	def    = "0",
	items  = {
		{
		key  = "0",
		name = "Survival Spawner: Very Easy",
		desc = "Beginer Games",
		},
	  },
  },

  --all optional below, copy-paste any modoption you like and set a different default value to override
  
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
}
return options
