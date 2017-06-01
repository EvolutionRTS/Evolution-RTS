-- UNITDEF -- EAMPHIBARTY_up1 --
--------------------------------------------------------------------------------

unitName = "eamphibarty_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Assimilator Mark II]]

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
