
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
local music_volume_set = Spring.GetConfigInt("snd_volmusic", 20) * 0.01 or 0.2
Spring.SetSoundStreamVolume(music_volume_set)
local r = math.random(0,2)

if r == 0 then 
	musicfiles = VFS.DirList("LuaUI/Widgets_Evo/Music/loading", "*.ogg")
else
	musicfiles = VFS.DirList("LuaUI/Widgets_Evo/Music/war", "*.ogg")
end

if (#musicfiles > 0) then
	Spring.PlaySoundStream(musicfiles[math.random(1,#musicfiles)], music_volume_set)
	Spring.SetSoundStreamVolume(music_volume_set)
end


--function addon.DrawLoadScreen()
	--Spring.SetSoundStreamVolume(100)
--end


function addon.Shutdown()
	--Spring.StopSoundStream()
	--Spring.SetSoundStreamVolume(0.5)
end
