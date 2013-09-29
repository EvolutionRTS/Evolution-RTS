
function widget:GetInfo()
  return {
    name      = "Auto Skirm",
    desc      = "Automatically keeps units at max range",
    author    = "Google Frog",
    date      = "Dec 23, 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

local team = Spring.GetMyTeamID()
local skirm = {}

----SPEEDUPS

local spGiveOrderToUnit = Spring.GiveOrderToUnit
local spGetUnitPosition = Spring.GetUnitPosition
local spGetUnitNearestEnemy = Spring.GetUnitNearestEnemy
local spGetUnitDefID = Spring.GetUnitDefID
local spGetCommandQueue = Spring.GetCommandQueue
local spGetUnitSeparation = Spring.GetUnitSeparation

--------------------------
----CONFIG
--------------------------

local orderDis = 500

local unitArray = { 

	"eartytank",
	"eheavytank3",
	"elighttank3",
	"emediumtank3",
	"emissiletank",
	"eallterrheavy",
	"eallterrlight",
	"eallterrmed",
	"eamphibarty",
	"eamphibrock",

}


--------------------------
----SKIRMISHER CONTROL
--------------------------

function widget:GameFrame(n)
 
  if (n%30<1) then 
	checkSkirms()
  end
  
end

function checkSkirms()
  for unit, v in pairs(skirm) do
  
    if checkIdle(unit,v) then
	
	  local enemy = spGetUnitNearestEnemy(unit,v.range)
	  
	  if (enemy) then
	    local ed = spGetUnitDefID(enemy)
	    local er = UnitDefs[ed].maxWeaponRange
	    if (er) and (er < v.range) and (er ~= 0) then
	      local ex,ez,ez = spGetUnitPosition(enemy)
	      local ux,uy,uz = spGetUnitPosition(unit)
		  local pointDis = spGetUnitSeparation(unit,enemy)
		  local dis = orderDis 
		  local f = dis/pointDis
		  if (pointDis+dis > v.range) then
		    f = (v.range-pointDis)/pointDis
		  end
	      local cx = ux+(ux-ex)*f
		  local cy = uy
	      local cz = uz+(uz-ez)*f
	      spGiveOrderToUnit(unit,CMD.MOVE,{cx,cy,cz},CMD.OPT_RIGHT)
		  v.cx,v.cy,v.cz = cx,cy,cz
		end
	  end
	  
	end
	
  end
end

function checkIdle(unit,v)

  local cQueue = spGetCommandQueue(unit)

  if (#cQueue == 0) then
    return true
  elseif (#cQueue == 1) then
  
    local cx,cy,cz = cQueue[1].params[1],cQueue[1].params[2],cQueue[1].params[3]
	if (cx == v.cx) and (cy == v.cy) and (cz == v.cz) then
	  return true
	end
	
  end

  return false
  
end

--------------------------
----UNIT DETECTION
--------------------------

local unitSet = {}

function widget:Initialize() 
  for i, v in pairs(unitArray) do
    unitSet[v] = true
  end
end

local function IsSkirm(ud)
  
  for i, v in pairs(unitSet) do
    if (unitSet[ud.name]) then
	  return true
	end
  end
  
  return false
  
end

function widget:UnitCreated(unitID, unitDefID, unitTeam)
  if (unitTeam == team) then
	
	local ud = UnitDefs[unitDefID]
  
    if ( (ud ~= nil) and IsSkirm(ud) ) then
    
	  skirm[unitID] = {range = ud.maxWeaponRange-35, cx = 0, cy = 0, cz = 0}
	
    end
  elseif (skirm[unitID]) then
    skirm[unitID] = nil
  end
end

function widget:UnitGiven(unitID, unitDefID, unitTeam)
  widget:UnitCreated(unitID, unitDefID, unitTeam)
end

function widget:UnitDestroyed(unitID, unitDefID, unitTeam)
  if (skirm[unitID]) then
    skirm[unitID] = nil
  end
end


