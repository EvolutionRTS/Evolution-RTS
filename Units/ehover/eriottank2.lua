-- UNITDEF -- ERIOTTANK2 --
--------------------------------------------------------------------------------

unitName = "eriottank2"

--------------------------------------------------------------------------------
isUpgraded	= false
isUpgraded2	= false
isUpgraded3	= false

humanName = "Spas"

objectName = "eriottank3.s3o"
script = "eriottank3.cob"

tech = [[tech1]]
armortype = [[light]]
supply = [[3]]


VFS.Include("units-configs-basedefs/basedefs/hover/eriottank2_basedef.lua")

unitDef.weaponDefs = weaponDefs--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
