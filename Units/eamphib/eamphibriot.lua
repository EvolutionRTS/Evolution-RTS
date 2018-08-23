-- UNITDEF -- EAMPHIBRIOT--
--------------------------------------------------------------------------------

unitName = "eamphibriot"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Dicer]]

objectName = "eamphibriot2.s3o"
script = "eamphibriot.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibriot_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
