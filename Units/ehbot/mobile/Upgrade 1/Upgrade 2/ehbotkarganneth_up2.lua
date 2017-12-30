-- UNITDEF -- ehbotkarganneth_up2 --
--------------------------------------------------------------------------------

unitName = "ehbotkarganneth_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Karganneth MK III]]

objectName = "ehbotkarganneth.s3o"
script = "ehbotkarganneth_lus.lua"

tech = [[endbringer]]
armortype = [[armored]]

VFS.Include("units-configs-basedefs/basedefs/hbot/mobile/ehbotkarganneth_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------