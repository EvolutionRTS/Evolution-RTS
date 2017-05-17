-- UNITDEF -- ERIOTTANK2_up2 --
--------------------------------------------------------------------------------

unitName = "eriottank2_up2"

--------------------------------------------------------------------------------

isUpgraded	= [[2]]

humanName = "Spas Upgrade 2"

objectName = "eriottank3.s3o"
script = "eriottank3.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[3]]


VFS.Include("units-configs-basedefs/basedefs/hover/eriottank2_basedef.lua")

unitDef.weaponDefs = weaponDefs--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
