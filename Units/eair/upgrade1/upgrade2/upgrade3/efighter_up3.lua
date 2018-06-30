-- UNITDEF -- EFIGHTER --
--------------------------------------------------------------------------------

unitName = "efighter_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Koyote Mark IV]]

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
