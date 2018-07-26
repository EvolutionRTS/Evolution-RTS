
if addon.InGetInfo then
	return {
		name    = "Music",
		desc    = "plays music",
		author  = "jK",
		date    = "2012,2013",
		license = "GPL2",
		layer   = 0,
		depend  = {"LoadProgress"},
		enabled = true,
	}
end

------------------------------------------
math.randomseed( os.time() - os.clock() * 1000 )
math.random() math.random() math.random()
Spring.SetSoundStreamVolume(0.5)
local musicfiles = VFS.DirList("LuaUI/Widgets_Evo/Music/loading", "*.ogg")
if (#musicfiles > 0) then
	Spring.PlaySoundStream(musicfiles[math.random(1,#musicfiles)], 0.5)
	Spring.SetSoundStreamVolume(1)
end


--function addon.DrawLoadScreen()
	--Spring.SetSoundStreamVolume(100)
--end


function addon.Shutdown()
	--Spring.StopSoundStream()
	--Spring.SetSoundStreamVolume(0.5)
end
