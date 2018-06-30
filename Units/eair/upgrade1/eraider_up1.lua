-- UNITDEF -- ERAIDER_up1 --
--------------------------------------------------------------------------------

unitName = "eraider_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Gridlock MK II]]

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
