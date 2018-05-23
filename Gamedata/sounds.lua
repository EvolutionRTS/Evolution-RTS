--- Valid entries used by engine: IncomingChat, MultiSelect, MapPoint
--- other than that, you can give it any name and access it like before with filenames
local Sounds = {
	SoundItems = {
	
		build = {
			--- new since 89.0
			--- you can overwrite the fallback profile here (used when no corresponding SoundItem is defined for a sound)
			file = "sounds/miscfx/buildstart.wav",
			--gainmod = 0.35,
			pitchmod = 0.05,
			--pitch = 0.7,
			in3d = true,
			maxconcurrent = 1,
		},
		buildmechanical = {
			--- new since 89.0
			--- you can overwrite the fallback profile here (used when no corresponding SoundItem is defined for a sound)
			file = "sounds/miscfx/buildstart-mechanical.wav",
			--gainmod = 0.35,
			pitchmod = 0.05,
			--pitch = 0.7,
			in3d = true,
			maxconcurrent = 1,
		},
	
		airraider = {
			--- new since 89.0
			--- you can overwrite the fallback profile here (used when no corresponding SoundItem is defined for a sound)
			file = "sounds/weapons/tmediumtankfire.wav",
			gainmod = 0.35,
			pitchmod = 0.05,
			--pitch = 0.7,
			in3d = true,
			maxconcurrent = 4,
		},
	
		riottankshotgun = {
			--- new since 89.0
			--- you can overwrite the fallback profile here (used when no corresponding SoundItem is defined for a sound)
			file = "sounds/weapons/bruisercannon.wav",
			gainmod = 0.35,
			pitchmod = 0.05,
			--pitch = 0.7,
			in3d = true,
			maxconcurrent = 8,
		},
		
		ehbotpeeweeshotgun = {
			--- new since 89.0
			--- you can overwrite the fallback profile here (used when no corresponding SoundItem is defined for a sound)
			file = "sounds/weapons/shotgun-reload.wav",
			gainmod = 0.35,
			pitchmod = 0.05,
			--pitch = 0.7,
			in3d = true,
			maxconcurrent = 16,
		},
		
		pdfire = {
			--- new since 89.0
			--- you can overwrite the fallback profile here (used when no corresponding SoundItem is defined for a sound)
			file = "sounds/weapons/pointdefensefire.wav",
			gainmod = 0.35,
			pitchmod = 0.05,
			--pitch = 0.7,
			in3d = true,
			maxconcurrent = 8,
		},
		
		artyweaponhit = {
			--- new since 89.0
			--- you can overwrite the fallback profile here (used when no corresponding SoundItem is defined for a sound)
			file = "sounds/explosions/artyhit.wav",
			gainmod = 0.35,
			pitchmod = 0.05,
			--pitch = 0.7,
			in3d = true,
			maxconcurrent = 1,
		},
		
		nukeartyweaponhit = {
			--- new since 89.0
			--- you can overwrite the fallback profile here (used when no corresponding SoundItem is defined for a sound)
			file = "sounds/explosions/nukeartyhit.wav",
			gainmod = 0.35,
			pitchmod = 0.05,
			--pitch = 0.7,
			in3d = true,
			maxconcurrent = 1,
		},
	
		ack = {
			--- always play on the front speaker(s)
			file = "sounds/ui/ack.wav",
			in3d = true,
			maxconcurrent = 1,
			gainmod = 0,
			pitchmod = 0,
		},
	
		IncomingChat = {
			--- always play on the front speaker(s)
			file = "sounds/ui/beep4.wav",
			in3d = "false",
			maxconcurrent = 1,
		},
		
		UnitSelect = {
			--- always play on the front speaker(s)
			file = "sounds/miscfx/unitselect.wav",
			in3d = true,
			maxconcurrent = 1,
		},
		
		MultiSelect = {
			--- always play on the front speaker(s)
			file = "sounds/ui/button9.wav",
			in3d = true,
			maxconcurrent = 1,
			gain = 0.25,
		},
		
		MapPoint = {
			--- respect where the point was set, but don't attuenuate in distace
			--- also, when moving the camera, don't pitch it
			file = "sounds/ui/beep6.wav",
			rolloff = 0,
			dopplerscale = 0,
			maxconcurrent = 1,
		},
		
		factory = {
			--- always play on the front speaker(s)
			file = "sounds/miscfx/gdfactoryselect.wav",
			in3d = "false",
			maxconcurrent = 1,
		},
		
		energy = {
			--- always play on the front speaker(s)
			file = "sounds/miscfx/gdenergy.wav",
			in3d = "false",
			maxconcurrent = 1,
		},
		
		mex = {
			--- always play on the front speaker(s)
			file = "sounds/miscfx/gdmex.wav",
			in3d = "false",
			maxconcurrent = 1,
		},
		
		radar = {
			--- always play on the front speaker(s)
			file = "sounds/miscfx/unitselect.wav",
			in3d = "false",
			maxconcurrent = 1,
		},
		
		mobileunit = {
			--- always play on the front speaker(s)
			file = "sounds/miscfx/unitselect.wav",
			in3d = "false",
			maxconcurrent = 1,
		},
		
		turret = {
			--- always play on the front speaker(s)
			file = "sounds/miscfx/turretselect.wav",
			in3d = "false",
			maxconcurrent = 1,
		},
		
		turret = {
			--- always play on the front speaker(s)
			file = "sounds/miscfx/heal.wav",
			in3d = "true",
			maxconcurrent = 1,
		},
		
		--ExampleSound = {
			--- some things you can do with this file

			--- can be either ogg or wav
		--	file = "somedir/subdir/soundfile.ogg",

			--- loudness, > 1 is louder, < 1  is more quiet, you will most likely not set it to 0
		--	gain = 1,

			--- > 1 -> high pitched, < 1 lowered
		--	pitch = 1,

			--- If > 0.0 then this adds a random amount to gain each time the sound is played.
			--- Clamped between 0.0 and 1.0. The result is in the range [(gain * (1 + gainMod)), (gain * (1 - gainMod))].
		--	gainmod = 0.0,

			--- If > 0.0 then this adds a random amount to pitch each time the sound is played.
			--- Clamped between 0.0 and 1.0. The result is in the range [(pitch * (1 + pitchMod)), (pitch * (1 - pitchMod))].
		--	pitchmod = 0.0,

			--- how unit / camera speed affects the sound, to exagerate it, use values > 1
			--- dopplerscale = 0 completely disables the effect
		--	dopplerscale = 1,

			--- when lots of sounds are played, sounds with lwoer priority are more likely to get cut off
			--- priority > 0 will never be cut of (priorities can be negative)
		--	priority = 0,

			--- this sound will not be played more than 16 times at a time
		--	maxconcurrent = 16,

			--- cutoff distance
		--	maxdist = 20000,

			--- how fast it becomes more quiet in the distance (0 means aleays the same loudness regardless of dist)
		--	rolloff = 1,

			--- non-3d sounds do always came out of the front-speakers (or the center one)
			--- 3d sounds are, well, in 3d
		--	in3d = true,

			--- you can loop it for X miliseconds
		--	looptime = 0,
		--},

		--default = {
			-- new since 89.0
			-- you can overwrite the fallback profile here (used when no corresponding SoundItem is defined for a sound)
		--	gainmod = 0.35,
		--	pitchmod = 0.05,
		--	pitch = 0.7,
		--	in3d = true,
		--},
	},
}

