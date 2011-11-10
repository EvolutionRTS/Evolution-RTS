--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    gui_allu_res.lua
--  brief:   Shows your allies resources and allows quick resource transfer
--  author:  Owen Martindell
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Ally Resource Bars 1.70 Alpha 6",
    desc      = "Shows your allies resources, thresholds, capacities and allows resource transfer",
    author    = "TheFatController & AF & BD",
    date      = "Feb 22, 2009",
    license   = "MIT/x11",
    layer     = -9,
    enabled   = false  --  loaded by default?
  }
end

-- mono's changes since 1.6:
-- Alpha 6: added actual numeric resource amount and capacity as tooltip on the right
-- Alpha 5: fixed movement from player to spectator only showing the players from the player's team
-- Alpha 4: "fixed" the bug that prevented plugin from activating after being deactivated
-- (but it will be loaded before game start because the initialize function is used for this for now)
-- fixed save/load position for spectator mode and added proper boundary checks
-- Alpha 3: hopefully fixed the display of the empty player when in player mode, myID now only calculated in player mode
-- if spectator mode position donesn't exist, load the player mode position for spectator mode, the other way around for player mode
-- and only when none exist load the default position that is calculated at load
-- added unloading when only one player in the team
-- Alpha 2: added table cleanups in teamdied
-- Alpha 1: should now correctly sort the playerlist for both player and spectator modes

-- mono's changes since 1.3/1.5:
-- major thanks to: smoth, aegis, quantum, lurker and the testers: Malicus, [war]duckomen
-- version mono.40 beta 22: a few cleanups and maybe fixed the position bug
-- version mono.40 beta 21: hopefully fixed the drifting y-axis for save position and spectator mode not set before setupteam executes bugs
-- version mono.40 beta 20: capacity indicators positions are no longer constantly recalculated unless plugin is moved
-- capacity indicators color determination now uses non-float numbers
-- rearranged the if nest of capacity indicators in GL section (chances are higher for > 6000/3000 energy/metal capacity then the chances for < 100)
-- added save and restore plugin location on the screen
-- added save and restore plugin location on the screen independently for spectator and player modes
-- version mono.40 beta 17: removed the useless function call ViewResize which caused all the debugging and programming headaches in updateBars
-- optimized drawscreen by moving isguihidden into gameframe (there is no need to call the function so many times)
-- all myID filtering is hopefully permanently removed from inner loops without the bug of drawing before game start
-- version mono.40 beta 16: another updateBars inner loop optimization: removed the root conditional
-- threshold indicators position should now remain correct independently of it's size
-- removed the root conditional from all teamList for loops
-- hopefully fixed the bug when only one allied player exists but is not shown
-- version mono.40 beta 15: hopefully fixed the "-1 player" being drawn in the list of players bug
-- version mono.40 beta 14: fixed threshold indicators lag when moving
-- version mono.40 beta 13: removed the if moving conditional in updateBars and placed content in mousemove
-- fixed bug showing own (non-player) resources when spectator/replay
-- optimized inner updateBars loop and mousepress to not make function calls to determine spectator/replay state
-- by using UnitCreated for all spectator state tracking
-- one more optimization to threshold indicators - reduce the math done in parameters (x2 of threshold indicators is not updated 30*numallied players per sec)
-- version mono.40 beta 12: reverted to the old tooltips method, fixed bug with height inscreasing after every time the plugin is reloaded
-- version mono.40 beta 11: merged with latest released work of others (AF, BD), reverted beta 6 changes
-- version mono.40 beta 10: fixed bug with resource bar plus v2.0 affecting alpha of bar backgrounds
-- version 1.40 beta 9: colors on the right of the bars instead of alpha of background for capacity indication
-- version 1.40 beta 8: reduce one more instruction in GL section of updateBars, increased number of alpha values for capacity indication
-- that however comes with the same penalty of lag as the threshold indicators when the toggle state changes
-- version 1.40 beta 7: prevent resource from drawing outside of the bar sizes, don't calculate share threshold by default of players who are no longer members of the team
-- version 1.40 beta 6: correctly position the bars based on player's resolution without resorting to hacks
-- version 1.40: added alpha-coded storage capacities bar background controllable with right mouse button
-- version 1.37: 6 more optimizations to updateBars: draw the background from the amount of current resource instead of from beginning
-- side effect makes it easier to see players which are no longer part of the team
-- remove ex1 and use xoffset directly, move ex2 outside of the loop, update them only when they change
-- eliminated the 2 redundant reassignments eCur and mCur
-- version 1.36: added option to draw share threshold even if allies are not sharing and middle mouse toggle
-- version 1.35: one more indicators optimization: remove function calls and nil checks from unitcreated
-- version 1.34: 2 more indicators optimizations: updates only allies and updates ALL allies when any unit is created
-- version 1.33: yet more optimizations for indicators (moved to UnitCreated, removed esx2/msx2, made xoffset loop invariant in updateBars)
-- version 1.32: optimizations (mostly in the indicators but also a few others)
-- version 1.31: added energy and metal share threshold indicators
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local TOOL_TIPS = true

--------------------------------------------------------------------------------
------------------------------ Function Speedups -------------------------------

local GetPlayerList = Spring.GetPlayerList
local GetPlayerInfo = Spring.GetPlayerInfo
local GetTeamResources = Spring.GetTeamResources
local GetMyTeamID = Spring.GetMyTeamID
local GetMouseState = Spring.GetMouseState
local GetSpectatingState = Spring.GetSpectatingState
--local IsReplay = Spring.IsReplay -- is it a good idea to localize a function that is only run once ?
local IsGUIHidden = Spring.IsGUIHidden
local ShareResources = Spring.ShareResources
local GetGameFrame = Spring.GetGameFrame
local GetAllyTeamList = Spring.GetAllyTeamList
local GetTeamList = Spring.GetTeamList
local GetTeamColor = Spring.GetTeamColor
local GetMyAllyTeamID = Spring.GetMyAllyTeamID
local GetTeamInfo = Spring.GetTeamInfo -- used to find the -1 teamID and remove it from the teamList
local SendCommands = Spring.SendCommands

-------------------------- Lua Math Function Speedups --------------------------
local mathMin = math.min
--local theroot = math.sqrt
--local thelog = math.log10
---------------------------------- GL Speedups ---------------------------------
local sF = string.format
local gl, GL = gl, GL
local glText = gl.Text
local glRect = gl.Rect
local glColor = gl.Color
local glBlending = gl.Blending
local glPushMatrix = gl.PushMatrix
local glCallList = gl.CallList
local glPopMatrix = gl.PopMatrix
local glDeleteList = gl.DeleteList
local glCreateList = gl.CreateList
--local glGetViewSizes = gl.GetViewSizes

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local displayList
local staticList
--local viewSizeX, viewSizeY = 0,0
local BAR_HEIGHT       = 6
local BAR_SPACER       = 3
local BAR_WIDTH        = 120
local BAR_GAP          = 7
local TOTAL_BAR_HEIGHT = (BAR_SPACER + BAR_HEIGHT + BAR_HEIGHT)
local TOP_HEIGHT       = (BAR_GAP + BAR_GAP)
local BAR_OFFSET       = (TOP_HEIGHT + BAR_SPACER)
local START_HEIGHT     = (TOTAL_BAR_HEIGHT + BAR_GAP + TOP_HEIGHT)
local FULL_BAR         = (BAR_WIDTH + BAR_GAP + BAR_GAP + BAR_SPACER)
local w                = (BAR_WIDTH + BAR_OFFSET + BAR_GAP)
local h                = START_HEIGHT
--local x1               = - w-- - 1171
--local y1               = - h
local viewSizeX, viewSizeY = gl.GetViewSizes()
--local x1               = - w + viewSizeX
--local y1               = - h - 31 + viewSizeY
local replay = Spring.IsReplay()
local initspec = GetSpectatingState()
if replay then initspec = true end
if initspec then
 x1 = viewSizeX - w
 y1, saveY = ((viewSizeY / 1000) * 999) + (- h - ((viewSizeY / 100) * 20))
