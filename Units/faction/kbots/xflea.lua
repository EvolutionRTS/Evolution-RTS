-- UNITDEF -- xflea --
--------------------------------------------------------------------------------

unitName = "xflea"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Skulk]]

objectName = "faction/xflea.s3o"
script = "faction/xflea.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[1]]

VFS.Include("units-configs-basedefs/basedefs/faction/xflea_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
