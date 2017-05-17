-- UNITDEF -- ELIGHTTANK3 --
--------------------------------------------------------------------------------

unitName = "elighttank3"

--------------------------------------------------------------------------------

isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= false

humanName = "Kite"

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
