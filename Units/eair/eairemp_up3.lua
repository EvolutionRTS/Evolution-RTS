-- UNITDEF -- eairemp_up3 --
--------------------------------------------------------------------------------

unitName = "eairemp_up3"

--------------------------------------------------------------------------------

isUpgraded = [[3]]

humanName = [[Gridlock MK IV]]

objectName = "eairemp.s3o"
script = "eairemp.cob"


tech = [[tech3]]
armortype = [[airlight]]
supply = [[2]]

VFS.Include("units-configs-basedefs/basedefs/air/eairemp_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
