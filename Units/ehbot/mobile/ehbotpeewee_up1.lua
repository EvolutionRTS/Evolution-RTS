-- UNITDEF -- ehbotpeewee_up1 --
--------------------------------------------------------------------------------

unitName = "ehbotpeewee_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[A.K. MK II]]

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