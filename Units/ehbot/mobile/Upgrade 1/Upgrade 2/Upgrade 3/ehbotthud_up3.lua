-- UNITDEF -- ehbotthud_up3 --
--------------------------------------------------------------------------------

unitName = "ehbotthud_up3"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Thud MK IV]]

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