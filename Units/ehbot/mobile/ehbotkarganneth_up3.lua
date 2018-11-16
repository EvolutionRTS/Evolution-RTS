-- UNITDEF -- ehbotkarganneth_up3 --
--------------------------------------------------------------------------------

unitName = "ehbotkarganneth_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Karganneth MK IV]]

objectName = "ehbotkarganneth.s3o"
script = "ehbotkarganneth_lus.lua"

tech = [[tech3]]
armortype = [[armored]]

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotkarganneth_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------