-- UNITDEF -- EFIGHTER --
--------------------------------------------------------------------------------

unitName = "efighter_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Koyote Mark III]]

objectName = "efighter2-small.s3o"
script = "efighter2.cob"


tech = [[tech2]]
armortype = [[light]]
supply = [[2]]

VFS.Include("units-configs-basedefs/basedefs/air/efighter_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------