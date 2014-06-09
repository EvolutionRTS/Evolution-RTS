local versionNumber = "1.55"
---------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
-- Changelog

------------------------
-- Version 1.54
------------------------
-- * Bug fixes and performance improvements
-- * Added TS values and better handling of screen position
-- * Improved player list management and handling of dead players

------------------------
-- Version 1.5
------------------------
-- * Rewritten code to increase performance, fps cost down by 50% in normal usage scenario.
-- * Now uses drawlists and gl.loadFont

------------------------
-- Version 1.41
------------------------
-- * Bug fixes and performance improvements

------------------------
-- Version 1.4
------------------------
-- * Performance improvements
-- * Font improvements
-- * Display extended info by pressing on i-button instead of overcomplicated arrows
-- * Drag widget with right button; drag infopanel with left button and close with right (yes i know, maybe counter-intuitive)
-- * Fixed opengl bugs

------------------------
-- version 1.32
------------------------
-- * Compatible with spring 95.0
-- * fixed bug with incorrect expand button location
-- * fixed spam errors bc of old tags
------------------------

function widget:GetInfo()
	return {
		name = "Ecostats",
		desc = "Display team eco",
		author = "Jools",
		date = "jan, 2014",
		license = "GNU GPL, v2 or later",
		layer = 99,
		enabled = false
	}
end

---------------------------------------------------------------------------------------------------
--  Declarations
---------------------------------------------------------------------------------------------------

local bestTeam, bestKills, worstLosses 						
local killCounters 					= {}
local lossCounters 					= {}
local killedHP						= {}
local lostHP						= {}
local kMat 							= {}     -- player to player kill matrix
local PmaxDmg						= 0
local comTable 						= {}
local teamData 						= {}
local allyData 						= {}
local pressedToMove, pressedHPlus, pressedHMinus, pressedWPlus, pressedWMinus -- click detection for moving the widget
local pressedExpandMove 			= false
local gamestarted 					= false
local gameover						= false
local inSpecMode					= false
local expandDown                    = false
local expandLeft                    = false
local isReplay						= Spring.IsReplay()

local infoButton			 		= {}
local playerButton					= {}
local options						= {}
local expandMove					= {}
local Teambutton					= {}

local lastPlayerChange				= 0
local lastDrawUpdate				
local drawList

local vsx,vsy                    	= gl.GetViewSizes()
local right							= true
local widgetHeight					
local widgetWidth                	= 110
local widgetPosX                 	= vsx-widgetWidth
local widgetPosY                 	= 600
local widgetRight			 	    = widgetPosX + widgetWidth
local tH						 	= 75 -- team row height
local WBadge					 	= 14 -- width of player badge (side icon)
local iPosX, iPosY
local InfotablePosX, InfotablePosY	-- Expand bar bottom left coordinates
local cW 							= 100 -- column width
local infoTableHeight 				= 520
local ctrlDown 						= false
local textsize						= 11
local textlarge						= 18
local gaiaID						= Spring.GetGaiaTeamID()
local gaiaAllyID					= select(6,Spring.GetTeamInfo(gaiaID))
local LIMITSPEED					= 2.0 -- gamespseed under which to fully update dynamic graphics

---------------------------------------------------------------------------------------------------
local announcingOn = true
local soundsOn = true -- set true if you want sounds
local snd = "LuaUI/Sounds/ding.ogg" --path to sound file
if snd == nil then soundsOn = false end

local fontPath  		= "LuaUI/Fonts/ebrima.ttf" 
local font2Path  		= "LuaUI/Fonts/ebrima.ttf"
local myFont	 		= gl.LoadFont("FreeSansBold.otf",textsize, 1.9, 40) --gl.LoadFont(fontPath,textsize,2,20)
local myFontBig	 		= gl.LoadFont(font2Path,textlarge,5,40)

local images			= {
						["arm"]					= "LuaUI/Images/ecostats/arm_default.png",
						["core"]     			= "LuaUI/Images/ecostats/core_default.png",
						["contrast"]			= "LuaUI/Images/ecostats/contrast.png",
						["borderson"]			= "LuaUI/Images/ecostats/borders.png",
						["bordersoff"]			= "LuaUI/Images/ecostats/bordersOff.png",
						["checkboxon"]			= "LuaUI/Images/ecostats/chkBoxOn.png",
						["checkboxoff"]			= "LuaUI/Images/ecostats/chkBoxOff.png",
						["more"]				= "LuaUI/Images/ecostats/ButtonMore.png",
						["less"]				= "LuaUI/Images/ecostats/ButtonLess.png",
						["default"]				= "LuaUI/Images/ecostats/default.png",
						["move"]				= "LuaUI/Images/ecostats/move.png",
						["arrowleft"]			= "LuaUI/Images/ecostats/arrowL.png",
						["arrowright"]			= "LuaUI/Images/ecostats/arrowR.png",
						["info"]				= "LuaUI/Images/ecostats/info.png",
						["dead"]     			= "LuaUI/Images/ecostats/cross.png",
						}
			
local AttackUnits			= {}
local BuilderUnits			= {}
			
---------------------------------------------------------------------------------------------------
--  Speed ups
---------------------------------------------------------------------------------------------------

local Echo 						 = Spring.Echo
local glText            		 = gl.Text

---------------------------------------------------------------------------------------------------
--  Start
---------------------------------------------------------------------------------------------------

function widget:Initialize()
	if not (Spring.GetSpectatingState() or isReplay) then
		inSpecMode = false
		Echo("Ecostats: widget loaded in active player mode")
	else
		inSpecMode = true
		Echo("Ecostats: widget loaded in spectator mode")
	end
	if Spring.GetGameSeconds() > 0 then gamestarted = true end
	
	Init()
end

function widget:Shutdown()
	 gl.DeleteList(drawList)
	 gl.DeleteList(drawListDynamic)
end

function Init()
	local maxPlayers = getMaxPlayers()
	bestKills = 0
	worstLosses = 0
	killCounters = {}
	lossCounters = {}
	killedHP = {}
	lostHP = {}
	kMat = {}
	teamData = {}
	allyData = {}
	comTable = {}
	infoButton	 = {}
	expandMove    = {}
	playerButton = {}
	iPosX = {}
	iPosY = {}
	iPanel = {}
	Teambutton = {}
	Teambutton["Next"] = {}
	Teambutton["Prev"] = {}
	right = widgetPosX/vsx > 0.5
	widgetHeight = getNbTeams()*tH+2
	
	if right then
		InfotablePosX = widgetPosX - (180 + cW*maxPlayers)
	else
		InfotablePosX = widgetPosX + widgetWidth
	end
	InfotablePosY = widgetPosY + widgetHeight
	
	if maxPlayers == 1 then
		WBadge = 18
	elseif maxPlayers == 2 or maxPlayers == 3 then
	    WBadge = 16
	else
		WBadge = 14
	end
	if maxPlayers * WBadge + 30 > widgetWidth then 
		widgetWidth = 30 + maxPlayers * WBadge
		
	end 
	
	for _,teamID in ipairs(Spring.GetTeamList()) do
		if teamID ~= gaiaID then
			killCounters[teamID] = 0
			lossCounters[teamID] = 0
			killedHP[teamID] = 0
			lostHP[teamID] = 0
			kMat[teamID] = {}
			setPlayerTable(teamID)
			playerButton[teamID] = {}
			for sortindex,enemy in ipairs(Spring.GetTeamList()) do
				kMat[teamID][sortindex] = {enemy,0} -- maintain association: 1 = pID, 2 = kills
			end
		end
	end
	
	for id,unitDef in ipairs(UnitDefs) do
		if unitDef.customParams.iscommander then
			table.insert(comTable,id)
		end
		if #(unitDef.weapons) > 0 then
			AttackUnits[id] = true
		end
		if unitDef.isBuilder then
			BuilderUnits[id] = true
		end
	end	
	
	local allyList = Spring.GetAllyTeamList()
	for _,allyID in ipairs (allyList) do
		if allyID ~= gaiaAllyID then
			setAllyData(allyID)		
			local nbPlayers 						= getNbPlayers(allyID)
			infoButton[allyID]						= {}
			expandMove[allyID] 						= {}
			Teambutton["Next"][allyID] 				= {}
			Teambutton["Prev"][allyID] 				= {}
			infoButton[allyID]["mouse"] 			= false
			infoButton[allyID]["click"] 			= false
			expandMove[allyID]["mouseover"]			= false
			Teambutton["Next"][allyID]["mouse"] 	= false
			Teambutton["Next"][allyID]["click"] 	= false
			Teambutton["Prev"][allyID]["mouse"] 	= false
			Teambutton["Prev"][allyID]["click"] 	= false
			iPanel[allyID]							= false
		end
	end
	updateButtons()
	UpdateTeams()
	if not options.disable then
		Echo("Ecostats:Options not loaded, using default settings. (This is normal during first run.)")
		setDefaults()
	end
	
	local frame = Spring.GetGameFrame()
	lastPlayerChange = frame

	
end

function Reinit()
			
	local maxPlayers = getMaxPlayers()
		
	if (not inSpecMode) and gamestarted then 
		if widgetWidth < 60 then widgetWidth = 60 end
		if tH < 50 then tH = 50 end
	else
		if widgetWidth <  110 then widgetWidth = 110 end
		if tH < 75 then tH = 75 end
	end
	
	if maxPlayers == 1 then
		WBadge = 18
	elseif maxPlayers == 2 or maxPlayers == 3 then
	    WBadge = 16
	else
		WBadge = 14
	end
	if maxPlayers * WBadge + 30 > widgetWidth then 
		widgetWidth = 30 + maxPlayers * WBadge
	end	
	if widgetPosX + widgetWidth > vsx then widgetPosX = vsx-widgetWidth end
	if widgetPosX < 0 then widgetPosX = 0 end
	
	local allyList = Spring.GetAllyTeamList()
	UpdateTeams()
	UpdateTeams()
	updateButtons()
	
end

---------------------------------------------------------------------------------------------------
--  Save / Load
---------------------------------------------------------------------------------------------------

function setDefaults()
	options = {}
	options["contrastMore"] = {}
	options["contrastLess"] = {}
	options["contrast"] = 0.2
	options["borders"] = {}
	options["borders"]["On"] = false
	options["disable"] = {}
	options["disable"]["On"] = false
	options["FPBar1"] = {}
	options["FPBar1"]["On"] = true
	options["FPBar2"] = {}
	options["FPBar2"]["On"] = true
	options["BPBar1"] = {}
	options["BPBar1"]["On"] = true
	options["BPBar2"] = {}
	options["BPBar2"]["On"] = true
	options["kills1"] = {}
	options["kills1"]["On"] = false
	options["kills2"] = {}
	options["kills2"]["On"] = true
	options["widthInc"] = {}
	options["widthDec"] = {}
	options["heightInc"] = {}
	options["heightDec"] = {}
	options["Announce"] = {}
	options["Announce"]["On"] = false
	options["resText"] = {}
	options["removeDead"] = {}
	options["resText"]["On"] = true
	options["removeDead"]["On"] = false
	vsx,vsy 			= gl.GetViewSizes()
	widgetWidth 		= 110
	widgetPosX         	= vsx-widgetWidth
	widgetPosY         	= 600
	expandDown         	= true
	expandLeft         	= true
	right 				= true
	tH					= 60
	soundsOn 			= true
end

function widget:GetConfigData(data)      -- save
	if options.Announce then
		--Echo("Saving config data")
		return {
			vsx                = vsx,
			vsy                = vsy,
			widgetPosX         = widgetPosX,
			widgetPosY         = widgetPosY,
			widgetWidth		   = widgetWidth,
			expandDown         = expandDown,
			expandLeft         = expandLeft,
			tH				   = tH,
			announcingOn 	   = options.Announce.On,
			removeDeadOn 	   = options.removeDead.On,
			resTextOn 	   	   = options.resText.On,
			soundsOn		   = soundsOn,
			bordersOn 		   = options.borders.On,
			contrast 		   = options.contrast,
			disableOn		   = options.disable.On,
			FPBar1On		   = options.FPBar1.On,
			FPBar2On		   = options.FPBar2.On,
			BPBar1On		   = options.BPBar1.On,
			BPBar2On		   = options.BPBar2.On,
			kills1On 		   = options.kills1.On,
			kills2On 		   = options.kills2.On,
			vsx                = vsx,
			vsy                = vsy,
			widgetPosX         = widgetPosX,
			widgetPosY         = widgetPosY,
			widgetWidth		   = widgetWidth,
			expandDown         = expandDown,
			expandLeft         = expandLeft,
			right			   = right,
			tH				   = tH,
		}
	end
end

function widget:SetConfigData(data)      -- load
	--Echo("Loading config data...")
	options = {}
	options["contrastMore"] = {}
	options["contrastLess"] = {}
	options["contrast"] = data.contrast or 0.3
	options["borders"] = {}
	options["borders"]["On"] = data.bordersOn or false
	options["disable"] = {}
	options["disable"]["On"] = data.disableOn or false
	options["FPBar1"] = {}
	options["FPBar1"]["On"] = data.FPBar1On or false
	options["FPBar2"] = {}
	options["FPBar2"]["On"] = data.FPBar2On or false
	options["BPBar1"] = {}
	options["BPBar1"]["On"] = data.BPBar1On or false
	options["BPBar2"] = {}
	options["BPBar2"]["On"] = data.BPBar2On or false
	options["kills1"] = {}
	options["kills1"]["On"] = data.kills1On or false
	options["kills2"] = {}
	options["kills2"]["On"] = data.kills2On or false
	options["widthInc"] = {}
	options["widthDec"] = {}
	options["heightInc"] = {}
	options["heightDec"] = {}
	options["Announce"] = {}
	options["Announce"]["On"] = data.announcingOn or false
	options["resText"] = {}
	options["removeDead"] = {}
	options["resText"]["On"] = data.resTextOn or false
	options["removeDead"]["On"] = data.removeDeadOn or false
	vsx					= data.vsx or vsx
	vsy 				= data.vsy or vsy
	widgetPosX         	= data.widgetPosX or widgetPosX
	widgetPosY         	= data.widgetPosY or widgetPosY
	widgetWidth 		= data.widgetWidth or widgetWidth
	expandDown         	= data.expandDown or expandDown
	expandLeft         	= data.expandLeft or expandLeft
	tH					= data.tH or tH
	soundsOn 			= data.soundsOn or soundsOn
