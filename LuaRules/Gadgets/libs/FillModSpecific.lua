
ModSpecific = nil

function CutOrAddMapSuffix(name)-- Not local so can be used wherever that .lua is included
	local version=tonumber(string.match(Game.version,"^(%d+%.%d+)") or string.match(Game.version,"^(%d+)") or 100)+(string.match(Game.version,"^[%d%.]+(%+)") and 0.009 or 0)
	local hasSuffix=string.lower(string.sub(name,-4))==".smf"
	if version<0.815 then
		if hasSuffix then
			return name
		else
			return name..".smf"
		end
	else
		if hasSuffix then
			return string.sub(name,1,-5)
		else
			return name
		end
	end
end

function FillModSpecific()
	ModSpecific = {}
	ModSpecific.ModDisplayName=Game.modName -- What the the single player menu should display
	ModSpecific.ReadmeFileName="story.txt" -- A text file the single player menu can print
	ModSpecific.CreditsFileName="credits.txt" -- A text file the single player menu can print
	ModSpecific.ModFileName=Game.modName -- Not a filename, but follows the mod renaming
	ModSpecific.ScriptFileName="script.txt"
	ModSpecific.ReloadScriptFileName="script.sav"
	ModSpecific.ExecutableFileName="spring.exe"

	ModSpecific.FactionsList={}
	for _,faction in ipairs(Spring.GetSideData()) do
		table.insert(ModSpecific.FactionsList,{
			ClearName=string.gsub(faction.caseName,"_"," "),InternalName=faction.sideName})
	end
	if not ModSpecific.FactionsList[2] then
		ModSpecific.FactionsList[2]=ModSpecific.FactionsList[1] -- Fix crashes when there's only one faction
	end
	ModSpecific.FactionsList[3]=nil -- Clamp out the chickens


	ModSpecific.BotsList={}
	for b=1,5 do
		table.insert(ModSpecific.BotsList,{
			ShortName="Shard",
			LongName="Shard: Brutal AI",
			PathAndFileName="\\AI\\Skirmish\\Shard\\0.21\\SkirmishAI.dll"})
	end


	local function AddMap(Weight,ClearName,ShortName,ExternalFileName,InternalFileName,MaxPlayers,TimeFactor,DefaultMapOptions)
		table.insert(ModSpecific.MapsList,{ClearName=ClearName,ShortName=ShortName,ExternalFileName=ExternalFileName,InternalFileName=CutOrAddMapSuffix(InternalFileName),MaxPlayers=MaxPlayers,Weight=Weight,TimeFactor=TimeFactor,DefaultMapOptions=DefaultMapOptions})
	end
	ModSpecific.MapsList = {}
	AddMap(5,"RiverDale","RD","EvoRTS-Riverdale-v06.sd7","EvoRTS-Riverdale-v06.smf",6,4,{dry=0,inv=0,alt=0,wc=0,fog=0})
	AddMap(5,"RiverDale Winter Night","RD","EvoRTS-Riverdale-v06.sd7","EvoRTS-Riverdale-v06.smf",6,4,{dry=0,inv=0,alt=1,wc=1,fog=1})
	AddMap(10,"A House Divided","AHD","EvoRTS-A_House_Divided.sd7","EvoRTS-A_House_Divided-v02.smf",6,4,{dry=1,inv=0,alt=0,wc=0,fog=0})
	AddMap(10,"The Tale of Two Hills","TTH","EvoRTS-Tale_of_Two_Hills-v03.sd7","EvoRTS-Tale_of_Two_Hills-v03.smf",6,4,{dry=0,inv=0,alt=0,wc=0,fog=0})
	AddMap(10,"General Caiaphas' Revenge","GCR","EvoRTS-CaisRevenge-v02.sd7","EvoRTS-CaisRevenge-v02.smf",6,4,{dry=1,inv=0,alt=0,wc=0,fog=0})

	if VFS.FileExists("modoptions.lua") then
		local RawModOptions=loadstring(VFS.LoadFile("modoptions.lua"))
		if type(RawModOptions)=="function" then
			RawModOptions=RawModOptions()
		end
		local ModOptions={}
		for _,mo in pairs(RawModOptions) do
			if mo.type=="list" or mo.type=="number" or mo.type=="bool" then
				local def=mo.def
				if type(def)=="boolean" then
					def=def and "1" or "0"
				end
				if type(def)=="number" then
					def=tostring(def)
				end
				local desc=mo.desc
				if type(desc)=="string" then
					desc=string.gsub(desc,"[\r\n]+"," ")
				end
				table.insert(ModOptions,{key=mo.key,name=mo.name,desc=desc,def=def})
			end
		end
		ModSpecific.MultiplayerModOptions=ModOptions
		ModSpecific.AnyModOptionWillDo=ModSpecific.MultiplayerModOptions[1].key
	else
		ModSpecific.AnyModOptionWillDo="minspeed"
	end

end
