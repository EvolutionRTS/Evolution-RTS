-- UNITDEF -- ehbotrocko_turret --
--------------------------------------------------------------------------------

unitName = [[ehbotrocko_turret_up1]]

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Rocko Mk II (Deployed)]]

objectName = [[ehbotrocko_turret.s3o]]
script = [[ehbotrocko_turret_lus.lua]]

tech = [[tech2]]
armortype = [[light]]
supply = [[15]]

VFS.Include("Units-Configs-Basedefs/basedefs/hbot/turret/ehbotrocko_turret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------