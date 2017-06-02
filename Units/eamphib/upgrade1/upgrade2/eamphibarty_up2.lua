-- UNITDEF -- EAMPHIBARTY_up2 --
--------------------------------------------------------------------------------

unitName = "eamphibarty_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Assimilator Mark III]]

objectName = "eamphibarty2.s3o"
script = "eamphibarty2.cob"

tech = [[tech0]]
armortype = [[light]]
supply = [[5]]

VFS.Include("units-configs-basedefs/basedefs/amphib/eamphibarty_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
