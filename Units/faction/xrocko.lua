-- UNITDEF -- xrocko --
--------------------------------------------------------------------------------

unitName = "xrocko"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Rocko]]

objectName = "faction/xrocko.s3o"
script = "faction/xrocko.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[1]]

VFS.Include("units-configs-basedefs/basedefs/faction/xrocko_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------