-- UNITDEF -- ERAIDER_up2 --
--------------------------------------------------------------------------------

unitName = "eraider_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Gridlock MK III]]

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
