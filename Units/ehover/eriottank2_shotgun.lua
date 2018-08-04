-- UNITDEF -- ERIOTTANK2_shotgun --
--------------------------------------------------------------------------------

unitName = "eriottank2_shotgun"

--------------------------------------------------------------------------------

isUpgraded	= [[0]]

humanName = "Spas"

objectName = "eriottank3.s3o"
script = "eriottank3.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[3]]


VFS.Include("units-configs-basedefs/basedefs/hover/eriottank2_shotgun_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
