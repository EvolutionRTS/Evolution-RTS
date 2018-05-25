-- UNITDEF -- ehbotsniper_turret --
--------------------------------------------------------------------------------

unitName = [[ehbotsniper_turret_up1]]

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Sniper Mk II (Deployed)]]

objectName = [[ehbotsniper_turret.s3o]]
script = [[ehbotsniper_turret_lus.lua]]

tech = [[tech2]]
armortype = [[light]]
supply = [[9]]

VFS.Include("Units-Configs-Basedefs/basedefs/hbot/turret/ehbotsniper_turret_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------