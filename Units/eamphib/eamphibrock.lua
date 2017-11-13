-- UNITDEF -- EAMPHIBROCK --
--------------------------------------------------------------------------------

unitName = "eamphibrock"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Spitter]]

objectName = "eamphibrock4.s3o"
script = "eamphibrock4.cob"

tech = [[tech2]]
armortype = [[light]]
supply = [[5]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibrock_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]  = unitDef })

--------------------------------------------------------------------------------
