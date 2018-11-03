-- UNITDEF -- ehbotkarganneth_turret --
--------------------------------------------------------------------------------

unitName = [[ehbotkarganneth_turret]]

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Karganneth (Deployed)]]

objectName = [[ehbotkarganneth_turret.s3o]]
script = [[ehbotkarganneth_turret_lus.lua]]

tech = [[tech3]]
armortype = [[armored]]

VFS.Include("Units-Configs-Basedefs/basedefs/hbot/turret/ehbotkarganneth_turret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------