-- UNITDEF -- EAMPHIBRIOT_up3--
--------------------------------------------------------------------------------

unitName = "eamphibriot_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Dicer Mark IV]]

objectName = "eamphibriot2.s3o"
script = "eamphibriot.cob"

tech = [[tech0]]
armortype = [[light]]
supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibriot_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
