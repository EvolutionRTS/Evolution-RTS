-- UNITDEF -- EAMPHIBBUGGY_up1 --
--------------------------------------------------------------------------------

unitName = "eamphibbuggy_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Snake Mark I]]

objectName = "eamphibbuggy2.s3o"
script = "eamphibbuggy_lus.lua"

tech = [[tech1]]
armortype = [[light]]
supply = [[1]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibbuggy_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
