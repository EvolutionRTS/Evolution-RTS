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
    name      = "Ally Resource Bars 1.83 Alpha 2",
    desc      = "Shows your allies resources, thresholds, capacities and allows resource transfer",
    author    = "TheFatController & AF & BD",
    date      = "Feb 22, 2009",
    license   = "MIT/x11",
    layer     = -9,
    enabled   = false  --  loaded by default?
  }
end

-- mono's changes since 1.6:
-- 1.83 Alpha 2: fixed cpu hogging during window movement due to creating additional windows without fully deleting the old ones
-- 1.83: a Chili window as background when Chili is detected
-- 1.82: fixed the Chili options save/load conflicting with set/get configdata, added a size option to Chili menu (exclusive to Chili for now)
-- 1.81: initial Chili support
-- 1.80 alpha 3: fixed the incorrect placement of names bug with jK's help
-- 1.80 alpha 2: fixed a nasty luaUI-crashing bug with saveY, added metal/energy request from players on right click, re-added TOOL_TIPS player name drawing when player names are not drawn
-- 1.80: added options menu, hopefully fixed the player mode mis-positioned name drawing
-- Alpha 2: cleanup, added option to control the drawing of the list of teams (DRAW_TEAMS), updated default location
-- 1.72 Alpha 1: added team separators, added players list from other teams without bars for both spectator and player modes
-- 1.71: players list is drawn at all times
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
------------------------------ Function Speedups -------------------------------

local GetPlayerList = Spring.GetPlayerList
local GetPlayerInfo = Spring.GetPlayerInfo
local GetTeamResources = Spring.GetTeamResources
local GetMyTeamID = Spring.GetMyTeamID
local GetMouseState = Spring.GetMouseState
local GetSpectatingState = Spring.GetSpectatingState
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
local GetTextWidth        = fontHandler.GetTextWidth
local UseFont             = fontHandler.UseFont
local TextDraw            = fontHandler.Draw
local TextDrawCentered    = fontHandler.DrawCentered
local TextDrawRight       = fontHandler.DrawRight

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local displayList
local staticList
local optionsList = nil -- the options menu
--local optionsList = glCreateList( function() end)
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
local x1				= 0
local y1				= 0
local saveY				= 0
local xoffset			= 0
local x2				= 0
local capstart			= 0
local capend			= 0
local size				= 1
local viewSizeX, viewSizeY = gl.GetViewSizes()
local replay = Spring.IsReplay()
local initspec = GetSpectatingState()
if replay then initspec = true end
if initspec then
 x1 = viewSizeX - w
 y1, saveY = ((viewSizeY / 1000) * 999) + (- h - ((viewSizeY / 100) * 20))
else
 if 1750 <= viewSizeX then
 x1 = ((viewSizeX / 1000) * 267) - w
 y1, saveY = viewSizeY - h
-- this is the nice place for high resolution players
 else
 x1 = viewSizeX - w - 100
 y1, saveY = ((viewSizeY / 1000) * 999) + (- h - ((viewSizeY / 100) * 3))
 end
end

local mx, my = 0,0
local sentSomething = false
local enabled       = false
local transferring  = false
local transferTeam
local transferType
local teamList   = {}
local teamListA   = {}
local teamColors = {}
local teamIcons  = {}
local deadTeams  = {}
local sendEnergy = {}
local sendMetal  = {}
local trnsEnergy = {}
local trnsMetal  = {}
local labelText  = {}
local labelTextname  = {}
local separators = {}
local sentEnergy = 0
local sentMetal  = 0

--------------------------------------------------------------------------------
local THRESH_SIZE = 3	-- size (width) of the threshold indicators
local teamResES = {}
local teamResMS = {}
local teamResSE = {}
local teamResSM = {}
local eShare = {}
local mShare = {}
local eMax = {}
local mMax = {}
local drawAll = false		-- draw share threshold when player is not sharing ?
local DRAW_TEAMS = true
local draw_player_names = true
local capcolors = true
local TOOL_TIPS = true