else
 if 1600 <= viewSizeX then
--   Spring.Echo("x1 = "..x1)
 x1 = ((viewSizeX / 1000) * 267) - w
--	Spring.Echo("x1 = "..x1)
 y1, saveY = viewSizeY - h
-- this is the nice place for high resolution players
 else
--  x1 = ((viewSizeX / 100000) * 92000) + x1
--   x1 = viewSizeX + x1 - 100
 x1 = viewSizeX - w - 100
--  y1 = ((viewSizeY / 100000) * 99900) + y1 - 30
 y1, saveY = ((viewSizeY / 1000) * 999) + (- h - ((viewSizeY / 100) * 3))
  --Spring.Echo("y1 = "..y1)
 end
end

local mx, my = 0,0
local sentSomething = false
local enabled       = false
local transferring  = false
local transferTeam
local transferType
local teamList   = {}
--local teamRes    = {}
--teamRes    = {}
local teamColors = {}
local teamIcons  = {}
local deadTeams  = {}
local sendEnergy = {}
local sendMetal  = {}
local trnsEnergy = {}
local trnsMetal  = {}
local labelText  = {}
local sentEnergy = 0
local sentMetal  = 0
--local myID
--local myID = GetMyTeamID()
--local myID = Spring.GetMyTeamID()

--------------------------------------------------------------------------------
-- threshold boolean flow control additions
local THRESH_SIZE = 3	-- size (width) of the threshold indicators
--local storecolorX = 
--local storecolorY = 
local teamResES = {}
local teamResMS = {}
local teamResSE = {}
local teamResSM = {}
--local updateTe = true
--local updateTm = true
--local mainU = 0
--local teamBarsUpdate = 0
--local mainE = 0
--local secE = 0
--local mainM = 0
--local secM = 0
--local GetTimer = Spring.GetTimer
--local DiffTimers = Spring.DiffTimers
--local Start_, End_, totaltime, differencetime = 0,0,0,0
--local mouseStart_, mouseEnd_, mousetotaltime, mousedifferencetime = 0,0,0,0
--local destStart_, destEnd_, desttotaltime, destdifferencetime = 0,0,0,0
--local thestatic = 0
local eShare = {}
local mShare = {}
--local storeFactor = 200
local eMax = {}
local mMax = {}
local capcolors = true		-- color indication on the right of bars for capacity ?
local drawAll = false		-- draw share threshold when player is not sharing ?
--local ChangedPosition = false    -- avoid unnecessary writes to Config/shortmodname.lua
--------------------------------------------------------------------------------

local function getTeamNames()
  local teamNames = {}
  local playerList = GetPlayerList()
  for _,playerID in ipairs(playerList) do
    local name,_,spec,teamID = GetPlayerInfo(playerID)
    if not spec then
      if name and teamID then
--        Spring.Echo(name)
		teamNames[teamID] = name
      end
    end
  end
  return teamNames
end



function widget:Shutdown()
  glDeleteList(displayList)
end

local function setUpTeam()
  teamList = {}
  teamRes = {}
  teamColors = {}
--  Spring.Echo("setUpTeam")
--  Spring.Echo("pre-setupteam ID: "..GetMyTeamID())
--  Spring.Echo("post setupteam ID: "..GetMyTeamID())
  local getTeams = nil
  local teamCount = 0
--  mx, my = 0,0
--  if GetSpectatingState() then
  Ispec = GetSpectatingState()
  if Ispec then
   local alist = GetAllyTeamList()
   for _,allyID in pairs(alist) do
     getTeams = GetTeamList(allyID)
     if getTeams ~= nil then
       for _,teamID in ipairs(getTeams) do --ipairs appears to return the teams better sorted than pairs
          --local eCur = GetTeamResources(teamID, "energy")
          --Spring.Echo(eCur..teamID)
		  --if eCur and (not deadTeams[teamID]) then
		  _,p,dead = GetTeamInfo(teamID)
		  --p,t,spectator,s = GetPlayerInfo(teamID)
		  --if isdead then 
		  --Spring.Echo(teamID.."is a dead".."playerID:"..p.."allyteam:"..a.."income mult:"..imult)
		  --if (not deadTeams[teamID]) and (not spectator) then
		  --Spring.Echo(_.." "..teamID)
		  --used, produced, excessed, received, sent = Spring.GetTeamResourceStats(teamID, "energy")
		  --Spring.Echo(_..teamID..":"..used..produced..excessed..received..sent)
		  if (not deadTeams[teamID]) and (p ~= -1) and (not dead) then --and (used ~= 0) and (produced ~= 0) and (excessed ~= 0) and (received ~=0) and (sent ~=0) then --and (teamID ~= 16) then
            --Spring.Echo("my ID: "..myID)
			--Spring.Echo(_..teamID..p..s)
			teamCount = (teamCount + 1)
			teamList[teamCount] = teamID
            -- the problem that occured when using [teamID] is the lua language rules, indexes start with 1 and not from 0 as in C/++
			-- which is probably what caused teamID 0 to jump to the end of the list
			-- the sorting problem was a result of teamID's being the indexers, which caused the for loop of teamRes to receive them unsorted
          end
        end
     end
   end
  else
   myID = GetMyTeamID() -- this is only needed here and in transfer resources, but in spectator mode resources cannot be transfered
   getTeams = GetTeamList(GetMyAllyTeamID())
   for _,teamID in ipairs(getTeams) do
      local eCur = GetTeamResources(teamID, "energy")
      --if eCur and (not deadTeams[teamID]) then
	  -- next stage of testing requires playing
	  --_,p,_,_,_,_,_,name = GetTeamInfo(teamID)
	  --Spring.Echo(teamID..p..name..myID)
	  --table.remove(teamList,myID)
	  --Spring.Echo(teamList[teamID])
	  --if teamList[teamID] == nil then table.remove(teamList,teamID) end
	  --Spring.Echo(_)
	  --table.remove(teamList,1)
	  --_,p,dead = GetTeamInfo(teamID)
	  if eCur and (not deadTeams[teamID]) and (teamID ~= myID) then --and (not dead) then
	  -- by removing own team from here, we eliminate the need for redoing the comparison within future loops
	  -- as long as myID is not determined at initialization - in which case the updateBars for loop runs before setupteams updates the teams
	  -- which causes a nil teamRes to pass to the GL loop at it's first iteration
	  --if teamID ~= myID then
	    --lowest = mathMin((lowest or teamID),teamID)
		--highest = math.max((highest or teamID),teamID)
		--lowest
