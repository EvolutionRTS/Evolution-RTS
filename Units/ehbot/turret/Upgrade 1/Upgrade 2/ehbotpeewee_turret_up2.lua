-- UNITDEF -- ehbotpeewee_turret --
--------------------------------------------------------------------------------

unitName = [[ehbotpeewee_turret_up2]]

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[A.K. Mk III (Deployed)]]

objectName = [[ehbotpeewee_turret.s3o]]
script = [[ehbotpeewee_turret_lus.lua]]

tech = [[tech0]]
armortype = [[building]]
supply = [[5]]

VFS.Include("Units-Configs-Basedefs/basedefs/hbot/turret/ehbotpeewee_turret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------