--local windows = {}
--local Window
--local ScrollPanel
--local Chili
--local lab
--local tx = "Many of your fathers and brothers have perished valiantly in the face of a contemptible enemy. We must never forget what the Federation has done to our people! My brother, Garma Zabi, has shown us these virtues through our own valiant sacrifice. By focusing our anger and sorrow, we are finally in a position where victory is within our grasp, and once again, our most cherished nation will flourish. Victory is the greatest tribute we can pay those who sacrifice their lives for us! Rise, our people, Rise! Take your sorrow and turn it into anger! Zeon thirsts for the strength of its people! SIEG ZEON!!! SIEG ZEON!!! SIEG ZEON!!"
--local btn
--local scrollpanel1
--local redlabel
--local bluelabel
--local scrolllabel
--local drawAll = options.drawAll.value
--local DRAW_TEAMS = options.DRAW_TEAMS.value
--local draw_player_names = options.draw_player_names.value
--local capcolors = options.capcolors.value
--local TOOL_TIPS = options.TOOL_TIPS.value
--------------------------------------------------------------------------------

options = {
  drawAll = {
    name   = 'forced thresh',
    desc   = 'draw share thresholds even when the player is not sharing',
    type   = 'bool',
    value  = false
  },
    capcolors = {
    name   = 'capacity rects',
    desc   = 'reclangles to indicate storage capacity',
    type   = 'bool',
    value  = true
  },
    DRAW_TEAMS = {
    name   = 'player teams',
    desc   = 'draw players from other teams',
    type   = 'bool',
    value  = true
  },
    draw_player_names = {
    name   = 'player names',
    desc   = 'draw player names next to resource bars',
    type   = 'bool',
    value  = true
  },
	TOOL_TIPS = {
    name   = 'Tool Tips',
--    desc   = 'If there are multiple builders of the same type, only one icon will be shown.',
    type   = 'bool',
    value  = true
  },
    size = {
    name   = 'Size',
    desc   = 'Scaling factor of the widget',
    type   = 'number',
    value  = 1,
    min    = 0.4,
    max    = 2.0,
    step   = 0.1
  }
  
}

options_path = 'Settings/Interface/Ally Resource Bars 1.83 Alpha 2'

function options.size:OnChange()
  options.size.value = self.value
  --size = self.value
  BAR_HEIGHT		= 6 * self.value
  BAR_SPACER		= 3 * self.value
  BAR_WIDTH			= 120 * self.value
  BAR_GAP			= 7 * self.value
  TOTAL_BAR_HEIGHT	= (BAR_SPACER + BAR_HEIGHT + BAR_HEIGHT)
  TOP_HEIGHT		= (BAR_GAP + BAR_GAP)
  BAR_OFFSET		= (TOP_HEIGHT + BAR_SPACER)
  START_HEIGHT		= (TOTAL_BAR_HEIGHT + BAR_GAP + TOP_HEIGHT)
  FULL_BAR			= (BAR_WIDTH + BAR_GAP + BAR_GAP + BAR_SPACER)
  w					= (BAR_WIDTH + BAR_OFFSET + BAR_GAP)
  h					= START_HEIGHT
  xoffset			= (x1+BAR_OFFSET)
  x2				= (xoffset+BAR_WIDTH)
  capstart			= x2+1
  capend			= x2 + (BAR_GAP - 1)
  THRESH_SIZE		= 3 * self.value
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
  if started and enabled then
  updateStatics()
  updateBars()
  end
end

function options.drawAll:OnChange()
  options.drawAll.value = self.value
  drawAll = self.value
end

function options.capcolors:OnChange()
  options.capcolors.value = self.value
  capcolors = self.value
end

function options.DRAW_TEAMS:OnChange()
  options.DRAW_TEAMS.value = self.value
  DRAW_TEAMS = self.value
end

function options.draw_player_names:OnChange()
  options.draw_player_names.value = self.value
  draw_player_names = self.value
end

function options.TOOL_TIPS:OnChange()
  options.TOOL_TIPS.value = self.value
  TOOL_TIPS = self.value
end

