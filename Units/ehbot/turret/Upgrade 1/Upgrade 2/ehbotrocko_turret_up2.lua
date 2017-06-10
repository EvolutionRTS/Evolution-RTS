-- UNITDEF -- ehbotrocko_turret --
--------------------------------------------------------------------------------

unitName = [[ehbotrocko_turret_up2]]

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Rocko Mk III (Deployed)]]

objectName = [[ehbotrocko_turret.s3o]]
script = [[ehbotrocko_turret_lus.lua]]

tech = [[tech2]]
armortype = [[building]]
supply = [[15]]

VFS.Include("Units-Configs-Basedefs/basedefs/hbot/turret/ehbotrocko_turret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------