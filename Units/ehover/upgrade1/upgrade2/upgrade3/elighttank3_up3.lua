-- UNITDEF -- ELIGHTTANK3_up3 --
--------------------------------------------------------------------------------

unitName = "elighttank3_up3"

--------------------------------------------------------------------------------

isUpgraded	= [[3]]

humanName = [[Kite Mark IV]]

objectName = "elighttank4.s3o"
script = "elighttank3_lus.lua"

tech						 = [[tech1]]
armortype					 = [[light]]
supply					 = [[3]]

VFS.Include("units-configs-basedefs/basedefs/hover/elighttank3_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
