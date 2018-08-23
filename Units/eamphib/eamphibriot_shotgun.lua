-- UNITDEF -- EAMPHIBRIOT_shotgun--
--------------------------------------------------------------------------------

unitName = "eamphibriot_shotgun"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Dicer]]

objectName = "eamphibriot2.s3o"
script = "eamphibriot.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibriot_shotgun_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
