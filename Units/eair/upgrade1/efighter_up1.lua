-- UNITDEF -- EFIGHTER --
--------------------------------------------------------------------------------

unitName = "efighter_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Koyote v1.1]]

objectName = "efighter2.s3o"
script = "efighter2.cob"


tech = [[tech1]]
armortype = [[light]]
supply = [[2]]

VFS.Include("units-configs-basedefs/basedefs/air/efighter_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