--		Spring.Echo(teamID)
		teamCount = (teamCount + 1)
		teamList[teamCount] = teamID
		--teamList[teamID] = true
      end
	  --Spring.Echo(teamList)
	  --if teamID == myID then teamList[teamID] = nil end
	  --table.remove(teamList,3)
	  --table.remove(teamList)
	   --Spring.Echo(#teamList)
	end
--	Spring.Echo("list lenght: "..#teamList)
--    for teamID in pairs(teamList) do
--	 if teamList[teamID] == nil then table.remove(teamList,teamID) end
--	end
  --teamList[teamCount] = teamID
  end

  for teamIndex,teamID in pairs(teamList) do
    local r,g,b = GetTeamColor(teamID)
    teamColors[teamID] = {r=r,g=g,b=b}
    --table.remove(teamColors,myID)
  end
--  teamISsetup = true
  if (teamCount > 0) then
    enabled = true
    return true
  else
    enabled = false
	Spring.Echo("Ally Resource Bars: No allies, unloading")
    widgetHandler:RemoveWidget() -- without this, setUpTeam is continuously executed in solo mode, probably from gameframe's elseif
	return false
  end
end



--[[local function setUpTeam()
  teamList = {}
  teamRes = {}
  teamColors = {}
  myID = GetMyTeamID()
  local getTeams = Spring.GetTeamList(Spring.GetMyAllyTeamID())
  mx, my = 0,0
  local teamCount = 0
  for _,teamID in pairs(getTeams) do
    local eCur = GetTeamResources(teamID, "energy")
    if eCur and (not deadTeams[teamID]) then
      teamList[teamID] = true
      teamCount = (teamCount + 1)
    end
  end
  for teamID in pairs(teamList) do
    local r,g,b = Spring.GetTeamColor(teamID)
    teamColors[teamID] = {r=r,g=g,b=b}
  end
  if (teamCount > 1) then
    enabled = true
    return true
  else
    enabled = false
    return false
  end
end--]]

local function updateStatics()
--	thestatic = thestatic +1
--	Spring.Echo("statics:"..thestatic)
--	Spring.Echo("updateStatics")
  if (staticList) then glDeleteList(staticList) end
  staticList = glCreateList( function()
    glBlending(true)
	glColor(0.2, 0.2, 0.2, 0.8)
    glRect(x1, y1, x1+w,y1+h)
    local height = h - TOP_HEIGHT
    local teamNames = getTeamNames()
    teamIcons = {}
    for teamIndex,teamID in pairs(teamList) do
      --if (teamID ~= myID or spec) then
        glColor(teamColors[teamID].r,teamColors[teamID].g,teamColors[teamID].b,1)
        glRect(x1+BAR_GAP,y1+height,x1+TOP_HEIGHT,y1+height-TOTAL_BAR_HEIGHT)
        teamIcons[teamID] = 
        {
         name = teamNames[teamID] or "No Player",
         iy1 = y1+height,
         iy2 = y1+height-TOTAL_BAR_HEIGHT,
        }
        height = (height - TOTAL_BAR_HEIGHT - BAR_GAP)
      --end
    end
  end)
end

local function updateBars()
	--if not started then return false end
	-- the "solution" below to the problem of: either bars drawing before the game has started, or having to run a conditional on the inner loop
	-- is not a perfect one for sure, and will still require work in the future, but currently it is most certainly superior to the alternatives
	-- (those being: running a function call everytime updateBars is called AND having a conditional on the inner loop)
	-- of corse the presented "solution" has drawback(s) of it's own:
	-- the first: an assignment operation will be performed everytime updateBars is called (a minimum of 30 per second)
	-- but hopefully because it is a boolean operation it will be only a small drawback
	-- and the second: it requires the use of an extra 2 booleans for flow control
--  Spring.Echo("Updatebars pre-if Start")
--  Spring.Echo("pre updatebars ID: "..GetMyTeamID())
--  if (myID ~= GetMyTeamID()) then
--	if not teamISsetup then setUpTeam()
--	if started then --setUpTeam()
--     if setUpTeam() then
--      updateStatics()
--      updateBars()
--     end
    --Spring.Echo("Updatebars return")
--	return false   
--	else
--	updateStatics()
--	updateBars()
--    end
--  Spring.Echo("Updatebars not return")
--  local eCur, eMax, mCur, mMax --, eShare, mShare
    local eCur, mCur --, eShare, mShare
--  local eShare, mShare = 0, 0
  --  local eShares, mShares = false, false
    local height = h - TOP_HEIGHT
--  mainU = mainU+1
--  Spring.Echo("updateBars:"..mainU)
--  if moving then

--  storecolorX = 
--  storecolorY = 
-- start and end of the x axis of the bars only need to be updated if they have changed
--  end
-- teamList for loop to function execution ratio is number of allied players:1 * 30 per second
--  bars = true
  for teamIndex,teamID in pairs(teamList) do
--    if (teamID ~= myID) or spec then
--	  eShare[teamID] = {}
--	  mShare[teamID] = {}
	  eCur, eMax[teamID], _, _, _, eShare[teamID], _ = GetTeamResources(teamID, "energy")
      mCur, mMax[teamID], _, _, _, mShare[teamID], _ = GetTeamResources(teamID, "metal")
	  --Spring.Echo("Currently Drawing: "..teamID)
	  --Spring.Echo("list lenght: "..#teamList)
	  --Spring.Echo("minimum: "..mathMin(teamList))
--	  eCur, eMax, _, _, _, eShare = GetTeamResources(teamID, "energy")
--    mCur, mMax, _, _, _, mShare = GetTeamResources(teamID, "metal")
--	  mShare = mShare or 1
--	  eShare = eShare or 1
--	  eCur = eCur + (sendEnergy[teamID] or 0)
--    mCur = mCur + (sendMetal[teamID] or 0)
		
--      local xoffset = (x1+BAR_OFFSET)
--		Spring.Echo(teamID,xoffset,teamRes[teamID])
--      teamBarsUpdate = teamBarsUpdate+1
--	  Spring.Echo("teamList:"..teamBarsUpdate..Einc..eCur..Eexp..sent..received..pull)
	  --Spring.Echo("teamres")
--	  if trnsEnergy[teamID] ~= nil then Spring.Echo(trnsEnergy[teamID],type(trnsEnergy[teamID])) end
	  --eCur = eCur + (sendEnergy[teamID] or 0)
	  teamRes[teamID] =
      {
--        ex1 = xoffset,
        ey1 = y1+height,
--        ex2 = xoffset+BAR_WIDTH,
-- ex1 and ex2 are loop invariant they can be moved outside of the loop
        ex2b = xoffset+(BAR_WIDTH * ((eCur + (sendEnergy[teamID] or 0)) / eMax[teamID])),
--        ex2b = xoffset+(BAR_WIDTH * (eCur / eMax)),
        ey2 = y1+height-BAR_HEIGHT,
--		DoesPlayerShareEnergy = false,
--        teamRes[teamID].mx1 = xoffset
        my1 = y1+height-BAR_HEIGHT-BAR_SPACER,
--        teamRes[teamID].mx2 = xoffset+BAR_WIDTH,
--		mx1 and mx2 have the same value as ex1 and ex2, no need for them
        mx2b = xoffset+(BAR_WIDTH * ((mCur + (sendMetal[teamID] or 0)) / mMax[teamID])),
--        mx2b = xoffset+(BAR_WIDTH * (mCur / mMax)),
        my2 = y1+height-TOTAL_BAR_HEIGHT,
--		DoesPlayerShareMetal = false,
--		e = (math.sqrt(eMax) / 200) * storeFactor,
--		m = (math.sqrt(mMax) / 130) * storeFactor,
--		e = theroot(eMax) / storeFactor,
--		m = theroot(mMax) / storeFactor,
	  }
	  
--	  if (eCur > eMax[teamID]) or ((eCur + (sendEnergy[teamID] or 0)) > eMax[teamID]) then eCur = eMax
--	  if (mCur > mMax[teamID]) or ((mCur + (sendMetal[teamID] or 0)) > mMax[teamID]) then mCur = mMax
	  -- fixing the drawing outside of the bars area bug here will cost a minimum of 5 operations
	  -- because of the weight I've decided to perform only one comparison operation in the GL section

--	  if relativity then
--	  Spring.Echo(math.sqrt(eMax))
--	  teamRes[teamID].e = math.sqrt(eMax) / 200
--	  teamRes[teamID].m = math.sqrt(mMax) / 120
--	  if eMax > 0 then teamRes[teamID].a = 0.2
--	  if eMax > 10 then teamRes[teamID].a = 0.3
--	  if eMax > 100 then teamRes[teamID].a = 0.4

	  
--	  if mMax < 10 then teamRes[teamID].m = 0
--	  elseif mMax < 50 then teamRes[teamID].m = 0.1
--	  elseif mMax < 100 then teamRes[teamID].m = 0.2
--	  elseif mMax < 1000 then teamRes[teamID].m = 0.3
--	  elseif (100000 <= eMax) then teamRes[teamID].a = 0.4
--	  else teamRes[teamID].m = 0.4 end
--	  if (Einc > Eexp) then teamRes[teamID].a = (Eexp / Einc) end
--	  if (Einc < Eexp) then teamRes[teamID].a = (Einc / Eexp) end
--	  if Einc == Eexp then teamRes[teamID].a = 0.8 end
--	  else teamRes[teamID].a = Einc / Eexp end
	  
	  
--	  mainU = mainU +1
--	  Spring.Echo("Main update "..mainU)
--	  if (eShare < 0.94) then teamResES[teamID] = {prevEshare = eShare}
--	  else teamResES[teamID] = {prevEshare = 1.1}
--	  if (eShare < 0.94) and (teamResES[teamID].prevEshare ~= eShare) then
--	  if ((teamResES[teamID] ~= nil) and (teamResES[teamID].prevEshare ~= eShare) and (eShare < 0.94)) or ((teamResES[teamID] == nil) and (eShare < 0.94)) then
--	  if (teamResES[teamID] ~= nil) and (teamResES[teamID].prevEshare ~= nil) and (teamResES[teamID].prevEshare ~= eShare) then Spring.Echo(teamResES[teamID].prevEshare, " ", eShare) end
--	Start_ = GetTimer()
--	  if (eShare < 0.94) and ((teamResES[teamID] == nil) or ((teamResES[teamID] ~= nil) and (teamResES[teamID].prevEshare ~= eShare)) or moving) then

	  --	  if (eShare < 0.94) then
--	   if (teamResES[teamID] ~= nil) and (teamResES[teamID].prevEshare ~= eShare) or (teamResES[teamID] == nil)
	  
	  -- first entry point means if the player has changed his previous energy share threshold and has a previous value that is different from current
	  -- the second means the player created an energy share threshold and doesn't have a previous value
	  -- I am assuming that math is more expensive than using an extra variable, 3 math operations or 1 assignment and 1 math operation ?
--	  esx = xoffset+(BAR_WIDTH * (eShare+0.04))
--	  teamRes[teamID].esx1 = esx
--	  esx = xoffset+(BAR_WIDTH * (eShare+0.04))
--	  teamResES[teamID] = 
--	  {
--	    esx1 = xoffset+(BAR_WIDTH * eShare),
--	    esx2 = teamResES[teamID].esx1+2,
--	    DoesPlayerShareEnergy = true,
--	    prevEshare = eShare,
--	  }
--	  teamResES[teamID].prevEshare = eShare
--	  teamResES[teamID].esx2 = teamResES[teamID].esx1+2
--	  mainE = mainE+1
--	  Spring.Echo("energy update "..mainE..eShare)
--	  else
--	   if ((teamResES[teamID] ~= nil) and (teamResES[teamID].prevEshare ~= eShare) and (eShare > 0.94)) then
--	   teamResES[teamID] = nil
--	   secE = secE+1
--	   Spring.Echo("energy else:"..secE)
--	   end
--	   	End_ = GetTimer()
--	differencetime = DiffTimers(End_,Start_)
--	totaltime = totaltime+differencetime
--	Spring.Echo("Energy Current: "..differencetime,"Energy Total: "..totaltime)
--	   if teamResES[teamID] ~= nil then teamResES[teamID] = nil end
	  -- there is no need to keep a table any more for the player that had a threshold before but no longer does, and the non-existence of the table
	  -- is the check in itself whether or not the player has a share threshold, removing the need to keep a boolean as a check for it
	  --	  updateTe = false
	  
--	  teamRes[teamID] = 
--	  {
--		wesH = true,
--		esx1  = xoffset+(BAR_WIDTH * (eShare+0.04)),
--		esx2  = xoffset+(BAR_WIDTH * (eShare+0.04))+2,
--		esx2  = teamRes[teamID].esx1+2,
--		esy1  = xoffset+(BAR_WIDTH * (eShare+0.03)),
--		esy2  = esx1+2
--	  }
--	  end
--	  if (mShare ~= nil) and (mShare < 0.99) then
--	  if (mShare < 0.99) and (teamResMS[teamID].prevMshare ~= eShare) then
--	  if (teamResMS[teamID] ~= nil) and (teamResMS[teamID].prevMshare ~= mShare) then Spring.Echo("metal update "..mainM..mShare,teamResMS[teamID].prevMshare) end
--	  if (mShare < 0.99) and ((teamResMS[teamID] == nil) or ((teamResMS[teamID] ~= nil) and (teamResMS[teamID].prevMshare ~= mShare))) then
--	  msx = xoffset+(BAR_WIDTH * (mShare))
--	  teamRes[teamID].msx1 = msx
--	  msx = xoffset+(BAR_WIDTH * (mShare))
--	  teamResMS[teamID] =
--	  {
--	    msx1 = xoffset+(BAR_WIDTH * mShare),
--	    msx2 = teamResMS[teamID].msx1+2,
--	    DoesPlayerShareMetal = true,
--	    prevMshare = mShare,
--	  }
--	  teamResMS[teamID].prevMshare = mShare
--	  teamResMS[teamID].msx2 = teamResMS[teamID].msx1+2
	  --	  updateTm = false
--	  mainM = mainM +1
--	  Spring.Echo("metal update "..mainM..mShare)
--	  else
--	   if (teamResMS[teamID] ~= nil) then teamResMS[teamID] = {} end
	  --	  updateTm = false
	  --	  teamRes[teamID] = 
--	  {
--		wmsH = true,
--		msx1  = xoffset+(BAR_WIDTH * (mShare)),
--		msx2  = xoffset+(BAR_WIDTH * (mShare))+2,
--		msx2  = teamRes[teamID].msx1+2,
--	  }
--	  end
      if (teamID == transferTeam) then
        if (transferType == "energy") then
          teamRes[teamID].eRec = true
        else
          teamRes[teamID].mRec = true
        end
      end
      height = (height - TOTAL_BAR_HEIGHT - BAR_GAP)
--    end
  end
  if (height ~= 0) then
    h = (h - height)
    y1 = (y1 + height)
    updateStatics()
  end
  --mainU = mainU+1
  --Spring.Echo("loop iteration :"..mainU)
  if (displayList) then glDeleteList(displayList) end
  displayList = glCreateList( function()
    for _,d in pairs(teamRes) do
      glColor(1, 1, 0, 1)
	  if d.ex2b > x2 then d.ex2b = x2 end -- bug fix for bars drawing outside borders
	  glRect(xoffset,d.ey1,d.ex2b,d.ey2) -- draw the amount of the resource from the offset to the relative capacity position on screen
	  if d.eRec then
        glColor(0.8, 0, 0, 0.8)
--		glColor(0.8, 0, 0, 0)
--	  elseif teamResSE[_] ~= nil then
--		  gl.Color(0.8, 0.8, 0, teamResSE[_])
--        gl.Color(0.8, 0.8, 0, 0.3)
	  else
		  glColor(0.8, 0.8, 0, 0.3)
--        gl.Color(0.8, 0.8, 0, 0.3)
      end
	  glRect(d.ex2b,d.ey1,x2,d.ey2) -- draw the rest of the unused relative capacity on screen from the current capacity (ex2b) to the end of the bar (x2)
	  if teamResSE[_] ~= nil then
	   if teamResSE[_] == 2 then
--	   gl.Color(0.8, 0.8, 0, teamResSE[_])
	   glColor(0, 0.8, 0, 1)
	   elseif teamResSE[_] == 3 then
	    glColor(0, 0, 0.8, 1)
	    elseif teamResSE[_] == 1 then
	     glColor(0.6, 0.2, 0, 1)
	   end
--	   glRect(x2+1,d.ey1+1,x2+BAR_GAP,d.ey2) -- draw the capacity indicator from the end of the bar (x2+1) to x size of plugin - 1
	   glRect(capstart,d.ey1,capend,d.ey2) -- draw the capacity indicator from the end of the bar (x2+1) to x size of plugin - 1
	  end

--    gl.Rect(d.ex1,d.ey1,d.ex2,d.ey2)
--      gl.Color(1, 1, 0, 1)
--	  gl.Color(1, 1, 0, d.a)
--	  Spring.Echo(d.a)
--      if d.ex2b > x2 then gl.Rect(xoffset,d.ey1,x2,d.ey2)
--	  else gl.Rect(xoffset,d.ey1,d.ex2b,d.ey2) end
	  -- bug fix for bars drawing outside of the bars
--    gl.Rect(d.ex1,d.ey1,d.ex2b,d.ey2)
--	  Spring.Echo(_,d,type(d))
--     if (teamResES[_] ~= nil and teamResES[_].DoesPlayerShareEnergy == true) then
	  if teamResES[_] ~= nil then
		glColor(1, 0.2, 0, 0.8)
		glRect(teamResES[_].esx1,d.ey1,teamResES[_].esx2,d.ey2)
	  end
      glColor(1, 1, 1, 1)
	  if d.mx2b > x2 then d.mx2b = x2 end
	  glRect(xoffset,d.my1,d.mx2b,d.my2)
	  if d.mRec then
        glColor(0.8, 0, 0, 0.8)
--      elseif teamResSM[_] ~= nil then
--        gl.Color(0.8, 0.8, 0.8, 0.3)
--        gl.Color(0.8, 0.8, 0.8, teamResSM[_])
	  else
--        gl.Color(0.8, 0.8, 0.8, 0.3)
        glColor(0.8, 0.8, 0.8, 0.3)
      end
	  glRect(d.mx2b,d.my1,x2,d.my2)
  	  if teamResSM[_] ~= nil then
	   if teamResSM[_] == 2 then
--	   gl.Color(0.8, 0.8, 0, teamResSE[_])
	   glColor(0, 0.8, 0, 1)
	   elseif teamResSM[_] == 3 then
	    glColor(0, 0, 0.8, 1)
	    elseif teamResSM[_] == 1 then
	     glColor(0.6, 0.2, 0, 1)
	   end
	   glRect(capstart,d.my1,capend,d.my2)
	  end
--    gl.Rect(d.ex1,d.my1,d.ex2,d.my2)
--    gl.Rect(d.ex1,d.my1,d.mx2b,d.my2)
--	  if (teamResMS[_] ~= nil and teamResMS[_].DoesPlayerShareMetal == true) then
	  if teamResMS[_] ~= nil then
--		Spring.Echo(teamResMS[_].msx1)
		glColor(1, 0.2, 0.2, 0.8)
		glRect(teamResMS[_].msx1,d.my1,teamResMS[_].msx2,d.my2)
	  end
	  end
  end)
end

function widget:Initialize()

 --  Spring.Echo("Init")
--  x1 = math.floor(x1 - viewSizeX)
--  y1 = math.floor(y1 - viewSizeY)
--  viewSizeX, viewSizeY = gl.GetViewSizes()
--  if 1600 <= viewSizeX then
--   x1 = ((viewSizeX / 1000) * 267) + x1
--   y1 = viewSizeY + y1
  -- this is the nice place for high resolution players
--  else
--  x1 = ((viewSizeX / 100000) * 92000) + x1
--   x1 = viewSizeX + x1 - 100
--  y1 = ((viewSizeY / 100000) * 99900) + y1 - 30
--   y1 = ((viewSizeY / 1000) * 999) + (y1 - ((viewSizeY / 100) * 3))
--  end
--  Spring.Echo(x1,y1)
  xoffset = x1+BAR_OFFSET
  x2 = xoffset+BAR_WIDTH
  capstart = x2+1
  capend = x2 + (BAR_GAP - 1)
	if setUpTeam() then
     updateStatics()
     updateBars()
    end
--  myID = GetMyTeamID()
--  Spring.Echo("Init ID: "..GetMyTeamID())
  --  setUpTeam()
end

function widget:TeamDied(teamID)
  deadTeams[teamID] = true
  -- these tables will otherwise still contain data that is no longer relevant
  -- the unitcreated else cleanup will only cleanup from the list of current teams created by setupteam
  -- it will not clean the ID's of the previous teamList
  teamResES[teamID] = nil
  teamResMS[teamID] = nil
  teamResSE[teamID] = nil
  teamResSM[teamID] = nil
  eShare[teamID] = nil
  mShare[teamID] = nil
  eMax[teamID] = nil
  mMax[teamID] = nil

  if setUpTeam() then
    updateStatics()
    updateBars()
  end
end

function widget:UnitCreated(unitID, unitDefID, unitTeam)
  if deadTeams[unitTeam] then
    deadTeams[unitTeam] = nil
    --spec = GetSpectatingState()
	if setUpTeam() then
      updateStatics()
      updateBars()
    end
  end
--  Spring.Echo("UnitCreated Start")
  if enabled then
  --  getTeamsC = {}
--  local getTeamsC = Spring.GetTeamList(Spring.GetMyAllyTeamID())
--  this function will cost higher than updateBars only when units are created faster than 30 * number of allied players per second
  for teamIndex,teamID in ipairs(teamList) do -- makes it faster without keeping information about non-allied teams
   --if (myID ~= teamID) or spec then
  --   if (myID ~= teamID and (spec or replay)) or (myID ~= teamID and (not spec and not replay)) then

   if capcolors then
	 if eMax[teamID] <= 100 then teamResSE[teamID] = nil
	 elseif (eMax[teamID] > 100) and (eMax[teamID] < 1000) then teamResSE[teamID] = 1
	 elseif (eMax[teamID] >= 1000) and (eMax[teamID] < 6000) then teamResSE[teamID] = 2
--	 elseif (eMax[teamID] > 6000) and (eMax[teamID] < 10000) then teamResSE[teamID] = 0.4
--	 elseif eMax[teamID] > 10000 then teamResSE[teamID] = 0.4
	 elseif eMax[teamID] >= 6000 then teamResSE[teamID] = 3 end
	 
	 if mMax[teamID] <= 100 then teamResSM[teamID] = nil
	 elseif (mMax[teamID] > 100) and (mMax[teamID] < 1000) then teamResSM[teamID] = 1
	 elseif (mMax[teamID] >= 1000) and (mMax[teamID] < 3000) then teamResSM[teamID] = 2
	 elseif mMax[teamID] >= 3000 then teamResSM[teamID] = 3 end
	 --	 elseif (mMax[teamID] > 3000) and (mMax[teamID] < 10000) then teamResSM[teamID] = 0.4
--	 elseif mMax[teamID] < 10000 then teamResSM[teamID] = 0.4
	else
	 teamResSE[teamID] = nil
	 teamResSM[teamID] = nil
   end

--	if relativity and (eMax[teamID] > 1.3) then
--	 if (eMax[teamID] < 1000000) then ex2[teamID] = xoffset+((BAR_WIDTH + 51) / (thelog(eMax[teamID]) * 10))
--	 elseif (eMax[teamID] > 1000000) and (eMax[teamID] < 10000000) then ex2[teamID] = {xoffset+((BAR_WIDTH + 30) * (thelog(eMax[teamID]) / 10))}
--	 elseif (eMax[teamID] > 10000000) and (eMax[teamID] < 100000000) then ex2[teamID] = {xoffset+((BAR_WIDTH + 13.33) * (thelog(eMax[teamID]) / 10))}
--	 elseif (eMax[teamID] > 100000000) and (eMax[teamID] < 1000000000) then ex2[teamID] = {xoffset+((BAR_WIDTH + 13.33) * (thelog(eMax[teamID]) / 10))}
--	end
--	else
--	 teamResSE[teamID] = nil
--	 teamResSM[teamID] = nil
--	end
--	mx2 = 
	

--	(thelog(mMax[teamID]) * 10)
--	Spring.Echo("Energy LOG: "..thelog(eMax[teamID]).." "..eMax[teamID].." "..thelog(eMax[teamID])/2.305)
--	Spring.Echo("Metal LOG: "..thelog(mMax[teamID]).." "..mMax[teamID].." "..thelog(mMax[teamID])/2.305)
--	if alphacoding then
	  
	
--	 if eMax[teamID] < 100 then teamRes[teamID].e = eMax[teamID] / 1000
--	  elseif eMax[teamID] < 1000 then teamRes[teamID].e = eMax[teamID] / 3300
--	  elseif eMax[teamID] < 10000 then teamRes[teamID].a = eMax[teamID] / 100000
--	  elseif teamResSE[teamID] = 0.3 end


--	if alphacoding and ((eMax[teamID] > 100) or (eMax[teamID] < 100000)) then teamResSE[teamID] = (thelog(eMax[teamID]) ) / 20
--	 elseif eMax[teamID] > 100000 then teamResSE[teamID] = 0.5 end
--	else teamResSE[teamID] = 0.05 end
--	Spring.Echo(thelog(eMax[teamID]))
--	if alphacoding and ((mMax[teamID] > 100) or (mMax[teamID] < 100000)) then teamResSM[teamID] = (thelog(mMax[teamID]) ) / 20
--	 elseif mMax[teamID] > 100000 then teamResSM[teamID] = 0.5 end
--	else teamResSM[teamID] = 0.05 end

--	and (mMax[teamID] < 1000) then teamResSM[teamID] = 0.05
--	elseif alphacoding and (mMax[teamID] > 3000) then teamResSM[teamID] = 0.5 end
--	  elseif eMax < 10000 then teamRes[teamID].e = 0.2
--	  elseif eMax < 100000 then teamRes[teamID].e = 0.3
--	  elseif (100000 <= eMax) then teamRes[teamID].a = 0.4
--	else teamResSM[teamID] = 0.3 end
	
	-- the idea is to allow players to distinguish quickly between players that do have storage and those that dont (when it is visible)
	-- I can't come up with a way that will provide this information when they DO have the bar full
	-- (but then, they may not need energy or storage at that point anyway)
	-- I guess I could use a fraction of these values to brighten up the quantity bar...
--    _,_,_,_,_,eShare = GetTeamResources(teamID, "energy")
--    _,_,_,_,_,mShare = GetTeamResources(teamID, "metal")
--	eShares = tonumber(eShare[teamID])
--	mShares = tonumber(mShare[teamID])
--	Spring.Echo(eShare[teamID],type(eShare[teamID]), eShares, type(eShares))
--    if ((eShare[teamID] ~= nil) and (eShare[teamID] < 0.94)) then teamResES[teamID] = {esx1 = xoffset+(BAR_WIDTH * eShare)}
	if drawAll or ((not deadTeams[teamID]) and (eShare[teamID] < 0.94)) then
	 teamResES[teamID] = {esx1 = xoffset+(BAR_WIDTH * eShare[teamID]) - THRESH_SIZE / 2}
	 teamResES[teamID].esx2 = teamResES[teamID].esx1+THRESH_SIZE
    else teamResES[teamID] = nil end
--    if ((mShare[teamID] ~= nil) and (mShare[teamID] < 0.99)) then teamResMS[teamID] = {msx1 = xoffset+(BAR_WIDTH * mShare)}
    if drawAll or ((not deadTeams[teamID]) and (mShare[teamID] < 0.99)) then
	 teamResMS[teamID] = {msx1 = xoffset+(BAR_WIDTH * mShare[teamID]) - THRESH_SIZE / 2}
	 teamResMS[teamID].msx2 = teamResMS[teamID].msx1+THRESH_SIZE
    else teamResMS[teamID] = nil end
   end
--  end
-- the side effect is that when spectating data is available immediatly when switching to different ally team(s)
-- because data about that team is not nullified and will remain (but new data about other team(s) will not be created until team is switched again)
-- but when player, data will never be created of the other team(s)
  --  for _,teamID in pairs(getTeams) do
  --  if myID == unitTeam then
--  updateTe = true
--  updateTm = true
--  Spring.Echo("UnitCreated End")
  end
 --end
end

local function transferResources(n)
  local sCur, sMax = GetTeamResources(transferTeam, transferType)
  local lCur, _, _, lInc, _, _, _, lRec = GetTeamResources(myID, transferType)
  if (transferType == "metal") then 
    lCur = (lCur - sentMetal)
    sCur = sCur + (sendMetal[transferTeam] or 0)
  else
    lCur = (lCur - sentEnergy)
    sCur = sCur + (sendEnergy[transferTeam] or 0)
  end
  local send = mathMin(mathMin((sMax-sCur),((lInc+lRec)*0.3)),lCur)
--local send = 100
  if (send > 0) then
    if (transferType == "energy") then
      if sendEnergy[transferTeam] then
        sendEnergy[transferTeam] = (sendEnergy[transferTeam] + send)
      else
        sendEnergy[transferTeam] = send
        sentSomething = true
      end
      sentEnergy = (sentEnergy + send)
      trnsEnergy[transferTeam] = (send * 30)
    else
      if sendMetal[transferTeam] then
        sendMetal[transferTeam] = (sendMetal[transferTeam] + send)
      else
        sendMetal[transferTeam] = send
        sentSomething = true
      end
      sentMetal = (sentMetal + send)
      trnsMetal[transferTeam] = (send * 30)
    end
  end
end

function widget:GameFrame(n)
--  Spring.Echo("GameFrame: "..n)
  if enabled then
    updateBars()
    if transferTeam then
      transferResources(n)
    end
    if sentSomething and ((n % 16) == 0) then
      for teamID,send in pairs(sendEnergy) do
        ShareResources(teamID,"energy",send)
      end
      for teamID,send in pairs(sendMetal) do
        ShareResources(teamID,"metal",send)
      end
      sendEnergy = {}
      sendMetal = {}
      trnsEnergy = {}
      trnsMetal = {}
      sentEnergy = 0
      sentMetal = 0 
      sentSomething = false
    end
    if TOOL_TIPS then
      local x, y = GetMouseState()
      if (mx ~= x) or (my ~= y) or transferring or ((n % 15) == 0) then
        mx = x
        my = y
        if (x > x1 + BAR_GAP) and (y > y1 + BAR_GAP) and (x < (x1 + FULL_BAR)) and (y < (y1 + h - TOP_HEIGHT)) then
          for teamID,defs in pairs(teamIcons) do
            if (y < defs.iy1) and (y >= defs.iy2) then
              local eAmount, eCapacity, _, eInc, _, _, _, eRec = GetTeamResources(teamID, "energy")
              local mAmount, mCapacity, _, mInc, _, _, _, mRec = GetTeamResources(teamID, "metal")   
              eRec = eRec + (trnsEnergy[teamID] or 0)
              mRec = mRec + (trnsMetal[teamID] or 0)      
              labelText[1] = 
              {
                label=defs.name,
                x=x1-BAR_SPACER,
                y=defs.iy2-1,
                size=TOTAL_BAR_HEIGHT,
                config="orn",
              }
              labelText[2] = 
              {
                label="(E: +"..sF("%.1f",eInc+eRec) ..", M: +"..sF("%.2f",mInc+mRec)..")", 
                --x=x1-BAR_SPACER, 
                y=defs.iy2-TOTAL_BAR_HEIGHT, 
                size=TOTAL_BAR_HEIGHT/1.25, 
                --config="orn",
              }
			  labelText[3] = 
              {
                label="(E: "..sF("%d",eAmount) .." / "..sF("%d",eCapacity)..")", 
                x=x2+BAR_SPACER+BAR_GAP,
				--x=x1-BAR_SPACER,
                y=defs.iy2+11,
                --size=TOTAL_BAR_HEIGHT/1.25, 
                config="oln",
              }
			  labelText[4] = 
              {
                label="(M: "..sF("%d",mAmount) .." / "..sF("%d",mCapacity)..")", 
                --x=x1-BAR_SPACER,
                y=defs.iy2+11+BAR_SPACER-TOTAL_BAR_HEIGHT, 
                --size=TOTAL_BAR_HEIGHT/1.25, 
                --config="oln",
              }
              return
            end
          end
          if (labelText) then labelText = {} end
        elseif (labelText) then labelText = {} end
      end
    end
  elseif (#GetTeamList(GetMyAllyTeamID()) > 1) then
--    Spring.Echo("GameFrame Else Start")
	setUpTeam()
    updateStatics()
    updateBars()
  end
--  if (not IsGUIHidden()) and (n > 0) then started = true end
--	if not IsGUIHidden() then started = true end
	if not IsGUIHidden() then started = true end
--	if started and not enabled then
--	 if setUpTeam() then
--     updateStatics()
--     updateBars()
--     end
	--end
	--   if n > 0 then started = true end
 -- else started = false
--  end
end

function widget:GameStart()
  enabled = true
  setUpTeam()
  updateStatics()
end 

function widget:DrawScreen()
--  if enabled and (not IsGUIHidden()) and teamISsetup then
--  if bars and (not IsGUIHidden()) then
--	Spring.Echo("draw")
	--Spring.Echo("list lenght: "..#teamList)
	if enabled and started then
--	Spring.Echo("Drawscreen Start")
    glPushMatrix()
      glCallList(staticList)
      glCallList(displayList)
	  if (labelText[1]) then
        glColor(1, 1, 1, 0.8)
        glText(labelText[1].label,labelText[1].x,labelText[1].y,labelText[1].size,labelText[1].config)
        glColor(0.8, 0.8, 0.8, 0.8)
        glText(labelText[2].label,labelText[1].x,labelText[2].y,labelText[2].size,labelText[1].config)
        glColor(0.8, 0.8, 0.8, 0.8)
        glText(labelText[3].label,labelText[3].x,labelText[3].y,labelText[2].size,labelText[3].config)
        glColor(0.8, 0.8, 0.8, 0.8)
        glText(labelText[4].label,labelText[3].x,labelText[4].y,labelText[2].size,labelText[3].config)
		end
    glPopMatrix()
--  else setUpTeam()
  end
  
--	Spring.Echo("Drawscreen End")
end

function widget:MouseMove(x, y, dx, dy, button)
  if (enabled) then
    if moving then
--      ChangedPosition = true
	  x1 = x1 + dx
--      saveY = y - ((viewSizeY / 100) * 3)
	  y1 = y1 + dy
	  saveY = saveY + dy
	  xoffset = (x1+BAR_OFFSET)
	  x2 = (xoffset+BAR_WIDTH)
	  capstart = x2+1
	  capend = x2 + (BAR_GAP - 1)
	  for teamIndex,teamID in pairs(teamList) do
	   -- update position of the thresholds only if they already have a position, eliminates the if myID 
	   -- and the rest of the conditionals for determining is they do have a threshold, it is still only updated at the UnitCreated frequency
	   if teamResES[teamID] ~= nil then
        teamResES[teamID] = {esx1 = xoffset+(BAR_WIDTH * eShare[teamID]) - THRESH_SIZE / 2}
	    teamResES[teamID].esx2 = teamResES[teamID].esx1+THRESH_SIZE
	   end
	   if teamResMS[teamID] ~= nil then
	    teamResMS[teamID] = {msx1 = xoffset+(BAR_WIDTH * mShare[teamID]) - THRESH_SIZE / 2}
	    teamResMS[teamID].msx2 = teamResMS[teamID].msx1+THRESH_SIZE
	   end
	  end
	  updateBars()
      updateStatics()
    elseif transferring then
      transferTeam = nil
      if (x > (x1+BAR_OFFSET)) and (x < (x1+BAR_OFFSET+BAR_WIDTH)) then
        if (transferType == "energy") then
          for teamID,defs in pairs(teamRes) do
            if (y < defs.ey1) and (y > defs.ey2) then
              transferTeam = teamID
              return
            end
          end
        else
          for teamID,defs in pairs(teamRes) do
            if (y < defs.my1) and (y > defs.my2) then
              transferTeam = teamID
              return
            end
          end
        end
      end      
    end
  end
end

function widget:MousePress(x, y, button)
--  if (button == 4) then
--  storeFactor = storeFactor + 50
--  return true
-- end
--  if (button == 5) and (storeFactor > 50) then
--  storeFactor = storeFactor - 50
--  return true
--  end
  if (enabled) and ((x > x1) and (y > y1) and (x < (x1 + w)) and (y < (y1 + h))) then
	if button == 1 and (y > (y1 + h - TOP_HEIGHT)) then
	  capture = true
      moving  = true
      return capture
    end
    if (button == 2) and (y > (y1 + h - TOP_HEIGHT)) then
	 drawAll = not drawAll
	 return true
	end
    if (button == 3) and (y > (y1 + h - TOP_HEIGHT)) then
	 capcolors = not capcolors
	 return true
	end
    if (x > (x1+BAR_OFFSET)) and (x < (x1+BAR_OFFSET+BAR_WIDTH)) then
      for teamID,defs in pairs(teamRes) do
        if (y < defs.ey1) and (y >= defs.ey2) then
		   -- IsReplay does not need to be called everytime a mouse is clicked, it can be determined at initialization
		   -- there is no need to run a function every time to determine the spectating state
		   -- but because it is a variable it has to be monitored because a player can become a spectator later in the game
		   -- and because it is needed for setupteam, it needs to be maintained all the time, for that a state update is done in UnitCreated
		  if Ispec or replay then
            SendCommands('specteam '..teamID)
          else
            transferTeam = teamID
            transferType = "energy"
            transferring = true
          end
          return true
        elseif (y < defs.my1) and (y >= defs.my2) then
		  if Ispec or replay then
            SendCommands('specteam '..teamID)
          else
          transferTeam = teamID
          transferType = "metal"
          transferring = true
		  end
          return true
        end
      end
    end
  end
  return false
end

function widget:MouseRelease(x, y, button)
  capture = nil
  moving  = nil
  transferring = false
  transferTeam = nil
  return capture
end

--[[function widget:ViewResize(vsx, vsy)
  x1 = x1 * viewSizeX / vsx
  y1 = y1 * viewSizeY / vsy
  viewSizeX = vsx
  viewSizeY = vsy
  updateBars()
  updateStatics()
end--]]

function widget:GetConfigData(data)
--	spec = GetSpectatingState()
	--Spring.Echo("Get")
--	xoffset = x1+BAR_OFFSET
--	x2 = xoffset+BAR_WIDTH
--	Spring.Echo("Get y1 Pre = "..y1)
--   if ChangedPosition then
	if initspec then
--	 if data~=nil and data.x and data.y then
--	  return {
--		 sx = x1,
--		 sy = y1,
--		 x = data.x,
--		 y = data.y,
--	  }
--	 else
	  return {
		 sx = x1,
		 sy = saveY, -- this variable is used to make sure we are saving the position of the plugin before the value has changed in updatebars loops
		 x = x,
		 y = y,
	  }
--	 end
	else
--	 if data~=nil and data.sx and data.sy then
--	  return {
--		 sx = data.sx,
--		 sy = data.sy,
--		 x = x1,
--		 y = y1,
--	  }
--	 else
	  return {
		 sx = sx,
		 sy = sy,
		 x = x1,
		 y = saveY,
--		 y = y1,
	  }
--	 end
	end
--   end
	--Spring.Echo("Get y1 Post = "..y1)
end

function widget:SetConfigData(data)
--	spec = GetSpectatingState()
	--Spring.Echo("Set")
--	Spring.Echo(data.sx.." "..data.sy.." "..data.x.." "..data.y)
--	local viewX, viewY = gl.GetViewSizes() -- why run this again ? it is run at start
--  if 1600 <= viewX then
--   Spring.Echo("x1 = "..x1)
--   x1 = ((viewX / 1000) * 267) - w
--	Spring.Echo("x1 = "..x1)
--   y1 = viewY - h
-- this is the nice place for high resolution players
--  else
--  x1 = ((viewSizeX / 100000) * 92000) + x1
--   x1 = viewSizeX + x1 - 100
--   x1 = viewX - w - 100
--  y1 = ((viewSizeY / 100000) * 99900) + y1 - 30
--   y1 = ((viewY / 1000) * 999) + (- h - ((viewY / 100) * 3))
--  Spring.Echo("y1 = "..y1)
--  end
	
	
	
	--  if 1600 <= viewX then
--   Spring.Echo("x1 = "..x1)
--   x1 = ((viewX / 1000) * 267) - w
--	Spring.Echo("Set x1 = "..x1)
   --   y1 = viewY + y1
-- this is the nice place for high resolution players
--  else
--  x1 = ((viewSizeX / 100000) * 92000) + x1
--   x1 = viewX + x1 - 100
--  y1 = ((viewSizeY / 100000) * 99900) + y1 - 30
--   y1 = ((viewY / 1000) * 999) + ((viewY - h) - ((viewY / 100) * 3))
--  end
--	Spring.Echo("Set y1 = "..y1)
	if initspec then
	 if data.sx and data.sy then
	  x1 = data.sx
	  y1 = data.sy
	 elseif data.x and data.y then
	  x1 = data.x
	  y1 = data.y
--	 else
--	  x1 = mathMin( x1, viewSizeX - w )
--	  y1, saveY = mathMin( y1, viewSizeY - h )
	 end
	 
--	 x1 = data.sx or data.x or mathMin( x1, viewSizeX - w )
--	 y1, saveY = data.sy or data.y or mathMin( y1, viewSizeY - h )
--	 x1 = data.sx or data.x or x1
--	 y1 = data.sy or data.y or y1
	 if data.x then
	  x = data.x
	 end 
	 if data.y then
	  y = data.y
	 end
	else
	 if data.x and data.y then
	  x1 = data.x
	  y1 = data.y
	 elseif data.sx and data.sy then
	  x1 = data.sx
	  y1 = data.sy
--	 else
--	  x1 = mathMin( x1, viewSizeX - w )
--	  y1, saveY = mathMin( y1, viewSizeY - h )
	 end
	 
--	 x1 = data.sx or data.x or mathMin( x1, viewSizeX - w )
--	 y1, saveY = data.sy or data.y or mathMin( y1, viewSizeY - h )
--	 x1 = data.sx or data.x or x1
--	 y1 = data.sy or data.y or y1
	 if data.sx then
	  sx = data.sx
	 end
	 if data.sy then
	  sy = data.sy
	 end
--	 x1 = data.x or data.sx or mathMin( x1, viewSizeX - w )
--	 y1, saveY = data.y or data.sy or mathMin( y1, viewSizeY - h )
--	 x1 = data.x or data.sx or x1
--	 y1 = data.y or data.sy or y1
--	 if data.sx and data.sy then
--	  sx = data.sx
--	  sy = data.sy
--	 end
	end
--	Spring.Echo("Set:"..viewX.." "..viewY)
--	if x1 ~= (viewX - w) then
--	x1 = mathMin( x1, viewX - w )
--	x1 = mathMin( x1, viewSizeX - w )
	if x1 > (viewSizeX - w) then x1 = viewSizeX - w
	elseif x1 < 1 then x1 = 0 end
--	saveX = x1
--	end
--	if y1 ~= (viewY - h) then
--	y1 = mathMin( y1, viewY - h )
--	y1 = mathMin( y1, viewSizeY )
	if y1 > (viewSizeY - h) then y1 = viewSizeY - h
	elseif y1 < 1 then y1 = 0 end
--	y1 = math.max( y1, viewSizeY - h )
	saveY = saveY or y1
--	end
--	xoffset = x1+BAR_OFFSET
--	x2 = xoffset+BAR_WIDTH
	--Spring.Echo("Set y1 = "..y1)
end

-- this is the function that causes updateBars to execute before setupteam, it appears to be redundant
--[[function widget:ViewResize(vsx, vsy)
  x1 = math.floor(x1 - viewSizeX)
  y1 = math.floor(y1 - viewSizeY)
  viewSizeX, viewSizeY = vsx, vsy
  x1 = viewSizeX + x1
  y1 = viewSizeY + y1
  Spring.Echo("ViewResize")
  
  updateBars()
  updateStatics()
end--]]

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------