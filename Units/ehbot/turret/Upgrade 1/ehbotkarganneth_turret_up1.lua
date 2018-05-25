-- UNITDEF -- ehbotkarganneth_turret_up1 --
--------------------------------------------------------------------------------

unitName = [[ehbotkarganneth_turret_up1]]

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Karganneth (Deployed) MK II]]

objectName = [[ehbotkarganneth_turret.s3o]]
script = [[ehbotkarganneth_turret_lus.lua]]

tech = [[endbringer]]
armortype = [[armored]]

VFS.Include("Units-Configs-Basedefs/basedefs/hbot/turret/ehbotkarganneth_turret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------