--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    weapondefs_post.lua
--  brief:   weaponDef post processing
--  author:  Dave Rodgers
--
--  Copyright (C) 2008.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  Per-unitDef weaponDefs
--

local function isbool(x)   return (type(x) == 'boolean') end
local function istable(x)  return (type(x) == 'table')   end
local function isnumber(x) return (type(x) == 'number')  end
local function isstring(x) return (type(x) == 'string')  end

local function tobool(val)
  local t = type(val)
  if (t == 'nil') then
    return false
  elseif (t == 'boolean') then
    return val
  elseif (t == 'number') then
    return (val ~= 0)
  elseif (t == 'string') then
    return ((val ~= '0') and (val ~= 'false'))
  end
  return false
end

--------------------------------------------------------------------------------

local function BackwardCompability(wdName,wd)
  -- weapon reloadTime and stockpileTime were seperated in 77b1
  if (tobool(wd.stockpile) and (wd.stockpiletime==nil)) then
    wd.stockpiletime = wd.reloadtime
    wd.reloadtime    = 2             -- 2 seconds
  end

  -- auto detect ota weapontypes
  if (wd.weapontype==nil) then
    local rendertype = tonumber(wd.rendertype) or 0
    if (tobool(wd.dropped)) then
      wd.weapontype = "AircraftBomb";
    elseif (tobool(wd.vlaunch)) then
      wd.weapontype = "StarburstLauncher";
    elseif (tobool(wd.beamlaser)) then
      wd.weapontype = "BeamLaser";
    elseif (tobool(wd.isshield)) then
      wd.weapontype = "Shield";
    elseif (tobool(wd.waterweapon)) then
      wd.weapontype = "TorpedoLauncher";
    elseif (wdName:lower():find("disintegrator",1,true)) then
      wd.weaponType = "DGun"
    elseif (tobool(wd.lineofsight)) then
      if (rendertype==7) then
        wd.weapontype = "LightningCannon";

      -- swta fix (outdated?)
      elseif (wd.model and wd.model:lower():find("laser",1,true)) then
        wd.weapontype = "LaserCannon";

      elseif (tobool(wd.beamweapon)) then
        wd.weapontype = "LaserCannon";
      elseif (tobool(wd.smoketrail)) then
        wd.weapontype = "MissileLauncher";
      elseif (rendertype==4 and tonumber(wd.color)==2) then
        wd.weapontype = "EmgCannon";
      elseif (rendertype==5) then
        wd.weapontype = "Flame";
      --elseif(rendertype==1) then
      --  wd.weapontype = "MissileLauncher";
      else
        wd.weapontype = "Cannon";
      end
    else
      wd.weapontype = "Cannon";
    end
  end

  weapondamage = tonumber(wd.damage.default)
  if (weapondamage > 0) then
		if (wd.customparams) then
		local damagetypelower = string.lower(wd.customparams.damagetype)

		if (damagetypelower == "nonexistent") then
				wd.damage.ARMORED = 		weapondamage*0.1
				wd.damage.LIGHT = 			weapondamage*0.1
				wd.damage.BUILDING  = 		weapondamage*0.1
				
