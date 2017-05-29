-- UNITDEF -- ESCOUT --
--------------------------------------------------------------------------------

unitName = "escout_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[AirSkout v1.1]]

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
