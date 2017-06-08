-- UNITDEF -- ehbotthud_up2 --
--------------------------------------------------------------------------------

unitName = "ehbotthud_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Thud MK III]]

objectName = "ehbotthud.s3o"
script = "ehbotthud_lus.lua"

tech = [[tech1]]
armortype = [[light]]
supply = [[7]]

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotthud_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------