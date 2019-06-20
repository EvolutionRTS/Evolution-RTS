-- UNITDEF -- zairtogroundfighter --
--------------------------------------------------------------------------------

unitName = "zairtogroundfighter"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Koyote]]

objectName = "zaal/zairtogroundfighter.s3o"
script = "zaal/zairtogroundfighter.cob"


tech = [[4 hive]]
armortype = [[light]]
supply = [[2]]

VFS.Include("units-configs-basedefs/basedefs/zaal/zairtogroundfighter_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