-----------------------------------------------------------------------------				
				
			-- Start Hovers
			elseif (damagetypelower	== "eaatank") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*0.66
				wd.damage.BUILDING  = 		weapondamage*0.66
				
			elseif (damagetypelower	== "eartytank") then
				wd.damage.ARMORED = 		weapondamage*0.25
				wd.damage.LIGHT = 			weapondamage*0.25
				wd.damage.BUILDING  = 		weapondamage*1
				
			elseif (damagetypelower	== "ebomb") then
				wd.damage.ARMORED = 		weapondamage*0.25
				wd.damage.LIGHT = 			weapondamage*0.25
				wd.damage.BUILDING  = 		weapondamage*1
			
			elseif (damagetypelower	== "efatso") then
				wd.damage.ARMORED = 		weapondamage*0.125
				wd.damage.LIGHT = 			weapondamage*0.125
				wd.damage.BUILDING  = 		weapondamage*1
			
			elseif (damagetypelower == "eflametank") then
				wd.damage.ARMORED = 		weapondamage*0.25
				wd.damage.LIGHT = 			weapondamage*0.25
				wd.damage.BUILDING  = 		weapondamage*1
			
			elseif (damagetypelower == "elighttank3") then
				wd.damage.ARMORED = 		weapondamage*0.5
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.5
			
			elseif (damagetypelower	== "eheavytank3") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.5
			
			elseif (damagetypelower	== "emediumtank3") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*0.5
				wd.damage.BUILDING  = 		weapondamage*0.5
			
			elseif (damagetypelower	== "emissiletank") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.5
				
			elseif (damagetypelower	== "eriottank2") then
				wd.damage.ARMORED = 		weapondamage*0.5
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.5
			-- End Hovers
			
			-- Start All Terrains
			elseif (damagetypelower	== "eallterrheavy") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.5
			
			elseif (damagetypelower == "eallterrlight") then
				wd.damage.ARMORED = 		weapondamage*0.5
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.5
				
			elseif (damagetypelower	== "eallterrmed") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*0.5
				wd.damage.BUILDING  = 		weapondamage*0.5
			
			elseif (damagetypelower	== "eallterrriot") then
				wd.damage.ARMORED = 		weapondamage*0.5
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.5
			
			elseif (damagetypelower	== "eallterrassault") then
				wd.damage.ARMORED = 		weapondamage*0.125
				wd.damage.LIGHT = 			weapondamage*0.125
				wd.damage.BUILDING  = 		weapondamage*1
			-- End All Terrains
			
			-- Start Amphibs
			elseif (damagetypelower == "eamphibbuggy") then
				wd.damage.ARMORED = 		weapondamage*0.5
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.5
			
			elseif (damagetypelower	== "eamphibriot") then
				wd.damage.ARMORED = 		weapondamage*0.5
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.5
			
			elseif (damagetypelower	== "eamphibmedtank") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.5
			
			elseif (damagetypelower	== "eamphibrock") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*0.5
				wd.damage.BUILDING  = 		weapondamage*0.5
			
			elseif (damagetypelower	== "eamphibarty") then
				wd.damage.ARMORED = 		weapondamage*0.25
				wd.damage.LIGHT = 			weapondamage*0.25
				wd.damage.BUILDING  = 		weapondamage*1
			-- End Amphibs
			
			-- Start Aircraft
			elseif (damagetypelower == "edrone") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*1
			
			elseif (damagetypelower	== "efighter") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*0.66
				wd.damage.BUILDING  = 		weapondamage*0.66
			
			elseif (damagetypelower	== "egunship2") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.25
				
			elseif (damagetypelower	== "ebomber") then
				wd.damage.ARMORED = 		weapondamage*0.125
				wd.damage.LIGHT = 			weapondamage*0.125
				wd.damage.BUILDING  = 		weapondamage*1
			-- End Aircraft
			
			-- Start Experimentals
			elseif (damagetypelower	== "eexkrabgroth") then
				wd.damage.ARMORED = 		weapondamage*0.1
				wd.damage.LIGHT = 			weapondamage*0.1
				wd.damage.BUILDING  = 		weapondamage*1
				
			elseif (damagetypelower	== "eextankdestroyer") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.1
			
			elseif (damagetypelower	== "eexnukearty") then
				wd.damage.ARMORED = 		weapondamage*0.5
				wd.damage.LIGHT = 			weapondamage*0.5
				wd.damage.BUILDING  = 		weapondamage*1
			-- End Experimentals
			
			-- Start Buildings
			elseif (damagetypelower	== "elightturret2") then
				wd.damage.ARMORED = 		weapondamage*0.25
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.1
			
			elseif (damagetypelower	== "eheavyturret2") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*0.5
				wd.damage.BUILDING  = 		weapondamage*0.1
			
			elseif (damagetypelower	== "eaaturret") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*0.66
				wd.damage.BUILDING  = 		weapondamage*0.66
			
			elseif (damagetypelower	== "elrpc") then
				wd.damage.ARMORED = 		weapondamage*0.25
				wd.damage.LIGHT = 			weapondamage*0.25
				wd.damage.BUILDING  = 		weapondamage*1
			
			elseif (damagetypelower	== "euwturret") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.1
			-- End Buildings
			
			-- Start Miscellaneous
			
			
			-- End Miscellaneous
			
			else -- Default Damage
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*1
				
			end
		end
  end
  
  
  
  -- 
  if (tobool(wd.ballistic) or tobool(wd.dropped)) then
    wd.gravityaffected = true
  end
end

--------------------------------------------------------------------------------

local function ProcessUnitDef(udName, ud)

  local wds = ud.weapondefs
  if (not istable(wds)) then
    return
  end

  -- add this unitDef's weaponDefs
  for wdName, wd in pairs(wds) do
    if (isstring(wdName) and istable(wd)) then
      local fullName = udName .. '_' .. wdName
      WeaponDefs[fullName] = wd
      wd.filename = ud.filename
    end
  end

  -- convert the weapon names
  local weapons = ud.weapons
  if (istable(weapons)) then
    for i = 1, 32 do
      local w = weapons[i]
      if (istable(w)) then
        if (isstring(w.def)) then
          local ldef = string.lower(w.def)
          local fullName = udName .. '_' .. ldef
          local wd = WeaponDefs[fullName]
          if (istable(wd)) then
            w.name = fullName
          end
        end
        w.def = nil
      end
    end
  end

  -- convert the death explosions
  if (isstring(ud.explodeas)) then
    local fullName = udName .. '_' .. ud.explodeas
    if (WeaponDefs[fullName]) then
      ud.explodeas = fullName
    end
  end
  if (isstring(ud.selfdestructas)) then
    local fullName = udName .. '_' .. ud.selfdestructas
    if (WeaponDefs[fullName]) then
      ud.selfdestructas = fullName
    end
  end
end

--------------------------------------------------------------------------------

local function ProcessWeaponDef(wdName, wd)
  -- backward compability
  BackwardCompability(wdName,wd)
end

--------------------------------------------------------------------------------

-- Process the unitDefs
local UnitDefs = DEFS.unitDefs

for udName, ud in pairs(UnitDefs) do
  if (isstring(udName) and istable(ud)) then
    ProcessUnitDef(udName, ud)
  end
end


for wdName, wd in pairs(WeaponDefs) do
  if (isstring(wdName) and istable(wd)) then
    ProcessWeaponDef(wdName, wd)
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------