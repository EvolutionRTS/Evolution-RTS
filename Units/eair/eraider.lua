-- UNITDEF -- ERAIDER --
--------------------------------------------------------------------------------

unitName = "eraider"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Gridlock]]

objectName = "eraider.s3o"
script = "eraider.cob"


tech = [[tech1]]
armortype = [[light]]
supply = [[10]]

VFS.Include("units-configs-basedefs/basedefs/air/eraider_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
