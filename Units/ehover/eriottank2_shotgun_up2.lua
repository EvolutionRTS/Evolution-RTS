-- UNITDEF -- ERIOTTANK2_shotgun_up2 --
--------------------------------------------------------------------------------

unitName = "eriottank2_shotgun_up2"

--------------------------------------------------------------------------------

isUpgraded	= [[2]]

humanName = [[Spas Mark III]]

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
