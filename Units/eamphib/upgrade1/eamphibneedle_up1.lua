-- UNITDEF -- eamphibneedle_up1 --
--------------------------------------------------------------------------------

unitName = "eamphibneedle_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Ikinz Mark II]]

objectName = "eamphibaa.s3o"
script = "eamphibaa.cob"

tech = [[tech0]]
armortype = [[light]]
supply = [[3]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibneedle_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
