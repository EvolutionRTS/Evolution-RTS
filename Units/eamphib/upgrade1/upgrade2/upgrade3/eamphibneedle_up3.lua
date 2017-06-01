-- UNITDEF -- eamphibneedle_up3 --
--------------------------------------------------------------------------------

unitName = "eamphibneedle_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Ikinz Mark III]]

objectName = "eamphibaa.s3o"
script = "eamphibaa.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibneedle_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
