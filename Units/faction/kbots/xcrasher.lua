-- UNITDEF -- xcrasher --
--------------------------------------------------------------------------------

unitName = "xcrasher"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Crasher]]

objectName = "faction/xcrasher.s3o"
script = "faction/xcrasher.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[1]]

VFS.Include("units-configs-basedefs/basedefs/faction/xcrasher_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------