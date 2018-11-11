-- UNITDEF -- ehbotpeewee_up2 --
--------------------------------------------------------------------------------

unitName = "ehbotpeewee_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[A.K. MK III]]

objectName = "ehbotpeewee2.s3o"
script = "ehbotpeewee_lus.lua"

tech = [[tech1]]
armortype = [[light]]
supply = [[6]]

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotpeewee_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------