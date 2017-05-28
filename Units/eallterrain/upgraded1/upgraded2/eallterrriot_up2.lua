-- UNITDEF -- eallterrriot -- Mossberg --
--------------------------------------------------------------------------------

unitName = "eallterrriot_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Mossberg Mark III]]

objectName = "eallterrriot2.s3o"
script = "eallterrriot.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[3]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterrriot_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------