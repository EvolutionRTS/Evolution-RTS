-- UNITDEF -- ehbotpeewee_turret --
--------------------------------------------------------------------------------

unitName = [[ehbotpeewee_turret_up1]]

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[A.K. Mk II (Deployed)]]

objectName = [[ehbotpeewee_turret.s3o]]
script = [[ehbotpeewee_turret_lus.lua]]

tech = [[tech0]]
armortype = [[light]]
supply = [[6]]

VFS.Include("Units-Configs-Basedefs/basedefs/hbot/turret/ehbotpeewee_turret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------