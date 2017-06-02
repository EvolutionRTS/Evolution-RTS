-- UNITDEF -- ESCOUT --
--------------------------------------------------------------------------------

unitName = "escout_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[AirSkout Mark II]]

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