local files = VFS.DirList("sounds/deathsounds/generic/")
local t = Sounds.SoundItems
for i=1,#files do
   local fileName = files[i]
   t[fileName] = {
      file     = fileName;
      pitchmod = 0.3;
      --gainmod  = 0.2;
      maxconcurrent = 16;
	  rolloff = 2,
	  dopplerscale = 2,
	  in3d = true,
   }
end

local files = VFS.DirList("sounds/explosions/")
local t = Sounds.SoundItems
for i=1,#files do
   local fileName = files[i]
   t[fileName] = {
      file     = fileName;
      pitchmod = 0.3;
      --gainmod  = 0.2;
      maxconcurrent = 16;
	  rolloff = 2,
	  dopplerscale = 2,
	  in3d = true,
   }
end

local files = VFS.DirList("sounds/deathsounds/nuke/")
local t = Sounds.SoundItems
for i=1,#files do
   local fileName = files[i]
   t[fileName] = {
      file     = fileName;
      pitchmod = 0.3;
      --gainmod  = 0.2;
      maxconcurrent = 16;
	  rolloff = 2,
	  dopplerscale = 2,
	  in3d = true,
   }
end

local files = VFS.DirList("sounds/weapons/")
local t = Sounds.SoundItems
for i=1,#files do
   local fileName = files[i]
   t[fileName] = {
      file     = fileName;
      pitchmod = 0.2;
      --gainmod  = 0.2;
      maxconcurrent = 16;
	  rolloff = 2,
	  dopplerscale = 1.5,
	  in3d = true,
   }
end

local files = VFS.DirList("sounds/selfdcountdown/")
local t = Sounds.SoundItems
for i=1,#files do
   local fileName = files[i]
   t[fileName] = {
      file     = fileName;
      pitchmod = 0;
      gainmod  = 0;
      maxconcurrent = 1;
   }
end

return Sounds