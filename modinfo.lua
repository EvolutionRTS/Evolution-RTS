-- $Id: modinfo.lua 4663 2009-05-24 06:00:10Z det $
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    modinfo.lua
--  brief:   Mod Info
--

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return {
	name='Evolution RTS -',
	description='EvoRTS',
	shortname='EvoRTS',
	version='$VERSION',
	mutator='Official',
	game='Evolution RTS',
	shortGame='EvoRTS',
	modtype=1,
	depend = {
		"rapid://spring-features:test",
		-- "Shard LuaAI $VERSION",
		-- "Evolution RTS Shard LuaAI $VERSION",		
	},
}
