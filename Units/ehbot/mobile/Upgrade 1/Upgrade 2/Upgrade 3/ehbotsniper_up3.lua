-- UNITDEF -- ehbotsniper_up3 --
--------------------------------------------------------------------------------

unitName = "ehbotsniper_up3"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Sniper MK IV]]

objectName = "ehbotsniper.s3o"
script = "ehbotsniper_lus.lua"

tech = [[tech2]]
armortype = [[light]]
supply = [[9]]

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotsniper_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------