--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Attack AoE",
    desc      = "v2.6 Cursor indicator for area of effect and scatter when giving attack command.\n" ..
                "AoE: Red circles; transparency indicate proportion of maximum damage.\n" ..
                "Scatter (approximate): Yellow circle. Weapons subject to gravity have additional line indicating length of scatter.",
    author    = "Evil4Zerggin",
    date      = "14 September 2008",
    license   = "GNU GPL, v2 or later",
    layer     = 1, 
    enabled   = true  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--config
--------------------------------------------------------------------------------
local pulseSpeed    = 1
local lineWidthMult = 16
local divsMult      = 1000
local numCircles    = 9
local minAoE        = 16
local aoeColor      = {1, 0, 0}
local scatterColor  = {1, 1, 0}

--------------------------------------------------------------------------------
--vars
--------------------------------------------------------------------------------
local maxAlpha                  = 1
local hasSelectionChangedCallin = false
local aoe                       = 0
local ee                        = 0
local scatter                   = 0
local scatterLength             = 0
local scatterUnit               = nil

--------------------------------------------------------------------------------
--speedups
--------------------------------------------------------------------------------

local GetActiveCommand       = Spring.GetActiveCommand
local GetSelectedUnitsSorted = Spring.GetSelectedUnitsSorted
local TraceScreenRay         = Spring.TraceScreenRay
local GetMouseState          = Spring.GetMouseState 
local GetUnitPosition        = Spring.GetUnitPosition
local GetFeaturePosition     = Spring.GetFeaturePosition
local GetCameraPosition      = Spring.GetCameraPosition
local GetGroundHeight        = Spring.GetGroundHeight
local CMD_ATTACK             = CMD.ATTACK
local glDrawGroundCircle     = gl.DrawGroundCircle
local glColor                = gl.Color
local glLineWidth            = gl.LineWidth
local glBeginEnd             = gl.BeginEnd
local glDepthTest            = gl.DepthTest
local glTranslate            = gl.Translate
local glVertex               = gl.Vertex
local GL_LINE_STRIP          = GL.LINE_STRIP
local gravity                = Game.gravity

function GetMaxAoE(unitDef)
  if (not unitDef or not unitDef.weapons) then return 0, 0 end
  
  local maxAoEWeapon = nil
  local maxAoE = 0
  local maxEE = 0
  
  for _, weapon in ipairs(unitDef.weapons) do
    if (weapon.weaponDef) then
      local weaponDef = WeaponDefs[weapon.weaponDef]
      if (weaponDef and 
           ((weaponDef.areaOfEffect > maxAoE)
            or (weaponDef.areaOfEffect == maxAoE) and weaponDef.edgeEffectiveness > maxEE)) then
        maxAoE = weaponDef.areaOfEffect
        maxEE = weaponDef.edgeEffectiveness
      end
    end
  end
  return maxAoE, maxEE
end

function GetMaxScatter(unitDef)
  if (not unitDef or not unitDef.weapons) then return 0, 0 end
  
  local maxScatter = 0
  local maxScatterLength = 0
  
  for _, weapon in ipairs(unitDef.weapons) do
    if (weapon.weaponDef) then
      local weaponDef = WeaponDefs[weapon.weaponDef]
      local currScatter = 0
      local currScatterLength = 0
      local weaponType = weaponDef.type
      if (weaponDef and weaponDef.canAttackGround) then
        if (weaponType == "AircraftBomb") then
          currScatter = (weaponDef.accuracy + weaponDef.sprayAngle) * math.sqrt(2 * unitDef.wantedHeight / gravity) * unitDef.speed
          currScatterLength = (weaponDef.salvoSize - 1) * weaponDef.salvoDelay * unitDef.speed / 2
        elseif (weaponDef.cylinderTargetting > 100) then
          currScatter = 45055 * (math.asin(weaponDef.accuracy) + math.asin(weaponDef.sprayAngle)) / math.pi
        elseif (weaponType == "Cannon") then
          if (unitDef.highTrajectoryType > 0) then
            currScatter = (weaponDef.accuracy + weaponDef.sprayAngle) * weaponDef.maxVelocity * weaponDef.maxVelocity * 2 / gravity
            currScatterLength = currScatter
          else
            currScatter = (weaponDef.accuracy + weaponDef.sprayAngle) * weaponDef.range
            if (not unitDef.canFly) then
              local ballisticRange = weaponDef.maxVelocity * weaponDef.maxVelocity / gravity
              local temp = ballisticRange * ballisticRange - weaponDef.range * weaponDef.range
              if (temp > 0) then
                currScatterLength = 2 * (weaponDef.accuracy + weaponDef.sprayAngle) * math.sqrt(temp)
                currScatterLength = math.min(weaponDef.range, currScatterLength)
              end
            end
            currScatterLength = math.max(currScatter, currScatterLength)
          end
        elseif (weaponType == "MissileLauncher") then
          currScatter = (weaponDef.wobble - weaponDef.turnRate) * weaponDef.maxVelocity * 10 * (weaponDef.range / weaponDef.maxVelocity + 1)
        else
          currScatter = (weaponDef.accuracy + weaponDef.sprayAngle) * weaponDef.range
        end
      end
      
      if (currScatter > maxScatter) then maxScatter = currScatter end
      if (currScatterLength > maxScatterLength) then maxScatterLength = currScatterLength end
    end
  end
  return maxScatter, maxScatterLength
