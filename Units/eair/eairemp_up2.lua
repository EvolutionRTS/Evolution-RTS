-- UNITDEF -- eairemp_up2 --
--------------------------------------------------------------------------------

unitName = "eairemp_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Gridlock MK III]]

objectName = "eairemp.s3o"
script = "eairemp.cob"


tech = [[tech3]]
armortype = [[light]]
supply = [[2]]

VFS.Include("units-configs-basedefs/basedefs/air/eairemp_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
