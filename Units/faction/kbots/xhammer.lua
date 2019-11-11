-- UNITDEF -- xhammer --
--------------------------------------------------------------------------------

unitName = "xhammer"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Hammer]]

objectName = "faction/xhammer.s3o"
script = "faction/xhammer.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[1]]

VFS.Include("units-configs-basedefs/basedefs/faction/xhammer_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------