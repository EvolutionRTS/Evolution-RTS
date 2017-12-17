-- UNITDEF -- EFIGHTER --
--------------------------------------------------------------------------------

unitName = "efighter_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Koyote Mark II]]

objectName = "efighter3.s3o"
script = "efighter3.cob"


tech = [[tech0]]
armortype = [[light]]
supply = [[2]]

VFS.Include("units-configs-basedefs/basedefs/air/efighter_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
