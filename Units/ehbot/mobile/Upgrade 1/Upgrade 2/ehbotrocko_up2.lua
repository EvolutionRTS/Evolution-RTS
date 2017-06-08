-- UNITDEF -- ehbotthud_up2 --
--------------------------------------------------------------------------------

unitName = "ehbotrocko_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Rocko MKIII]]

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