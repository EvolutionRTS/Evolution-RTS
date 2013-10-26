
if addon.InGetInfo then
	return {
		name    = "Main",
		desc    = "(musicfor loading)",
		author  = "jK",
		date    = "2012",
		license = "GPL2",
		layer   = 0,
		depend  = {"LoadProgress"},
		enabled = true,
	}
end

------------------------------------------

require "savetable.lua"

local lastLoadMessage = ""

function addon.LoadProgress(message, replaceLastLine)
	lastLoadMessage = message
end

------------------------------------------

Spring.SetSoundStreamVolume(0)
local musicfiles = VFS.DirList(LUA_DIRNAME .. "Assets/music", "*.ogg")
if (#musicfiles > 0) then
	Spring.PlaySoundStream(musicfiles[ math.random(#musicfiles) ], 1)
	Spring.SetSoundStreamVolume(0)
end

function addon.DrawLoadScreen()
	local loadProgress = SG.GetLoadProgress()

	-- fade in & out music with progress
	if (loadProgress < 0) then
		Spring.SetSoundStreamVolume(loadProgress)
	else
		Spring.SetSoundStreamVolume(0.9 + ((0.9 - loadProgress) * 9))
	end
end

function addon.Shutdown()
	Spring.StopSoundStream()
	Spring.SetSoundStreamVolume(1)
end