-- UNITDEF -- ESCOUT --
--------------------------------------------------------------------------------

unitName = "escout_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[AirSkout Mark IV]]

objectName = "escout2.s3o"
script = "escout2.cob"


tech = [[tech0]]
armortype = [[light]]
supply = [[0]]

VFS.Include("units-configs-basedefs/basedefs/air/escout_basedef.lua")

-- unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
