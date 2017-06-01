-- UNITDEF -- EAMPHIBBUGGY_up2 --
--------------------------------------------------------------------------------

unitName = "eamphibbuggy_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Snake Mark II]]

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
