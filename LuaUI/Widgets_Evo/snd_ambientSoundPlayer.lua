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
		layer	= 9999999999,
		enabled	= true	--	loaded by default?
	}
end

function widget:Initialize()

end

function widget:GameFrame(n)

	if n == 1 then
		myTeamID = Spring.GetMyTeamID()
		myFaction = Spring.GetTeamRulesParam(myTeamID, "faction", playerFaction)
		if myFaction == nil then
			Spring.Echo("[Ambient Background Sound Player] If you're seeing this message that means that the code which sets the player's faction is absolutely fucked somewhere. On the next line I will echo the myFaction variable (It will be nil). If it says anything other than the factions listed in game_spawn.lua (it will), at least it will provide a clue. Additionally I will manually set the player faction to Federation of Kala so that it doesn't crash and burn. Happy bug hunting!")
			Spring.Echo(myFaction)
			myFaction = "Federation of Kala"
		else
			Spring.Echo("[Ambient Background Sound Player] Player faction is " .. myFaction)
		end
	end
	
	if myFaction == "Federation of Kala" then
		if n == 1 then
			Spring.PlaySoundFile("LuaUI/Sounds/ambient/ambient-stereo-short.wav", 0.33, 'ui')
		elseif (n % 50) == 4 then
			Spring.PlaySoundFile("LuaUI/Sounds/ambient/ambient-stereo-short.wav", 0.33, 'ui')
		end
	elseif myFaction == "Loz Alliance" then
		if n == 1 then
			Spring.PlaySoundFile("LuaUI/Sounds/ambient/zaalambient.wav", 0.33, 'ui')
		elseif (n % 50) == 4 then
			Spring.PlaySoundFile("LuaUI/Sounds/ambient/zaalambient.wav", 0.33, 'ui')
		end
	elseif myFaction == "pattern" then
		if n == 1 then
			Spring.PlaySoundFile("LuaUI/Sounds/ambient/ambient-stereo-short.wav", 0.33, 'ui')
		elseif (n % 50) == 4 then
			Spring.PlaySoundFile("LuaUI/Sounds/ambient/ambient-stereo-short.wav", 0.33, 'ui')
		end
	end
	
end