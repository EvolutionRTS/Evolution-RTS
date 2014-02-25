function gadget:GetInfo()
	return {
		name			= "Utilities for GG",
		desc			= "",
		author			= "Smoth",
		date			= "2012",
		license		 	= "PD",
		layer		 	= -666,
		experimental	= false,
		enabled	 		= true
	}
end

-- gets all the files in a dir blah blah
local function FileSearch(startingDir, fileType)
  local files = {}
  local function AddSubDir(dir)
    for _,file in ipairs(VFS.DirList(dir, fileType)) do
      files[#files + 1] = file
    end
    for _,sd in ipairs(VFS.SubDirs(dir)) do
      AddSubDir(sd)
    end
  end
  
  AddSubDir(startingDir)
  
  return files
end

local spPlaySoundFile		= Spring.PlaySoundFile
local deathSoundsLocation	= "gamedata/configs/deathSounds/"
local deathSoundFiles		= FileSearch(deathSoundsLocation, '*.lua') 
local deathSoundCounts		= {}
local defaultSoundDefName	= "default"


if gadgetHandler:IsSyncedCode() then
	--SYNCED
	function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID)
		local unitName			= UnitDefs[unitDefID].name 
		local soundSet			= deathSoundFiles[unitName] or 
								  deathSoundFiles[defaultSoundDefName] 
		local deathSoundCounts	= #soundSet or 0
		local x,y,z				= GetUnitPosition(unitID)
		local randNumber
		
		if soundSet then
		-- use unit sound file
			local soundCount	= deathSoundCounts[unitName]
			randNumber			= math_rand(1,soundCount)	
			
			spPlaySoundFile(soundSet[randNumber],15, x, y, z )
		end
	end
end