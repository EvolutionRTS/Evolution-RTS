-- UNITDEF -- ehbotthud_up1 --
--------------------------------------------------------------------------------

unitName = "ehbotthud_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Thud MK II]]

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