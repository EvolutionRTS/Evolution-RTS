-- UNITDEF -- eallterrriot_shotgun_up3 -- Mossberg --
--------------------------------------------------------------------------------

unitName = "eallterrriot_shotgun_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

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