-- UNITDEF -- ESCOUTDRONE --
--------------------------------------------------------------------------------

unitName = "escoutdrone"

--------------------------------------------------------------------------------

humanName = [[Mosquito]]

objectName = "edrone2.s3o"
script = "edrone2.cob"

armortype = [[light]]

tech = [[tech0]]

VFS.Include("units-configs-basedefs/basedefs/air/escoutdrone_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
