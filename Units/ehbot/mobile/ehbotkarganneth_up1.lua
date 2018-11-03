-- UNITDEF -- ehbotkarganneth_up1 --
--------------------------------------------------------------------------------

unitName = "ehbotkarganneth_up1"

--------------------------------------------------------------------------------

isUpgraded = [[1]]

humanName = [[Karganneth MK II]]

objectName = "ehbotkarganneth.s3o"
script = "ehbotkarganneth_lus.lua"

tech = [[tech3]]
armortype = [[armored]]

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotkarganneth_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------