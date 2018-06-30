-- UNITDEF -- EDRONE_up2 --
--------------------------------------------------------------------------------

unitName = "edrone_up2"

--------------------------------------------------------------------------------

isUpgraded = [[2]]

humanName = [[Mosquito MK III]]

objectName = "edrone2.s3o"
script = "edrone2.cob"


tech = [[tech0]]
armortype = [[light]]
supply = [[9]]

VFS.Include("units-configs-basedefs/basedefs/air/edrone_basedef.lua")

unitDef.weaponDefs = weaponDefs

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
