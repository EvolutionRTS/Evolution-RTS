-- UNITDEF -- XSKULK --
--------------------------------------------------------------------------------

unitName = "xskulk"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Skulk]]

objectName = "faction/xskulk.s3o"
script = "faction/xskulk.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[1]]

VFS.Include("units-configs-basedefs/basedefs/faction/xskulk_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
