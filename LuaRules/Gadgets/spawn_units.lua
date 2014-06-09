
function gadget:GetInfo()
	return {
		name = "Spawn Units",
		desc = "Spawn/dump units & features & triggers from/to missions startscripts",
		author = "zwzsg",
		version = "1.6",
		date = "20th May, 2009",
		license = "Public Domain",
		layer = 0,
		enabled = true,
	}
end

VFS.Include("LuaRules/Gadgets/libs/dump_units_lib.lua",nil)
VFS.Include("LuaRules/Gadgets/libs/FillModSpecific.lua",nil)
--VFS.Include("LuaRules/Gadgets/libs/ColorConversion.lua",nil) -- Not need to invent new color when we take current ones
VFS.Include("LuaRules/Gadgets/libs/GenerateGame.lua",nil) -- Only so WriteScript.lua gets GetMaxAllyTeam from GenerateGame.lua"
VFS.Include("LuaRules/Gadgets/libs/WriteScript.lua",nil)

if (gadgetHandler:IsSyncedCode()) then
--SYNCED

	local fullscript={}
	function gadget:RecvLuaMsg(msg,player)
		local MsgForMe=string.match(msg,gadget:GetInfo().name..":(.*)")
		if MsgForMe then
			local num,str=string.match(MsgForMe,"(%d+)%:(.*)")
			fullscript[tonumber(num)]=str
		end
	end

	function gadget:GameFrame(frame)
		if frame>12 then
			RefreshTriggers(frame)
		elseif frame==3 then
			if #fullscript>0 and Spring.GetModOptions() and Spring.GetModOptions()["fullscript"] then
				fullscript=table.concat(fullscript,"")
				SetModOptionsToFull(fullscript)
				fullscript={}
			end
			SpawnHeightMap()
			SpawnAllTriggers()
			SpawnAllUnits() -- This also delete already present units for teams with RemoveUnits=1
			SpawnAllFeatures() -- This also delete features when RemoveFeatures=1. By default does it on a pear team basis, leaving Gaia features untouched.
		elseif frame==5 then
			SpawnAllOrders()
			SpawnResources()
		end
	end


	function gadget:UnitDestroyed(u)
		RemoveUnitFromSpawn(u)
	end



	local function DumpCmdIssued(cmd,line,words,player)
		if #Spring.GetPlayerList()>1 and not Spring.IsCheatingEnabled() then
			Spring.SendMessageToPlayer(player,"Dump in multiplayer requires cheat")
			return
		end
		--Spring.SendMessageToPlayer(player,"/dump [filename] [abbreviated] [grid] [restart]")
		local restart=false
		local SaveHeightmap=false
		repeat
			local LoopAgain=false
			if words[#words] and string.lower(words[#words])=="restart" then
				table.remove(words)
				restart=true
				LoopAgain=true
			end
			if words[#words] and string.lower(words[#words])=="light" then
				table.remove(words)
				SaveHeightmap=false
				LoopAgain=true
			end
		until not LoopAgain
		local filename=words[1]
		local abbreviated=((words[2] and ((not tonumber(words[2])) or (tonumber(words[2])>=1))) and 1 or nil)
		local grid=(words[3] and tonumber(words[3])) or nil
		if filename and string.len(filename)>=1 then
			if string.sub(filename,-4)~=".txt" and string.sub(filename,-4)~=".sav" then
				filename=filename..".sav"
			end
		else
			filename="Dump.sav"
		end
		SendToUnsynced("Dump",filename,abbreviated,grid,restart,SaveHeightmap)-- "Dump" is both the name of the SyncAction, and the first parameter passed to it
	end

	local function SetupCmdDump()
		local cmd,func,help
		cmd  = "dump"
		func = DumpCmdIssued
		help = " dump every unit into a startscript"
		gadgetHandler:AddChatAction(cmd,func,help)
		Script.AddActionFallback(cmd..' ',help)
	end

	function gadget:Initialize()
		GG.MissionTrigger={Equ={},States={},FromNames={}}
		SetupCmdDump()
	end

else
--UNSYNCED

	local function IsThereFolder(foldername,path)
		local folders=VFS.SubDirs((path or "").."/","*",VFS.RAW)
		for _,folder in ipairs(folders) do
			local BeginIndex=1
			local EndIndex=string.len(folder)
			while string.sub(folder,EndIndex,EndIndex)=="/" or string.sub(folder,EndIndex,EndIndex)=="\\" do
				EndIndex=EndIndex-1
			end
			repeat
				local NewBeginIndex=string.find(string.sub(folder,BeginIndex,EndIndex),"/",1,true)
								or string.find(string.sub(folder,BeginIndex,EndIndex),"\\",1,true)
				BeginIndex=NewBeginIndex and BeginIndex+NewBeginIndex or BeginIndex
			until not NewBeginIndex
			if string.lower(string.sub(folder,BeginIndex,EndIndex))==string.lower(foldername) then
				return true
			end
		end
		return false
	end

	local function MakeDumpNao(actioname,filename,abbreviated,grid,restart,SaveHeightmap)
		if restart then
			Spring.Echo("MakeDumpNao with restart")
			if Script.LuaUI('WriteAndRunState') then
				local state,ok=GenerateFromCurrentState(nil,nil,true,false)
				if ok then
					Script.LuaUI.WriteAndRunState(state)
				else
					Spring.Echo((actioname or "Dump").." failed!"
					..(ok and "" or " Failed to regenerate game state script."))
				end
			else
				Spring.Echo((actioname or "Dump").." impossible!"
				.." Please enable \"Write GameState\" widget.")
			end
		else
			local state,ok=GenerateFromCurrentState(nil,nil,false,SaveHeightmap)
			if ok and Script.LuaUI('WriteStateToScript') then
				local folder="Savegames"
				pcall(Spring.CreateDir,folder)
				if IsThereFolder(folder) then
					folder=folder.."/"..Game.modShortName
					pcall(Spring.CreateDir,folder)
					if IsThereFolder(Game.modShortName,"savegames") then
						folder=folder.."/"
					else
						folder=""
					end
				else
					folder=""
				end
				Spring.Echo((actioname or "Dump").." to \""..folder..filename.."\"")
				Script.LuaUI.WriteStateToScript(state,folder..filename,abbreviated,grid)
			else
				Spring.Echo((actioname or "Dump").." failed!"
					..(ok and "" or " Failed to regenerate game state script.")
					..(Script.LuaUI('WriteStateToScript') and "" or " Please enable \"Write GameState\" widget."))
			end
		end
	end

	local LastAutoSaveFrame = 0

	function gadget:DrawScreen()
		local frame=Spring.GetGameFrame()
		if frame>LastAutoSaveFrame+30*60*5 then -- 30 frames per seconds, 60 seconds per minutes, 5 minutes
			LastAutoSaveFrame=frame
			if #Spring.GetPlayerList()<=1 or Spring.IsCheatingEnabled() then
				MakeDumpNao("AutoSave","AutoSave.sav")
			end
		end
	end

	function gadget:Initialize()
		gadgetHandler:AddSyncAction("Dump",MakeDumpNao)
		local fullscript=GetFullScript()
		if fullscript then
			-- Spring crashes when I send 2MB through SendLuaRulesMsg, so I split it in smaller chunks
			local chunk_size=30000
			for chunk=0,string.len(fullscript)/chunk_size do
				Spring.SendLuaRulesMsg(gadget:GetInfo().name..":"..(1+chunk)..":"..string.sub(fullscript,1+chunk*chunk_size,(1+chunk)*chunk_size))
			end
		end
	end

end
