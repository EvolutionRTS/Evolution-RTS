-- UNITDEF -- ehbotthud --
--------------------------------------------------------------------------------

unitName = "ehbotthud"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Thud]]

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