-- UNITDEF -- zairtoairfighter --
--------------------------------------------------------------------------------

unitName = "zairtoairfighter"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Koyote]]

objectName = "zaal/zairtoairfighter.s3o"
script = "zaal/zairtoairfighter.cob"


tech = [[4 hive]]
armortype = [[light]]
supply = [[2]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zairtoairfighter_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
