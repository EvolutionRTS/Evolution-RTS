
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

Spring.SetSoundStreamVolume(0.5)
local musicfiles = VFS.DirList("LuaUI/Widgets_Evo/Music/loading", "*.ogg")
if (#musicfiles > 0) then
	Spring.PlaySoundStream(musicfiles[1], 0.5)
	Spring.SetSoundStreamVolume(0)
end


function addon.DrawLoadScreen()
	local loadProgress = SG.GetLoadProgress()
	Spring.SetSoundStreamVolume(loadProgress)
end


function addon.Shutdown()
	--Spring.StopSoundStream()
	--Spring.SetSoundStreamVolume(0.5)
end
