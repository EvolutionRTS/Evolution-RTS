-- UNITDEF -- ehbotkarganneth --
--------------------------------------------------------------------------------

unitName = "ehbotkarganneth"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Karganneth]]

objectName = "ehbotkarganneth.s3o"
script = "ehbotkarganneth_lus.lua"

tech = [[tech3]]
armortype = [[armored]]

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotkarganneth_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------