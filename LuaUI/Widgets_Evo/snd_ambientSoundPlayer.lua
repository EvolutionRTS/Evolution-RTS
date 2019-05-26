--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--	file: snd_ambientSoundPlayer.lua
--	brief:	Plays a looping background sound
--	author:	Forboding Angel
--
--	Copyright (C) 2019.
--	Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
math.randomseed( os.time() - os.clock() * 1000 )
math.random() math.random() math.random()

function widget:GetInfo()
	return {
		name	= "Ambient Background Sound Player",
		desc	= "Plays a looping background sound",
		author	= "Forboding Angel",
		date	= "May 2019",
		license	= "GNU GPL, v2 or later",
		layer	= -4,
		enabled	= true	--	loaded by default?
	}
end

function widget:Initialize()
	
end

function widget:GameFrame(n)
	if n == 1 then
		Spring.PlaySoundFile("LuaUI/Sounds/ambient/ambient-stereo-short.wav", 0.33, 'ui')
	end

	if (n % 50) == 4 then
		Spring.PlaySoundFile("LuaUI/Sounds/ambient/ambient-stereo-short.wav", 0.33, 'ui')
	end

end