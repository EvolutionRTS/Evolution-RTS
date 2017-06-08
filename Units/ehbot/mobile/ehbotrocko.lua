-- UNITDEF -- ehbotthud --
--------------------------------------------------------------------------------

unitName = "ehbotrocko"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Rocko]]

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