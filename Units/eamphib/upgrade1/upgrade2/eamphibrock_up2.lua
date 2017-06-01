-- UNITDEF -- EAMPHIBROCK_up2 --
--------------------------------------------------------------------------------

unitName = "eamphibrock_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Spitter Mark III]]

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
