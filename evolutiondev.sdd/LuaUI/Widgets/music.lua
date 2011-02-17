--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--	file:		gui_music2.lua
--	brief:	yay music
--	author:	cake
--
--	Copyright (C) 2007.
--	Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
	return {
		name			= "Music 2",
		desc			= "Plays music based on situation",
		author		= "cake, trepan, Smoth",
		date			= "Mar 01, 2008, Aug 20 2009",
		license	= "GNU GPL, v2 or later",
		layer		= 0,
		enabled	= true	--	loaded by default?
	}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local GetMyTeamID 		= Spring.GetMyTeamID
local myFaction
local myOldFaction

local windows = {}

local tx = "Many of your fathers and brothers have perished valiantly in the face of a contemptible enemy. We must never forget what the Federation has done to our people! My brother, Garma Zabi, has shown us these virtues through our own valiant sacrifice. By focusing our anger and sorrow, we are finally in a position where victory is within our grasp, and once again, our most cherished nation will flourish. Victory is the greatest tribute we can pay those who sacrifice their lives for us! Rise, our people, Rise! Take your sorrow and turn it into anger! Zeon thirsts for the strength of its people! SIEG ZEON!!! SIEG ZEON!!! SIEG ZEON!!"

local WAR_THRESHOLD = 5000
local PEACE_THRESHOLD = 1000

local musicType = 'peace'
local dethklok = {} -- keeps track of the number of doods killed in each time frame
local timeframetimer = 0
local lastTrack = ''
local lastTrackType = ''
local newTrackWait = 1000
local numVisibleEnemy = 0
local volume
local fadeVol
local curTrack	= "no name"


local warTracks		=	VFS.DirList('Music/war/', '*.ogg')
local peaceTracks	=	VFS.DirList('Music/peace/', '*.ogg')

local warOverTracks		=	VFS.DirList('evosettings/musicoverride/war/', '*.ogg')
local peaceOverTracks	=	VFS.DirList('evosettings/musicoverride/peace/', '*.ogg')

