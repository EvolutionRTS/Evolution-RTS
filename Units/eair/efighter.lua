-- UNITDEF -- EFIGHTER --
--------------------------------------------------------------------------------

unitName = "efighter"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Koyote]]

objectName = "efighter3.s3o"
script = "efighter3.cob"


tech = [[tech1]]
armortype = [[light]]
supply = [[16]]

VFS.Include("units-configs-basedefs/basedefs/air/efighter_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