end

---------------------------------------------------------------------------------------------------
--  Local
---------------------------------------------------------------------------------------------------

local function firstToUpper(str)
	return (str:sub(1,1):upper()..str:sub(2))
end

local function digitsep(amount)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1 %2')
    if (k==0) then
      break
    end
  end
  return formatted
end

local function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

local function friendlyName(teamID)
	if teamID == nil then return "NONE" end
	local _,_,_,isAIteam,side,_,_,_ = Spring.GetTeamInfo(teamID)
	if isAIteam then
		if side == "arm" then return "Arm"
		elseif side == "core" then return "Core"
		elseif not (side == nil or #side < 1) then return side
		else return ("Team " .. teamID)
		end
	else
		names=nil
		for _,pid in ipairs(Spring.GetPlayerList(teamID,true)) do
			local name,active,spectator,_,_,_,_,_,_ = Spring.GetPlayerInfo(pid)
			if not spectator then
				names=(names and names.."," or "").."<PLAYER"..pid..">"
			end
		end
		if names == nil or #names < 1 then return ("Team " .. teamID) end
		return (names and names or "")
	end
end

local function formatRes(number)
	local label
	if number > 10000 then
		label = table.concat({math.floor(round(number/1000)),"k"})
	elseif number > 1000 then
		label = table.concat({string.sub(round(number/1000,1),1,2+string.find(round(number/1000,1),".")),"k"})
	elseif number > 10 then
		label = string.sub(round(number,0),1,3+string.find(round(number,0),"."))
	else
		label = string.sub(round(number,1),1,2+string.find(round(number,1),"."))
	end
	return tostring(label)
end

local function formatRes1000(number)
	local label
	if number == nil then
		Echo(Spring.GetGameFrame(),": formatRes1000 returned nil")
		
		return nil
	end
	if number > 10000 then
		label = digitsep(round(number))
	elseif number > 1000 then
		label = digitsep(round(number))
	elseif number > 10 then
		label = string.sub(round(number,0),1,3+string.find(round(number,0),"."))
	else
		label = string.sub(round(number,1),1,2+string.find(round(number,1),"."))
	end
	return label
end

---------------------------------------------------------------------------------------------------
--  General
---------------------------------------------------------------------------------------------------

function UpdateAllPlayers()
	for _,teamID in ipairs(Spring.GetTeamList()) do
		if teamID ~= gaiaID then
			if inSpecMode then
				setPlayerTable(teamID)
			else
				local allyID = teamData[teamID].allyID
				if allyID == Spring.GetMyAllyTeamID() then setPlayerTable(teamID) end
			end
		end
	end
end

function UpdatePlayer(pID)
	if pID ~= Spring.GetGaiaTeamID then
		if inSpecMode then
			setPlayerTable(pID)
		else
			local allyID = teamData[pID].allyID
			if allyID == Spring.GetMyAllyTeamID() then setPlayerTable(pID) end
		end
	end
end

function UpdateTeams()
	local allyList = Spring.GetAllyTeamList()	
	for _,allyID in ipairs (allyList) do	
		if inSpecMode then
			setAllyData(allyID)
		else
			if allyID == Spring.GetMyAllyTeamID() then 
				setAllyData(allyID) 
			end
		end
	end
	
end

function UpdateTeam(teamID)
	if inSpecMode then
		setAllyData(teamID)
	else
		if teamID == Spring.GetMyAllyTeamID() then 
			setAllyData(teamID) 
		end
	end
end

function setPlayerTable(pID)
	
	local side, tID, isDead, commanderAlive, minc, einc, kills, losses, x, y, kills2, losses2, leaderName, leaderID, active, unitCount, spectator, country, rank
	_,leaderID,isDead,isAI,side,tID,_,_ 	= Spring.GetTeamInfo(pID)
	leaderName,active,spectator,_,_,_,_,country,rank	= Spring.GetPlayerInfo(leaderID)
	
	local tred, tgreen, tblue = Spring.GetTeamColor(pID)
	local luminance  = (tred * 0.299) + (tgreen * 0.587) + (tblue * 0.114)
	if (luminance < 0.2) then
		tred = tred + 0.25
		tgreen = tgreen + 0.25
		tblue = tblue + 0.25
	end
	
	kills2,losses2 				= Spring.GetTeamUnitStats(pID)
	_,_,_,minc 					= Spring.GetTeamResources(pID,"metal")
	_,_,_,einc 					= Spring.GetTeamResources(pID,"energy")
	x,_,y 						= Spring.GetTeamStartPosition(pID)
	commanderAlive 				= checkCommander(pID)
	kills 						= killCounters[pID]
	losses 						= lossCounters[pID]
	killedhp 					= killedHP[pID]
	losthp 						= lostHP[pID]
	unitCount 					= Spring.GetTeamUnitCount(pID)
	
	if not teamData[pID] then teamData[pID] = {} end
	
	teamData[pID]["playerID"] 		= pID
	teamData[pID]["allyID"] 		= tID
	teamData[pID]["red"]			= tred
	teamData[pID]["green"]			= tgreen
	teamData[pID]["blue"]			= tblue
	teamData[pID]["startx"]			= x
	teamData[pID]["starty"]			= y
	teamData[pID]["side"]			= side
	teamData[pID]["isDead"] 		= isDead
	teamData[pID]["hasCom"]			= commanderAlive
	teamData[pID]["minc"]			= minc
	teamData[pID]["einc"] 			= einc
	teamData[pID]["kills"]			= kills
	teamData[pID]["losses"]			= losses
	teamData[pID]["kills2"]			= kills2
	teamData[pID]["losses2"]		= losses2
	teamData[pID]["killedhp"]		= killedhp
	teamData[pID]["losthp"]			= losthp
	teamData[pID]["leaderID"]		= leaderID
	teamData[pID]["leaderName"]		= leaderName
	teamData[pID]["active"]			= active
	teamData[pID]["spectator"]		= spectator
	teamData[pID]["unitCount"]		= unitCount
	teamData[pID]["country"]		= country
	teamData[pID]["rank"]			= rank
	teamData[pID]["isAI"]			= isAI
	setPlayerFP(pID)
	setPlayerBP(pID)
	teamData[pID]["skill"]			= GetSkill(pID)
end

function setAllyData(allyID)
	if allyID == gaiaAllyID then return end
	local id = allyID + 1
	
	local playerList = Spring.GetTeamList(allyID)
	
	if #playerList > 0 and isTeamAlive(allyID) then
		for _,tID in ipairs (playerList) do
			if tID ~= gaiaID then
				setPlayerTable(tID)
			end
		end
				
		local player1 = playerList[1] --leader id
			
		if not allyData[id] then allyData[id] = {} end
		
		allyData[id]["tE"] 				= getTeamSum(allyID,"einc")
		allyData[id]["tM"] 				= getTeamSum(allyID,"minc")
		allyData[id]["tFP"]				= getTeamSum(allyID,"firepower")
		allyData[id]["tBP"]				= getTeamSum(allyID,"buildpower")
		allyData[id]["tFPM"]			= getTeamSum(allyID,"firepowerMob")
		allyData[id]["tBPA"]			= getTeamSum(allyID,"buildpowerAir")
		allyData[id]["x"]				= getTeamSum(allyID,"startx")
		allyData[id]["y"]				= getTeamSum(allyID,"starty")
		allyData[id]["validPlayers"]	= getNbPlacedPositions(allyID)
		allyData[id]["kills"]			= getTeamSum(allyID,"kills")
		allyData[id]["losses"]			= getTeamSum(allyID,"losses")
		allyData[id]["killedhp"]		= getTeamSum(allyID,"killedhp")
		allyData[id]["losthp"]			= getTeamSum(allyID,"losthp")
		allyData[id]["isAlive"]			= isTeamAlive(allyID)
		allyData[id]["leader"]			= teamData[player1]["leaderName"] or "N/A"
		allyData[id]["tFP"]				= getTeamSum(allyID,"firepower")
		allyData[id]["tFPM"]			= getTeamSum(allyID,"firepowerMob")
		allyData[id]["tBP"]				= getTeamSum(allyID,"buildpower")
		allyData[id]["tBPA"]			= getTeamSum(allyID,"buildpowerAir")
		allyData[id]["aID"]				= allyID
	else
		if options["removeDead"]["On"] then
			allyData[id] = nil
		end
	end

end

function getTeamSum(allyID,param)
	local tValue = 0
	local teamList = Spring.GetTeamList(allyID)
		
	for _,tID in ipairs (teamList) do
		if tID ~= gaiaID then
			tValue = tValue + (teamData[tID][param] or 0)
		end
	end
	
	return tValue
	
end

function getTeamStarts(team)
	
	local x, y, active, leaderID, leaderName, isDead
	local validPlayers = 0
	
	for _,pID in ipairs (Spring.GetTeamList(team)) do
		leaderID = teamData[pID].leaderID
		x = teamData[pID].startx
		y = teamData[pID].starty
		active = teamData[pID].active
		leaderName,active,spectator	= Spring.GetPlayerInfo(leaderID)				
		isDead = teamData[pID].isDead
		if leaderName and startx then
			if active and startx >= 0 and starty >= 0 or isDead then
				validPlayers = validPlayers +1
				x = x + x
				y = y + y
			end
		end
	end
	if not validPlayers == 0 then
		return math.floor(x/validPlayers), math.floor(y/validPlayers)
	else
		return nil
	end
end

function isTeamReal(allyID)
	if allyID == nil then return false end
	local leaderID, spectator, isDead, unitCount

	for _,tID in ipairs (Spring.GetTeamList(allyID)) do
		_,leaderID,isDead			= Spring.GetTeamInfo(tID)
		unitCount					= Spring.GetTeamUnitCount(tID)
		leaderName,active,spectator	= Spring.GetPlayerInfo(leaderID)
		if leaderName ~= nil or isDead or unitCount > 0 then return true end
	end
	return false
end

function isTeamAlive(teamID)
	if teamID == nil then return false end
	for _,pID in ipairs (Spring.GetTeamList(teamID)) do
		if not teamData[pID]["isDead"] then return true end
	end
	return false
end

function getNbTeams()
	local nbTeams = 0
	for _,allyID in ipairs (Spring.GetAllyTeamList()) do
		if isTeamReal(allyID) then nbTeams = nbTeams + 1 end
	end
	return nbTeams
end

function getNbPlayers(teamID)
	local nbPlayers = #(Spring.GetTeamList(teamID))
	return nbPlayers
end
	
function getMaxPlayers()
	local maxPlayers = 0
	local myNum
	for _,allyID in ipairs(Spring.GetAllyTeamList()) do
		myNum = getNbPlayers(allyID)
		if myNum > maxPlayers then maxPlayers = myNum end
	end
	
	return maxPlayers
end

function getNbActivePlayers(teamID)
	local nbPlayers = 0
	local leaderID,active,spectator,isDead, leaderName

	for _,pID in ipairs (Spring.GetTeamList(teamID)) do
		leaderID = teamData[pID].leaderID
		leaderName = teamData[pID].leaderName
		active = teamData[pID].active
		spectator = teamData[pID].spectator
		isDead = teamData[pID].isDead
		if not (spectator or isDead or leaderID == -1) and active then
			nbPlayers = nbPlayers +1
		end
	end
	return nbPlayers
end

function getNbPlacedPositions(teamID)
	local nbPlayers = 0
	local startx, starty, active, leaderID, unitCount, leaderName, isDead
	
	for _,pID in ipairs (Spring.GetTeamList(teamID)) do
		if teamData[pID] == nil then
			Echo("getNbPlacedPositions returned nil:",teamID)
			return nil
		end
		leaderID = teamData[pID].leaderID
		if leaderID == nil then
			Echo("getNbPlacedPositions returned nil:",teamID)
			return nil
		end
		startx = teamData[pID].startx or -1
		starty = teamData[pID].starty or -1
		active = teamData[pID].active
		leaderName,active,spectator	= Spring.GetPlayerInfo(leaderID)				
		
		isDead = teamData[pID].isDead
		if (active and startx >= 0 and starty >= 0 and leaderName ~= nil)  or isDead then
			nbPlayers = nbPlayers +1
		end
	end
	return nbPlayers
end

function checkCommander(pID)
	local hasCom = false
	for _, commanderID in ipairs (comTable) do
		if Spring.GetTeamUnitDefCount(pID,commanderID) > 0 then hasCom = true end
	end
	return hasCom
end

function setPlayerFP(pID)
	local pFP = 0
	local pFPMob = 0
		
	local team = teamData[pID].allyID
	for _, unitID in ipairs(Spring.GetTeamUnits(pID)) do
		local udid = Spring.GetUnitDefID(unitID)
		if udid then
			if AttackUnits[udid] and isUnitComplete(unitID) then
				pFP = pFP + (Spring.GetUnitHealth(unitID) or 0)
				if UnitDefs[udid].canMove then
					pFPMob = pFPMob + (Spring.GetUnitHealth(unitID) or 0)
				end
			end
		end
	end
	teamData[pID]["firepower"]			= pFP
	teamData[pID]["firepowerMob"]		= pFPMob
end

function setPlayerBP(pID)
	local pBP = 0
	local pBPair = 0	
	local team = teamData[pID].allyID
	
	for _, unitID in ipairs(Spring.GetTeamUnits(pID)) do			
		local udid = Spring.GetUnitDefID(unitID)
		if udid then
			if BuilderUnits[udid] and isUnitComplete(unitID) then
				pBP = pBP + (UnitDefs[udid].buildSpeed or 0)
				if UnitDefs[udid].canFly then
					pBPair = pBPair + (UnitDefs[udid].buildSpeed or 0)
				end
			end
		end
	end
	
	teamData[pID]["buildpower"]			= pBP
	teamData[pID]["buildpowerAir"]		= pBPair
end

function setPlayerResources()
	local minc, einc
	
	if inSpecMode then
		for _,data in pairs(allyData) do
			allyID = data.aID
			data["tM"] = 0
			data["tE"] = 0
			for _, teamID in ipairs (Spring.GetTeamList(allyID)) do
				if teamID ~= gaiaID then
					minc = select(4,Spring.GetTeamResources(teamID,"metal")) or 0
					einc = select(4,Spring.GetTeamResources(teamID,"energy")) or 0
					teamData[teamID]["minc"] = minc
					teamData[teamID]["einc"] = einc
					data["tM"] = data["tM"] + minc
					data["tE"] = data["tE"] + einc
				end
			end
		end
	else
		local allyID = Spring.GetMyAllyTeamID()
		local data = allyData[allyID+1]
		data["tM"] = 0
		data["tE"] = 0
		for _, teamID in ipairs (Spring.GetTeamList(allyID)) do
			if teamID ~= gaiaID then
				minc = select(4,Spring.GetTeamResources(teamID,"metal")) or 0
				einc = select(4,Spring.GetTeamResources(teamID,"energy")) or 0
				teamData[teamID]["minc"] = minc
				teamData[teamID]["einc"] = einc
				data["tM"] = data["tM"] + minc
				data["tE"] = data["tE"] + einc
			end
		end
	end	
	drawStandard()
	drawDynamic()
end

function setPlayerActivestate()
	local active
	local leaderID
	for tID,data in pairs(teamData) do
		_,leaderID 	= Spring.GetTeamInfo(tID)
		_,active	= Spring.GetPlayerInfo(leaderID)
		data["active"] 			= active
	end
end

function isUnitComplete(UnitID)
	local health,maxHealth,paralyzeDamage,captureProgress,buildProgress=Spring.GetUnitHealth(UnitID)
	if buildProgress and buildProgress>=1 then
		return true
	else
		return false
	end
end

function GetSkill(playerID)
	local customtable = select(10,Spring.GetPlayerInfo(playerID)) -- player custom table
	
	if not customtable then return "N/A" end
	
	local tsMu = customtable.skill 
	local tsSigma = customtable.skilluncertainty
	local tskill = ""
	if tsMu then
		tskill = tsMu and tonumber(tsMu:match("%d+%.?%d*")) or 0
		tskill = round(tskill,0)
		if string.find(tsMu, ")") then
			tskill = "\255"..string.char(190)..string.char(140)..string.char(140) .. tskill -- ')' means inferred from lobby rank
		else
		
			-- show privacy mode
			local priv = ""
			if string.find(tsMu, "~") then -- '~' means privacy mode is on
				priv = "\255"..string.char(200)..string.char(200)..string.char(200) .. "*" 		
			end
			
			--show sigma
			if tsSigma then -- 0 is low sigma, 3 is high sigma
				tsSigma=tonumber(tsSigma)
				local tsRed, tsGreen, tsBlue 
				if tsSigma > 2 then
					tsRed, tsGreen, tsBlue = 190, 130, 130
				elseif tsSigma == 2 then
					tsRed, tsGreen, tsBlue = 140, 140, 140
				elseif tsSigma == 1 then
					tsRed, tsGreen, tsBlue = 195, 195, 195
				elseif tsSigma < 1 then
						tsRed, tsGreen, tsBlue = 250, 250, 250
				end
				tskill = priv .. "\255"..string.char(tsRed)..string.char(tsGreen)..string.char(tsBlue) .. tskill
			else
				tskill = priv .. "\255"..string.char(195)..string.char(195)..string.char(195) .. tskill --should never happen
			end
		end
	else
		tskill = "\255"..string.char(160)..string.char(160)..string.char(160) .. "?"
	end
	return tskill
end

---------------------------------------------------------------------------------------------------
--  User interface
---------------------------------------------------------------------------------------------------

function IsOnButton(x, y, BLcornerX, BLcornerY,TRcornerX,TRcornerY)
	if BLcornerX == nil then return false end
	-- check if the mouse is in a rectangle

	return x >= BLcornerX and x <= TRcornerX
	                      and y >= BLcornerY
	                      and y <= TRcornerY

end

function updateButtons()
	
	if widgetPosX < 0 then
		widgetPosX = 0
	elseif widgetPosX + widgetWidth > vsx then
		widgetPosX = vsx-widgetWidth
	end

	if widgetPosY < 0 then
		widgetPosY = 0
	elseif widgetPosY + widgetHeight > vsy then
		widgetPosY = vsy - widgetHeight
	end
	
	widgetRight = widgetPosX + widgetWidth
	if widgetPosX + widgetWidth/2 > vsx/2 then
		right = true
	else
		right = false
	end
		
	local drawpos = 0
	
	for _, data in pairs(allyData) do
		local allyID = data.aID
		
		if allyID ~= gaiaAllyID then 
			
			local w1 = 14
			local x1, y1, x2, y2
			local nbPlayers = getNbPlayers(allyID)
			local maxPlayers = getMaxPlayers()
			local lm = 20
			local w = 180 + cW*nbPlayers
			
			if inSpecMode then
				widgetHeight = getNbTeams()*tH+2
			else
				widgetHeight = tH+2
			end
			
			x1 	= widgetPosX + 2
			
			iPosX[allyID] = InfotablePosX
			iPosY[allyID] = InfotablePosY
			
			if iPosX[allyID] < 0 then iPosX[allyID] = 0 end
			if iPosX[allyID] + w > vsx then iPosX[allyID] = vsx - w end
			if iPosY[allyID] - infoTableHeight < 0 then iPosY[allyID] = infoTableHeight end
			if iPosY[allyID]  > vsy then iPosY[allyID] = vsy  end
			
			x2 = x1 + w1
			y1 = widgetPosY + widgetHeight - (drawpos)*tH - w1 - 3 
			y2 = y1 + w1
			
			--Echo("IB1",allyID,infoButton[allyID])
			
			infoButton[allyID]["x1"] 		= x1
			infoButton[allyID]["y1"] 		= y1
			infoButton[allyID]["x2"] 		= x2
			infoButton[allyID]["y2"] 		= y2
			
			--Echo("IB2",allyID,infoButton[allyID].y1)

			local x3, y3, x4, y4
			local w2 = 18
			
			local x5, y5, x6, y6
			
			x5 	= iPosX[allyID] + lm
			x6 	= iPosX[allyID] + lm + 20
			y6 	= iPosY[allyID] - 25
			y5 	= y6 - 20
			
			expandMove[allyID]["x1"] 		= x5
			expandMove[allyID]["y1"] 		= y5
			expandMove[allyID]["x2"] 		= x6
			expandMove[allyID]["y2"] 		= y6
			
			local x7,x8,x9,x10,y7,y8,y9,y10
			
			x7 = iPosX[allyID] + w/2 - 60
			x8 = x7 + 12 
			y8 = iPosY[allyID] - 25
			y7 = y8 - 18
			
			x9 = iPosX[allyID] + w/2 + 38
			x10 = x9 + 12
			y10 = iPosY[allyID] - 25
			y9 = y10 - 18
			
			Teambutton["Prev"][allyID]["x1"] = x7
			Teambutton["Prev"][allyID]["x2"] = x8
			Teambutton["Next"][allyID]["x1"] = x9
			Teambutton["Next"][allyID]["x2"] = x10
			Teambutton["Prev"][allyID]["y1"] = y7
			Teambutton["Prev"][allyID]["y2"] = y8
			Teambutton["Next"][allyID]["y1"] = y9
			Teambutton["Next"][allyID]["y2"] = y10
		end
		
		for i,tID in ipairs(Spring.GetTeamList(allyID)) do
			playerButton[tID]["x1"] = widgetPosX + WBadge*(i-1) + 25 + (WBadge-14)*4 
			playerButton[tID]["x2"] = widgetPosX + WBadge*(i-1) + 25 + (WBadge-14)*4 + WBadge
			playerButton[tID]["y1"] = widgetPosY + widgetHeight - tH*(drawpos) - 16 - (WBadge-14)
			playerButton[tID]["y2"] = widgetPosY + widgetHeight - tH*(drawpos) - 16 - (WBadge-14) + WBadge
			playerButton[tID]["pID"] = tID
			
			if not inSpecMode then 
				playerButton[tID]["x1"] = widgetPosX + WBadge*(i-1) + 25 + (WBadge-14)*4  - 10
				playerButton[tID]["x2"] = widgetPosX + WBadge*(i-1) + 25 + (WBadge-14)*4 + WBadge - 10
				
			end
		end
		
		if isTeamReal(allyID) and (allyID == Spring.GetMyAllyTeamID() or inSpecMode) then
			drawpos = drawpos + 1
		end
		data["drawpos"] = drawpos
	end
end

---------------------------------------------------------------------------------------------------
--  Call-ins
---------------------------------------------------------------------------------------------------

function widget:PlayerChanged(playerID)
	local frame = Spring.GetGameFrame()
	lastPlayerChange = frame
	if not (Spring.GetSpectatingState() or isReplay) then
		if inSpecMode then Echo("Ecostats: widget now in active player mode.") end
		inSpecMode = false
		UpdateTeams()
	else
		if not inSpecMode then Echo("Ecostats: widget now in spectator mode.") end
		inSpecMode = true
		Reinit()
	end
	drawStandard()
	drawDynamic()
end

function widget:UnitFinished(unitID, unitDefID, teamID)
	team = teamData[teamID]["allyID"]
	if teamID ~= nil and isUnitComplete(unitID) then
		--Echo("Unit is finished. Parameters:",unitID, unitDefID, teamID)
		UpdateTeam(team)
	end
end

function widget:UnitTaken(unitID, unitDefID, unitTeam, newTeam)
	local newteam = teamData[newTeam]["allyID"]
	local oldteam = teamData[unitTeam]["allyID"]
	if newTeam ~= nil then UpdateTeam(newteam) end
	if oldTeam ~= nil then UpdateTeam(oldteam) end
end

function widget:UnitGiven(unitID, unitDefID, unitTeam, oldTeam)
	local newteam = teamData[unitTeam]["allyID"]
	local oldteam = teamData[oldTeam]["allyID"]
	if newTeam ~= nil then UpdateTeam(newteam) end
	if oldTeam ~= nil then UpdateTeam(oldteam) end
end

function widget:UnitDestroyed(u,ud,ut,a,ad,at) --unitID, unitDefID, teamID, attackerID
	local uteam, ateam
	a = Spring.GetUnitLastAttacker(u)
	--Echo("Unit attacker",a)
	if a then at = Spring.GetUnitTeam(a) end
	if ut then
		uteam = teamData[ut]["allyID"]
		--Echo("Unit is destroyed!. Parameters:",ut,at)
		UpdateTeam(uteam)
	end

	if at then
		ateam = teamData[at]["allyID"]
		--Echo("Unit is destroyed!. Parameters:",ut,at)
		UpdateTeam(ateam)
	end

	local function sortByLargest(v1,v2)
		return v1[2] > v2[2]
	end
	
	local function sortByTeam(v1,v2)
		return v1[1] < v2[1]
	end
	
	if ut and at and (not Spring.AreTeamsAllied(ut,at)) and isUnitComplete(u) and u and a and u~=a then
		local _,uhp =  Spring.GetUnitHealth(u)
		--local playerlist = Spring.GetTeamList()
		killCounters[at]=killCounters[at]+1
		lossCounters[ut]=lossCounters[ut]+1
		killedHP[at] =  killedHP[at] + uhp
		lostHP[ut] = lostHP[ut] + uhp
		
		table.sort(kMat[at],sortByTeam)
		
		local sortindex = ut + 1
		
		kMat[at][sortindex][2] = kMat[at][sortindex][2] + uhp
		if kMat[at][sortindex][2] > PmaxDmg then PmaxDmg = kMat[at][sortindex][2] end
		
		table.sort(kMat[at],sortByLargest)
				
		if lossCounters[ut]>worstLosses then
			worstLosses = lossCounters[ut]
		end
		if killCounters[at]>bestKills then
			bestKills=killCounters[at]
			if at~=bestTeam then
				bestTeam=at
				if options["Announce"]["On"] then
					if soundsOn then Spring.PlaySoundFile(snd) end
					Spring.SendMessage(friendlyName(bestTeam) .. " has taken the lead with " .. bestKills .. " kills.")
				end
			end
		end
	end
end

function widget:GameStart()
	gamestarted = true
	UpdateAllPlayers()
end

function widget:GameOver()
	gameover = true
	UpdateAllPlayers()
end

function widget:TeamDied(TeamID)
	local frame = Spring.GetGameFrame()
	lastPlayerChange = frame
	if not (Spring.GetSpectatingState() or isReplay) then
		if inSpecMode then Echo("Ecostats: widget now in active player mode.") end
		inSpecMode = false
		UpdateTeams()
	else
		if not inSpecMode then Echo("Ecostats: widget now in spectator mode.") end
		inSpecMode = true
		Reinit()
	end	
end

function widget:MapDrawCmd(playerID, cmdType, px, py, pz, labeltext)
	if not gamestarted then 
		UpdateTeams() 
		drawStandard()
		drawDynamic()
	end
end

function widget:TweakMouseMove(x,y,dx,dy,button)
	if pressedToMove ~= nil then
		if moveStartX == nil then                                                      -- move widget on y axis
			moveStartX = x - widgetPosX
		end
		if moveStartY == nil then                                                      -- move widget on y axis
			moveStartY = y - widgetPosY
		end
		widgetPosX = widgetPosX + dx
		widgetPosY = widgetPosY + dy
		
		updateButtons()
		drawStandard()
		drawDynamic()
	end
end

function widget:TweakMousePress(x, y, button)
	if button == 1 then
		local x0, x1
		
		if right then
			x0 = widgetPosX-200
		else
			x0 = widgetPosX
		end
		x1 = x0 + 200 + widgetWidth

		if IsOnButton(x, y, options["contrastLess"]["x1"],options["contrastLess"]["y1"],options["contrastLess"]["x2"],options["contrastLess"]["y2"]) then
			options["contrast"] = options["contrast"] - 0.1
			if options["contrast"] < 0 then options["contrast"] = 0 end
			Echo("Contrast = " .. formatRes1000(options["contrast"]))
			return true
		elseif IsOnButton(x, y, options["contrastMore"]["x1"],options["contrastMore"]["y1"],options["contrastMore"]["x2"],options["contrastMore"]["y2"]) then
			options["contrast"] = options["contrast"] + 0.1
			if options["contrast"] > 1.0 then options["contrast"] = 1.0 end
			Echo("Contrast = " .. formatRes1000(options["contrast"]))
			return true
		
		elseif IsOnButton(x, y, options["borders"]["x1"],options["borders"]["y1"],options["borders"]["x2"],options["borders"]["y2"]) then
			options["borders"]["On"] = not options["borders"]["On"]
			return true
		
		elseif IsOnButton(x, y, options["widthInc"]["x1"],options["widthInc"]["y1"],options["widthInc"]["x2"],options["widthInc"]["y2"]) then
			pressedWPlus = true
			widgetWidth = widgetWidth + 5
			if widgetWidth > 500 then widgetWidth = 500 end
			if widgetPosX + widgetWidth > vsx then widgetPosX = vsx - widgetWidth end
			return true
		
		elseif IsOnButton(x, y, options["widthDec"]["x1"],options["widthDec"]["y1"],options["widthDec"]["x2"],options["widthDec"]["y2"]) then
			pressedWMinus = true
			widgetWidth = widgetWidth - 5
			if widgetWidth < 25 then widgetWidth = 25 end
			return true		
		elseif IsOnButton(x, y, options["heightInc"]["x1"],options["heightInc"]["y1"],options["heightInc"]["x2"],options["heightInc"]["y2"]) then
			pressedHPlus = true
			tH = tH + 2
			if tH > 100 then tH = 100 end
			return true
		
		elseif IsOnButton(x, y, options["heightDec"]["x1"],options["heightDec"]["y1"],options["heightDec"]["x2"],options["heightDec"]["y2"]) then
			pressedHMinus = true
			tH = tH - 2
			if tH < 4 then tH = 4 end
			return true
			
		elseif IsOnButton(x, y, options["disable"]["x1"],options["disable"]["y1"],options["disable"]["x2"],options["disable"]["y2"]) then
			options["disable"]["On"] = not options["disable"]["On"]
			return true
		elseif IsOnButton(x, y, options["Announce"]["x1"],options["Announce"]["y1"],options["Announce"]["x2"],options["Announce"]["y2"]) then
			options["Announce"]["On"] = not options["Announce"]["On"]	
			return true
		elseif IsOnButton(x, y, options["FPBar1"]["x1"],options["FPBar1"]["y1"],options["FPBar1"]["x2"],options["FPBar1"]["y2"]) then
			options["FPBar1"]["On"] = not options["FPBar1"]["On"]	
			return true	
		elseif IsOnButton(x, y, options["FPBar2"]["x1"],options["FPBar2"]["y1"],options["FPBar2"]["x2"],options["FPBar2"]["y2"]) then
			options["FPBar2"]["On"] = not options["FPBar2"]["On"]	
			return true
		elseif IsOnButton(x, y, options["BPBar1"]["x1"],options["BPBar1"]["y1"],options["BPBar1"]["x2"],options["BPBar1"]["y2"]) then
			options["BPBar1"]["On"] = not options["BPBar1"]["On"]	
			return true	
		elseif IsOnButton(x, y, options["BPBar2"]["x1"],options["BPBar2"]["y1"],options["BPBar2"]["x2"],options["BPBar2"]["y2"]) then
			options["BPBar2"]["On"] = not options["BPBar2"]["On"]	
			return true	
		elseif IsOnButton(x, y, options["kills1"]["x1"],options["kills1"]["y1"],options["kills1"]["x2"],options["kills1"]["y2"]) then
			options["kills1"]["On"] = not options["kills1"]["On"]	
			return true		
		elseif IsOnButton(x, y, options["kills2"]["x1"],options["kills2"]["y1"],options["kills2"]["x2"],options["kills2"]["y2"]) then
			options["kills2"]["On"] = not options["kills2"]["On"]	
			return true	
		elseif IsOnButton(x, y, options["removeDead"]["x1"],options["removeDead"]["y1"],options["removeDead"]["x2"],options["removeDead"]["y2"]) then
			options["removeDead"]["On"] = not options["removeDead"]["On"]	
			return true
		elseif IsOnButton(x, y, options["resText"]["x1"],options["resText"]["y1"],options["resText"]["x2"],options["resText"]["y2"]) then
			options["resText"]["On"] = not options["resText"]["On"]	
			return true
		elseif IsOnButton(x, y, widgetPosX, widgetPosY, widgetPosX + widgetWidth, widgetPosY + widgetHeight) or 
		IsOnButton(x, y, x0, widgetPosY - 300, x1, widgetPosY) 
		then		
			pressedToMove = true
			return true
		end -- end Button == 1
	else
		return false
	end
end

function widget:TweakMouseRelease(x,y,button)
	pressedToMove = nil                                             
	pressedHPlus = false
	pressedHMinus = false
	pressedWPlus = false
	pressedWMinus = false
end

function widget:KeyPress(key, mods, isRepeat) 
	if (key == 0x132) and (not isRepeat) and not (mods.shift) and (not mods.alt) then -- ctrl
		ctrlDown = true
	end
	return false
end

function widget:KeyRelease(key) 
	if (key == 0x132)  then -- ctrl
		ctrlDown = false
	end
	return false
end

function widget:MouseMove(x, y, dx, dy, button)
	if pressedExpandMove then
		for _,data in pairs (allyData) do
			local allyID = data.aID
			
			if infoButton[allyID]["click"] then nbPlayers = getNbPlayers(allyID) end
		end
		
		local w = 180 + cW*getMaxPlayers()
		
		InfotablePosX = InfotablePosX + dx
		InfotablePosY = InfotablePosY + dy
		
		if InfotablePosX < 0 then
			InfotablePosX = 0
		end
		
		if InfotablePosX + w  > vsx then
			InfotablePosX = vsx - w
		end
		
		updateButtons()
		setPlayerResources()
		drawStandard()
		drawDynamic()
		return true
	end
	
	if pressedToMove then
		if moveStartX == nil then                                                      -- move widget on y axis
			moveStartX = x - widgetPosX
		end
		if moveStartY == nil then                                                      -- move widget on y axis
			moveStartY = y - widgetPosY
		end
		widgetPosX = widgetPosX + dx
		widgetPosY = widgetPosY + dy

		updateButtons()
		setPlayerResources()
		drawStandard()
		drawDynamic()
		return true
	end
	return false
end

function widget:MousePress(x, y, button)
	----------------
	-- LEFT BUTTON
	----------------
		
	if button == 1 then	
		
		local playerlist = Spring.GetTeamList()
		local x1, x2, y1, y2		
		local pressedExpand = false
		local nbPlayers
		local x7, y7, x8, y8, pID
		local x9, y9, x10, y10 
		local x11,x12,x13,x14,y11,y12,y13,y14
		local x15,x16,y15,y16
		
		for _,data in pairs (allyData) do
			local allyID = data.aID
			local allyDataID = allyID+1
			if allyID ~= gaiaAllyID then				
				nbPlayers = getNbPlayers(allyID)
				
				-- info-button
				x1 = infoButton[allyID]["x1"]
				x2 = infoButton[allyID]["x2"]
				y1 = infoButton[allyID]["y1"]
				y2 = infoButton[allyID]["y2"]
				
				-- move infotable button	
				x9 = expandMove[allyID]["x1"]
				x10 = expandMove[allyID]["x2"]
				y9 = expandMove[allyID]["y1"]
				y10 = expandMove[allyID]["y2"]
				
				-- prev/next allyID
				x11 = Teambutton["Prev"][allyID]["x1"]
				x12 = Teambutton["Prev"][allyID]["x2"]
				y11 = Teambutton["Prev"][allyID]["y1"]
				y12 = Teambutton["Prev"][allyID]["y2"]

				x13 = Teambutton["Next"][allyID]["x1"]
				x14 = Teambutton["Next"][allyID]["x2"]
				y13 = Teambutton["Next"][allyID]["y1"]
				y14 = Teambutton["Next"][allyID]["y2"]
								
				-- infotable coords
				x15 = iPosX[allyID]
				y16 = iPosY[allyID]
				x16 = x15 + 180 + cW*getNbPlayers(allyID)
				y15 = y16 - infoTableHeight
				
				-- info-button
				if IsOnButton(x, y, x1, y1, x2, y2) and (not options["removeDead"]["On"] or allyData[allyDataID]["isAlive"]) then 
					for _,data in pairs (allyData) do
						local aID = data.aID
						if aID ~= allyID then
							infoButton[aID]["click"] = false
						end
					end
					infoButton[allyID]["click"] = not infoButton[allyID]["click"]
					drawStandard()
					drawDynamic()
					return true
				end
				
				-- infotable active
				if infoButton[allyID]["click"] then
						
					-- prev team
					if IsOnButton(x, y, x11, y11, x12, y12) and inSpecMode then
						if allyID > 0 then
							local prevAlly = FindPrevAlly(allyID)
							if prevAlly then
								infoButton[allyID]["click"] = false
								infoButton[prevAlly]["click"] = true
							end
							drawStandard()
							drawDynamic()
							return true
						end
						
					-- next team
					elseif IsOnButton(x, y, x13, y13, x14, y14) and inSpecMode  then
						if  allyID <  getNbTeams() - 1  then
							local nextAlly = FindNextAlly(allyID)
							if nextAlly then
								infoButton[allyID]["click"] = false
								infoButton[nextAlly]["click"] = true
							end
							drawStandard()
							return true
						end
		
					-- just move infotable
					elseif IsOnButton(x, y, x9, y9, x10, y10) or IsOnButton(x, y, x15, y15, x16, y16) then 	
						pressedExpandMove = true
						drawStandard()
						drawDynamic()
						return true
					end
				end
			end
		end
		
		-- main widget buttons
		for _,teamID in ipairs (playerlist) do
			if teamID ~= gaiaID and not teamData[teamID].isDead then
				local allyID = teamData[teamID].allyID
				
				if isTeamReal(allyID) and (allyID == Spring.GetMyAllyTeamID() or inSpecMode)then			
					x7 = playerButton[teamID]["x1"]
					x8 = playerButton[teamID]["x2"]
					y7 = playerButton[teamID]["y1"]
					y8 = playerButton[teamID]["y2"]
					
					if IsOnButton(x, y, x7, y7, x8, y8) then
						if ctrlDown and teamData[teamID].hasCom then
							local com
							for _, commanderID in ipairs (comTable) do
								com  = Spring.GetTeamUnitsByDefs(teamID,commanderID)[1] or com
							end
				
							if com then
				
								local cx, cy, cz
								local camState = Spring.GetCameraState()
								cx, cy, cz = Spring.GetUnitPosition(com)
				
								if camState and cx then
									camState["px"] = cx
									camState["py"] = cy
									camState["pz"] = cz
									camState["height"] = 800
									Spring.SetCameraState(camState,2)
									if inSpecMode then Spring.SelectUnitArray({com}) end
								end
							end
						elseif not ctrlDown then
							local sx = teamData[teamID].startx
							local sz = teamData[teamID].starty
							local sy = Spring.GetGroundHeight(sx,sz)
							local camState = Spring.GetCameraState()
							if camState and sx and sz and sx > 0 and sz > 0 then
								camState["px"] = sx
								camState["py"] = sy
								camState["pz"] = sz
								camState["height"] = 5000
								Spring.SetCameraState(camState,2)
							end
						end
					end
				end
			end
		end
				
		return false
	----------------
	-- RIGHT BUTTON
	----------------
	elseif button == 2 then
		if IsOnButton(x,y,widgetPosX,widgetPosY,widgetPosX+widgetWidth,widgetPosY+widgetHeight) then
			pressedToMove = true
			return true
		end
	elseif button == 3 then
		local x5, y5, x6, y6
		local w
		
		for _,data in pairs (allyData) do
			local allyID = data.aID
			
			if allyID ~= gaiaAllyID then
				w = 180 + cW*getNbPlayers(allyID)
				
				x5 = iPosX[allyID]
				x6 = x5 + w
				y6 = iPosY[allyID]
				y5 = y6 - infoTableHeight
				
				
				if infoButton[allyID]["click"] then	
					if IsOnButton(x, y, x5, y5, x6, y6) then
						infoButton[allyID]["click"] = false
						drawStandard()
						drawDynamic()
						return true
					end
				end
			end
		end
		
		-- second loop is needed for drag detection, because otherwise it returns true too soon
		for _,data in pairs (allyData) do
		local allyID = data.aID
			if IsOnButton(x,y,widgetPosX,widgetPosY,widgetPosX+widgetWidth,widgetPosY+widgetHeight) then
				pressedToMove = true
				drawStandard()
				drawDynamic()
				return true
			else
				return false
			end
		end
	else
		return false
	end
end

function widget:MouseRelease(x,y,button)
	if button == 1 then 
		pressedExpandMove = false 
	elseif button == 2 or button == 3 then
		pressedToMove = nil                                              -- ends move action
	end
end

function widget:IsAbove(x, y)
	local allyList = Spring.GetAllyTeamList()
	local playerlist = Spring.GetTeamList()
	local x1, x2, y1, y2
	local x3, x4, y3, y4
	local x5, x6, y5, y6
	local x7, x8, y7, y8
	local x9, x10, y9, y10
	local x11, x12, y11, y12
	local w = 180 + cW*getMaxPlayers()
	local speed,_,paused = Spring.GetGameSpeed()
	
	--player faction button
	for _,teamID in ipairs (playerlist) do
		if teamID ~= gaiaID then
			x5 = playerButton[teamID]["x1"]
			x6 = playerButton[teamID]["x2"]
			y5 = playerButton[teamID]["y1"]
			y6 = playerButton[teamID]["y2"]
			
			playerButton[teamID]["mouse"] = IsOnButton(x, y, x5, y5, x6, y6)
			
			if IsOnButton(x,y, x5,y5,x6,y6) then
				if (not paused) and speed < LIMITSPEED and (not isReplay) then
					drawDynamic()
				end
				return true
			end
		end
	end
	
	--team infobutton
	for _,allyID in ipairs (allyList) do
		if allyID ~= gaiaAllyID then
				
			x1 = infoButton[allyID]["x1"]
			x2 = infoButton[allyID]["x2"]
			y1 = infoButton[allyID]["y1"]
			y2 = infoButton[allyID]["y2"]
			infoButton[allyID]["mouse"] = IsOnButton(x, y, x1, y1, x2, y2)
			
			if IsOnButton(x, y, x1, y1, x2, y2) then
				if (not paused) and speed < LIMITSPEED and (not isReplay) then
					drawDynamic()
				end
				return true
			end
			if infoButton[allyID]["click"] then
				-- move expand table button
				x7 = expandMove[allyID]["x1"]
				x8 = expandMove[allyID]["x2"]	
				y7 = expandMove[allyID]["y1"]	
				y8 = expandMove[allyID]["y2"]	
				expandMove[allyID]["mouseover"] = IsOnButton(x, y, x7, y7, x8, y8)
				
				if IsOnButton(x, y, x7, y7, x8, y8) then
					if (not paused) and speed < LIMITSPEED and (not isReplay) then
						drawDynamic()
					end
					return true
				end
				
				--next/prev team
				x9 = Teambutton["Prev"][allyID]["x1"]
				x10 = Teambutton["Prev"][allyID]["x2"]
				y9 = Teambutton["Prev"][allyID]["y1"]
				y10 = Teambutton["Prev"][allyID]["y2"]
				
				Teambutton["Prev"][allyID]["mouse"] = IsOnButton(x, y, x9, y9, x10, y10)
				
				if IsOnButton(x, y, x9, y9, x10, y10) then
					if (not paused) and speed < LIMITSPEED and (not isReplay) then
						drawDynamic()
					end
					return true
				end
				
				x11 = Teambutton["Next"][allyID]["x1"]
				x12 = Teambutton["Next"][allyID]["x2"]
				y11 = Teambutton["Next"][allyID]["y1"]
				y12 = Teambutton["Next"][allyID]["y2"]
				Teambutton["Next"][allyID]["mouse"] = IsOnButton(x, y, x11, y11, x12, y12)
				
				if IsOnButton(x, y, x11, y11, x12, y12) then
					if (not paused) and speed < LIMITSPEED and (not isReplay) then
						drawDynamic()
					end
					return true
				end
			end
		end
	end
	
	for _,allyID in ipairs (allyList) do
		if allyID ~= gaiaAllyID then
			if IsOnButton(x,y, InfotablePosX, InfotablePosY-infoTableHeight, InfotablePosX + w, InfotablePosY) and infoButton[allyID]["click"] then
				iPanel[allyID] = true
			else
				iPanel[allyID] = false
			end
		end
	end
	
	return false
end

function widget:ViewResize(viewSizeX, viewSizeY)
	vsx,vsy = gl.GetViewSizes()
	Reinit()
end

function FindNextAlly(allyID)
	
	local allyDataID = allyID+1
	for i=allyDataID,#allyData do
		if allyData[i+1] then return i end
	end
	return false
end

function FindPrevAlly(allyID)
	
	local allyDataID = allyID+1
	for i=allyDataID,1,-1 do
		if allyData[i-1] then return i-2 end
	end
	return false
end


---------------------------------------------------------------------------------------------------
--  Draw
---------------------------------------------------------------------------------------------------

function drawDynamic()
	
	if (drawListDynamic) then gl.DeleteList(drawListDynamic) end
	
	--
	
	local function drawFunction()

		local t = Spring.GetGameSeconds()
		
		for _, data in pairs(allyData) do
			local aID = data.aID
			local drawpos = data.drawpos
			
			if isTeamReal(aID) and (aID == Spring.GetMyAllyTeamID() or inSpecMode) and aID ~= gaiaAllyID then
				
				local posy = tH*(drawpos)
				local label, isAlive, hasCom
				
				-- Infobutton
				if not infoButton[aID]["click"] then
					DrawInfoButton(aID, infoButton[aID]["mouse"],right,false)
				else
					DrawInfoButton(aID, infoButton[aID]["mouse"],right,true)
				end
				
				-- Expand table border and buttons
				if infoButton[aID]["click"] then
					DrawExpandTableBorders(aID)
					DrawExpandTableButtons(aID)
				end
				
				local teamList = Spring.GetTeamList(aID)
				
				-- Player faction images
				for i, tID  in ipairs (teamList) do
					if tID ~= gaiaID then
						
						local tData = teamData[tID]
						local r = tData.red or 1
						local g = tData.green or 1
						local b = tData.blue or 1	
						local alpha, sideImg
						local side = tData.side
						local posx = WBadge*(i-1)
						
						sideImg = images[side] or images["default"]
					
						data["isAlive"] = not tData.isDead
						hasCom = tData.hasCom
										
						if Spring.GetGameSeconds() > 0 then
							if not tData.isDead then
								if tData.active then
									alpha = 1
								else
									alpha = 0.3
								end						
								
								if hasCom then
									DrawSideImage(sideImg,posx,posy, r, g, b,alpha,false,playerButton[tID]["mouse"],t, false)--big icon	
								else
									DrawSideImage(sideImg,posx,posy, r, g, b,alpha,true,playerButton[tID]["mouse"],t, false) --small icon
								end
							else
								sideImg = images["dead"]
								DrawSideImage(sideImg,posx,posy, r, g, b,alpha,true,playerButton[tID]["mouse"],t, true) --dead, big icon
							end
						else
							DrawBox( posx, posy, r, g, b)
						end
					end
				end
			end
		end
	end
	
	--
	
	drawListDynamic = gl.CreateList(drawFunction)
end
		
function drawStandard()
	
	if (drawList) then gl.DeleteList(drawList) end
	
	local function drawFunction()
	
		local maxMetal 					= 0
		local maxEnergy 				= 0
		local maxFP 					= 0
		local maxBP 					= 0
		local maxHP 					= 0
		local splits
		
		
		if not gamestarted then updateButtons() end
		
		for _, data in pairs(allyData) do
			local aID = data.aID
			
			if isTeamReal(aID) and (aID == Spring.GetMyAllyTeamID() or inSpecMode) and aID ~= gaiaAllyID then
					
				-- Expanded table
				if infoButton[aID]["click"] then
					--Echo("ET:",aID)
					DrawExpandTable(aID)
				end
								
				if data["tM"] and data["tM"] > maxMetal then
					maxMetal = data["tM"]
				end
				if data["tE"] and data["tE"] > maxEnergy then
					maxEnergy = data["tE"]
				end
				if data["tFP"] and data["tFP"] > maxFP then
					maxFP = data["tFP"]
				end
				if data["tBP"] and data["tBP"] > maxBP then
					maxBP = data["tBP"]
				end
				if data["killedhp"] and data["killedhp"] > maxHP then
					maxHP = data["killedhp"]
				end
				if data["losthp"] and data["losthp"] > maxHP then
					maxHP = data["losthp"]
				end
			end
		end
	
		splits = math.floor(0.001*maxHP/widgetWidth)
	
		for _, data in pairs(allyData) do
			local aID = data.aID
			local drawpos = data.drawpos
			
			if isTeamReal(aID) and (aID == Spring.GetMyAllyTeamID() or inSpecMode) and aID ~= gaiaAllyID then
			
				local posy = tH*(drawpos)
				if data["isAlive"] then DrawBackground(posy) end
				
				local t = Spring.GetGameSeconds()
				if data["isAlive"] and t > 5 and gamestarted and not gameover then
					DrawEBar(data["tE"]/maxEnergy,posy)
					DrawEText(data["tE"],posy)
					DrawKillDeathText(data["kills"],data["losses"],posy)
					DrawKillBar(data["killedhp"],posy,splits)
					DrawLossesBar(data["losthp"],posy,splits)
				else
					if gamestarted and t < 5 then
						DrawLabelCT("(Go!)", posy,t)
					elseif not gamestarted then
						setPlayerActivestate()
						local nbPlayers = getNbPlayers(aID)
						local nbActive = getNbActivePlayers(aID)
						local nbPlaced = getNbPlacedPositions(aID)
						if nbActive > 0 then
							if nbPlayers > 1 and nbPlaced > 0 then
								DrawLabelCM("(On their marks)", posy)
								DrawLabelCM2(table.concat({"   ",nbPlaced,"/",nbPlayers}), posy)
							elseif nbPlayers > 1 then
								DrawLabelC("(Warming up)", posy)
							elseif nbPlayers == 1 then
								if nbPlaced == 1 then
									DrawLabelCM("(On his marks)", posy)
								else
									DrawLabelC("(Warming up)", posy)
								end
							end
						else
							DrawLabelC("(No one here)", posy)
						end
					end
				end
				if data["isAlive"] and t > 5 and not gameover then
				DrawMBar(data["tM"]/maxMetal,posy)
				DrawMText(data["tM"],posy)
				end
				if data["tFP"] and data["tFP"] > 0 and not gameover then
					DrawFPBar(data["tFP"]/maxFP,posy,data["tFPM"]/data["tFP"])
				end
				if data["tBP"] and data["tBP"] > 0 and not gameover then
					DrawBPBar(data["tBP"]/maxBP,posy,data["tBPA"]/data["tBP"])
				end			
			end
		end
	end
	
	drawList = gl.CreateList(drawFunction)	
end

function widget:TweakDrawScreen()
	DrawOptionRibbon()
	updateButtons()	
	drawStandard()
	drawDynamic()		
end

function widget:DrawScreen()
	
	if Spring.IsGUIHidden() or (not inSpecMode and options["disable"]["On"]) then return end
	
	if not drawList then drawStandard() end
	if not drawListDynamic then drawDynamic() end
	
	gl.PushMatrix()
	gl.CallList(drawList)
	gl.CallList(drawListDynamic)
	gl.PopMatrix()
	
end

function widget:Update()
	speed,_,paused = Spring.GetGameSpeed()
	
	if paused or (isReplay and speed < LIMITSPEED) then
		drawDynamic()
	end
	
	if not gamestarted then
		drawStandard()
	end
end

function widget:GameFrame(frameNum)
	
	if frameNum < 5 * 30 then
		drawStandard()
		drawDynamic()
	end
	
	if frameNum%32 == 0 then 
		updateButtons()
		UpdateTeams() 
		setPlayerResources()
		drawStandard()
		drawDynamic()
	end
	
	if frameNum - lastPlayerChange == 30  then 
		UpdateTeams() 
		updateButtons()
	end
	
	if not gamestarted and frameNum > 0 then gamestarted = true end
end

function DrawEText(numberE, vOffset)
	if options["resText"]["On"] then
		local label = table.concat({"+",formatRes(numberE)})
		myFont:Begin()
		myFont:SetTextColor({1, 1, 0, 1})
		myFont:Print(label, widgetPosX + widgetWidth - 10, widgetPosY + widgetHeight -vOffset+tH-42,textsize,'rs')
		myFont:End()
	end
end

function DrawMText(numberM, vOffset)
	if options["resText"]["On"] then
		local label = table.concat({"+",formatRes(numberM)})
		myFont:Begin()
		myFont:SetTextColor({0.8,0.8,0.8,1})
		myFont:Print(label, widgetPosX + widgetWidth - 10, widgetPosY + widgetHeight -vOffset+tH-30,textsize,'rs')
		myFont:End()
	end
end

function DrawEBar(tE,vOffset)-- where tE = team Energy = [0,1]
	--Echo("Drawing E Bar:",tE)
	local dx = 15
	local dy = tH-35
	gl.Color(0.3,0.3,0.3)
	gl.Rect(
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy,
			widgetPosX + dx-5 + widgetWidth/2,
			widgetPosY + widgetHeight -vOffset+dy-1
			)
	gl.Color(1,1,0) --yellow 1
	gl.Rect(
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy-1,
			widgetPosX + dx + tE * (widgetWidth/2-5),
			widgetPosY + widgetHeight -vOffset+dy-3
			)
	gl.Color(1,0.5,0) --yellow 2
	gl.Rect(
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy-3,
			widgetPosX + dx + tE * (widgetWidth/2-5),
			widgetPosY + widgetHeight -vOffset+dy-4
			)
	gl.Color(0.3,0.3,0.3)
	gl.Rect(
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy-4,
			widgetPosX + dx-5 + widgetWidth/2,
			widgetPosY + widgetHeight -vOffset+dy-5
			)
	gl.Rect(
			widgetPosX + dx-5 + widgetWidth/2,
			widgetPosY + widgetHeight -vOffset+dy,
			widgetPosX + dx-4 + widgetWidth/2,
			widgetPosY + widgetHeight -vOffset+dy-5
			)
	gl.Rect(
			widgetPosX + dx-1,
			widgetPosY + widgetHeight -vOffset+dy,
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy-5
			)
	gl.Color(1,1,1,1)
end

function DrawMBar(tM,vOffset) -- where tM = team Metal = [0,1]
	local dx = 15
	local dy = tH-25
	gl.Color(0.3,0.3,0.3)
	gl.Rect(
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy,
			widgetPosX + dx-5 + widgetWidth/2,
			widgetPosY + widgetHeight -vOffset+dy-1
			)
	gl.Color(0.8,0.8,0.8)
	gl.Rect(
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy-1,
			widgetPosX + dx + tM * (widgetWidth/2-5),
			widgetPosY + widgetHeight -vOffset+dy-3
			)
	gl.Color(0.6,0.6,0.8)
	gl.Rect(
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy-3,
			widgetPosX + dx + tM * (widgetWidth/2-5),
			widgetPosY + widgetHeight -vOffset+dy-4
			)
	gl.Color(0.3,0.3,0.3)
	gl.Rect(
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy-4,
			widgetPosX + dx-5 + widgetWidth/2,
			widgetPosY + widgetHeight -vOffset+dy-5
			)
	gl.Rect(
			widgetPosX + dx-5 + widgetWidth/2,
			widgetPosY + widgetHeight -vOffset+dy,
			widgetPosX + dx-4 + widgetWidth/2,
			widgetPosY + widgetHeight -vOffset+dy-5
			)
	gl.Rect(
			widgetPosX + dx-1,
			widgetPosY + widgetHeight -vOffset+dy,
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy-5
			)
	gl.Color(1,1,1)
end

function DrawFPBar(tFP,vOffset,sM)-- where tFP = team Firepower = [0,1]
	if inSpecMode then
		if not options["FPBar2"]["On"] then return end
	else
		if not options["FPBar1"]["On"] then return end
	end
	
	local dx = 3
	local dy = tH-45
	local h = 22
	gl.Color(0.3,0.3,0.3)
	gl.Rect(widgetPosX+dx-1, widgetPosY + widgetHeight -vOffset + dy + h + 1,widgetPosX+dx+7,widgetPosY + widgetHeight -vOffset + dy + h)
	gl.Rect(widgetPosX+dx-1, widgetPosY + widgetHeight -vOffset + dy-1,widgetPosX+dx+7,widgetPosY + widgetHeight -vOffset + dy)
	gl.Color(0,0,0) --blue 1
	gl.Rect(
			widgetPosX+dx+1,
			widgetPosY + widgetHeight -vOffset + dy,
			widgetPosX + dx + 2,
			widgetPosY + widgetHeight -vOffset + dy+ (1-sM)*tFP * h
			)
	gl.Color(0,0.2,0.4) --blue 2
	gl.Rect(
			widgetPosX+dx+2,
			widgetPosY + widgetHeight -vOffset + dy,
			widgetPosX + dx + 3,
			widgetPosY + widgetHeight -vOffset + dy + (1-sM)*tFP * h
			)
	gl.Color(0,0.4,0.8) -- violet 1
	gl.Rect(
			widgetPosX+dx+1,
			widgetPosY + widgetHeight -vOffset + dy + (1-sM)*tFP * h,
			widgetPosX + dx + 2,
			widgetPosY + widgetHeight -vOffset + dy+ tFP * h
			)
	gl.Color(0,0.4,1) -- violet 2
	gl.Rect(
			widgetPosX+dx+2,
			widgetPosY + widgetHeight -vOffset + dy + (1-sM)*tFP * h,
			widgetPosX + dx + 3,
			widgetPosY + widgetHeight -vOffset + dy + tFP * h
			)
	gl.Color(1,1,1)
end

function DrawBPBar(tBP,vOffset,sA)-- where tE = team Buildpower = [0,1]
	if inSpecMode then
		if not options["BPBar2"]["On"] then return end
	else
		if not options["BPBar1"]["On"] then return end
	end
	
	local dx = 7
	local dy = tH-45
	local h = 22
	gl.Color(0.3,0.3,0.3)
	gl.Rect(
			widgetPosX+dx-1,
			widgetPosY + widgetHeight -vOffset + dy + h + 1,
			widgetPosX+dx+7,
			widgetPosY + widgetHeight -vOffset + dy + h
			)
	gl.Rect(
			widgetPosX+dx-1,
			widgetPosY + widgetHeight -vOffset + dy-1,
			widgetPosX+dx+7,
			widgetPosY + widgetHeight -vOffset + dy
			)
	gl.Color(0,0.8,0) -- green 1
	gl.Rect(
			widgetPosX+dx+1,
			widgetPosY + widgetHeight -vOffset + dy,
			widgetPosX + dx + 2,
			widgetPosY + widgetHeight -vOffset + dy + (1-sA) * tBP * h
			)
	gl.Color(0,0.8,0.3) --green 2
	gl.Rect(
			widgetPosX+dx+2,
			widgetPosY + widgetHeight -vOffset + dy,
			widgetPosX + dx + 3,
			widgetPosY + widgetHeight -vOffset + dy + (1-sA) * tBP * h
			)
	gl.Color(1,1,0) -- yellow 1
	gl.Rect(
			widgetPosX+dx+1,
			widgetPosY + widgetHeight -vOffset + dy + (1-sA) * tBP * h,
			widgetPosX + dx + 2,
			widgetPosY + widgetHeight -vOffset + dy+ tBP * h
			)
	gl.Color(0.3,1,0) --yellow 2
	gl.Rect(
			widgetPosX+dx+2,
			widgetPosY + widgetHeight -vOffset + dy + (1-sA) * tBP * h,
			widgetPosX + dx + 3,
			widgetPosY + widgetHeight -vOffset + dy + tBP * h
			)
	gl.Color(0.3,0.3,0.3)
	gl.Color(1,1,1)
end

function DrawKillBar(killedhp,vOffset,splits) -- where killedHP = abs. number
	local dx = 1
	local dy = 1
	local len = 0.001*killedhp/(splits+1)
	
	gl.Color(0,0.3,0.9,0.8)
	gl.Rect(
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy+1,
			widgetPosX + dx + len,
			widgetPosY + widgetHeight -vOffset+dy
			)
	gl.Color(0,0.2,0.5,0.8)
	gl.Rect(
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy,
			widgetPosX + dx + len,
			widgetPosY + widgetHeight -vOffset+dy-1
			)
	gl.Color(1,1,1,1)
end

function DrawLossesBar(losthp,vOffset,splits)
	local dx = 1
	local dy = -1
	local len = 0.001*losthp/(splits+1)
	
	gl.Color(0.6,0.2,0.2,0.8) -- (1,0,0.3,0.8)
	gl.Rect(
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy+1,
			widgetPosX + dx + len,
			widgetPosY + widgetHeight -vOffset+dy
			)
	gl.Color(0.3,0.1,0.1,0.8) -- (0.6,0,0.4,0.8)
	gl.Rect(
			widgetPosX + dx,
			widgetPosY + widgetHeight -vOffset+dy,
			widgetPosX + dx + len,
			widgetPosY + widgetHeight -vOffset+dy-1
			)
	gl.Color(1,1,1,1)
end

function DrawKillDeathText(kills, losses, vOffset)
	if inSpecMode then
		if not options["kills2"]["On"] then return end
	else
		if not options["kills1"]["On"] then return end
	end
	--Echo("K/L:",kills, losses, vOffset)
	local dx = 6
	local dy = 68
	--local len = 1+math.floor(1+math.log(kills+1)+math.log(losses+1))
	local len  = 7 * #(tostring(losses))
	local len2 = 7 * #(tostring(kills))+len
	gl.Color(0.8,1,0.8,1)
	if kills > 0 then glText(kills, widgetPosX + widgetWidth - 15 - dx - len2, widgetPosY + widgetHeight -vOffset+tH-dy+2,textsize) end
	gl.Color(0.85,0.85,0.85,0.85)
	if kills > 0 and losses > 0 then glText("/", widgetPosX  + widgetWidth - 10 - dx - len, widgetPosY + widgetHeight -vOffset+tH-dy+2,textsize) end
	gl.Color(1,0.8,0.8,1)
	if losses > 0 then glText(losses, widgetPosX + widgetWidth - dx - len, widgetPosY + widgetHeight -vOffset+tH-dy+2,textsize) end
	gl.Color(1,1,1,1)
end

function DrawBackground(posY)
	local y1 = widgetPosY - posY + widgetHeight - 1
	local y2 = widgetPosY - posY + tH + widgetHeight - 1
	gl.Color(0,0,0,options["contrast"])                              
	gl.Rect(widgetPosX,y1, widgetPosX + widgetWidth, y2)
	if options["borders"]["On"] then
		gl.Color(0,0,0,1)
		gl.Rect(widgetPosX,y1 -1 , widgetPosX + widgetWidth, y1) --bottom
		gl.Rect(widgetPosX,y2 - 1, widgetPosX + widgetWidth, y2) --top
		gl.Rect(widgetPosX , y1-1, widgetPosX + 1, y2  - 1) --left
		gl.Rect(widgetPosX + widgetWidth - 1, y1-1, widgetPosX + widgetWidth, y2  - 1)--right
	end
	
	gl.Color(1,1,1,1)
end

function DrawExpandTableBorders(teamID)
	
	local x1, x2, y1, y2
	local w = 180 + cW*getNbPlayers(teamID) -- infotable width
	x1 = iPosX[teamID]
	y2 = iPosY[teamID]
	x2 = x1 + w
	y1 = y2 - infoTableHeight
		
	if iPanel[teamID] then
		gl.Color(0,0,0,1)	-- highlight borders
	else
		gl.Color(0.3,0.3,0.3,1) 	
	end
	
	gl.Rect(x1, y1-1, x2, y1) 						-- lower
	gl.Rect(x1, y2, x2, y2+1) 						--upper
	gl.Rect(x1-1, y1, x1, y2) 						--left
	gl.Rect(x2, y1, x2+1, y2-1)						--right
end

function DrawExpandTableButtons(teamID)
	
	if expandMove[teamID]["mouseover"] then
		gl.Color(1,1,1,1)
	else
		gl.Color(0.5,0.5,0.8,0.7)
	end
	
	gl.Texture(images["move"])
	gl.TexRect(expandMove[teamID]["x1"], expandMove[teamID]["y1"] , expandMove[teamID]["x2"], expandMove[teamID]["y2"])
	gl.Texture(false)

	if Teambutton["Next"][teamID]["mouse"] then
		if teamID < getNbTeams() - 1 and inSpecMode then
			gl.Color(0.7,0.9,1,1)
		else
			gl.Color(1,0.7,0.7,1)
		end
	else
		gl.Color(0.5,0.5,0.8,0.7)
	end
	
	gl.Texture(images["arrowright"])
	gl.TexRect(Teambutton["Next"][teamID]["x1"], Teambutton["Next"][teamID]["y1"] , Teambutton["Next"][teamID]["x2"], Teambutton["Next"][teamID]["y2"])
	gl.Texture(false)
	
	if Teambutton["Prev"][teamID]["mouse"] then
		if teamID > 0 and inSpecMode then
			gl.Color(0.7,0.9,1,1)
		else
			gl.Color(1,0.7,0.7,1)
		end
	else
		gl.Color(0.5,0.5,0.8,0.7)
	end
	
	gl.Texture(images["arrowleft"])
	gl.TexRect(Teambutton["Prev"][teamID]["x1"], Teambutton["Prev"][teamID]["y1"] , Teambutton["Prev"][teamID]["x2"], Teambutton["Prev"][teamID]["y2"])
	gl.Texture(false)
end

function DrawExpandTable(teamID)
	
	local nbTeams = getNbTeams()
	local nbPlayers = getNbPlayers(teamID)
	if nbPlayers > 5 then cW = 90 end
	if nbPlayers > 8 then cW = 80 end
	
	local lm  						= 20 -- left margin
	local rm  						= 35 --right margin
	local dy 						= 35 -- top margin
	local w 						= 180 + cW*nbPlayers -- infotable width
	local j
	local rs  						= 18 --row spacing
	local hBar 						= 40 -- bottom bar height
	local x1, y1, x2, y2
	local clr = {0.8, 0.8, 0.9 ,1}
	
	local posX = iPosX[teamID]
	local posY = iPosY[teamID]

	local splits = math.floor(0.004*PmaxDmg/hBar)
	local scale = splits*250
	
	x1 = posX
	y2 = posY
	x2 = x1 + w
	y1 = y2 - infoTableHeight
	--------------
	-- Background --
	--------------
	gl.Texture(false)
	
	local hasCom
	local active
	local mycomlbl
	local myactlbl
	local r,b,g,s1, s2, s3, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17,s18, s19, rank, sStatus
	
	
	gl.Color(0.1,0.1,0.1,0.85)
	gl.Rect(x1, y1, x2, y2)
	
	local teamlbl = table.concat({"Team ",tostring(teamID)})
	
	myFontBig:Begin()
	myFontBig:SetTextColor({0.8,0.8,1,0.4})
	myFontBig:Print(teamlbl, posX + w/2 -30, posY - 38,textlarge,'o')
	myFontBig:End()
	
	--------------
	-- Headings --
	-------------
	myFont:Begin()
	myFont:SetTextColor({0.5,0.5,0.8,1})
	myFont:Print("Player:", posX + lm, posY - dy - 10 - 1*rs,textsize)
	myFont:Print("Commander:", posX + lm, posY - dy - 10- 2*rs,textsize)
	myFont:Print("Units:", posX + lm, posY - dy - 10 - 3*rs,textsize)
	myFont:Print("Metal:", posX + lm, posY - dy - 10 - 4*rs,textsize)
	myFont:Print("Energy:", posX + lm, posY - dy - 10 - 5*rs,textsize)
	myFont:Print("Firepower:", posX + lm, posY - dy - 10 - 6*rs,textsize)
	myFont:Print(".....mobile:", posX + lm, posY - dy - 5 - 7*rs,textsize)
	myFont:Print("Buildpower:", posX + lm, posY - dy - 10 - 8*rs,textsize)
	myFont:Print(".......air:", posX + lm, posY - dy - 5 - 9*rs,textsize)
	myFont:Print("Kills:", posX + lm, posY - dy - 10 - 10*rs,textsize)
	myFont:Print("Losses:", posX + lm, posY - dy - 10 - 11*rs,textsize)
	myFont:Print("Killed HP:", posX + lm, posY - dy - 10 - 12*rs,textsize)
	myFont:Print("Lost HP:", posX + lm, posY - dy - 10 - 13*rs,textsize)
	myFont:Print("Active:", posX + lm, posY - dy - 10 - 14*rs,textsize)
	myFont:Print("Faction:", posX + lm, posY - dy - 10 - 16*rs,textsize)
	myFont:Print("Country:", posX + lm, posY - dy - 10 - 17*rs,textsize)
	myFont:Print("Rank:", posX + lm, posY - dy - 10 - 18*rs,textsize,textsize)
	myFont:Print("Skill:", posX + lm, posY - dy - 10 - 19*rs,textsize,textsize)
	myFont:SetTextColor({0.4,0.4,0.2,1})
	myFont:Print("Kills:", posX + lm, posY - dy - 10 - 24*rs,textsize)	
	myFont:Print("0 HP", posX + 100, posY - dy - 10 - 24*rs - 2,textsize)
	local s0 = table.concat({formatRes1000((1+splits)*hBar/4) or ""," kHP"})
	myFont:Print(s0, posX + 135 - #s0*7, posY - dy - 10 - 24*rs + hBar-2,textsize)
	myFont:SetTextColor({0.5,0.5,0.8,0.3})
	myFont:Print("(Right-click to close)", posX + lm, posY - dy - 26*rs,textsize)
	myFont:End()
	--gl.Color(0.5,0.5,0.8,1)
	
	for i, pID in ipairs (Spring.GetTeamList(teamID)) do
		j = nbPlayers - i
		------------
		-- Values --
		------------
		r  		= teamData[pID].red
		g  		= teamData[pID].green
		b  		= teamData[pID].blue

		if r ~= nil then
			local luminance  = (r * 0.299) + (g * 0.587) + (b * 0.114)
			if (luminance < 0.3) then
				r = r + 0.2
				g = g + 0.2
				b = b + 0.2
			end
		end
		s1 		= teamData[pID]["leaderName"] or "(Retired)"
		if 	#s1 > cW/7 and nbPlayers > 1 then s1 = string.sub(s1,1,math.floor(cW/7)) end
		s3 		= tostring(teamData[pID]["unitCount"]) or ""
		hasCom 	= teamData[pID]["hasCom"]
		s5 		= table.concat({"+", formatRes1000(teamData[pID]["minc"]) or ""})
		s6		= table.concat({"+", formatRes1000(teamData[pID]["einc"]) or ""})
		s7		= formatRes1000(teamData[pID]["firepower"]) or ""
		if teamData[pID]["firepower"] > 0 then
			s8		= table.concat({formatRes1000(100*(teamData[pID]["firepowerMob"]/teamData[pID]["firepower"])) or "","%"})
		else
			s8 = ""
		end
		s9		= formatRes1000(teamData[pID]["buildpower"])
		if teamData[pID]["firepower"] > 0 then
			s10		= table.concat({formatRes1000(100*(teamData[pID]["buildpowerAir"]/teamData[pID]["buildpower"]))or "","%"})
		else
			s10 = ""
		end
		s11		= tostring(teamData[pID]["kills"])
		s12		= tostring(teamData[pID]["losses"])
		s13		= formatRes1000(teamData[pID]["killedhp"]) or ""
		s14		= formatRes1000(teamData[pID]["losthp"]) or ""
		active 	= teamData[pID]["active"]
		s16		= firstToUpper(teamData[pID]["side"] or "") 
		s17		= string.upper(teamData[pID]["country"] or "") 
		rank 	= teamData[pID]["rank"]
		if rank == 0 then
			s18 = "Enlisted"
		elseif rank == 1 then
			s18 = "2nd Lieut."
		elseif rank == 2 then
			s18 = "Lieutenant"
		elseif rank == 3 then
			s18 = "Captain"
		elseif rank == 4 then
			s18 = "Major"
		elseif rank == 5 then
			s18 = "Lt.Colonel"
		elseif rank == 6 then
			s18 = "Colonel"
		elseif rank == 7 then
			s18 = "Brigadier"
		elseif rank == 8 then
			s18 = "Maj.General"
		else
			s18 = ""
		end
		s19		= teamData[pID]["skill"]
		
		------------------
		-- Print values --
		------------------
		myFont:Begin()
		myFont:SetTextColor({r,g,b,1})
		myFont:Print(s1, posX + w - rm - j*cW, posY - dy - 10 - 1*rs,textsize,'r')
		myFont:SetTextColor(clr)
		if hasCom then
			s2 = "Yes"
			myFont:SetTextColor({0.7,1,0.7,1})
		else
			s2 = "No"
			myFont:SetTextColor({1,0.7,0.7,1})
		end
						
		myFont:Print(s2, posX + w - rm - j*cW, posY - dy - 10 - 2*rs,textsize,'r')
		myFont:SetTextColor(clr)
		if (teamData[pID]["isDead"]) then myFont:SetTextColor({0.5,0.5,0.5,0.8}) end
		myFont:Print(s3, posX + w - rm - j*cW, posY - dy - 10 - 3*rs,textsize,'r')
		myFont:SetTextColor({0.8,0.8,1,1})
		myFont:Print(s5, posX + w - rm - j*cW, posY - dy - 10 - 4*rs,textsize,'r')
		myFont:SetTextColor({1,1,0,1})
		myFont:Print(s6, posX + w - rm - j*cW, posY - dy - 10 - 5*rs,textsize,'r')
		myFont:SetTextColor(clr)
		myFont:Print(s7, posX + w - rm - j*cW, posY - dy - 10 - 6*rs,textsize,'r')
		myFont:Print(s8, posX + w - rm + 7 - j*cW, posY - dy - 5 - 7*rs,textsize,'r')
		myFont:SetTextColor(clr)
		myFont:Print(s9, posX + w - rm - j*cW, posY - dy - 10 - 8*rs,textsize,'r')
		myFont:Print(s10, posX + w - rm + 7 - j*cW, posY - dy - 5 - 9*rs,textsize,'r')
		myFont:SetTextColor(clr)
		myFont:Print(s11, posX + w - rm - j*cW, posY - dy - 10 - 10*rs,textsize,'r')
		myFont:Print(s12, posX + w - rm - j*cW, posY - dy - 10 - 11*rs,textsize,'r')
		myFont:Print(s13, posX + w - rm - j*cW, posY - dy - 10 - 12*rs,textsize,'r')
		myFont:Print(s14, posX + w - rm - j*cW, posY - dy - 10 - 13*rs,textsize,'r')
		if active then
			s15 = "Yes"
			myFont:SetTextColor({0.7,1,0.7,1})
		else
			s15 = "No"
			myFont:SetTextColor({1,0.7,0.7,1})
		end
		myFont:Print(s15, posX + w - rm - j*cW, posY - dy - 10 - 14*rs,textsize,'r')
		myFont:SetTextColor(clr)
		myFont:Print(s16, posX + w - rm - j*cW, posY - dy - 10 - 16*rs,textsize,'r')
		myFont:Print(s17, posX + w - rm - j*cW, posY - dy - 10 - 17*rs,textsize,'r')
		myFont:Print(s18, posX + w - rm - j*cW, posY - dy - 10 - 18*rs,textsize,'r')
		myFont:Print(s19, posX + w - rm - j*cW, posY - dy - 10 - 19*rs,textsize,'r')
		
		if gamestarted then
			if not teamData[pID]["active"] and teamData[pID]["unitCount"] > 0 then
			myFont:SetTextColor({0.5,0.5,0.8,1})
			sStatus = "[MIA]"
			elseif teamData[pID]["isDead"] then
			myFont:SetTextColor({0.5,0.1,0.1,1})
			sStatus = "[KIA]"
			else
			myFont:SetTextColor({0.7,1,0.7,1})
			sStatus = ""
			end
		else
			if not teamData[pID]["active"] then
				myFont:SetTextColor({0.3,0.3,0.6,1})
				sStatus = "(Not here)"
			elseif teamData[pID]["startx"] > 0 and teamData[pID]["starty"] > 0 then
				myFont:SetTextColor({0.5,0.5,0.8,1})
				sStatus = "(Marked)"
			elseif teamData[pID]["startx"] == -100 and teamData[pID]["starty"] == -100 then
				myFont:SetTextColor({0.4,0.4,0.7,1})
				sStatus = "(Warming up)"
			else
				sStatus = ""
			end
		end
		myFont:Print(sStatus, posX + w - rm - j*cW, posY - dy - 20 - 20*rs,textsize,'r')
		myFont:End()
		
		for rank,_ in ipairs(Spring.GetTeamList()) do -- first player id in matrix is ranking, since table is sorted by most kills
			if rank < 16 then
				local r2,g2,n2,r3,g3,b3,r4,g4,b4
				local xi, yi, hi
				local enemy = kMat[pID][rank][1] -- the associated player with rank is the actual player id that we want to plot
				
				if enemy ~= gaiaID then
					r2 = teamData[enemy].red or 0
					g2 = teamData[enemy].green or 0
					b2 = teamData[enemy].blue or 0
				else
					r2,g2,b2 = 1,1,1
				end
				
				local luminance  = (r2 * 0.299) + (g2 * 0.587) + (b2 * 0.114)
				
				if luminance > 0.3 then
					r3 = r2 - 0.25 * luminance
					r4 = r3 - 0.25 * luminance
					g3 = g2 - 0.25 * luminance
					g4 = g3 - 0.25 * luminance
					b3 = b2 - 0.25 * luminance
					b4 = b3 - 0.25 * luminance
				else
					r3 = r2 + 0.5 * luminance
					r4 = r3 + 0.5 * luminance
					g3 = g2 + 0.5 * luminance
					g4 = g3 + 0.5 * luminance
					b3 = b2 + 0.5 * luminance
					b4 = b3 + 0.5 * luminance
				end
							
				hi = (kMat[pID][rank][2]/250)/(splits+1) or 0
				xi = posX + w - rm - (j+0.55)*cW - 10 + 9*rank
				yi = posY - dy - 10 - 24*rs
				
				gl.Color(0.1,0.1,0.05,0.7)
				--gl.Color(0.4,0.4,0.2,1)
				gl.Rect(posX + w - rm - (j+0.66)*cW, yi-1, posX + w - rm - j*cW, yi)
				gl.Rect(posX + w - rm - (j+0.66)*cW, yi+hBar, posX + w - rm - j*cW, yi+hBar+1)
				
				gl.Color(r2,g2,b2,1)
				gl.Rect(
				xi+1,
				yi,
				xi+2,
				yi+hi
				)
				gl.Color(r3,g3,b3,1)
				gl.Rect(
				xi+2,
				yi,
				xi+3,
				yi+hi
				)
				gl.Color(r4,g4,b4,1)
				gl.Rect(
				xi+3,
				yi,
				xi+4,
				yi+hi
				)
			end
		end
		
		gl.Color(1,1,1,1)
		gl.Texture(false)
	end
end

function DrawOptionRibbon()
	local h = 300
	local dx = 200
	local x0
	local t = 12
	
	if right then
		x0 = widgetPosX-dx
		x1 = x0 + dx + widgetWidth
	else
		x0 = widgetPosX
		x1 = x0 + dx + widgetWidth
	end
	
	options["contrastLess"]["x1"] = x0 + 80
	options["contrastLess"]["x2"] = x0 + 87
	options["contrastLess"]["y2"] = widgetPosY - 20
	options["contrastLess"]["y1"] = widgetPosY - 35
	
	options["contrastMore"]["x1"] = x0 + 88
	options["contrastMore"]["x2"] = x0 + 95
	options["contrastMore"]["y2"] = widgetPosY - 20
	options["contrastMore"]["y1"] = widgetPosY - 35
	
	options["borders"]["x1"] = x0 + 80
	options["borders"]["x2"] = x0 + 95
	options["borders"]["y2"] = widgetPosY - 40
	options["borders"]["y1"] = widgetPosY - 55
	
	options["widthInc"]["x1"] = x0 + 200
	options["widthInc"]["x2"] = x0 + 215
	options["widthInc"]["y2"] = widgetPosY - 20
	options["widthInc"]["y1"] = widgetPosY - 35
	
	options["widthDec"]["x1"] = x0 + 180
	options["widthDec"]["x2"] = x0 + 195
	options["widthDec"]["y2"] = widgetPosY - 20
	options["widthDec"]["y1"] = widgetPosY - 35
	
	options["heightInc"]["x1"] = x0 + 200
	options["heightInc"]["x2"] = x0 + 215
	options["heightInc"]["y2"] = widgetPosY - 40
	options["heightInc"]["y1"] = widgetPosY - 55
	
	options["heightDec"]["x1"] = x0 + 180
	options["heightDec"]["x2"] = x0 + 195
	options["heightDec"]["y2"] = widgetPosY - 40
	options["heightDec"]["y1"] = widgetPosY - 55
	
	options["disable"]["x1"] = x0 + 220
	options["disable"]["x2"] = x0 + 220 + t
	options["disable"]["y2"] = widgetPosY - 100
	options["disable"]["y1"] = widgetPosY - 100 - t

	options["FPBar1"]["x1"] = x0 + 180
	options["FPBar1"]["x2"] = x0 + 180 + t
	options["FPBar1"]["y2"] = widgetPosY - 200
	options["FPBar1"]["y1"] = widgetPosY - 200 - t
	
	options["BPBar1"]["x1"] = x0 + 180
	options["BPBar1"]["x2"] = x0 + 180 + t
	options["BPBar1"]["y2"] = widgetPosY - 220
	options["BPBar1"]["y1"] = widgetPosY - 220 - t
	
	options["FPBar2"]["x1"] = x0 + 220
	options["FPBar2"]["x2"] = x0 + 220 + t
	options["FPBar2"]["y2"] = widgetPosY - 200
	options["FPBar2"]["y1"] = widgetPosY - 200 - t
	
	options["BPBar2"]["x1"] = x0 + 220
	options["BPBar2"]["x2"] = x0 + 220 + t
	options["BPBar2"]["y2"] = widgetPosY - 220
	options["BPBar2"]["y1"] = widgetPosY - 220 - t
	
	options["kills1"]["x1"] = x0 + 180
	options["kills1"]["x2"] = x0 + 180 + t
	options["kills1"]["y2"] = widgetPosY - 240
	options["kills1"]["y1"] = widgetPosY - 240 - t
	
	options["kills2"]["x1"] = x0 + 220
	options["kills2"]["x2"] = x0 + 220 + t
	options["kills2"]["y2"] = widgetPosY - 240
	options["kills2"]["y1"] = widgetPosY - 240 - t
	
	options["Announce"]["x1"] = x0 + 220
	options["Announce"]["x2"] = x0 + 220 + t
	options["Announce"]["y2"] = widgetPosY - 120
	options["Announce"]["y1"] = widgetPosY - 120 - t
	
	options["removeDead"]["x1"] = x0 + 220
	options["removeDead"]["x2"] = x0 + 220 + t
	options["removeDead"]["y2"] = widgetPosY - 140
	options["removeDead"]["y1"] = widgetPosY - 140 - t
	
	options["resText"]["x1"] = x0 + 220
	options["resText"]["x2"] = x0 + 220 + t
	options["resText"]["y2"] = widgetPosY - 160
	options["resText"]["y1"] = widgetPosY - 160 - t
	
	
	gl.Color(0,0,0,0.4)                              -- draws background rectangle
	gl.Rect(x0,widgetPosY, x1, widgetPosY -h)
	gl.Color(0,0,0,1)
	gl.Rect(x0,widgetPosY, x0+1, widgetPosY-h)
	gl.Rect(x1 - 1,widgetPosY, x1, widgetPosY-h)
	gl.Color(1,1,1,1)
	glText("Adjust", x0+95, widgetPosY - 10,textsize)
	glText("Options", x0+95, widgetPosY - 90,textsize)
	gl.Rect(x0+95,widgetPosY - 12, x0 + 137, widgetPosY-13)
	gl.Rect(x0+95,widgetPosY - 92, x0 + 145, widgetPosY-93)
	gl.Color(0.8,0.8,1,0.8)
	glText("Contrast:", x0+5, widgetPosY - 30,textsize)
	glText("Borders:", x0+5, widgetPosY - 50,textsize)
	glText("Width:", x0+125, widgetPosY - 30,textsize)
	glText("Height:", x0+125, widgetPosY - 50,textsize)
	gl.Color(1,1,1,1)
	gl.Texture(images["contrast"])
	gl.TexRect(
		options["contrastLess"]["x1"],
		options["contrastLess"]["y1"],
		options["contrastMore"]["x2"],
		options["contrastMore"]["y2"]
		)
	if options["borders"]["On"] then
		gl.Texture(images["borderson"])
	else
		gl.Texture(images["bordersoff"])
	end
	gl.TexRect(
		options["borders"]["x1"],
		options["borders"]["y1"],
		options["borders"]["x2"],
		options["borders"]["y2"]
		)
	gl.Color(0.8,0.8,1,0.8)
	glText("Disable for non-spectators:", x0+5, widgetPosY - 110,textsize)
	glText("Show firepower bar:", x0+5, widgetPosY - 210,textsize)
	glText("Show buildpower bar:", x0+5, widgetPosY - 230,textsize)
	glText("Show kills and losses:", x0+5, widgetPosY - 250,textsize)
	glText("Show resource text:", x0+5, widgetPosY - 170,textsize)
	glText("Announce kills:", x0+5, widgetPosY - 130,textsize)
	glText("Remove dead teams:", x0+5, widgetPosY - 150,textsize)
	glText("(Drag window to reposition)", x0+35, widgetPosY - 280,textsize)
	gl.Color(1,1,1,1)
	glText("Player", x0+160, widgetPosY - 192,textsize)
	glText("Spec", x0+215, widgetPosY - 192,textsize)
	if options["disable"]["On"] then
		gl.Texture(images["checkboxon"])
	else
		gl.Texture(images["checkboxoff"])
	end
	gl.TexRect(
		options["disable"]["x1"],
		options["disable"]["y1"],
		options["disable"]["x2"],
		options["disable"]["y2"]
		)
		
	if options["FPBar2"]["On"] then
		gl.Texture(images["checkboxon"])
	else
		gl.Texture(images["checkboxoff"])
	end
	gl.TexRect(
		options["FPBar2"]["x1"],
		options["FPBar2"]["y1"],
		options["FPBar2"]["x2"],
		options["FPBar2"]["y2"]
		)
		
	if options["BPBar2"]["On"] then
		gl.Texture(images["checkboxon"])
	else
		gl.Texture(images["checkboxoff"])
	end
	gl.TexRect(
		options["BPBar2"]["x1"],
		options["BPBar2"]["y1"],
		options["BPBar2"]["x2"],
		options["BPBar2"]["y2"]
		)
	
	if options["FPBar1"]["On"] then
		gl.Texture(images["checkboxon"])
	else
		gl.Texture(images["checkboxoff"])
	end
	gl.TexRect(
		options["FPBar1"]["x1"],
		options["FPBar1"]["y1"],
		options["FPBar1"]["x2"],
		options["FPBar1"]["y2"]
		)
		
	if options["BPBar1"]["On"] then
		gl.Texture(images["checkboxon"])
	else
		gl.Texture(images["checkboxoff"])
	end
	gl.TexRect(
		options["BPBar1"]["x1"],
		options["BPBar1"]["y1"],
		options["BPBar1"]["x2"],
		options["BPBar1"]["y2"]
		)
	options["kills1"]["On"] = false
	gl.Color(0.8,0.4,0.4,0.5)
	glText("(N/A)", x0+170, widgetPosY - 250,textsize)
	gl.Color(1,1,1,1)
	
	if options["kills2"]["On"] then
		gl.Texture(images["checkboxon"])
	else
		gl.Texture(images["checkboxoff"])
	end
	gl.TexRect(
		options["kills2"]["x1"],
		options["kills2"]["y1"],
		options["kills2"]["x2"],
		options["kills2"]["y2"]
		)
	
	if options["Announce"]["On"] then
		gl.Texture(images["checkboxon"])
	else
		gl.Texture(images["checkboxoff"])
	end
	gl.TexRect(
		options["Announce"]["x1"],
		options["Announce"]["y1"],
		options["Announce"]["x2"],
		options["Announce"]["y2"]
		)
	
	if options["resText"]["On"] then
		gl.Texture(images["checkboxon"])
	else
		gl.Texture(images["checkboxoff"])
	end
	gl.TexRect(
		options["resText"]["x1"],
		options["resText"]["y1"],
		options["resText"]["x2"],
		options["resText"]["y2"]
		)
		
	if options["removeDead"]["On"] then
		gl.Texture(images["checkboxon"])
	else
		gl.Texture(images["checkboxoff"])
	end
	gl.TexRect(
		options["removeDead"]["x1"],
		options["removeDead"]["y1"],
		options["removeDead"]["x2"],
		options["removeDead"]["y2"]
		)
	
	gl.Texture(images["more"])
	gl.TexRect(
		options["widthInc"]["x1"],
		options["widthInc"]["y1"],
		options["widthInc"]["x2"],
		options["widthInc"]["y2"]
		)
	gl.Texture(images["less"])
	gl.TexRect(
		options["widthDec"]["x1"],
		options["widthDec"]["y1"],
		options["widthDec"]["x2"],
		options["widthDec"]["y2"]
		)
		gl.Texture(images["more"])
	gl.TexRect(
		options["heightInc"]["x1"],
		options["heightInc"]["y1"],
		options["heightInc"]["x2"],
		options["heightInc"]["y2"]
		)
	gl.Texture(images["less"])
	gl.TexRect(
		options["heightDec"]["x1"],
		options["heightDec"]["y1"],
		options["heightDec"]["x2"],
		options["heightDec"]["y2"]
		)
end

function DrawInfoButton (allyID, active, right, big)
	
	local allyDataID = allyID+1
	if options["removeDead"]["On"] then
		if not allyData[allyDataID]["isAlive"] then return end
	end
	
	local x1 = infoButton[allyID]["x1"]
	local y1 = infoButton[allyID]["y1"]
	local x2 = infoButton[allyID]["x2"]
	local y2 = infoButton[allyID]["y2"]

	if big then 
		x2 = x2 + 5
		y2 = y2 + 5
	end
	
	if active then
		gl.Color(0.8,0.8,0.2,1)
	else
		gl.Color(1,1,1,1)
	end
	gl.Texture(images["info"])
	gl.TexRect(x1,y1,x2,y2)
	
	gl.Color(1,1,1,1)
	gl.Texture(false)
end

function DrawLabelC(text, vOffset)
	if widgetWidth < 67 then
		text = string.sub(text, 0, 1)
	end
	gl.Color(0.55,0.55,0.8,0.7)
	glText(text or "", widgetPosX + 15, widgetPosY + widgetHeight -vOffset+tH-42,textsize)
end

function DrawLabelCM(text, vOffset)
	local len = #text
	if widgetWidth < 67 then
		text = string.sub(text, 0, 1)
	end
	
	myFont:Begin()
	myFont:SetTextColor({0.8,0.8,1,0.8})
	myFont:Print(text or "", widgetPosX + 30-len*1.875, widgetPosY + widgetHeight -vOffset+tH-42,textsize,'s')
	myFont:End()
end

function DrawLabelCM2(text, vOffset)
	local len = #text
	if widgetWidth < 67 then
		text = string.sub(text, 0, 1)
	end
	myFont:Begin()
	myFont:SetTextColor({0.8,0.8,1,0.8})
	myFont:Print(text or "", widgetPosX + 30-len*1.875, widgetPosY + widgetHeight -vOffset+tH-62,textsize,'s')
	myFont:End()
end

function DrawLabelCT(text, vOffset,t)
	if widgetWidth < 67 then
		text = string.sub(text, 0, 1)
	end
	local gs 
	gs,_,_ = Spring.GetGameSpeed() or 1
	
	myFont:Begin()
	myFont:SetTextColor({1-0.5*math.sin(20*t/gs),1-0.5*math.sin(20*t/gs),1-0.25*math.sin(20*t/gs),0.8})
	if t < 3 then
		myFont:Print(text or "", widgetPosX + 30, widgetPosY + widgetHeight -vOffset+tH-42,textsize,'s')
	else
		myFont:Print(text or "", widgetPosX + 30 + (t-3)^12, widgetPosY + widgetHeight -vOffset+tH-42,textsize,'s')
	end
	myFont:End()
end

function DrawBox(hOffset, vOffset,r,g,b)
	local dx = 20
	local dy = 58
	gl.Color(.2,.2,.2)
	gl.Rect(widgetPosX+hOffset+dx+7, widgetPosY + widgetHeight -vOffset+dy+17, widgetPosX+hOffset+dx+8, widgetPosY + widgetHeight -vOffset+dy+3)
	gl.Rect(widgetPosX+hOffset+dx+20, widgetPosY + widgetHeight -vOffset+dy+17, widgetPosX + hOffset + dx + 21, widgetPosY + widgetHeight -vOffset+dy+3)
	gl.Rect(widgetPosX+hOffset+dx+7, widgetPosY + widgetHeight -vOffset+dy+17, widgetPosX + hOffset +dx + 21, widgetPosY + widgetHeight -vOffset+dy+16)
	gl.Rect(widgetPosX+hOffset+dx+7, widgetPosY + widgetHeight -vOffset+dy+4, widgetPosX + hOffset + dx + 21, widgetPosY + widgetHeight -vOffset+dy+3)
	gl.Color(r,g,b,0.5)
	gl.Rect(widgetPosX+hOffset+dx+8, widgetPosY + widgetHeight -vOffset+dy+16, widgetPosX + hOffset + dx + 20, widgetPosY + widgetHeight -vOffset+dy+4)
	gl.Color(1,1,1,1)
end

function DrawSideImage(sideImage, hOffset, vOffset, r, g, b, a, small, mouseOn,t,isDead)
	local w
	local h
	local dx
	local dy
	
	if small then
		w = 8
		h = 8
		dx = 28 + (WBadge-14)*4
		dy = tH - 12
	else
		w = WBadge
		h = WBadge
		dx = 25 + (WBadge-14)*4
		dy = tH - 16 - (WBadge-14)
	end
	
	if not inSpecMode then dx = dx -10 end
	
	if mouseOn and (not isDead) then
		if ctrlDown then
			gl.Color(1,1,1,a)
		else
			local gs 
			gs,_,_ = Spring.GetGameSpeed() or 1
			gl.Color(r-0.2*math.sin(10*t/gs),g-0.2*math.sin(10*t/gs),b,a)
		end
	else
		gl.Color(r,g,b,a)
	end
	gl.Texture(sideImage)
	gl.TexRect(
	widgetPosX + hOffset + dx,
	widgetPosY + widgetHeight - vOffset + dy,
	widgetPosX + hOffset + dx + w,
	widgetPosY + widgetHeight - vOffset + dy + h
	)
	gl.Texture(false)
	gl.Color(1,1,1,1)
end