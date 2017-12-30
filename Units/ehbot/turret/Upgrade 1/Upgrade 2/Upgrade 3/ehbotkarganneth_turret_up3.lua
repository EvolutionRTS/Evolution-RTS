-- UNITDEF -- ehbotkarganneth_turret_up3 --
--------------------------------------------------------------------------------

unitName = [[ehbotkarganneth_turret_up3]]

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Karganneth (Deployed) MK IV]]

objectName = [[ehbotkarganneth_turret.s3o]]
script = [[ehbotkarganneth_turret_lus.lua]]

tech = [[endbringer]]
armortype = [[building]]

VFS.Include("Units-Configs-Basedefs/basedefs/hbot/turret/ehbotkarganneth_turret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------