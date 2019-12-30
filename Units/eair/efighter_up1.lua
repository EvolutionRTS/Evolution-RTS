-- UNITDEF -- EFIGHTER --
--------------------------------------------------------------------------------

unitName = "efighter_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Koyote Mark II]]

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