local firsttime = true
local firstFade = true
local initTrack
	
	if (#peaceOverTracks > 0) then
		initTrack = peaceOverTracks[math.random(1, #peaceOverTracks)] 
	else
		initTrack = peaceTracks[math.random(1, #peaceTracks)]
	end

function widget:Initialize()
	
	volume = Spring.GetConfigInt("snd_volmusic", 60)
	volume = volume * 0.01
 
	math.randomseed(os.clock()* 101.01) --lurker wants you to burn in hell rgn
	
	for i = 1, 30, 1 do
		dethklok[i]=0
	end
end

function SetVolume(Vol)

Spring.SetSoundStreamVolume(Vol)
end

function ReadOggInfo(filename)
	return pcall(function()
	local info = {comments = {}}
	
	local contents =	VFS.LoadFile(filename)
	local start = contents:sub(1, 1000)
	
	if not start:find("\001vorbis") then
			error("missing vorbis header")
	end
	
	local audio_channels, audio_sample_rate, bitrate_maximum, bitrate_nominal, bitrate_minimum = 
	contents:match("\001vorbis%z%z%z%z(.)(....)(....)(....)(....)")
	info.audio_channels = string.byte(audio_channels)
	info.audio_sample_rate = VFS.UnpackU32(audio_sample_rate)
	info.bitrate_maximum = VFS.UnpackU32(bitrate_maximum)
	info.bitrate_nominal = VFS.UnpackU32(bitrate_nominal)
	info.bitrate_minimum = VFS.UnpackU32(bitrate_minimum)
			
	local granule_low, granule_high = contents:match("OggS%z[\004\005](....)(....)")
	info.audio_sample_count = VFS.UnpackU32(granule_high) * 2^32 + VFS.UnpackU32(granule_low)
	info.length = info.audio_sample_count / info.audio_sample_rate
	
	local pos = start:find("\003vorbis")
	if pos then
			local function read(n) pos = pos + n return contents:sub(pos-n, pos-1) end
			
			read(7)
			local vendorLength = VFS.UnpackU32(read(4))
				
			if vendorLength > 1000 then 
				error("malformed comments")
			end
			
			info.vendor = read(vendorLength)
			local numComments = VFS.UnpackU32(read(4))
		
			if numComments > 1000 then 
				error("malformed comments") 
			end
		
			for i=1,numComments do
				local commentLength = VFS.UnpackU32(read(4))
				
				if commentLength > 1000 then 
						error() 
				end
				
				local comment = read(commentLength)
				local splitPoint = comment:find("=")
				local field = comment:sub(1, splitPoint - 1)
				local value = comment:sub(splitPoint + 1)
				info.comments[field] = value
			end
	end
	
	return info
	
	end)
end


function widget:Shutdown()
	Spring.StopSoundStream()
	
	for i=1,#windows do
		(windows[i]):Dispose()
	end
end


function widget:Update(dt)
	
	if (Spring.GetGameSeconds() < 3) then
		dethklok[1] = 0
	else
		timeframetimer = timeframetimer + dt
		if (timeframetimer > 1) then	-- every second
			timeframetimer = 0
			newTrackWait = newTrackWait + 1

			local PlayerTeam = Spring.GetMyTeamID()
			numVisibleEnemy = 0
			local doods = Spring.GetVisibleUnits()
		for _, u in ipairs(doods) do
			if (Spring.IsUnitAllied(u) ~= true) then
				numVisibleEnemy = numVisibleEnemy + 1
			end
		end
			
		totalKilled = 0
		for i = 1, 10, 1 do
			totalKilled = totalKilled + (dethklok[i] * 2)
		end
		
		for i = 11, 20, 1 do
			totalKilled = totalKilled + dethklok[i]
		end
		
		for i = 20, 1, -1 do
			dethklok[i+1] = dethklok[i]
		end
		dethklok[1] = 0
		
		
		if (totalKilled > WAR_THRESHOLD) then
			-- Spring.Echo("war!")
			musicType = 'war'
		end
		
		if (totalKilled <= PEACE_THRESHOLD) then
			--Spring.Echo("peace!")
			musicType = 'peace'
		end
		
		if (firsttime) then
			volume = Spring.GetConfigInt("snd_volmusic", 60)
			volume = volume * 0.01
			Spring.PlaySoundStream(initTrack, volume) --init to something
			firsttime = false -- pop this cherry	
									
			-- local success, oggInfo = ReadOggInfo(initTrack)
			-- local titleText, artistText
			
			-- if (oggInfo.comments.TITLE) then 
				-- titleText	= oggInfo.comments.TITLE
			-- else
				-- titleText	= "Title Missing"
			-- end
			
			-- if (oggInfo.comments.ARTIST) then 
				-- artistText	= oggInfo.comments.ARTIST
			-- else
				-- artistText	= "Artist Missing"
			-- end

			-- songname:SetCaption(titleText .. "By: " .. artistText)
		end
		
		local playedTime, totalTime = Spring.GetSoundStreamTime()
		playedTime = math.floor(playedTime)
		totalTime = math.floor(totalTime)
		
		--Spring.Echo(playedTime, totalTime, newTrackWait)
		
			--if((totalTime - playedTime) <= 6 and (totalTime >= 1) ) then
				--Spring.Echo("time left:", (totalTime - playedTime))
				--Spring.Echo("volume:", (totalTime - playedTime)/6)
				--if ((totalTime - playedTime)/6 >= 0) then
				--	Spring.SetSoundStreamVolume((totalTime - playedTime)/6)
				--else
				--	Spring.SetSoundStreamVolume(0.1)
				--end
			--elseif(playedTime <= 5 )then--and not firstFade
				--Spring.Echo("time playing:", playedTime)
				--Spring.Echo("volume:", playedTime/5)
				--Spring.SetSoundStreamVolume( playedTime/5)
			--end
		

			if ( (musicType ~= lastTrackType and musicType == 'war') or (playedTime > totalTime)	) then
				lastTrackType = musicType
				local newTrack
				repeat
				if musicType == 'peace' then
					if (#peaceOverTracks > 0) then
						newTrack = peaceOverTracks[math.random(1, #peaceOverTracks)]	
					else
						newTrack = peaceTracks[math.random(1, #peaceTracks)]
					end
				elseif musicType == 'war' then
					if (#warOverTracks > 0) then
						newTrack = warOverTracks[math.random(1, #warOverTracks)]	
					else
							newTrack = warTracks[math.random(1, #warTracks)]
					end
				end
				until newTrack ~= lastTrack
				
				local success, oggInfo = ReadOggInfo(newTrack)
					-- if (oggInfo.comments.TITLE and oggInfo.comments.TITLE) then
					
					-- MakeUi()
					-- end
			
				-- for key, val in pairs(oggInfo) do
					-- Spring.Echo(key, val)	
				-- end
				firstFade = false
				lastTrack = newTrack
				
				-- if (oggInfo.comments.TITLE and oggInfo.comments.TITLE) then
					-- Spring.Echo("Song changed to: " .. oggInfo.comments.TITLE .. " By: " .. oggInfo.comments.ARTIST)
				-- else
					-- Spring.Echo("Song changed but unable to get the artist and title info")
				-- end
				curTrack = newTrack
				volume = Spring.GetConfigInt("snd_volmusic", 60)
				volume = volume * 0.01
				Spring.PlaySoundStream(newTrack, volume)
				
				--Spring.Echo("Track: " .. newTrack)
				newTrackWait = 0
			end
		end
	end
end

function widget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer)
	if (damage < 1.5) then return end
	local PlayerTeam = Spring.GetMyTeamID()
	
	if (UnitDefs[unitDefID] == nil) then return end
		
	if paralyzer then
		return
	else
		if (teamID == PlayerTeam) then
			damage = damage * 1.5
		end
		local multifactor = 1
		if (numVisibleEnemy > 3) then
			multifactor = math.log(numVisibleEnemy)
		end
		dethklok[1] = dethklok[1] + (damage * multifactor);
	end
end

function widget:UnitDestroyed(unitID, unitDefID, teamID) 
	local unitWorth = 50
	if (UnitDefs[unitDefID].metalCost > 5) then
		unitWorth = 200
	end
	if (UnitDefs[unitDefID].metalCost > 20) then
		unitWorth = 300
	end
	if (UnitDefs[unitDefID].metalCost > 50) then
		unitWorth = 500
	end
	if (UnitDefs[unitDefID].metalCost > 100) then
		unitWorth = 700
	end
	if (teamID == PlayerTeam) then
		unitWorth = unitWorth * 1.5
	end
	local multifactor = 1
	if (numVisibleEnemy > 3) then
		multifactor = math.log(numVisibleEnemy)
	end
	dethklok[1] = dethklok[1] + (unitWorth*multifactor);
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------