end

function UpdateSelection()
  local sel = GetSelectedUnitsSorted()
  
  aoe = 0
  ee = 0
  scatter = 0
  scatterLength = 0
  scatterUnit = nil
  
  for unitDefID, unitIDs in pairs(sel) do
    local unitDef = UnitDefs[unitDefID]
    
    local currAoE, currEE = GetMaxAoE(unitDef)
    
    if (currAoE > aoe or (currAoE == aoe and currEE > ee)) then
      aoe = currAoE
      ee = currEE
    end
    
    local currScatter, currScatterLength = GetMaxScatter(unitDef)
    
    if (currScatter > scatter) then
      scatter = currScatter
    end
    
    if (currScatterLength > scatterLength) then
      scatterLength = currScatterLength
      scatterUnit = unitIDs[1]
    end
    
  end
  
end

function widget:DrawWorld()
  local _, cmd, _ = GetActiveCommand()
  
  if (not hasSelectionChangedCallin) then
    UpdateSelection()
  end
  
  if (cmd ~= CMD_ATTACK) then return end
  
  --get the position
  local mx, my = GetMouseState()
  local mouseTargetType, mouseTarget = TraceScreenRay(mx, my)
  local x, y, z
  
  if (mouseTargetType == "ground") then
    x = mouseTarget[1]
    y = mouseTarget[2]
    z = mouseTarget[3]
  elseif (mouseTargetType == "unit") then
    x, y, z = GetUnitPosition(mouseTarget)
  elseif (mouseTargetType == "feature") then
    x, y, z = GetFeaturePosition(mouseTarget)
  else
    return 
  end
  
  if (not x) then return end
  
  local _, cy, _ = GetCameraPosition()
  local ch = cy - y
  
  --aoe
  if (aoe >= minAoE) then
    for i = 1,numCircles do
      local proportion = i / (numCircles + 1)
      local radius = aoe * proportion
      local divs = math.max(math.ceil(divsMult * radius / ch), 3)
      local alpha = maxAlpha * (1 - proportion) / (1 - proportion * ee)
      glColor(aoeColor[1], aoeColor[2], aoeColor[3], alpha)
      glLineWidth(lineWidthMult * aoe / ch)
      glDrawGroundCircle(x, y, z, radius, divs)
    end
  end
  
  glColor(scatterColor[1], scatterColor[2], scatterColor[3], maxAlpha)
  
  --inaccuracy
  if (scatter > 0) then
    local divs = math.max(divsMult * scatter / ch, 3)
    
    glLineWidth(lineWidthMult * scatter / ch)
    glDrawGroundCircle(x, y, z, scatter, divs)
  end
  
  if (scatterLength > 0 and scatterUnit) then
    local sx, _, sz = GetUnitPosition(scatterUnit)
    if (sx and sz) then
      local ax = x - sx
      local az = z - sz
      local magnitude = math.sqrt(ax*ax + az*az)
      local drawLength = math.min(magnitude, scatterLength)
      local divs = math.max(math.ceil(lineWidthMult * drawLength / ch), 1)
      local divLength = drawLength / divs
      ax = ax * divLength / magnitude
      az = az * divLength / magnitude
      
      glTranslate(0, 0, 0)
      glDepthTest(false)
      glLineWidth(lineWidthMult * drawLength / ch)
      
      glBeginEnd(GL_LINE_STRIP, function()
          
          for i = -divs, divs do
            local vx = i * ax + x
            local vz = i * az + z
            local vy = math.max(GetGroundHeight(vx, vz), 0)
            
            glVertex(vx, vy, vz)
          end
          
        end
      )
      
      glDepthTest(true)
    end
    
  end
end

function widget:SelectionChanged(sel)
  hasSelectionChangedCallin = true
  UpdateSelection()
end

function widget:Update(dt)
  maxAlpha = maxAlpha - dt * pulseSpeed
  maxAlpha = maxAlpha - math.floor(maxAlpha)
end
