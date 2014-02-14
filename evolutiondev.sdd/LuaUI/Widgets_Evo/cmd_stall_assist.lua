--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    cmd_stall_assist.lua
--  brief:   Automatically shares your spare energy when your allies e-stall
--  original author:  Owen Martindell
--
--  Copyright (C) 2007.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Stall Assist",
    desc      = "Automatically shares your spare energy when your allies e-stall",
    author    = "author: TheFatController",
    date      = "May 27, 2007",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true -- loaded by default?
  }
end

--------------------------------------------------------------------------------



--------------------------------------------------------------------------------

local UPDATE   = 1.10 -- Time per check in seconds (do not set this too low)
local EPERCENT = 0.75 -- Percent of energy to save for yourself
local STALLING = 0.12 -- Energy fraction required to be considered stalling
local MAKERUSE = 0.25 -- Maximum percent of allies energy expenditure allowed to be spent on metal makers

--------------------------------------------------------------------------------

local GetMyTeamID      = Spring.GetMyTeamID
local GetTeamList      = Spring.GetTeamList
local GetMyAllyTeamID  = Spring.GetMyAllyTeamID
local GetTeamResources = Spring.GetTeamResources
local GetUnitDefID     = Spring.GetUnitDefID
local GetTeamUnits     = Spring.GetTeamUnits
local GetUnitResources = Spring.GetUnitResources

--------------------------------------------------------------------------------

local nextCheck   = 0
local timeCounter = 0
local allyList    = {}

function widget:Initialize()
  local _, _, spec = Spring.GetPlayerInfo(Spring.GetMyPlayerID())
  if spec then
    Spring.SendCommands({"echo Stall Assist widget disabled for spectators"})
    widgetHandler:RemoveWidget()
    return false
  end
  
  nextCheck = UPDATE + ((math.random(0,40) / 100) - 0.2)
  allyList = GetTeamList(GetMyAllyTeamID())
end

local function isMetalMaker(inUnit)
  if ((inUnit.makesMetal > 0) and (inUnit.energyUpkeep > 0) and (inUnit.onOffable == true)) then
    return true
  else
    return false
  end
end

function widget:Update(deltaTime)

  if (timeCounter < nextCheck) then
    timeCounter = timeCounter + deltaTime
    
  else
   
    if (table.getn(allyList) > 1) then
        
      local myID = GetMyTeamID()  

      local eCur, eMax, _, _, _, _, _ = GetTeamResources(myID, "energy")
      
      local ePercent = (eCur / eMax)
      
      local freeEnergy = (eCur - (eMax * EPERCENT))
      
      if (freeEnergy > (eCur * 0.12)) then
      
        local lowest = ePercent
        local lowAlly = myID
      
        for _,allyID in ipairs(allyList) do
          if (allyID ~= myID) then
            local aCur, aMax, _, _, _, _, _ = GetTeamResources(allyID, "energy")
            local aPercent = (aCur / aMax)
            if (aPercent < lowest) then
              lowest = aPercent
              lowAlly = allyID
            end
          end
        end

        if (lowest < STALLING) then
          local makerDrain = 0
          local teamUnits = GetTeamUnits(lowAlly)
          for _,unitID in ipairs(teamUnits) do
            local unitDefID = GetUnitDefID(unitID)
            local unitDefList = UnitDefs[unitDefID]
            if isMetalMaker(unitDefList) then
               local _, _, _, eUse = GetUnitResources(unitID)
               makerDrain = makerDrain + eUse
            end
          end
          local _, _, _, _, eExp, _, _ = GetTeamResources(lowAlly, "energy")
          if (makerDrain < (eExp * MAKERUSE)) then
            Spring.ShareResources(lowAlly, "energy", freeEnergy)
            nextCheck = UPDATE + ((math.random(0,40) / 100) - 0.2)
          end
        elseif ((ePercent > 0.9) and (lowest < 0.6)) then
          local share = (eCur * (ePercent - 0.9))
          if (share > 0) then
            Spring.ShareResources(lowAlly, "energy", share)
          end
        end
        
      end 
    else
      Spring.SendCommands({"echo Stall Assist widget disabled for solo players"})
      widgetHandler:RemoveWidget()   
    end
    
    timeCounter = 0
    
  end
end