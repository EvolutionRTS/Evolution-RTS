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
--  def:      the default value;
--  min:      minimum value for number options
--  max:      maximum value for number options
--  step:     quantization step, aligned to the def value
--  maxlen:   the maximum string length for string options
--  items:    array of item strings for list options
--  scope:    "all", "player", "team", "allyteam"      <<< not supported yet >>>


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local options = {

	{
		key    = "bg_image",
		name   = "bg_image",
		desc   = "BackgroundImage to be put on panes or such",
		type   = "string",
		--png/bmp should be fine, don't use transparency ( will look weird wrt controls )
		--the controls on startpage are v/h centered, best to leave around 40px "free" space (no text on bg)
		def    = "lobby/lobby_background.png", 
	},
	{
		key    = "battlelist_filter",
		name   = "battlelist_filter",
		desc   = "simple string/regex filter that defines which battles are shown in multiplayer",
		type   = "string",
		def    = "Evolution RTS",
	},
	{	-- optional
		key    = "notification_background",
		name   = "notification_background",
		desc   = "a background image applied to SL's notifications (in absence of libnotify)",
		type   = "string",
		def    = "lobby/notification_popup_background.png",
	},
	{	-- optional
		key    = "help_url",
		name   = "help_url",
		desc   = "the url that is opened in browser if help button is clicked",
		type   = "string",
		def    = "http://http://www.evolutionrts.info/game-manual/",
	},
	{
		-- mandatory
		key    = "intro_file",
		name   = "intro_file",
		desc   = "path from archive root",
		type   = "string",
		def    = "lobby/intro.txt",
	}
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
}
return options
