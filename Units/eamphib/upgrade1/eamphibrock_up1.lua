-- UNITDEF -- EAMPHIBROCK_up1 --
--------------------------------------------------------------------------------

unitName = "eamphibrock_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Spitter Mark I]]

objectName = "eamphibrock4.s3o"
script = "eamphibrock4.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[5]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibrock_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]  = unitDef })

--------------------------------------------------------------------------------
