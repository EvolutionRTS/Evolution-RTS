-- UNITDEF -- EAMPHIBROCK_up3 --
--------------------------------------------------------------------------------

unitName = "eamphibrock_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Spitter Mark IV]]

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
