-- UNITDEF -- ehbotpeewee --
--------------------------------------------------------------------------------

unitName = "ehbotpeewee"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[A.K.]]

objectName = "ehbotpeewee2.s3o"
script = "ehbotpeewee_lus.lua"

tech = [[tech0]]
armortype = [[light]]
supply = [[5]]

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotpeewee_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------