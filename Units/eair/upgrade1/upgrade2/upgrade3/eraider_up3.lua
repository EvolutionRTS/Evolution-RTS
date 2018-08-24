-- UNITDEF -- ERAIDER_up3 --
--------------------------------------------------------------------------------

unitName = "eraider_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Gridlock MK IV]]

objectName = "eraider.s3o"
script = "eraider.cob"


tech = [[tech1]]
armortype = [[light]]
supply = [[2]]

VFS.Include("units-configs-basedefs/basedefs/air/eraider_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
