-- UNITDEF -- EDRONE --
--------------------------------------------------------------------------------

unitName = "edrone"

--------------------------------------------------------------------------------

isUpgraded = [[0]]

humanName = [[Mosquito]]

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
