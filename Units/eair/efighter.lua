-- UNITDEF -- EFIGHTER --
--------------------------------------------------------------------------------

unitName = "efighter"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Koyote]]

objectName = "efighter2-small.s3o"
script = "efighter2.cob"


tech = [[tech2]]
armortype = [[airlight]]
supply = [[2]]

VFS.Include("units-configs-basedefs/basedefs/air/efighter_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
