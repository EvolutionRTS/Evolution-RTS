-- UNITDEF -- EAMPHIBBUGGY --
--------------------------------------------------------------------------------

unitName = "eamphibbuggybig"

--------------------------------------------------------------------------------

isUpgraded = [[boss]]

humanName = [[Big Snake]]

objectName = "scavs/big/eamphibbuggy2big.s3o"
script = "eamphibbuggy_lus.lua"

tech = [[tech3]]
armortype = [[light]]
supply = [[1]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibbuggy_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
