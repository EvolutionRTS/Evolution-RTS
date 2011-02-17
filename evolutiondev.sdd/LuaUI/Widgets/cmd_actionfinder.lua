include("colors.h.lua")
include("keysym.h.lua")
include("utils.lua")

function widget:GetInfo()
  return {
    name      = "Action Finder",
    desc      = "Focuses the camera to the places of the map with a lot of action.",
    author    = "xyz",
    date      = "May 26, 2009",
    license   = "GNU GPL, v2 or later",
    version   = "1.5",
    layer     = 0,
    enabled   = false,  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local TRANSITION_DURATION     			= 2

local CAMERA_IDLE_RESPONSE     			= 10
local CAMERA_FIGHT_RESPONSE 			= 5
local FORCE_ECONOMY_VIEW				= 10      -- show some economy stuff after this many events
local USER_IDLE_RESUME         			= 10

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local lastMove = 0
local lastUserMove = 0
local eventsCount = 0

local fracScale = 50
local healthScale = 0 -- 0.001

local paraFracScale = fracScale * 0.25
local paraHealthScale = healthScale * 0

-- Automatically generated local definitions
local spGetFrameTimeOffset   = Spring.GetFrameTimeOffset
local spGetGameSeconds       = Spring.GetGameSeconds
local spGetUnitPosition      = Spring.GetUnitPosition
local spGetUnitViewPosition  = Spring.GetUnitViewPosition
local spIsUnitAllied         = Spring.IsUnitAllied

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local inSpecMode = false
local inAttractMode = false
local wasSpecMode = false

local eventScale = 0.02

local lastMouseX = 0
local lastMouseY = 0

local WantedX,WantedZ,WantedID

local DEATH_EVENT            = 0
local TAKE_EVENT             = 1
local CREATE_EVENT           = 2
local CREATE_START_EVENT     = 3
local STOCKPILE_EVENTS       = 4
local DAMAGE_EVENTS          = 5
local PARALYZE_EVENT         = 6

local limit = 0.1

--------------------------------------------------------------------------------

local gameSecs = 0

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local eventMap  = {}

local damageMap = {}

local SavedInitialCameraState = nil

local ChangeModCounter = 1

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function clearTrackingMode()
  if WantedID and Spring.ValidUnitID(WantedID) then
    Spring.SelectUnitArray({WantedID})
    Spring.SendCommands("trackoff")
    Spring.SelectUnitArray({})
	WantedID = nil
  end
  
  Spring.SendCommands("trackoff")
end

--------------------------------------------------------------------------------

local function enableTrackingMode(id)
  clearTrackingMode()
  
  WantedID = id
  
  Spring.SelectUnitArray({id})
  Spring.SendCommands("track")
  Spring.SelectUnitArray({})
end

--------------------------------------------------------------------------------

local function PickCameraMode(x,z,id)
  lastMove = gameSecs
  WantedX=x
  WantedZ=z
  
  clearTrackingMode()
  
  ChangeModCounter=math.random(0,4)
  Spring.SelectUnitArray({})
  local RandomMode=math.random(1,3)
  -- Total war, close to ground
  if RandomMode==1 then
    Spring.SetCameraState({name=tw,mode=2,rz=0,rx=math.random(-100,0)/100,ry=math.random(-50,50)/10,px=x,py=0,pz=z},TRANSITION_DURATION)
  -- FPS, tracking
  elseif RandomMode==2 and id and Spring.ValidUnitID(id) and not Spring.GetUnitIsDead(id) then
    local vx,vy,vz=Spring.GetUnitVelocity(id)
    if vx and vy and vz and vx^2+vy^2+vz^2>0.1^2 then
      Spring.SetCameraState({name=fps,mode=0,px=x,py=Spring.GetGroundHeight(x,z)+20,pz=z,rz=0,dx=0,dy=-1,ry=9,rx=-1,dz=-0.5,oldHeight=999},0)
	  
      enableTrackingMode(id)
	  
      WantedX=nil
      WantedZ=nil
      WantedID=id
    end
  -- TA Overview
  else
    Spring.SetCameraState({name=ta,mode=1,px=x,py=0,pz=z,flipped=-1,dy=-0.9,zscale=0.5,height=999,dx=0,dz=-0.45},TRANSITION_DURATION)
  end
end

--------------------------------------------------------------------------------

function EnterSpecMode()
  Spring.Echo("Start spec mode / action finder")
  
  Spring.SetCameraTarget(Game.mapSizeX/2, 0,Game.mapSizeZ/2, TRANSITION_DURATION)
  inSpecMode = true
end

--------------------------------------------------------------------------------

function EnterAttractMode()
  if not inSpecMode then
    EnterSpecMode()
  else
    wasSpecMode = true
  end
 
  Spring.Echo("Attract mode camera style ON")
  
  inAttractMode = true
  
  SavedInitialCameraState = Spring.GetCameraState()
  PickCameraMode(Game.mapSizeX/2,Game.mapSizeZ/2)
end

--------------------------------------------------------------------------------

function LeaveSpecMode()
  Spring.Echo("End spec mode / action finder")
  inSpecMode = false
  
  if inAttractMode then
    LeaveAttractMode()
  end
end

--------------------------------------------------------------------------------

function LeaveAttractMode()
  Spring.Echo("Attract mode camera style OFF")
  
  inAttractMode = false
  
  if SavedInitialCameraState then
    Spring.SetCameraState(SavedInitialCameraState,TRANSITION_DURATION)
    SavedInitialCameraState=nil
  end
  
  if not wasSpecMode then
    LeaveSpecMode()
	wasSpecMode = false
  end
end

--------------------------------------------------------------------------------

local function UserAction()
  lastUserMove = gameSecs
  
  WantedX=nil
  WantedZ=nil
  
  clearTrackingMode()
end

--------------------------------------------------------------------------------

local function GetGameSecs()
  return spGetGameSeconds() + spGetFrameTimeOffset()
end

--------------------------------------------------------------------------------

local function UpdateCamera(pozX, pozZ, Uid)
    lastMove = gameSecs
	
	if inAttractMode then
	    if (ChangeModCounter > 0) then
	      ChangeModCounter=ChangeModCounter-1
	      if WantedID and Spring.ValidUnitID(WantedID) then
	        local x,_,z=Spring.GetUnitPosition(WantedID)
	        if WantedX and WantedZ and x==WantedX and z==WantedZ then
	          PickCameraMode(pozX,pozZ, Uid)
	        end
	      else
	        WantedX=pozX
	        WantedZ=pozZ
			
			clearTrackingMode()
			
	        Spring.SetCameraTarget(pozX, 0, pozZ, TRANSITION_DURATION)
	      end
	    else
	      PickCameraMode(pozX,pozZ,Uid)
	    end
	else
	  clearTrackingMode()
	  Spring.SetCameraTarget(pozX, 0, pozZ, TRANSITION_DURATION)
	end
end

--------------------------------------------------------------------------------

function widget:TextCommand(command)
--Specmode
  if (command == 'specmode' or command == 'specmode 1' or command == 'autocamera'  or command == 'autocamera 1' or command == 'actionfinder' or command == 'actionfinder 1')
        and not inSpecMode then
    EnterSpecMode()
    return false
  elseif (command == 'specmode' or command == 'specmode 0' or command == 'autocamera'  or command == 'autocamera 0' or command == 'actionfinder' or command == 'actionfinder 0')
        and inSpecMode then
    LeaveSpecMode()
  end
  
--AttractMode
  if (command == 'actionfinder' or command == 'actionfinder 1' or command == 'attractmode' or command == 'attractmode 1')
        and not inAttractMode then
    EnterAttractMode()
    return false
  elseif (command == 'actionfinder' or command == 'actionfinder 0' or command == 'attractmode' or command == 'attractmode 0')
        and inSpecMode then
    LeaveAttractMode()
  end
  
  local cmd = string.sub(command, 10)
  return true
end

--------------------------------------------------------------------------------

function widget:KeyPress(key, mods, isRepeat)

  if key == KEYSYMS.S and mods.alt and mods.ctrl and not (mods.meta or mods.shift) then
	if inSpecMode then
	  LeaveSpecMode()
	  return true
	else
	  EnterSpecMode()
	  return true
	end
  end
  
  if key == KEYSYMS.C and mods.alt and mods.ctrl and not (mods.meta or mods.shift) then
	if inAttractMode then
	  LeaveAttractMode()
	  return true
	else
	  EnterAttractMode()
	  return true
	end
  end
	  
  UserAction()
  return false
end

--------------------------------------------------------------------------------

function widget:Initialize()
  gameSecs = GetGameSecs()
  if Spring.GetSpectatingState() then
    EnterSpecMode()
  else
    LeaveSpecMode()
  end
end

--------------------------------------------------------------------------------

function widget:PlayerChanged(playerID)
--[[  if Spring.GetSpectatingState() then
    EnterSpecMode()
  else
    LeaveSpecMode()
  end
  ]]--
end

--------------------------------------------------------------------------------

function widget:Shutdown()
  if SavedInitialCameraState and inSpecMode then
    Spring.SetCameraState(SavedInitialCameraState,TRANSITION_DURATION)
  end
end

--------------------------------------------------------------------------------

function widget:MousePress(x, y, button)
  lastUserMove = gameSecs
end

--------------------------------------------------------------------------------

function widget:MouseMove(x, y, dx, dy, button)
  UserAction()
end

--------------------------------------------------------------------------------

function widget:MouseRelease(x, y, button)
  UserAction()
end

--------------------------------------------------------------------------------

function widget:MouseWheel(up, value)
  UserAction()
end

--------------------------------------------------------------------------------

local function DrawEvent(event)
  if gameSecs > lastMove + CAMERA_IDLE_RESPONSE then
    eventsCount = 0
    UpdateCamera(event.x, event.z)
  end
end

--------------------------------------------------------------------------------

local function DrawDamage(damage)
  local u=nil
  if Spring.ValidUnitID(damage.u) then
    u=damage.u
  elseif Spring.ValidUnitID(damage.a) then
    u=damage.a
  end
  if Spring.ValidUnitID(damage.u) and not Spring.GetUnitIsDead(damage.u) then
    local vx,vy,vz=Spring.GetUnitVelocity(damage.u)
    if vx and vy and vz and vx^2+vy^2+vz^2>0.1^2 then
      u=damage.u
    end
  end
  if Spring.ValidUnitID(damage.a) and not Spring.GetUnitIsDead(damage.a) then
    local vx,vy,vz=Spring.GetUnitVelocity(damage.a)
    if vx and vy and vz and vx^2+vy^2+vz^2>0.1^2 then
      u=damage.a
    end
  end
  if u==nil then
    return
  end

  local px, py, pz = spGetUnitViewPosition(u)
  if px == nil then
    px, py, pz = spGetUnitViewPosition(u)
    if px == nil then
      return
    end
  end

  if (gameSecs > lastMove + CAMERA_FIGHT_RESPONSE) and (eventsCount < FORCE_ECONOMY_VIEW) then
    eventsCount = eventsCount + 1;
    UpdateCamera(px, pz, u)
  end
end

--------------------------------------------------------------------------------

function MouseMoved()
  local x, y, lmb, mmb, rmb = Spring.GetMouseState()
  
  if x ~= lastMouseX then
    lastMouseX = x
    return true
  end
  
  if y ~= lastMouseY then
    lastMouseY = y
    return true
  end
  
  return false
end

--------------------------------------------------------------------------------

function widget:Update(dt)
  -- if specmode is not activated no need to update.
  if not inSpecMode then
    return
  end

  -- don't update evey frame
  local gs = GetGameSecs()
  if (gs == gameSecs) then
    return
  end

  gameSecs = gs

  -- if user wants to take manual controll pause the scipt for   USER_IDLE_RESUME seconds
  if MouseMoved() then
    UserAction()
    return
  end

  if gameSecs < lastUserMove + USER_IDLE_RESUME then
    return
  end

  local scale = (1 - (4 * dt))

  for unitID, d in pairs(eventMap) do
    local v = d.v
    v = v * scale
    if (v < limit) then
      eventMap[unitID] = nil
    else
      d.v = v
    end
  end

  for unitID, d in pairs(damageMap) do
      local v = d.v * scale
      local p = d.p * scale

      if (v > limit) then
        d.v = v
      else
        if (p > limit) then 
          d.v = 0
        else
          damageMap[unitID] = nil
        end
      end

      if (p > 1) then
        d.p = p
      else
        if (v > 1) then 
          d.p = 0
        else
          damageMap[unitID] = nil
        end
      end
  end
  
  if ((next(eventMap)  == nil) and
      (next(damageMap) == nil)) then
    return
  end

  -- draw damages before events
  for _,damage in pairs(damageMap) do
    DrawDamage(damage)
  end

  for _,event in pairs(eventMap) do
    DrawEvent(event)
  end
end

--------------------------------------------------------------------------------

local function AddEvent(unitID, unitDefID, color, cost)
  if (not spIsUnitAllied(unitID)) then
    return
  end
  local ud = UnitDefs[unitDefID]
  if ((ud == nil) or ud.isFeature) then
    return
  end
  local px, py, pz = spGetUnitPosition(unitID)
  if (px and pz) then
    eventMap[unitID] = {
      x = px,
      z = pz,
      v = cost or (ud.cost * eventScale),
      u = unitID,
      c = color,
--      t = GetGameSeconds()
    }
  end
end

--------------------------------------------------------------------------------

function IsTerrainViewable(x1,z1)
  local y1=Spring.GetGroundHeight(x1,z1)
  local xs,ys=Spring.WorldToScreenCoords(x1,y1,z1)
  local _,pos=Spring.TraceScreenRay(xs,ys,true,false)
  if pos then
    local x2,y2,z2=unpack(pos)
    --Spring.Echo("e="..((x2-x1)^2+(y2-y1)^2+(z2-z1)^2))
    if ((x2-x1)^2+(y2-y1)^2+(z2-z1)^2)<22500 then
      return true
    else
      return false
    end
  else
    return nil
  end
end

--------------------------------------------------------------------------------

function widget:DrawWorldPreUnit()
  if not inAttractMode then
	return
  end
  
  local gs = GetGameSecs()
  if (gs == gameSecs) then
    return
  end

  if WantedX and WantedZ and not WantedID then
    if (lastMove+TRANSITION_DURATION+0.2>gameSecs) then
      return
    elseif not IsTerrainViewable(WantedX,WantedZ) then
      Spring.Echo("View blocked, redoing it.")
      PickCameraMode(WantedX,WantedZ)
    end
  end
end

--------------------------------------------------------------------------------

function widget:UnitCreated(unitID, unitDefID, unitTeam)
  AddEvent(unitID, unitDefID, CREATE_START_EVENT)
end

--------------------------------------------------------------------------------

function widget:UnitFinished(unitID, unitDefID, unitTeam)
  AddEvent(unitID, unitDefID, CREATE_EVENT)
end

--------------------------------------------------------------------------------

function widget:UnitDestroyed(unitID, unitDefID, unitTeam)
  damageMap[unitID] = nil
  AddEvent(unitID, unitDefID, DEATH_EVENT)
  if WantedID and unitID==WantedID then
    clearTrackingMode()
    local x,_,z=Spring.GetUnitPosition(unitID)
    PickCameraMode(x,z)
  end
end

--------------------------------------------------------------------------------

function widget:UnitTaken(unitID, unitDefID)
  damageMap[unitID] = nil
  AddEvent(unitID, unitDefID, TAKE_EVENT)
end

--------------------------------------------------------------------------------

function widget:StockpileChanged(unitID, unitDefID, unitTeam,
                                 weaponNum, oldCount, newCount)
  if (newCount > oldCount) then
    AddEvent(unitID, unitDefID, STOCKPILE_EVENTS, 100)
  end
end

--------------------------------------------------------------------------------

function widget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponID, attackerID, attackerDefID)

  if (not spIsUnitAllied(unitID)) then
    return
  end
  if (damage <= 0) then
    return
  end

  local ud = UnitDefs[unitDefID]
  if (ud == nil) then
    return
  end

  -- clamp the damage
  damage = math.min(ud.health, damage)

  -- scale the damage value
  if (paralyzer) then
    damage = (paraHealthScale * damage) +
             (paraFracScale   * (damage / ud.health)) 
  else
    damage = (healthScale * damage) +
             (fracScale   * (damage / ud.health)) 
  end


  local d = damageMap[unitID]
  if (d ~= nil) then
    d.a = attackerID
    if (paralyzer) then
      d.p = d.p + damage
    else
      d.v = d.v + damage
    end
  else
    d = {}
    d.u = unitID
    d.a = attackerID
--    d.t = GetGameSeconds()
    if (paralyzer) then
      d.v = 0
      d.p = math.max(1, damage)
    else
      d.v = math.max(1, damage)
      d.p = 0
    end
    damageMap[unitID] = d
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
