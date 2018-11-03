-- UNITDEF -- ehbotthud_up1 --
--------------------------------------------------------------------------------

unitName = "ehbotrocko_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Rocko MKII]]

objectName = "ehbotrocko.s3o"
script = "ehbotrocko_lus.lua"

tech = [[tech2]]
armortype = [[light]]
supply = [[15]]

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotrocko_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------