-- UNITDEF -- ESCOUT --
--------------------------------------------------------------------------------

unitName = "escout"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[AirSkout]]

objectName = "escout2.s3o"
script = "escout2.cob"


tech = [[tech1]]
armortype = [[light]]
supply = [[0]]

VFS.Include("units-configs-basedefs/basedefs/air/escout_basedef.lua")

-- unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
