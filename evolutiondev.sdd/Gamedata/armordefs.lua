--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    armorDefs.lua
--  brief:   armor definitions
--
--  This file is based off of the armordefs.lua file from CA. 
--
--  This file contains the different armor types that exist in the game
--  The units listed under an armor type will belong to that category
--  All unlisted ones will belong to the default category (not listed in the file)
--  
--  Weapons work in much the same way:
--  They do the default damage against all categories except if they have a special 
--  damage against one of the units in a category
--  
--  In the future its of course meant that the units should have a ArmorType tag 
--  in the lua file and that weapons should list damage against armor categories 
--  instead of against units. This will make it easier to add new units without 
--  having to change all the old weapons
--  
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local damageClasses		= VFS.Include("gamedata/configs/damageTypes.lua")
local armorDefs = {}

for _,armorName in pairs(damageClasses.armorDefs) do
	--Spring.Echo("armordefs.lua: adding armor class:" .. armorName)
	armorDefs[armorName] = {}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


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

for name, ud in pairs(DEFS.unitDefs) do
  if (ud.customparams  and ud.customparams.armortype) then
	unitArmorType = string.upper(ud.customparams.armortype)
    --Spring.Echo("Unit: ", ud.unitname, " Armorclass: ", unitArmorType) 
	table.insert(armorDefs[unitArmorType], name)
  end
end

 -- put any unit that doesn't go in any other category in medium armor
for name, ud in pairs(DEFS.unitDefs) do
  local found
  for categoryName, categoryTable in pairs(armorDefs) do
    for _, usedName in pairs(categoryTable) do
      if (usedName == name) then
        found = true
      end
    end
  end
  if (not found) then
    table.insert(armorDefs.LIGHT, name)
	--Spring.Echo("Unit: ", ud.unitname, " Armorclass: MEDIUMARMOR") 
  end
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- convert to named maps  (does anyone know what 99 is for?  :)

for categoryName, categoryTable in pairs(armorDefs) do
  local t = {}
  for _, unitName in pairs(categoryTable) do
    t[#t + 1] = unitName
  end
  armorDefs[categoryName] = t
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local system = VFS.Include('gamedata/system.lua')

return system.lowerkeys(armorDefs)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------