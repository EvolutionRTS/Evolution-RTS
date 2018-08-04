-- UNITDEF -- eallterrriot_shotgun -- Mossberg --
--------------------------------------------------------------------------------

unitName = "eallterrriot_shotgun"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Mossberg]]

objectName = "eallterrriot2.s3o"
script = "eallterrriot.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[3]]

VFS.Include("Units-Configs-Basedefs/basedefs/allterrain/eallterrriot_shotgun_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------