--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local modOptions
if (Spring.GetModOptions) then
  modOptions = Spring.GetModOptions()
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Utility
--

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


local function disableunits(unitlist)
  for name, ud in pairs(UnitDefs) do
    if (ud.buildoptions) then
      for _, toremovename in ipairs(unitlist) do
        for index, unitname in pairs(ud.buildoptions) do
          if (unitname == toremovename) then
            table.remove(ud.buildoptions, index)
          end
        end
      end
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 3dbuildrange for all none plane builders
--
--[[
for name, ud in pairs(UnitDefs) do
  if (tobool(ud.builder) and not tobool(ud.canfly)) then
    ud.buildrange3d = true
  end
end
--]]

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- turn off unit collision check for planes
--

for name, ud in pairs(UnitDefs) do
  if (tobool(ud.canfly) and not tobool(ud.istransport)) then
    ud.collide = false
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Calculate mincloakdistance based on unit footprint size
--

local sqrt = math.sqrt

for name, ud in pairs(UnitDefs) do
  if (not ud.mincloakdistance) then
    local fx = ud.footprintx and tonumber(ud.footprintx) or 1
    local fz = ud.footprintz and tonumber(ud.footprintz) or 1
    local radius = 8 * sqrt((fx * fx) + (fz * fz))
    ud.mincloakdistance = (radius + 48)
  end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Special Air
--

if (modOptions and tobool(modOptions.specialair)) then
  local replacements = VFS.Include("LuaRules/Configs/specialair.lua")
  if (replacements[modOptions.specialair]) then
    replacements = replacements[modOptions.specialair]
    for name, ud in pairs(UnitDefs) do
      if (ud.buildoptions) then
        for buildKey, buildOption in pairs(ud.buildoptions) do
          if (replacements[buildOption]) then
            ud.buildoptions[buildKey] = replacements[buildOption];
          end
        end
      end
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Tactics GameMode
--

if (modOptions and (modOptions.gamemode == "tactics")) then
  -- remove all build options
  Game = { gameSpeed = 30 };  --  required by tactics.lua
  local options = VFS.Include("LuaRules/Configs/tactics.lua")
  local customBuilds = options.customBuilds
  for name, ud in pairs(UnitDefs) do
    if tobool(ud.commander) then
      ud.buildoptions = (customBuilds[name] or {}).allow or {}
    else
      ud.buildoptions = {}
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Metal Bonus
--

if (modOptions and modOptions.metalmult) then
  for name in pairs(UnitDefs) do
    local em = UnitDefs[name].extractsmetal
    if (em) then
      UnitDefs[name].extractsmetal = em * modOptions.metalmult
    end
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Commander Types
-- 

if (modOptions and modOptions.commtype) then
  if modOptions.commtype == 'lite' then

    for name, ud in pairs(UnitDefs) do
      --remove decoy commander from any buildlist
      if (ud.buildoptions) then
        for index,unitname in pairs(ud.buildoptions) do
          if (unitname == "armdecom" or unitname == "cordecom") then
            table.remove(ud.buildoptions, index)
          end
        end 
      end
    end --for

  elseif modOptions.commtype == 'standard' then

    for name, ud in pairs(UnitDefs) do
      local unitname = ud.unitname
      if (unitname == "armcom" or unitname == "corcom") then 
        ud.weapondefs.disintegrator.damage.commanders = "99999"
        ud.explodeas = "COMMANDER_BLAST_OLD"
        ud.selfdestructas = "COMMANDER_BLAST_OLD"
      end
    end --for

  end

end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Burrowed
-- 
for name, ud in pairs(UnitDefs) do
  if (ud.weapondefs) then
    for wName,wDef in pairs(ud.weapondefs) do      
      wDef.damage.burrowed = 0.001
    end
  end
end --for


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Concept unit factory mod option
-- 

if modOptions and tobool(modOptions.hiddenunits) then
	for name, ud in pairs(UnitDefs) do
		local unitname = ud.unitname
		if unitname == "armcom" 
			or unitname == "corcom" 
			or unitname == "armcomlite" 
			or unitname == "corcomlite" 
			then
			if (ud.buildoptions) then
				table.insert(ud.buildoptions, 1, "concept_factory")
			end
		end
	end --for
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Metal Makers
-- 

if (modOptions and tobool(modOptions.nometalmakers)) then
  disableunits({"armmakr", "cormakr", "armmmkr", "cormmkr", "armfmkr", "corfmkr", "emaker"})
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Spring Kludge Removal
-- 
for name, ud in pairs(UnitDefs) do
	ud.activateWhenBuilt  = true 
end

for name, ud in pairs(UnitDefs) do
	if (ud.builder) then 
	--	local buildDistance = ud.buildDistance * 1.7
	--	ud.buildDistance  = buildDistance
		Spring.Echo ("Build Distance is" (ud.buildDistance))
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Festive units mod option (CarRepairer's WIP)
-- 
--[[
if modOptions and tobool(modOptions.xmasunits) then
	for name, ud in pairs(UnitDefs) do
		local unitname = ud.unitname
		if unitname == "armcom" or unitname == "armcomlite" then
			--ud.object = 
		elseif unitname == "armdrag" or unitname == "cordrag" then
			ud.objectname = "christmastree_dt.S3O"
			ud.featuredefs.dead.object = "christmastree_dt.S3O"
			
		elseif unitname == "armthund" or unitname == "corshad" then
			ud.weapondefs.armbomb.model = "present_bomb1.s3o"
		elseif unitname == "armpnix" then
			ud.weapondefs.armadvbomb.model = "present_bomb2.s3o"
		elseif unitname == "armcybr" then
			ud.weapondefs.arm_pidr.model = "present_bomb3.s3o"
		elseif unitname == "corhurc" then
			ud.weapondefs.coradvbomb.model = "present_bomb2.s3o"
		elseif unitname == "corclog" then
			ud.objectname = "core_christmas_clogger.s3o"
			ud.featuredefs.dead.object = "christmastree_dt.S3O"
		end

	end --for
end
--]]


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- fix customParams table
--
--[[
for name, ud in pairs(UnitDefs) do
  if (ud.customparams and not ud.customParams) then
    ud.customParams = ud.customparams
    ud.customparams = nil
  end
end
--]]

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
