-- UNITDEF -- ehbotrocko_turret --
--------------------------------------------------------------------------------

unitName = [[ehbotrocko_turret]]

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Rocko (Deployed)]]

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