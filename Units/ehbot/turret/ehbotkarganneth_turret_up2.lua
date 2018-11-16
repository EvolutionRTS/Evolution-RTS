-- UNITDEF -- ehbotkarganneth_turret_up2 --
--------------------------------------------------------------------------------

unitName = [[ehbotkarganneth_turret_up2]]

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Karganneth (Deployed) MK III]]

objectName = [[ehbotkarganneth_turret.s3o]]
script = [[ehbotkarganneth_turret_lus.lua]]

tech = [[tech3]]
armortype = [[armored]]

VFS.Include("Units-Configs-Basedefs/basedefs/hbot/turret/ehbotkarganneth_turret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------