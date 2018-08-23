-- UNITDEF -- EAMPHIBARTY --
--------------------------------------------------------------------------------

unitName = "eamphibarty"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Assimilator]]

objectName = "eamphibarty2.s3o"
script = "eamphibarty2.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[5]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibarty_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