local function getTeamNames()
  local teamNames = {}
  local playerList = GetPlayerList()
  for _,playerID in ipairs(playerList) do
    local name,_,spec,teamID = GetPlayerInfo(playerID)
    if not spec then
      if name and teamID then
        --Spring.Echo(name)
		teamNames[teamID] = name
      end
    end
  end
  return teamNames
end

function widget:Shutdown()
  glDeleteList(displayList)
  for i=1,#windows do
	(windows[i]):Dispose()
  end
end

local function setUpTeam()
  teamList = {}
  teamListA = {}
  teamRes = {}
  teamColors = {}
  local getTeams = nil
  local teamCount = 0
  Ispec = GetSpectatingState()
  if Ispec then
   teamListA = nil
   local alist = GetAllyTeamList()
   for _,allyID in pairs(alist) do
     getTeams = GetTeamList(allyID)
	 if getTeams ~= nil then
		local removedead = 0
       for _,teamID in ipairs(getTeams) do --ipairs appears to return the teams better sorted than pairs
		  _,p,dead = GetTeamInfo(teamID)
		  if (not deadTeams[teamID]) and (p ~= -1) and (not dead) then --and (used ~= 0) and (produced ~= 0) and (excessed ~= 0) and (received ~=0) and (sent ~=0) then --and (teamID ~= 16) then
			teamCount = (teamCount + 1)
			teamList[teamCount] = teamID
		  else
		  removedead = removedead + 1
          end
        end
		local temp = _-1
		 separators[_] = (separators[temp] or 0) + (#getTeams - removedead)
	end

   end
  else
   myID = GetMyTeamID() -- this is only needed here and in transfer resources, but in spectator mode resources cannot be transfered
   getTeams = GetTeamList(GetMyAllyTeamID())
   local removedead = 0
   for _,teamID in ipairs(getTeams) do
      local eCur = GetTeamResources(teamID, "energy")
	  if eCur and (not deadTeams[teamID]) and (teamID ~= myID) then --and (not dead) then
		teamCount = (teamCount + 1)
		teamList[teamCount] = teamID
      	else
		  removedead = removedead + 1
	  end
	end
	separators[1] = #getTeams - removedead
	local alist = GetAllyTeamList()
   local teamCountA = 0
   for _,allyID in pairs(alist) do
     if allyID ~= GetMyAllyTeamID() then getTeams = GetTeamList(allyID) end
	 local removedead = 0
	 if getTeams ~= nil then
       for _,teamID in ipairs(getTeams) do --ipairs appears to return the teams better sorted than pairs
		  _,p,dead = GetTeamInfo(teamID)
		  if (not deadTeams[teamID]) and (p ~= -1) and (not dead) and (teamID ~= myID) then --and (used ~= 0) and (produced ~= 0) and (excessed ~= 0) and (received ~=0) and (sent ~=0) then --and (teamID ~= 16) then
			teamCountA = (teamCountA + 1)
			teamListA[teamCountA] = teamID
		  else
		  removedead = removedead + 1
          end
        end
		  local temp = _-1
		  separators[_] = (separators[temp] or 0) + (#getTeams - removedead)
	end
   end
  end

  for teamIndex,teamID in pairs(teamList) do
    local r,g,b = GetTeamColor(teamID)
    teamColors[teamID] = {r=r,g=g,b=b}
  end
  if teamListA ~= nil then
   for teamIndex,teamID in pairs(teamListA) do
    local r,g,b = GetTeamColor(teamID)
    teamColors[teamID] = {r=r,g=g,b=b}
   end
  end

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

local function updateStatics()
  if (staticList) then glDeleteList(staticList) end
  staticList = glCreateList( function()
    glBlending(true)

	if (WG.Chili) then
	 --for i=1,#windows do -- delete existing window
	 -- (windows[i]):Dispose()
     --end
	 --windows = {} -- delete existing windows part 2
	 if window0 ~= nil then window0:Dispose() end

	 --local Chili = WG.Chili
	 --local Window = Chili.Window
	 --local screen0 = WG.Chili.Screen0
	 --window0 = {}
	 window0 = WG.Chili.Window:New{
		x = x1,
		y = viewSizeY - y1 - h,
		dockable = false,
		--parent = screen0,
		parent = WG.Chili.Screen0,
		draggable = false,
		resizable = false,
		dragUseGrip = false,
		clientWidth = w - 20,
		clientHeight = h - 25,
	    }
	 --windows[1] = window0
	else
	 glColor(0.2, 0.2, 0.2, 0.8)
     glRect(x1, y1, x1+w,y1+h)
	end
	
	local height = h - TOP_HEIGHT
    local teamNames = getTeamNames()
    teamIcons = {}
	for teamIndex,teamID in pairs(teamList) do
        glColor(teamColors[teamID].r,teamColors[teamID].g,teamColors[teamID].b,1)
        glRect(x1+BAR_GAP,y1+height,x1+TOP_HEIGHT,y1+height-TOTAL_BAR_HEIGHT)
		teamIcons[teamID] = 
        {
         name = teamNames[teamID] or "No Player",
         iy1 = y1+height,
         iy2 = y1+height-TOTAL_BAR_HEIGHT,
        }
		labelTextname[teamID] = 
        {
        label=teamIcons[teamID].name,
        x=x1-BAR_SPACER,
        --y=teamIcons[teamID].iy2+1,
        y=y1+height-TOTAL_BAR_HEIGHT,
		size=TOTAL_BAR_HEIGHT,
        config="orn",
        }
		height = (height - TOTAL_BAR_HEIGHT - BAR_GAP)
    end
	height = (height + TOTAL_BAR_HEIGHT + BAR_GAP) * #teamList
	if teamListA ~= nil then
	 for teamIndex,teamID in pairs(teamListA) do
	 teamIcons[teamID] = 
        {
         name = teamNames[teamID] or "No Player",
         iy1 = y1+height,
         iy2 = y1+height-TOTAL_BAR_HEIGHT,
        }
		labelTextname[teamID] = 
        {
        label=teamIcons[teamID].name,
        x=x1-BAR_SPACER,
        y=teamIcons[teamID].iy2+1,
        size=TOTAL_BAR_HEIGHT,
        config="orn",
        }
		height = (height - TOTAL_BAR_HEIGHT - BAR_GAP)
	 end
	end

  end)
end

local function updateBars()
    local eCur, mCur --, eShare, mShare
    local height = h - TOP_HEIGHT
  for teamIndex,teamID in pairs(teamList) do
	  eCur, eMax[teamID], _, _, _, eShare[teamID], _ = GetTeamResources(teamID, "energy")
      mCur, mMax[teamID], _, _, _, mShare[teamID], _ = GetTeamResources(teamID, "metal")

	  teamRes[teamID] =
      {
        ey1 = y1+height,
        ex2b = xoffset+(BAR_WIDTH * ((eCur + (sendEnergy[teamID] or 0)) / eMax[teamID])),
        ey2 = y1+height-BAR_HEIGHT,
        my1 = y1+height-BAR_HEIGHT-BAR_SPACER,
        mx2b = xoffset+(BAR_WIDTH * ((mCur + (sendMetal[teamID] or 0)) / mMax[teamID])),
        my2 = y1+height-TOTAL_BAR_HEIGHT,
	  }

      if (teamID == transferTeam) then
        if (transferType == "energy") then
          teamRes[teamID].eRec = true
        else
          teamRes[teamID].mRec = true
        end
      end
      height = (height - TOTAL_BAR_HEIGHT - BAR_GAP)
  end
  if (height ~= 0) then
    h = (h - height)
    y1 = (y1 + height)
    updateStatics()
  end
  if (displayList) then glDeleteList(displayList) end
  displayList = glCreateList( function()
    for _,d in pairs(teamRes) do
      glColor(1, 1, 0, 1)
	  if d.ex2b > x2 then d.ex2b = x2 end -- bug fix for bars drawing outside borders
	  glRect(xoffset,d.ey1,d.ex2b,d.ey2) -- draw the amount of the resource from the offset to the relative capacity position on screen
	  if d.eRec then
        glColor(0.8, 0, 0, 0.8)
	  else
		  glColor(0.8, 0.8, 0, 0.3)
      end
	  glRect(d.ex2b,d.ey1,x2,d.ey2) -- draw the rest of the unused relative capacity on screen from the current capacity (ex2b) to the end of the bar (x2)
	  if teamResSE[_] ~= nil then
	   if teamResSE[_] == 2 then
	   glColor(0, 0.8, 0, 1)
	   elseif teamResSE[_] == 3 then
	    glColor(0, 0, 0.8, 1)
	    elseif teamResSE[_] == 1 then
	     glColor(0.6, 0.2, 0, 1)
	   end
	   glRect(capstart,d.ey1,capend,d.ey2) -- draw the capacity indicator from the end of the bar (x2+1) to x size of plugin - 1
	  end
	  if teamResES[_] ~= nil then
		glColor(1, 0.2, 0, 0.8)
		glRect(teamResES[_].esx1,d.ey1,teamResES[_].esx2,d.ey2)
	  end
      glColor(1, 1, 1, 1)
	  if d.mx2b > x2 then d.mx2b = x2 end
	  glRect(xoffset,d.my1,d.mx2b,d.my2)
	  if d.mRec then
        glColor(0.8, 0, 0, 0.8)
	  else
        glColor(0.8, 0.8, 0.8, 0.3)
      end
	  glRect(d.mx2b,d.my1,x2,d.my2)
  	  if teamResSM[_] ~= nil then
	   if teamResSM[_] == 2 then
	   glColor(0, 0.8, 0, 1)
	   elseif teamResSM[_] == 3 then
	    glColor(0, 0, 0.8, 1)
	    elseif teamResSM[_] == 1 then
	     glColor(0.6, 0.2, 0, 1)
	   end
	   glRect(capstart,d.my1,capend,d.my2)
	  end
	  if teamResMS[_] ~= nil then
		glColor(1, 0.2, 0.2, 0.8)
		glRect(teamResMS[_].msx1,d.my1,teamResMS[_].msx2,d.my2)
	  end
	  end
  end)
end

function widget:Initialize()
  if saveY == nil then saveY = y1 end
  xoffset = x1+BAR_OFFSET
  x2 = xoffset+BAR_WIDTH
  capstart = x2+1
  capend = x2 + (BAR_GAP - 1)
	if setUpTeam() then
     updateStatics()
     updateBars()
    end
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
	if setUpTeam() then
      updateStatics()
      updateBars()
    end
  end
  if enabled then
  for teamIndex,teamID in ipairs(teamList) do -- makes it faster without keeping information about non-allied teams
   if capcolors then
	 if eMax[teamID] <= 100 then teamResSE[teamID] = nil
	 elseif (eMax[teamID] > 100) and (eMax[teamID] < 1000) then teamResSE[teamID] = 1
	 elseif (eMax[teamID] >= 1000) and (eMax[teamID] < 6000) then teamResSE[teamID] = 2
	 elseif eMax[teamID] >= 6000 then teamResSE[teamID] = 3 end
	 
	 if mMax[teamID] <= 100 then teamResSM[teamID] = nil
	 elseif (mMax[teamID] > 100) and (mMax[teamID] < 1000) then teamResSM[teamID] = 1
	 elseif (mMax[teamID] >= 1000) and (mMax[teamID] < 3000) then teamResSM[teamID] = 2
	 elseif mMax[teamID] >= 3000 then teamResSM[teamID] = 3 end
	else
	 teamResSE[teamID] = nil
	 teamResSM[teamID] = nil
   end
	if drawAll or ((not deadTeams[teamID]) and (eShare[teamID] < 0.94)) then
	 teamResES[teamID] = {esx1 = xoffset+(BAR_WIDTH * eShare[teamID]) - THRESH_SIZE / 2}
	 teamResES[teamID].esx2 = teamResES[teamID].esx1+THRESH_SIZE
    else teamResES[teamID] = nil end
    if drawAll or ((not deadTeams[teamID]) and (mShare[teamID] < 0.99)) then
	 teamResMS[teamID] = {msx1 = xoffset+(BAR_WIDTH * mShare[teamID]) - THRESH_SIZE / 2}
	 teamResMS[teamID].msx2 = teamResMS[teamID].msx1+THRESH_SIZE
    else teamResMS[teamID] = nil end
   end
  end
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
			  if (Ispec and (draw_player_names == false)) or ((not Ispec) and (draw_player_names == false) and (DRAW_TEAMS == false)) then
			  labelText[1] = 
              {
                label=defs.name,
                x=x1-BAR_SPACER,
                y=defs.iy2-1,
                size=TOTAL_BAR_HEIGHT,
                config="orn",
              }
			  end
              labelText[2] = 
              {
                label="(E: +"..sF("%.1f",eInc+eRec) ..", M: +"..sF("%.2f",mInc+mRec)..")", 
                x=x1-BAR_SPACER, 
                y=defs.iy2-TOTAL_BAR_HEIGHT, 
                size=TOTAL_BAR_HEIGHT/1.25, 
                config="orn",
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
			  labelText[5] = -- options
              {
                --label="(M: "..sF("%d",mAmount) .." / "..sF("%d",mCapacity)..")", 
				label="Options >", 
                --x=x1-BAR_SPACER,
				x=x1+w,
                --y=defs.iy2+11+BAR_SPACER-TOTAL_BAR_HEIGHT, 
				y=y1-10, 
                size=TOTAL_BAR_HEIGHT/1.25, 
                config="oln",
              }
              return
            end
          end
          if (labelText) then labelText = {} end
        elseif (labelText) then labelText = {} end
      end
    end
  elseif (#GetTeamList(GetMyAllyTeamID()) > 1) then
	setUpTeam()
    updateStatics()
    updateBars()
  end
	if not IsGUIHidden() then started = true end
end

function widget:GameStart()
  enabled = true
  setUpTeam()
  updateStatics()
end 

function widget:DrawScreen()
	if enabled and started then
    glPushMatrix()
      glCallList(staticList)
      glCallList(displayList)
	  --glCallList(optionsList)
	  if optionsList then glCallList(optionsList) end
	  if (labelText[1]) then
	   glColor(1, 1, 1, 0.8)
       glText(labelText[1].label,labelText[1].x,labelText[1].y,labelText[1].size,labelText[1].config)
	  end
	  if (labelText[2]) then
        glColor(0.8, 0.8, 0.8, 0.8)
		glText(labelText[2].label,labelText[2].x,labelText[2].y,labelText[2].size,labelText[2].config)
        glText(labelText[3].label,labelText[3].x,labelText[3].y,labelText[2].size,labelText[3].config)
        glText(labelText[4].label,labelText[3].x,labelText[4].y,labelText[2].size,labelText[3].config)
		end
		if (not WG.Chili) then glText("Options >",x1+w,y1+h-TOP_HEIGHT/1.3,TOTAL_BAR_HEIGHT/1.25,"orn") end -- options
		if draw_player_names == true then
		 for teamIndex,teamID in pairs(teamList) do
		  glColor(teamColors[teamID].r,teamColors[teamID].g,teamColors[teamID].b,1)
		  TextDrawRight(labelTextname[teamID].label,labelTextname[teamID].x,labelTextname[teamID].y)
		  if Ispec then 
		   for i=1,#separators-1 do -- search the list for last player of the team indexes that need to be separated and find out if the current is one of them
		    if (separators[i] == teamIndex) then
		     glColor(1, 1, 1, 0.8)
		     glRect(x1,labelTextname[teamID].y-5,labelTextname[teamID].x-100,labelTextname[teamID].y-4) -- draw the separator relative to that player's position
			end
		   end
		  end
		 end
		end

		if DRAW_TEAMS and (teamListA ~= nil) then
		-- this list is needed only in player mode to draw all the other teams and their separators
		 for teamIndex,teamID in pairs(teamListA) do
		  glColor(teamColors[teamID].r,teamColors[teamID].g,teamColors[teamID].b,1)
		  TextDrawRight(labelTextname[teamID].label,labelTextname[teamID].x,labelTextname[teamID].y)
		   for i=1,#separators-1 do
		    if (separators[i] == teamIndex) then
		     glColor(1, 1, 1, 0.8)
			 glRect(x1,labelTextname[teamID].y-5,labelTextname[teamID].x-100,labelTextname[teamID].y-4)
		    end
		   end
		  --end
		 end
		end
		
    glPopMatrix()
  end
end

local function options()
 --posX = x1
 --posY = y1
 glDeleteList(optionsList)
 optionsList = glCreateList( function()
  glColor(0.8, 0.8, 0.8, 0.8)
  glRect(x1, y1, x1+w,y1+1) -- separator

  glColor(0.2, 0.2, 0.2, 0.8)
  glRect(x1, y1, x1+w,y1-90) -- background
 
  glText("capacity rects : ",x1+5,y1-20,TOTAL_BAR_HEIGHT,"oln")
  if capcolors == true then
   state = "on"
  else
   state = "off"
  end
  glText(state,x1+w-5,y1-20,TOTAL_BAR_HEIGHT,"orn")
  
  glText("forced thresh : ",x1+5,y1-35,TOTAL_BAR_HEIGHT,"oln")
  if drawAll == true then
   state = "on"
  else
   state = "off"
  end
  glText(state,x1+w-5,y1-35,TOTAL_BAR_HEIGHT,"orn")
    
  glText("player names  : ",x1+5,y1-50,TOTAL_BAR_HEIGHT,"oln")
  if draw_player_names == true then
   state = "on"
  else
   state = "off"
  end
  glText(state,x1+w-5,y1-50,TOTAL_BAR_HEIGHT,"orn")
  
  glText("player teams  : ",x1+5,y1-65,TOTAL_BAR_HEIGHT,"oln")
  if DRAW_TEAMS == true then
   state = "on"
  else
   state = "off"
  end
  glText(state,x1+w-5,y1-65,TOTAL_BAR_HEIGHT,"orn")
 
  glText("tool tips  : ",x1+5,y1-80,TOTAL_BAR_HEIGHT,"oln")
  if TOOL_TIPS == true then
   state = "on"
  else
   state = "off"
  end
  glText(state,x1+w-5,y1-80,TOTAL_BAR_HEIGHT,"orn")
 end)
 options_menu_active = true
end

function widget:MouseMove(x, y, dx, dy, button)
  if (enabled) then
    if moving then
	  x1 = x1 + dx
	  y1 = y1 + dy
	  saveY = (saveY + dy) or y1
	  xoffset = (x1+BAR_OFFSET)
	  x2 = (xoffset+BAR_WIDTH)
	  capstart = x2+1
	  capend = x2 + (BAR_GAP - 1)
	  if options_menu_active == true then options() end
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
 if (not WG.Chili) then
  if (options_menu_active == true) and (enabled) and ((x > x1) and (y > y1-20) and (x < (x1 + w)) and (y <= (y1 - 5))) then
   capcolors = not capcolors
   options()
  end
  
  if (options_menu_active == true) and (enabled) and ((x > x1) and (y > y1-35) and (x < (x1 + w)) and (y <= (y1 - 20))) then
   drawAll = not drawAll
   options()
  end
  
  if (options_menu_active == true) and (enabled) and ((x > x1) and (y > y1-50) and (x < (x1 + w)) and (y <= (y1 - 35))) then
   draw_player_names = not draw_player_names
   options()
  end
  
  if (options_menu_active == true) and (enabled) and ((x > x1) and (y > y1-65) and (x < (x1 + w)) and (y <= (y1 - 50))) then
   DRAW_TEAMS = not DRAW_TEAMS
   options()
  end
  
  if (options_menu_active == true) and (enabled) and ((x > x1) and (y > y1-80) and (x < (x1 + w)) and (y <= (y1 - 65))) then
   TOOL_TIPS = not TOOL_TIPS
   options()
  end
  if (enabled) and ((x > x1 + w/1.65) and (y > (y1 + h - TOP_HEIGHT)) and (x < (x1 + w)) and (y < (y1 + h))) then
    if button == 1 then
	 if options_menu_active == true then
	  options_menu_active = false
	  glDeleteList(optionsList)
	  optionsList = nil
	  --optionsList = glCreateList( function() end)
	 else
	 options()
	 end
	end
  end
 end 
  if (enabled) and ((((x > x1) and (y > (y1 + h - TOP_HEIGHT)) and (x < (x1 + w/1.65)) and (y < (y1 + h) )) or ((x > x1) and (y > y1) and (x < (x1 + w)) and (y < (y1 + h - TOP_HEIGHT)))) or ((WG.Chili) and ((x > x1) and (y > (y1 + h - TOP_HEIGHT)) and (x < x1 + w) and (y < (y1 + h) )))) then
	if button == 1 and (y > (y1 + h - TOP_HEIGHT)) then
	  capture = true
      moving  = true
      return capture
    end
    if (x > (x1+BAR_OFFSET)) and (x < (x1+BAR_OFFSET+BAR_WIDTH)) then
      for teamID,defs in pairs(teamRes) do
        if (y < defs.ey1) and (y >= defs.ey2) then
		  if Ispec or replay then
            SendCommands('specteam '..teamID)
          elseif button == 1 then
            transferTeam = teamID
            transferType = "energy"
            transferring = true
          elseif button == 3 then
		   SendCommands{"say a: would you give me some energy "..teamIcons[teamID].name.." ?"}
		  end
		  return true
        elseif (y < defs.my1) and (y >= defs.my2) then
		  if Ispec or replay then
            SendCommands('specteam '..teamID)
          elseif button == 1 then
            transferTeam = teamID
            transferType = "metal"
            transferring = true
		  elseif button == 3 then
		   SendCommands{"say a: would you give me some metal "..teamIcons[teamID].name.." ?"}
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

function widget:GetConfigData(data)
   if (not WG.Chili) then
	if initspec then
	  return {
		 sx = x1,
		 sy = saveY, -- this variable is used to make sure we are saving the position of the plugin before the value has changed in updatebars loops
		 x = x,
		 y = y,
		 capcolors = capcolors,
		 drawAll = drawAll,
		 pnames = draw_player_names,
		 DRAW_TEAMS = DRAW_TEAMS,
		 TT = TOOL_TIPS,
	  }
	else
	  return {
		 sx = sx,
		 sy = sy,
		 x = x1,
		 y = saveY,
		 capcolors = capcolors,
		 drawAll = drawAll,
		 pnames = draw_player_names,
		 DRAW_TEAMS = DRAW_TEAMS,
		 TT = TOOL_TIPS,
	  }
	end
   else
   	if initspec then
	  return {
		 sx = x1,
		 sy = saveY, -- this variable is used to make sure we are saving the position of the plugin before the value has changed in updatebars loops
		 x = x,
		 y = y,
	  }
	else
	  return {
		 sx = sx,
		 sy = sy,
		 x = x1,
		 y = saveY,
	  }
	end
   
   end
end

function widget:SetConfigData(data)
	if initspec then
	 if data.sx and data.sy then
	  x1 = data.sx
	  y1 = data.sy
	 elseif data.x and data.y then
	  x1 = data.x
	  y1 = data.y
	 end
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
	 end
	 if data.sx then
	  sx = data.sx
	 end
	 if data.sy then
	  sy = data.sy
	 end
	end
	if x1 > (viewSizeX - w) then x1 = viewSizeX - w
	elseif x1 < 1 then x1 = 0 end
	if y1 > (viewSizeY - h) then y1 = viewSizeY - h
	elseif y1 < 1 then y1 = 0 end
	saveY = saveY or y1
   if (not WG.Chili) then
	if data.capcolors ~= nil then capcolors = data.capcolors else capcolors = true end
	if data.TT ~= nil then TOOL_TIPS = data.TT else TOOL_TIPS = true end
	if data.drawAll ~= nil then drawAll = data.drawAll else drawAll = false end
	if data.pnames ~= nil then draw_player_names = data.pnames else draw_player_names = true end
	if data.DRAW_TEAMS ~= nil then DRAW_TEAMS = data.DRAW_TEAMS else DRAW_TEAMS = true end
   end
end
